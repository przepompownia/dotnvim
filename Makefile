.PHONY: *
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
SHELL := /bin/bash
DIR := ${CURDIR}
nvimDir = $(DIR)/nvim
nvimArctgxDir = $(nvimDir)/pack/arctgx/opt/arctgx
nvimInit = $(nvimDir)/init.lua

.ONESHELL:
phpactor-install:
	cd $(nvimDir)/pack/plugins/opt/phpactor
	composer install

gitconfig-include-local:
	git config --local include.path "$$(git rev-parse --show-toplevel)/.gitconfig"

submodule-update:
	git su

.ONESHELL:
telescope-fzf-native-build:
	cd $(nvimDir)/pack/plugins/opt/telescope-fzf-native.nvim
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
	$(MAKE) luarc nvimInit=$(nvimInit) projectDir=$(nvimDir)

.ONESHELL:
arctgx-luarc:
	cd $(nvimArctgxDir)
	$(MAKE) luarc nvimInit=$(nvimInit)

.ONESHELL:
arctgx-start:
	cd $(nvimDir)/pack/arctgx/opt/arctgx 
	$(MAKE) start

helptags:
	nvim -c 'helptags ALL' -c quit

.ONESHELL:
edit-init:
	nvim $(nvimInit) -c "lua vim.cmd.vsplit(vim.fs.joinpath(vim.fn.stdpath('config'), '.nvim.local.lua'))"
	$(MAKE) helptags
	$(MAKE) luarc
	$(MAKE) arctgx-luarc
