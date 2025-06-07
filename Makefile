.PHONY: *
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
SHELL := /bin/bash
DIR := ${CURDIR}
nvimArctgxDir = $(DIR)/nvim/pack/arctgx/opt/arctgx
nvimInit = $(DIR)/nvim/init.lua

.ONESHELL:
phpactor-install:
	cd $(DIR)/nvim/pack/plugins/opt/phpactor
	composer install

gitconfig-include-local:
	git config --local include.path "$$(git rev-parse --show-toplevel)/.gitconfig"

submodule-update:
	git su

.ONESHELL:
telescope-fzf-native-build:
	cd $(DIR)/nvim/pack/plugins/opt/telescope-fzf-native.nvim
	$(MAKE) -j CC=gcc

git-submodules-hooks-install:
	$(DIR)/.config/bin/git-submodules-hooks-install . .config/git-submodules/.config

git-submodules-sync:
	git submodule sync --recursive

update-non-submodule-plugins:
	git list-non-submodules | parallel --group -- 'git -C {} pull || echo "Error on {}."' | command grep -v "Already up to date." || true

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

helptags:
	nvim -c 'helptags ALL' -c quit

.ONESHELL:
edit-init:
	nvim -O $(nvimInit) nvim/.nvim.lua
	$(MAKE) helptags
	$(MAKE) luarc
	$(MAKE) arctgx-luarc
