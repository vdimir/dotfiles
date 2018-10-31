set shell=/bin/bash

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'jpalardy/vim-slime'
Plugin 'Shougo/neocomplete.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'terryma/vim-multiple-cursors'
"Plugin 'paradigm/vim-multicursor'
call vundle#end()

map L $
map H ^

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:neocomplete#enable_at_startup = 1

inoremap <expr><C-Space> pumvisible() ? "\<C-Space>" : "\<C-n>"

let g:haddock_browser="chromium"
let g:necoghc_enable_detailed_browse = 1


let g:NERDTrimTrailingWhitespace = 1
let g:NERDSpaceDelims = 1
let g:NERDAltDelims_haskell = 1

nnoremap <c-_> :call NERDComment('n',"toggle")<CR>j
vnoremap <c-_> :call NERDComment('x',"toggle")<CR>

set wildignore+=*/node_modules/*

let g:slime_target = "tmux"
nmap <c-c><c-l> :SlimeSend0 "<c-l>"<CR>
nmap <c-c><c-x> :SlimeSend0 ":r"<CR>
imap <C-c> <ESC>:SlimeSend<CR>
let g:slime_dont_ask_default = 1

let g:slime_default_config = {"socket_name": "default", "target_pane": "slime:0.0"}

let g:airline_powerline_fonts = 1
let g:airline_right_sep = ''
let g:airline_left_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1

filetype plugin indent on
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

syntax on

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
"set ruler
set colorcolumn=99

" set list listchars=tab:→\ ,trail:·

set hidden

set laststatus=2

set confirm
set visualbell

set wildmenu

set noswapfile
nnoremap <silent> <cr> :nohlsearch<cr><cr>

map <C-d> :NERDTreeToggle<CR>

let g:NumberToggleTrigger="<F2>"
set number

nmap <S-CR> :a<CR><CR>.<CR>

let mapleader=" "
noremap <Leader>s :update<CR>
inoremap <C-s> <ESC>:update<cr>

set showcmd

set t_ut=

colorscheme distinguished
"colorscheme molokai
"
"autocmd VimEnter,VimLeave * silent !tmux set status
"
