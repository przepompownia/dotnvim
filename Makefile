.PHONY: phpactor-install-extensions phpactor-start-server gitconfig-include-local coc-install
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
SHELL := /bin/bash
DIR := ${CURDIR}

.ONESHELL:
phpactor-install:
	cd pack/bundle/opt/phpactor
	composer install
	mapfile -t exts < config/travis/extensions-to-test
	./bin/phpactor extension:install "$${exts[@]}"

.ONESHELL:
phpactor-start-server:
	cd pack/bundle/opt/phpactor
	./bin/phpactor language-server --address=127.0.0.1:8888

gitconfig-include-local:
	git config --local include.path '../.gitconfig'

.ONESHELL:
coc-install:
	cd $(DIR)/pack/bundle/opt/coc.nvim
	yarn install --frozen-lockfile
	cd $(DIR)/.config/coc/extensions
	yarn

gitconfig-prepare:
	git config include.path = ../.gitconfig
	
submodule-update:
	git su

fzf-build:
	cd $(DIR)/pack/bundle/opt/fzf
	make -j4 install -o

start: gitconfig-prepare submodule-update coc-install phpactor-install fzf-build
