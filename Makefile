.PHONY: phpactor-install-extensions phpactor-start-server gitconfig-include-local
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
SHELL := /bin/bash
DIR := ${CURDIR}
vscodePhpDebugVersion := '1.32.1'
bashDebugVersion := '0.3.9'
bashDebugUrl := 'https://github.com/rogalmic/vscode-bash-debug/releases/download/untagged-438733f35feb8659d939/bash-debug-0.3.9.vsix'

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
	$(DIR)/bin/dap-adapter-utils install xdebug vscode-php-debug $(vscodePhpDebugVersion)
	$(DIR)/bin/dap-adapter-utils setAsCurrent vscode-php-debug $(vscodePhpDebugVersion)

install-vscode-bash-debug:
	$(DIR)/bin/dap-adapter-utils install rogalmic vscode-bash-debug $(bashDebugVersion) $(bashDebugUrl)
	$(DIR)/bin/dap-adapter-utils setAsCurrent vscode-bash-debug $(bashDebugVersion)
