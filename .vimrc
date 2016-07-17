set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'

Plugin 'airblade/vim-gitgutter'
Plugin 'Valloric/YouCompleteMe'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

Plugin 'altercation/vim-colors-solarized'
call vundle#end()

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

inoremap <C-l> <C-^>
inoremap <C-x> <C-^>

"set spell
"setlocal spell spelllang=ru_ru,en_us

autocmd FocusGained * :redraw!

filetype plugin indent on
syntax on

inoremap <Esc> <Esc>:w<CR>
nmap <leader>T :enew<cr>
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

nmap <leader>w :w<CR>

let g:airline_right_sep = ''
let g:airline_left_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1

let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-s>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

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
set ruler
set colorcolumn=99

set list listchars=tab:→\ ,trail:·

set hidden

set laststatus=2

set confirm
set visualbell

set wildmenu

set noswapfile
nnoremap <silent> <cr> :nohlsearch<cr><cr>
nnoremap E $

nnoremap B ^
map <C-n> :NERDTreeToggle<CR>
let g:NumberToggleTrigger="<F2>"

let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_min_num_of_chars_for_completion = 99
nmap <leader>g :YcmCompleter GoTo<CR>

nmap <S-CR> :a<CR><CR>.<CR>

set showcmd

set background=dark
if has('gui_running')
    colorscheme atom-dark
else
    colorscheme molokai
endif
let g:airline_theme='hybrid'

