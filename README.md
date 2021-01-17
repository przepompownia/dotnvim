# Personal portable vim environment

## Goals
	- Have more than one independent vim environment that not share data and configuration with any other. You can test plugin combinations unusual for you without changing your regular vim environment.
	- Allow easily disable extensions from running (by commenting `packadd!` in `init.vim`) or remove.

## Install and configure extensions
	- Run `make check-requirements` to check requirements that may be needed to use extensions used there
	- Run `make start` to configure local git aliases, then fetch, install and prepare extensions

## Running
```sh
	./bin/vim
	./bin/nvim
```

	You can append "</path/to/this/project>/bin" to "$PATH" in your shell environment if you want to use some copy of this project as a regular vim environment. Then check if the above executables replace the previously used `vim` and `neovim` (`command -V nvim` for example). It also simplifies using this executables by GUI (nvim-qt, vim -G).
