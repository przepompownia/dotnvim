.PHONY: phpactor-install-extensions phpactor-start-server gitconfig-include-local coc-install
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
SHELL := /bin/bash

.ONESHELL:
phpactor-install-extensions:
	cd pack/bundle/start/phpactor
	composer install
	mapfile -t exts < config/travis/extensions-to-test
	./bin/phpactor extension:install "$${exts[@]}"

.ONESHELL:
phpactor-start-server:
	cd pack/bundle/start/phpactor
	./bin/phpactor language-server --address=127.0.0.1:8888

gitconfig-include-local:
	git config --local include.path '../.gitconfig'

.ONESHELL:
coc-install:
	cd pack/bundle/start/coc.nvim
	yarn install --frozen-lockfile
