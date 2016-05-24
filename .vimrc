set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'scrooloose/nerdtree'
Plugin 'rust-lang/rust.vim'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'eagletmt/neco-ghc'
Plugin 'dhruvasagar/vim-table-mode'
" Plugin 'godlygeek/tabular'
" Plugin 'plasticboy/vim-markdown'
"
"Plugin 'timonv/vim-cargo'
"Plugin 'airblade/vim-gitgutter'
"Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'


"Plugin 'bling/vim-bufferline'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

Plugin 'lervag/vimtex'
"Plugin 'sjl/badwolf'
Plugin 'altercation/vim-colors-solarized'
"Plugin 'racer-rust/vim-racer'
call vundle#end()

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

inoremap <C-l> <C-^>
inoremap <C-x> <C-^>

set spell
setlocal spell spelllang=ru_ru,en_us

autocmd FocusGained * :redraw!
"autocmd BufEnter * :redraw!

filetype plugin indent on
syntax on
"let g:syntastic_rust_rustc_args = "-Zno-trans"

inoremap <Esc> <Esc>:w<CR>
" To open a new empty buffer
" " This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>
" " Move to the next buffer
nmap <leader>l :bnext<CR>
" " Move to the previous buffer
nmap <leader>h :bprevious<CR>
" " Close the current buffer and move to the previous one
" " This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>
" " Show all open buffers and their status
nmap <leader>bl :ls<CR>

nmap <leader>w :w<CR>
"let g:signify_update_on_focusgained = 1
"let g:signify_update_on_bufenter=1
"let g:signify_cursorhold_normal = 100
"let g:signify_cursorhold_insert = 100
"set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim/
let g:airline_powerline_fonts = 1
"let g:airline_right_sep = ''
"let g:airline_left_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1

let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-s>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:UltiSnipsEditSplit="vertical"


"set novisualbell
"noremap <expr> k ((line('.')==1)?'':'k')
"noremap <expr> j ((line('.')==line('$'))?'':'j')

set hlsearch
set incsearch

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

"set number
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

"let &t_SI = "\<Esc>]50;CursorShape=1;BlinkingCursorEnabled=1\x7"
""let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0;BlinkingCursorEnabled=1\x7"

"let &t_SI = "\<Esc>[6 q"
""let &t_SR = "\<Esc>[4 q"
"let &t_EI = "\<Esc>[2 q"

set list listchars=tab:→\ ,trail:·

set hidden

set laststatus=2

set confirm
set visualbell

set wildmenu

"set lazyredraw

"set backup
"set backupdir="/home/deffe/.vim-bcp"
set noswapfile
nnoremap <silent> <cr> :nohlsearch<cr><cr>
nnoremap E $
let g:rust_fold = 1

let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:ycm_semantic_triggers = {'haskell' : ['.']}

nnoremap B ^
map <C-n> :NERDTreeToggle<CR>
"let g:NERDTreeDirArrowExpandable = '>'
"let g:NERDTreeDirArrowCollapsible = 'v'
let g:NumberToggleTrigger="<F2>"

let g:ycm_rust_src_path = "/home/deffe/sources/rust/rustc-1.6.0/src/"
let g:ycm_key_invoke_completion = '<C-Space>'
"let g:ycm_auto_trigger = 0
let g:ycm_min_num_of_chars_for_completion = 99
nmap <leader>g :YcmCompleter GoTo<CR>

nmap <S-CR> :a<CR><CR>.<CR>
"let g:racer_cmd = "racer"
"let $RUST_SRC_PATH="/home/deffe/sources/rust/rustc-1.6.0/src/"

set showcmd
"let g:molokai_original = 1
"colorscheme molokai

set background=dark
colorscheme atom-dark
let g:airline_theme='hybrid'

