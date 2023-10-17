.PHONY: phpactor-install-extensions phpactor-start-server gitconfig-include-local
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
SHELL := /bin/bash
DIR := ${CURDIR}

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

start: gitconfig-include-local submodule-update git-submodules-hooks-install phpactor-install telescope-fzf-native-build arctgx-start

check-requirements:
	$(DIR)/.config/bin/check-requirements

arctgx-lua-ls-workspace-library:
	cd $(DIR)/nvim/pack/arctgx/opt/arctgx 
	nvim -u $(DIR)/nvim/init.lua -l lua/arctgx/luaLs/generateLuarcJson.lua

arctgx-start:
	cd $(DIR)/nvim/pack/arctgx/opt/arctgx 
	$(MAKE) start
