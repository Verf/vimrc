set nocompatible
syntax on
filetype on
filetype plugin on
filetype indent on

language en_US
language messages en_US
language ctype en_US
language time en_US
let $LANG = 'en_US'

set number
set relativenumber
set cursorline
set autoindent
set autoread
set autowrite
set expandtab
set nobackup
set nowrap
set hidden
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set nohlsearch
set wildmenu
set ttyfast
set splitright
set splitbelow
set noswapfile

set updatetime=750
set iminsert=0
set imsearch=0
set t_Co=256
set shiftwidth=4
set tabstop=4
set softtabstop=4
set history=1000
set scrolloff=999
set encoding=utf-8
set clipboard=unnamedplus
set fileformats=unix,dos,mac
set display=lastline
set backspace=indent,eol,start
set wildmode=list:longest
set fillchars=stl:\ ,stlnc:\ ,fold:\ ,vert:│
set shell=pwsh\ -nol
set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command\ [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;
set shellquote=
set shellxquote=

command! Trim :%s/\s\+$//e
command! Trimline :%g/^$/d

nnoremap d e
nnoremap f r
nnoremap k t
nnoremap j y
nnoremap r i
nnoremap l o
nnoremap e d
nnoremap t f
nnoremap y h
nnoremap n j
nnoremap i k
nnoremap o l
nnoremap p n
nnoremap h ;
nnoremap ; p
nnoremap D E
nnoremap F R
nnoremap K T
nnoremap J Y
nnoremap R I
nnoremap L O
nnoremap E D
nnoremap T F
nnoremap Y H
nnoremap N J
nnoremap I K
nnoremap O L
nnoremap P N
nnoremap H :
nnoremap : P

onoremap d e
onoremap f r
onoremap k t
onoremap j y
onoremap r i
onoremap l o
onoremap e d
onoremap t f
onoremap y h
onoremap n j
onoremap i k
onoremap o l
onoremap p n
onoremap h ;
onoremap ; p
onoremap D E
onoremap F R
onoremap K T
onoremap J Y
onoremap R I
onoremap L O
onoremap E D
onoremap T F
onoremap Y H
onoremap N J
onoremap I K
onoremap O L
onoremap P N
onoremap H :
onoremap : P

xnoremap d e
xnoremap f r
xnoremap k t
xnoremap j y
xnoremap r i
xnoremap l o
xnoremap e d
xnoremap t f
xnoremap y h
xnoremap n j
xnoremap i k
xnoremap o l
xnoremap p n
xnoremap h ;
xnoremap ; p
xnoremap D E
xnoremap F R
xnoremap K T
xnoremap J Y
xnoremap R I
xnoremap L O
xnoremap E D
xnoremap T F
xnoremap Y H
xnoremap N J
xnoremap I K
xnoremap O L
xnoremap P N
xnoremap H :
xnoremap : P

call plug#begin()
Plug 'dracula/vim'
Plug 'sbdchd/neoformat'
Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'airblade/vim-rooter'
Plug '907th/vim-auto-save'
Plug 'andymass/vim-matchup'
Plug 'voldikss/vim-floaterm'
Plug 'chaoren/vim-wordmotion'
Plug 'junegunn/vim-easy-align'
Plug 'farmergreg/vim-lastplace'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
call plug#end()

colorscheme dracula

vnoremap < <gv
vnoremap > >gv

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nnoremap <TAB> :bn<CR>
nnoremap <S-TAB> :bp<CR>
nnoremap <F1> :FloatermToggle<CR>
tnoremap <F1> <C-\><C-n>:FloatermToggle<CR>
tnoremap <ESc> <C-\><C-n>
tnoremap <C-t> <C-\><C-n>:FloatermNew<CR>
tnoremap <C-n> <C-\><C-n>:FloatermNext<CR>
tnoremap <C-p> <C-\><C-n>:FloatermPrev<CR>

let mapleader = " "
nnoremap <leader>qa :wqa<CR>
nnoremap <leader>qq :bd!<CR>

nnoremap <leader>fm :Neoformat<CR>

nnoremap <leader>wc :only<CR>
nnoremap <leader>wq :close<CR>
nnoremap <leader>wh <C-w>s
nnoremap <leader>wv <C-w>v
nnoremap <leader>wy <C-w>h
nnoremap <leader>wn <C-w>j
nnoremap <leader>wi <C-w>k
nnoremap <leader>wo <C-w>l
nnoremap <leader>wY <C-w>H
nnoremap <leader>wN <C-w>J
nnoremap <leader>wI <C-w>K
nnoremap <leader>wO <C-w>L

let g:auto_save = 1

let g:rooter_patterns = ['.git', 'make.sh', 'MakeFile', 'pom.xml', 'package.json']
let g:rooter_change_directory_for_non_project_files = 'current'

let g:floaterm_width = 0.8
let g:floaterm_height = 0.8

let g:wordmotion_mappings = {'e': 'd', 'E': 'D'}

let g:sneak#s_next = 1

let g:airline#extensions#tabline#enabled = 1

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_clear_cache_on_exit = 0
endif
