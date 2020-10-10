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
if has('win32')
    call plug#begin('~\AppData\Local\nvim\plugged')
else
    call plug#begin('~/.config/nvim/plugged')
endif
Plug 'tpope/vim-vinegar'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'itchyny/calendar.vim'
Plug 'vimwiki/vimwiki'
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
call plug#end()

" Basic
set nocompatible
filetype plugin on
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
set timeoutlen=1500                                         " timeout for map sequence (ms)

set scrolloff=999                                           " keep line in center of screen
set linebreak                                               " wrap long line
set showbreak=⮎                                             " label of line break
set nowrap                                                  " close autowrap
set textwidth=80                                            " autowrap line length
set encoding=utf-8                                          " set default encoding to utf-8
set fileencoding=utf-8                                      " set default file encoding to utf-8
set termencoding=utf-8                                      " set default terminal encoding to utf-8

set smartcase                                               " case sensitive only if pattern contains upper letter
set incsearch                                               " incrementally highlights all pattern matches
set nohlsearch                                              " don't highlight search pattern

set autoindent                                              " automatically indent when starting a new line
set smartindent                                             " automatically inserts one extra level of indentation in some cases
set expandtab                                               " replace tab to blanks
set smarttab                                                " <Tab> insert blanks according to 'shiftwidth', 'tabstop' or 'softabstop'
set tabstop=4                                               " number of spaces that a <Tab> in the file count for
set softtabstop=4                                           " number of spaces that a <Tab> is inserted
set shiftwidth=4                                            " number of spaces to use for (auto)indent
set report=0                                                " always report changed lines

set synmaxcol=200                                           " maxium column for search syntax items
set updatecount=100                                         " after type this many characters the swap file will be written to disk
set updatetime=300                                          " updatetime for CursorHold & CursorHoldI

set mouse=a                                                 " enable mouse in all mode
set autochdir
set clipboard=unnamedplus                                   " use system clip board
set pastetoggle=<F9>                                        " toggle paste mode by <F9>
set nobackup                                                " close auto backup
set nowritebackup                                           " close auto write
set hidden
set shortmess+=c                                            " don't give ins-completion-menu messages
set signcolumn=yes                                          " always show signcolumns

" UI
colorscheme onedark                                         " set colorscheme
set background=dark                                         " set background color
set termguicolors                                           " true color support in terminal
set cursorline                                              " highlight current line
set showmatch                                               " highlight matching parenthesis
set novisualbell                                            " no beep and screen flash
set showtabline=2                                           " show tabline

set ruler                                                   " show cursor position on status line
set relativenumber                                          " show relative line number
set switchbuf=useopen,usetab,newtab                         " better buffer switch
set noshowmode                                              " don't show insert status (use lightline instead)

" netrw
let g:netrw_banner = 0                                      " hidden netrw top banner
let g:netrw_liststyle = 3                                   " set display style to wide
let g:netrw_winsize = 25                                    " set netrw window width to 25%

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
nnoremap <silent> <leader>so :e $MYVIMRC<CR>                " open vimrc
nnoremap <silent> <leader>sr :source $MYVIMRC<CR>           " reload vimrc
" buffer operate
nnoremap <silent> <leader>bq :bd<CR>                        " close current buffer
nnoremap <silent> <leader>bn :bn<CR>                        " switch to next buffer
nnoremap <silent> <leader>bp :bp<CR>                        " switch to previous buffer
" windows operate
nnoremap <silent> <leader>ws <C-w>s                         " split window vertical
nnoremap <silent> <leader>wv <C-w>v                         " split window horizontal
nnoremap <silent> <leader>wq <C-w>c                         " close current window
nnoremap <silent> <leader>wt <C-w>T                         " move current window to new tab
nnoremap <silent> <leader>wy <C-w>h                         " jump to the left window
nnoremap <silent> <leader>wn <C-w>j                         " jump to the below window
nnoremap <silent> <leader>wi <C-w>k                         " jump to the above window
nnoremap <silent> <leader>wo <C-w>l                         " jump to the right window
nnoremap <silent> <leader>wc :only<CR>                      " close all the other windows
" tab operate
nnoremap <silent> <leader>tn :tabnew<CR>                    " create new tab
nnoremap <silent> <leader>tq :tabclose<CR>                  " close current tab
nnoremap <silent> <leader>1 :tabn 1<CR>                     " switch to tab1
nnoremap <silent> <leader>2 :tabn 2<CR>                     " switch to tab2
nnoremap <silent> <leader>3 :tabn 3<CR>                     " switch to tab3
nnoremap <silent> <leader>4 :tabn 4<CR>                     " switch to tab4
nnoremap <silent> <leader><tab> :tabnext<CR>                " switch to next tab
" buffer operate
nmap <silent> <leader><tab> <C-^>                           " switch to last buffer
nmap <silent> <Leader>1 :b1<CR>                             " switch to buffer 1
nmap <silent> <Leader>2 :b2<CR>                             " switch to buffer 2
nmap <silent> <Leader>3 :b3<CR>                             " switch to buffer 3
nmap <silent> <Leader>4 :b4<CR>                             " switch to buffer 4
nmap <silent> <Leader>5 :b5<CR>                             " switch to buffer 5

" lightline
let g:lightline#bufferline#show_number = 2
let g:lightline = {
            \ 'colorscheme': 'onedark',
            \ 'active': {
            \     'left': [ [ 'mode', 'paste' ],
            \               [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ],
            \     'right': [[ 'lineinfo' ],
            \               [ 'percent' ],
            \               [ 'fileformat', 'fileencoding', 'filetype' ]]
            \ },
            \ 'tabline': {
            \   'left': [ ['buffers'] ],
            \   'right': [ ['close'] ]
            \ },
            \ 'component_expand': {
            \   'buffers': 'lightline#bufferline#buffers'
            \ },
            \ 'component_type': {
            \   'buffers': 'tabsel'
            \ },
            \ 'component_function': {
            \     'gitbranch': 'gitbranch#name',
            \ },
            \ }

" easy motion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map s <Plug>(easymotion-overwin-f)

" vimwiki
let g:vimwiki_list = [{'path': '~/Sync/Notes', 'syntax': 'markdown', 'ext': '.md'}]

" coc.nvim
" trigger completion
inoremap <silent><expr> <c-/> coc#refresh()
" use tab to select and expand snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
" goto code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" symbol rename
nmap <leader>rn <Plug>(coc-rename)
" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>cn  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>ci  :<C-u>CocPrev<CR>
" view all errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<CR>
