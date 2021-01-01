.PHONY: phpactor-install-extensions phpactor-start-server gitconfig-include-local coc-install
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
SHELL := /bin/bash
DIR := ${CURDIR}

.ONESHELL:
phpactor-install:
	cd $(DIR)/pack/bundle/opt/phpactor
	composer install
	mapfile -t exts < config/travis/extensions-to-test
	./bin/phpactor extension:install "$${exts[@]}"

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

fzf-build:
	cd $(DIR)/pack/bundle/opt/fzf
	make -j4 install

git-submodules-hooks-install:
	$(DIR)/.config/bin/git-submodules-hooks-install . .config/git-submodules/.config

start: gitconfig-include-local submodule-update git-submodules-hooks-install coc-install phpactor-install fzf-build
