" vim-plug
call plug#begin('~/.nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'joshdick/onedark.vim'
call plug#end()

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

set smartindent
set autoindent
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=80
set pastetoggle=<f5>
 
set mouse=a
set clipboard=unnamedplus
set nobackup
set autochdir
set autowriteall
 
set undolevels=1000
set backspace=indent,eol,start
set completeopt-=preview

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

" The leader based key binding
" windows operate
noremap <leader>ws :sp<cr>
noremap <leader>wv :vs<cr>
noremap <leader>wq :q<cr>
noremap <leader>wn <C-w>j
noremap <leader>wi <C-w>k
noremap <leader>wy <C-w>h
noremap <leader>wo <C-w>l

" UI
colorscheme onedark   
set termguicolors
set cursorline
set ruler
set relativenumber
set wildmenu
set laststatus=2
set noshowmode
if !has('gui_running')
  set t_Co=256
endif
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" lightline
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" easy motion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
nmap s <Plug>(easymotion-overwin-f)

" leader F
noremap <F2> :LeaderfFunction!<cr>
let g:Lf_StlColorscheme = 'one'
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_PreviewResult = {'Function':0, 'Colorscheme':1}
let g:Lf_ShortcutF = '<leader>p'
let g:Lf_NormalMap = {
	\ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
	\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
	\ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
	\ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
	\ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
	\ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
	\ }

" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" neosnippet
imap <C-r>  <Plug>(neosnippet_expand_or_jump)
smap <C-r>  <Plug>(neosnippet_expand_or_jump)
xmap <C-r>  <Plug>(neosnippet_expand_target)
