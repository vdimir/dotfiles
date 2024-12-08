set shell=/bin/bash

set nocompatible
filetype off

set encoding=UTF-8

map L $
map H ^

set nopaste

filetype plugin indent on
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

syntax off

set hlsearch
set incsearch

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

set ignorecase
set smartcase

set wrap

set mouse=a
set whichwrap=b,s,<,>,[,]

set smartindent
set backspace=indent,eol,start
set autoindent

set cursorline
set scrolloff=5
set sidescrolloff=5
set showcmd
set colorcolumn=99

set hidden

set laststatus=2

set confirm
set visualbell

set wildmenu

set noswapfile
nnoremap <silent> <cr> :nohlsearch<cr><cr>
nnoremap <esc><esc> :silent! nohls<cr>

set number

map <C-d> *#

map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

let mapleader=" "
noremap <Leader>s :update<CR>
inoremap <C-s> <ESC>:update<cr>

set showcmd

set t_ut=
set t_vb=

colorscheme plain
