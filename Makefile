.PHONY: phpactor-install-extensions phpactor-start-server gitconfig-include-local
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
SHELL := /bin/bash
DIR := ${CURDIR}
vscodePhpDebugVersion := '1.33.0'
vscodePhpDebugUrl := 'https://github.com/xdebug/vscode-php-debug/releases/download/v1.33.0/php-debug-1.33.0.vsix'
bashDebugVersion := '0.3.9'
bashDebugUrl := 'https://github.com/rogalmic/vscode-bash-debug/releases/download/untagged-438733f35feb8659d939/bash-debug-0.3.9.vsix'
cpptoolsVersion := '1.16.3'
cpptoolsUrl := 'https://github.com/microsoft/vscode-cpptools/releases/download/v1.16.3/cpptools-linux.vsix'

.ONESHELL:
phpactor-install:
	cd $(DIR)/nvim/pack/bundle/opt/phpactor
	composer install

.ONESHELL:
phpactor-start-server:
	cd nvim/pack/bundle/opt/phpactor
	./bin/phpactor language-server --address=127.0.0.1:8888

gitconfig-include-local:
	git config --local include.path "$$(git rev-parse --show-toplevel)/.gitconfig"

submodule-update:
	git su

telescope-fzf-native-build:
	cd $(DIR)/nvim/pack/bundle/opt/telescope-fzf-native.nvim
	make -j

git-submodules-hooks-install:
	$(DIR)/.config/bin/git-submodules-hooks-install . .config/git-submodules/.config

git-submodules-sync:
	git submodule sync --recursive

start: gitconfig-include-local submodule-update git-submodules-hooks-install phpactor-install telescope-fzf-native-build install-vscode-php-debug

check-requirements:
	$(DIR)/.config/bin/check-requirements

install-vscode-php-debug:
	$(DIR)/bin/dap-adapter-utils install xdebug vscode-php-debug $(vscodePhpDebugVersion) $(vscodePhpDebugUrl)
	$(DIR)/bin/dap-adapter-utils setAsCurrent vscode-php-debug $(vscodePhpDebugVersion)

install-vscode-bash-debug:
	$(DIR)/bin/dap-adapter-utils install rogalmic vscode-bash-debug $(bashDebugVersion) $(bashDebugUrl)
	$(DIR)/bin/dap-adapter-utils setAsCurrent vscode-bash-debug $(bashDebugVersion)

install-vscode-cpptools-debug:
	$(DIR)/bin/dap-adapter-utils install microsoft vscode-cpptools $(cpptoolsVersion) $(cpptoolsUrl)
	$(DIR)/bin/dap-adapter-utils setAsCurrent vscode-cpptools $(cpptoolsVersion)

arctgx-lua-ls-workspace-library:
	cd $(DIR)/nvim/pack/arctgx/opt/arctgx 
	nvim -u $(DIR)/nvim/init.lua -l lua/arctgx/luaLs/workLibGen.lua
