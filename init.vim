"  __      _______ __  __ _____   _____ 
"  \ \    / /_   _|  \/  |  __ \ / ____|
"   \ \  / /  | | | \  / | |__) | |     
"    \ \/ /   | | | |\/| |  _  /| |     
"     \  /   _| |_| |  | | | \ \| |____ 
"      \/   |_____|_|  |_|_|  \_\\_____|
"                                       
" Vimrc for Verf
"
" vim-plug
call plug#begin('~/.nvim/plugged')
Plug 'tpope/vim-vinegar'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'easymotion/vim-easymotion'
Plug 'vim-python/python-syntax'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'neomake/neomake'
Plug 'SirVer/ultisnips'
Plug 'Shougo/echodoc.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
call plug#end()

" Basic
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
set timeoutlen=1500                                        " timeout for map sequence (ms)

set scrolloff=999                                          " keep line in center of screen
set linebreak                                              " wrap long line
set showbreak=⮎                                            " label of line break
set nowrap                                                 " close autowrap
set textwidth=80                                           " autowrap line length

set smartcase                                              " case sensitive only if pattern contains upper letter
set incsearch                                              " incrementally highlights all pattern matches
set nohlsearch                                             " don't highlight search pattern

set autoindent                                             " automatically indent when starting a new line
set smartindent                                            " automatically inserts one extra level of indentation in some cases
set expandtab                                              " replace tab to blanks
set smarttab                                               " <Tab> insert blanks according to 'shiftwidth', 'tabstop' or 'softabstop'
set tabstop=4                                              " number of spaces that a <Tab> in the file count for
set softtabstop=4                                          " number of spaces that a <Tab> is inserted
set shiftwidth=4                                           " number of spaces to use for (auto)indent
set report=0                                               " always report changed lines
set synmaxcol=200                                          " maxium column for search syntax items
set updatecount=100                                        " after type this many characters the swap file will be written to disk

set mouse=a                                                " enable mouse in all mode
set clipboard=unnamedplus                                  " use system clip board
set pastetoggle=<F9>                                       " toggle paste mode by <F9>
set nobackup                                               " close auto backup
set autowriteall                                           " auto save

" extra setting
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=yes


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
" buffer operate
nnoremap <leader>bq :bd<CR>                                 " close current buffer
nnoremap <leader>bn :bn<CR>                                 " switch to next buffer
nnoremap <leader>bp :bp<CR>                                 " switch to previous buffer
" windows operate
nnoremap <leader>ws <C-w>s                                  " split window vertical
nnoremap <leader>wv <C-w>v                                  " split window horizontal
nnoremap <leader>wq <C-w>c                                  " close current window
nnoremap <leader>wt <C-w>T                                  " move current window to new tab
nnoremap <leader>wy <C-w>h                                  " jump to the left window
nnoremap <leader>wn <C-w>j                                  " jump to the below window
nnoremap <leader>wi <C-w>k                                  " jump to the above window
nnoremap <leader>wo <C-w>l                                  " jump to the right window
" tab operate
nnoremap <silent> <leader>tn :tabnew<CR>                     " create new tab
nnoremap <silent> <leader>tq :tabclose<CR>                   " close current tab
nnoremap <silent> <leader>1 :tabn 1<CR>                      " switch to tab1
nnoremap <silent> <leader>2 :tabn 2<CR>                      " switch to tab2
nnoremap <silent> <leader>3 :tabn 3<CR>                      " switch to tab3
nnoremap <silent> <leader>4 :tabn 4<CR>                      " switch to tab4
nnoremap <silent> <leader><tab> :tabnext<CR>                 " switch to next tab

" UI
colorscheme onedark
set background=dark
set termguicolors                                          " true color support in terminal
set cursorline                                             " highlight current line
set showmatch                                              " highlight matching parenthesis
set novisualbell                                           " no beep and screen flash

set ruler                                                  " show cursor position on status line
set relativenumber                                         " show relative line number
set switchbuf=useopen,usetab,newtab                        " better buffer switch
set noshowmode                                             " don't show insert status (use lightline instead)

" Language
" python
let g:python_highlight_all = 1

" lightline
let g:lightline = {
            \ 'colorscheme': 'onedark',
            \ 'active': {
            \     'left': [ [ 'mode', 'paste' ],
            \               [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ],
            \     'right': [[ 'lineinfo' ],
            \               [ 'percent' ],
            \               [ 'fileformat', 'fileencoding', 'filetype' ]]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'gitbranch#name',
            \   'cocstatus': 'coc#status',
            \ },
            \ }

" easy motion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map s <Plug>(easymotion-overwin-f)
map <Leader>gn <Plug>(easymotion-j)
map <Leader>gi <Plug>(easymotion-k)

" leaderF
let g:Lf_HideHelp = 1
let g:Lf_ReverseOrder = 1                                  " show result bottom to top
let g:Lf_ShortcutF = '<leader>ff'                          " open file by leaderF
let g:Lf_ShortcutB = '<leader>fb'                          " open buffer by leaderF
let g:Lf_WindowHeight = 0.30                               " pop menu height of leaderF
let g:Lf_CommandMap = {'<C-T>': ['<CR>']}                  " open file in new tab
" marker of root directory
let g:Lf_RootMarkers = [
            \ '.git',
            \ '.hg',
            \ '.svn',
            \ '.python-version',
            \ '.env',
            \ '.root',
            \ ]

" Deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Ultisnips
let g:UltiSnipsExpandTrigger="<M-Tab>"
let g:UltiSnipsJumpForwardTrigger="<M-n>"
let g:UltiSnipsJumpBackwardTrigger="<M-i>"
