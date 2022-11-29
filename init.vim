scriptencoding utf-8

let g:initialVimDirectory = expand('<sfile>:p:h')
let g:bundle_dirs = [
      \ expand(g:initialVimDirectory . '/pack/bundle/opt'),
      \ expand(g:initialVimDirectory . '/pack/colorscheme/opt'),
      \ ]
let &runtimepath = g:initialVimDirectory.','.&runtimepath.','.g:initialVimDirectory.'/after'
let &packpath = &runtimepath

let g:vimrc_init_per_host = g:initialVimDirectory . '/' . 'vimrc_init_per_host'
if filereadable(expand(g:vimrc_init_per_host))
  execute 'source ' . expand(g:vimrc_init_per_host)
endif

packadd! fugitive
if has('nvim')
  packadd! cmp-buffer
  packadd! cmp-luasnip
  packadd! cmp-nvim-lsp
  packadd! cmp-path
  packadd! colorscheme-modus
  packadd! gitsigns.nvim
  packadd! leap.nvim
  packadd! lsp_signature
  packadd! lualine.nvim
  packadd! luasnip
  packadd! null-ls.nvim
  packadd! nvim-autopairs
  packadd! nvim-bqf
  packadd! nvim-cmp
  packadd! nvim-dap
  packadd! nvim-dap-ui
  packadd! nvim-dap-virtual-text
  packadd! nvim-lspconfig
  packadd! nvim-treesitter
  packadd! nvim-treesitter-context
  packadd! nvim-treesitter-refactor
  packadd! nvim-treesitter-textobjects
  packadd! treesj
  packadd! nvim-ts-context-commentstring
  packadd! nvim-ts-rainbow
  packadd! nvim-tree.lua
  packadd! osv-dap-nvim
  packadd! plenary.nvim
  packadd! schemastore.nvim
  packadd! telescope-fzf-native.nvim
  packadd! telescope.nvim
  packadd! telescope-ui-select.nvim
  packadd! nvim-notify
  packadd! nui.nvim
  packadd! noice.nvim
  packadd! phpactor
  packadd impatient.nvim
  lua require('impatient')
endif
packadd! surround
packadd! vim-commentary
packadd! vim-dispatch
packadd! vim-move
packadd! vim-pasta
packadd! vim-repeat
packadd! vim-rhubarb
packadd! vim-spacejam
packadd! vim-test
packadd! vim-unimpaired
packadd! vim-dadbod
packadd! vim-dadbod-ui
packadd! arctgx

let s:vimrc_per_host = g:initialVimDirectory . '/' . 'vimrc_per_host.vim'
if filereadable(expand(s:vimrc_per_host))
  execute 'source ' . expand(s:vimrc_per_host)
endif
