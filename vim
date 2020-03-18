#!/usr/bin/env bash

currentDir="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
initFile="${currentDir}/init.vim"
VIMINIT="$(printf 'source %s' "$initFile")"
export VIMINIT

command vim \
    -u "$initFile" \
    -i "${currentDir}/.config/vim/viminfo" \
    --cmd "set nocp runtimepath=${currentDir},/usr/share/vim/vim82/" \
    "$@"
