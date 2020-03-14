#!/usr/bin/env bash

initFile="$(realpath "$(dirname "${BASH_SOURCE[0]}")/init.vim")"
VIMINIT="$(printf 'source %s' "$initFile")"
export VIMINIT

nvim -i .config/nvim/shada/main.shada "$@"
