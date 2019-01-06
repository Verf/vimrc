" vim-plug
call plug#begin('~/.nvim/plugged')
Plug 'w0rp/ale'
Plug 'Chiel92/vim-autoformat'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'skywind3000/asyncrun.vim', {'on': 'AsyncRun'}
Plug 'tpope/vim-vinegar'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'maximbaz/lightline-ale'
Plug 'maximbaz/lightline-ale'
Plug 'easymotion/vim-easymotion'
Plug 'joshdick/onedark.vim'
call plug#end()

" Basic
let mapleader = " "

set scrolloff=999                                          " keep line in center of screen
set linebreak                                              " wrap long line
set showbreak=                                            " label of line break
set textwidth=80                                           " maxium line length

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
noremap <leader>bd :bd<CR>
noremap <leader>bn :bn<CR>
noremap <leader>bp :bp<CR>
" windows operate
noremap <leader>ws <C-w>s                                  " split window vertical
noremap <leader>wv <C-w>v                                  " split window horizontal
noremap <leader>wq <C-w>c                                  " close current window
noremap <leader>wy <C-w>h                                  " jump to the left window
noremap <leader>wn <C-w>j                                  " jump to the below window
noremap <leader>wi <C-w>k                                  " jump to the above window
noremap <leader>wo <C-w>l                                  " jump to the right window
" tab operate
noremap <silent> <leader>tn :tabnew<CR>                     " create new tab
noremap <silent> <leader>tc :tabclose<CR>                   " close current tab
noremap <silent> <leader>1 :tabn 1<CR>                      " switch to tab1
noremap <silent> <leader>2 :tabn 2<CR>                      " switch to tab2
noremap <silent> <leader>3 :tabn 3<CR>                      " switch to tab3
noremap <silent> <leader>4 :tabn 4<CR>                      " switch to tab4
noremap <silent> <leader><tab> :tabnext<CR>                 " switch to next tab

" UI
colorscheme onedark   
set termguicolors                                          " true color support in terminal
set cursorline                                             " highlight current line
set showmatch                                              " highlight matching parenthesis
set novisualbell                                           " no beep and screen flash

set ruler                                                  " show cursor position on status line
set relativenumber                                         " show relative line number
set switchbuf=useopen,usetab,newtab                        " better buffer switch
set noshowmode                                             " don't show insert status (use lightline instead)

" lightline
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \     'left': [ [ 'mode', 'paste' ],
      \               [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \     'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \               [ 'lineinfo' ],
      \               [ 'percent' ],
      \               [ 'fileformat', 'fileencoding', 'filetype' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }
      \ }

" easy motion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
nmap s <Plug>(easymotion-overwin-f)

" leader F
let g:Lf_ShortcutF = '<leader>ff'                          " open file by leaderF
let g:Lf_ShortcutB = '<leader>fb'                          " open buffer by leaderF
let g:Lf_WindowHeight = 0.30                               " pop menu height of leaderF
" marker of root directory
let g:Lf_RootMarkers = [
            \ '.git',
            \ '.hg',
            \ '.svn',
            \ '.python-version',
            \ '.env',
            \ ]
" open file in new tab like mordern editor
let g:Lf_CommandMap = {'<C-T>': ['<CR>']}

" AsyncRun
let g:asyncrun_open = 6                                    " quickfix window height
let g:asyncrun_rootmarks = [
            \ '.git',
            \ '.hg',
            \ '.svn',
            \ '.python-version',
            \ '.env',
            \ ]
nnoremap <silent> <leader>rr :AsyncRun -raw python %<CR>
nnoremap <silent> <leader>rt :call asyncrun#quickfix_toggle(6)<CR>

" ale
let b:ale_linters = {
       \ 'pythoe': ['pylint'],
       \ }

" autoformater
au BufWrite * :Autoformat                                  " autoformat when save
