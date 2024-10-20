.PHONY: *
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
SHELL := /bin/bash
DIR := ${CURDIR}
nvimArctgxDir = $(DIR)/nvim/pack/arctgx/opt/arctgx
nvimInit = $(DIR)/nvim/init.lua

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

.ONESHELL:
luarc:
	cd $(nvimArctgxDir)
	$(MAKE) luarc nvimInit=$(nvimInit) projectDir=$(DIR)

.ONESHELL:
arctgx-luarc:
	cd $(nvimArctgxDir)
	$(MAKE) luarc nvimInit=$(nvimInit)

.ONESHELL:
arctgx-start:
	cd $(DIR)/nvim/pack/arctgx/opt/arctgx 
	$(MAKE) start

edit-init:
	nvim nvim/init.lua

edit-local-init:
	nvim nvim/.nvim.lua
