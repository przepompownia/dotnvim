scriptencoding utf-8

let s:path = expand('<sfile>:p:h')
let g:bundle_dirs = [expand(s:path.'/pack/bundle/start'), expand(s:path.'/pack/bundle/opt')]
let g:arctgx_bundle_dir = expand(s:path.'/pack/bundle/opt/arctgx/')
let s:bundleConfigDir = g:arctgx_bundle_dir . '/bundleConfig/'

let s:earlyrtp=split(&runtimepath, ',')[0]
let g:vimrc_init_per_host = s:earlyrtp . '/' . 'vimrc_init_per_host'
if filereadable(expand(g:vimrc_init_per_host))
  execute 'source ' . expand(g:vimrc_init_per_host)
endif

packadd! arctgx
try
  for s:dir in g:bundle_dirs
    call arctgx#bundle#loadCustomConfiguration(s:dir, s:bundleConfigDir)
  endfor
  set termguicolors
  call arctgx#term#loadConfiguration(g:arctgx_bundle_dir . '/termConfig')
catch /^Vim\%((\a\+)\)\=:E117/
  echomsg v:exception
endtry

if has('mouse')
  set mouse=a
endif

if has('syntax')
  syntax on
endif
filetype plugin indent on

let g:mapleader=','
noremap <S-Insert> <MiddleMouse>
noremap! <S-Insert> <MiddleMouse>
nnoremap <Tab> <C-w>w
nnoremap <C-Tab> :tabNext<CR>
"noremap <C-Tab> <C-w>w
inoremap <C-Tab> <C-o><C-w>w
noremap <F12> <C-w>w
inoremap <F12> <C-o><C-W>w
" enter wybiera pozycję menu jak Ctrl-Y
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <silent> <A-Up> :wincmd k<CR>
nnoremap <silent> <A-Down> :wincmd j<CR>
nnoremap <silent> <A-Left> :wincmd h<CR>
nnoremap <silent> <A-Right> :wincmd l<CR>

nnoremap g<Left> <C-o>
nnoremap g<Right> <C-^>

inoremap <silent> <A-Up> <ESC>:wincmd k<CR>a
inoremap <silent> <A-Down> <ESC>:wincmd j<CR>a
inoremap <silent> <A-Left> <ESC>:wincmd h<CR>a
inoremap <silent> <A-Right> <ESC>:wincmd l<CR>a
inoremap <Insert> <Nop>
noremap Q <Nop>
inoremap <F2> <ESC>:update<CR>a
noremap <F2> <ESC>:update<CR>
noremap <F3> <ESC>:q<CR>
inoremap <F3> <ESC>:q<CR>
noremap <S-F3> <ESC>:q!<CR>
noremap <F15> <ESC>:q!<CR>
inoremap <S-F3> <ESC>:q!<CR>
inoremap <F15> <ESC>:q!<CR>
inoremap <C-Left> <C-o>b
inoremap <C-Right> <C-o>w
inoremap <S-Right> <ESC>v
inoremap <S-Left> <ESC>v
inoremap <F1> <C-o>za
noremap <F1> za
noremap <S-Up> <C-y>
noremap <S-Down> <C-e>
inoremap <C-z> <C-x><C-o>
noremap ]q :cnext<CR>
noremap [q :cprev<CR>
noremap <Leader>co :copen<CR>
noremap / /\c
noremap <Leader>/ /
noremap ? ?\c
nnoremap <Leader>= ggVG=
nnoremap <Leader>hls :let @/ = ''<CR>

" w trybie wstawiania kombinacje Ctrl-F2 .. F10 i tak były nieużywane
for s:key in [5,6,7,9,10]
  execute 'inoremap <F'.s:key.'> <C-o><F'.s:key.'>'
endfor

set pastetoggle=<F11>

set backspace=indent,eol,start

set softtabstop=-1 " the value of 'shiftwidth' is used
set tabstop=4
set shiftwidth=4

set hidden
set nobackup
set updatetime=300
set hlsearch
set incsearch
set wrapscan
let &showbreak='> '

set noruler
set noshowmatch

" Make % work with <>
set matchpairs+=<:>
set spelllang=pl
set splitbelow
set splitright
set noequalalways
set eadirection=hor
"set clipboard=unnamed
set isfname-==
"set shellcmdflag=-ic
set modeline modelines=5
augroup filetypes
  autocmd!
  autocmd FileType config,conf setlocal isfname-==
  autocmd FileType json,yaml setlocal softtabstop=2 shiftwidth=2 expandtab
  autocmd FileType gitcommit setlocal cursorline
augroup END
augroup previews
  autocmd!
  autocmd CompleteDone * pclose
  autocmd WinEnter * if &previewwindow && winnr() > 1 | wincmd L | vertical resize 40 | endif
augroup END
augroup filetypedetect
  autocmd BufNewFile,BufRead  svn-log.* setf svn
  autocmd BufRead,BufNewFile *.yml.dist setfiletype yaml
  autocmd BufRead,BufNewFile composer.lock setfiletype json
augroup END
augroup cmdlineIgnoreCase
  autocmd!
  autocmd CmdLineEnter : let g:case_insensivity = &ignorecase | set ignorecase
  autocmd CmdLineLeave : let &ignorecase = g:case_insensivity | unlet g:case_insensivity
augroup END

set diffopt+=vertical
if has('folding')
  set foldmethod=syntax
  set foldlevelstart=99

  let g:javaScript_fold=1
  let g:perl_fold=1
  let g:php_folding=0
  let g:r_syntax_folding=1
  let g:ruby_fold=1
  let g:sh_fold_enabled=1
  let g:vimsyn_folding='af'
  " let g:xml_syntax_folding=0
  set foldcolumn=1
  noremap zDDD zD
  noremap zddd zd
  noremap zEEE zE
  noremap zD <Nop>
  noremap zd <Nop>
  noremap zE <Nop>

  set foldtext=arctgx#fold#foldText()
endif

set number
set numberwidth=1
set winminheight=0
set switchbuf=usetab

set backupdir=~/.cache/vim,.
set directory=~/.cache/vim,.
set wildmenu
set history=1000
set laststatus=2
set completeopt-=preview
set noignorecase
if (v:version >= 703)
  set wildignorecase
endif
set path=.,,
set showcmd
set noswapfile
set autoread
set sessionoptions-=buffers
set sessionoptions-=help
set sessionoptions-=folds
set grepprg=grep\ --with-filename\ --extended-regexp\ --no-messages\ --color=never\ --binary-files=without-match\ --exclude-dir=.svn\ --exclude=tags\ --exclude=taglist.vim\ --exclude-dir=.git\ --line-number

" set tags=./tags;/
set tags=

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

set title
let &titleold=printf('%s %s', strftime('%F %H:%M:%S'), getcwd())

let s:vimrc_per_host = s:earlyrtp . '/' . 'vimrc_per_host'
if filereadable(expand(s:vimrc_per_host))
  execute 'source ' . expand(s:vimrc_per_host)
endif

set secure
set exrc
