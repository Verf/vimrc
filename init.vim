" vim-plug
call plug#begin('~/.nvim/plugged')
call plug#end()

" The key map for norman key board layout
noremap q q
noremap w w
noremap d e
noremap f r
noremap k t
noremap j y
noremap u u
noremap r i
noremap l o
noremap h p
noremap a a
noremap s s
noremap e d
noremap t f
noremap g g
noremap y h
noremap n j
noremap i k
noremap o l
noremap z z
noremap x x
noremap c c
noremap v v
noremap b b
noremap p n
noremap m m
noremap Q Q
noremap W W
noremap D E
noremap F R
noremap K T
noremap J Y
noremap U U
noremap R I
noremap L O
noremap H P
noremap A A
noremap S S
noremap E D
noremap T F
noremap G G
noremap Y H
noremap N J
noremap I K
noremap O L
noremap Z Z
noremap X X
noremap C C
noremap V V
noremap B B
noremap P N
noremap M M

" Basic
let mapleader = " "

set scrolloff=999
set linebreak
set showbreak=+++
set textwidth=80
set showmatch
set visualbell
 
set smartcase
set incsearch
set nohlsearch

set autoindent
set expandtab
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
 
set clipboard=unnamedplus
set nobackup
set autochdir
set autowriteall
 
set undolevels=1000
set backspace=indent,eol,start

" UI
set termguicolors
colorscheme desert
set ruler
set relativenumber
