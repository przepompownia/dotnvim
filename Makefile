.PHONY: phpactor-install-extensions phpactor-start-server gitconfig-include-local coc-install
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
SHELL := /bin/bash
DIR := ${CURDIR}
vscodePhpDebugVersion := '1.29.0'

.ONESHELL:
phpactor-install:
	cd $(DIR)/pack/bundle/opt/phpactor
	composer install

.ONESHELL:
phpactor-start-server:
	cd pack/bundle/opt/phpactor
	./bin/phpactor language-server --address=127.0.0.1:8888

gitconfig-include-local:
	git config --local include.path "$$(git rev-parse --show-toplevel)/.gitconfig"

.ONESHELL:
coc-install:
	cd $(DIR)/pack/bundle/opt/coc.nvim
	git remote set-head origin master
	yarn install --frozen-lockfile
	cd $(DIR)/.config/coc/extensions
	yarn
	
submodule-update:
	git su

telescope-fzf-native-build:
	cd $(DIR)/pack/bundle/opt/telescope-fzf-native.nvim
	make -j

git-submodules-hooks-install:
	$(DIR)/.config/bin/git-submodules-hooks-install . .config/git-submodules/.config

git-submodules-sync:
	git submodule sync --recursive

start: gitconfig-include-local submodule-update git-submodules-hooks-install phpactor-install telescope-fzf-native-build install-vscode-php-debug

check-requirements:
	$(DIR)/.config/bin/check-requirements

install-vscode-php-debug:
	$(DIR)/bin/vscode-php-debug install $(vscodePhpDebugVersion)
	$(DIR)/bin/vscode-php-debug setAsCurrent $(vscodePhpDebugVersion)
