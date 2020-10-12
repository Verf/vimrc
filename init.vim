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
Plug 'liuchengxu/vim-which-key'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'itchyny/calendar.vim'
Plug 'vimwiki/vimwiki'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-rooter'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'joshdick/onedark.vim'
call plug#end()

" =========
"   Basic
" =========
set nocompatible
filetype plugin on
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
set timeoutlen=1500                                        " timeout for map sequence (ms)

set scrolloff=999                                          " keep line in center of screen
set linebreak                                              " wrap long line
set showbreak=⮎                                            " label of line break
set nowrap                                                 " close autowrap
set textwidth=80                                           " autowrap line length
set encoding=utf-8                                         " set default encoding to utf-8
set fileencoding=utf-8                                     " set default file encoding to utf-8
set termencoding=utf-8                                     " set default terminal encoding to utf-8

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
set updatetime=300                                         " updatetime for CursorHold & CursorHoldI

set mouse=a                                                " enable mouse in all mode
set autochdir
set clipboard=unnamedplus                                  " use system clip board
set pastetoggle=<F9>                                       " toggle paste mode by <F9>
set nobackup                                               " close auto backup
set nowritebackup                                          " close auto write
set hidden
set shortmess+=c                                           " don't give ins-completion-menu messages
set signcolumn=yes                                         " always show signcolumns

" UI
colorscheme onedark                                        " set colorscheme
set background=dark                                        " set background color
set termguicolors                                          " true color support in terminal
set cursorline                                             " highlight current line
set showmatch                                              " highlight matching parenthesis
set novisualbell                                           " no beep and screen flash
set showtabline=2                                          " show tabline

set ruler                                                  " show cursor position on status line
set relativenumber                                         " show relative line number
set switchbuf=useopen,usetab,newtab                        " better buffer switch
set noshowmode                                             " don't show insert status (use lightline instead)


" ================
"   Key Bindings
" ================
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

" F-filed
noremap <silent> <F2> :Defx<CR>

" vim-which-key
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
set timeoutlen=500
" Define prefix dictionary
let g:which_key_map =  {}

" The leader based key binding
let g:which_key_map.s = {
    \ 'name': '+settings',
    \ 'o': 'open-vimrc',
    \ 'r': 'reload-vimrc'
    \ }
nnoremap <silent> <leader>so :e $MYVIMRC<CR>               " open vimrc
nnoremap <silent> <leader>sr :source $MYVIMRC<CR>          " reload vimrc
" buffer operate
let g:which_key_map.q = 'close buffer'
nnoremap <silent> <leader>q :bd!<CR>                       " close current buffer
let g:which_key_map.n= 'next buffer'
nnoremap <silent> <leader>n :bn<CR>                        " switch to next buffer
let g:which_key_map.p= 'previous buffer'
nnoremap <silent> <leader>p :bp<CR>                        " switch to previous buffer
" windows operate
let g:which_key_map.w = {
    \ 'name': '+windows',
    \ 'h': 'split window horizontal',
    \ 'v': 'split window vertical',
    \ 'q': 'close current window',
    \ 't': 'move window to tab',
    \ 'y': 'jump to left window',
    \ 'n': 'jump to below window',
    \ 'i': 'jump to above window',
    \ 'o': 'jump to right window',
    \ 'c': 'close all the other windows'
    \ }
nnoremap <silent> <leader>wh <C-w>s                        " split window horizontal
nnoremap <silent> <leader>wv <C-w>v                        " split window vertical
nnoremap <silent> <leader>wq <C-w>c                        " close current window
nnoremap <silent> <leader>wt <C-w>T                        " move current window to new tab
nnoremap <silent> <leader>wy <C-w>h                        " jump to the left window
nnoremap <silent> <leader>wn <C-w>j                        " jump to the below window
nnoremap <silent> <leader>wi <C-w>k                        " jump to the above window
nnoremap <silent> <leader>wo <C-w>l                        " jump to the right window
nnoremap <silent> <leader>wc :only<CR>                     " close all the other windows

" ===================
"   Plugin Settings
" ===================
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
let g:which_key_map.n = {
    \ 'name': 'Notes',
    \ 'i': 'open index',
    \ 's': 'select availdable wiki',
    \ 'd': 'open diary index',
    \ 'w': 'open today',
    \ 'y': 'open yesterday',
    \ 't': 'open tomorrow',
    \ }
nmap <silent> <leader>ni <Plug>VimwikiIndex
nmap <silent> <leader>ns <Plug>VimwikiUISelect
nmap <silent> <leader>nd <Plug>VimwikiDiaryIndex
nmap <silent> <leader>nw <Plug>VimwikiMakeDiaryNote
nmap <silent> <leader>ny <Plug>VimwikiMakeYesterdayNote
nmap <silent> <leader>nt <Plug>VimwikiMakeTomorrowDiaryNote

" coc.nvim
" use tab to select and expand snippets
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" enter to select
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

let g:coc_snippet_next = '<tab>'
" goto code navigation
let g:which_key_map.g= {
    \ 'name': 'next buffer',
    \ 'd': 'goto definition',
    \ 'y': 'type definition',
    \ 'i': 'goto implementation',
    \ 'r': 'show references'
    \ }
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" symbol rename
let g:which_key_map.r = {
    \ 'name': '+rename',
    \ 'n': 'rename symbol'
    \ }
nmap <leader>rn <Plug>(coc-rename)
" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" Mappings for CoCList
" Show all diagnostics.
let g:which_key_map.l= {
    \ 'name': '+CocList',
    \ 'd': 'diagnostics',
    \ 'e': 'extensions',
    \ 'c': 'commands',
    \ 'f': 'files',
    \ 'b': 'buffers',
    \ 'o': 'outline',
    \ 's': 'symbols',
    \ 'r': 'recent files'
    \ }
nnoremap <silent><nowait> <leader>ld  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <leader>le  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <leader>lc  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <leader>lf  :<C-u>CocList files<cr>
nnoremap <silent><nowait> <leader>lb  :<C-u>CocList buffers<cr>
nnoremap <silent><nowait> <leader>lo  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <leader>ls  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <leader>lr  :<C-u>CocList mru<cr>
" multiple cursor
nmap <silent> <C-s> <Plug>(coc-cursors-word)*
xmap <silent> <C-s> y/\V<C-r>=escape(@",'/\')<CR><CR>gN<Plug>(coc-cursors-range)gn

" defx
call defx#custom#option('_', {
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1
      \ })
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>    defx#do_action('open')
    nnoremap <silent><buffer><expr>  c      defx#do_action('copy')
    nnoremap <silent><buffer><expr>  m      defx#do_action('move')
    nnoremap <silent><buffer><expr>  p      defx#do_action('paste')
    nnoremap <silent><buffer><expr>  l      defx#do_action('open')
    nnoremap <silent><buffer><expr>  V      defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr>  o      defx#do_action('open_tree', 'toggle')
    nnoremap <silent><buffer><expr>  K      defx#do_action('new_directory')
    nnoremap <silent><buffer><expr>  N      defx#do_action('new_file')
    nnoremap <silent><buffer><expr>  M      defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr>  C      defx#do_action('toggle_columns, dent:icon:filename:type:size:time')
    nnoremap <silent><buffer><expr>  S      defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr>  d      defx#do_action('remove')
    nnoremap <silent><buffer><expr>  r      defx#do_action('rename')
    nnoremap <silent><buffer><expr>  !      defx#do_action('execute_command')
    nnoremap <silent><buffer><expr>  x      defx#do_action('execute_system')
    nnoremap <silent><buffer><expr>  yy     defx#do_action('yank_path')
    nnoremap <silent><buffer><expr>  .      defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr>  -      defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr>  ~      defx#do_action('cd')
    nnoremap <silent><buffer><expr>  q      defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr>  *      defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr>  n      line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr>  i      line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l>   defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>   defx#do_action('print')
    nnoremap <silent><buffer><expr>  cd     defx#do_action('change_vim_cwd')
endfunction

" rooter
let g:rooter_patterns = ['.git', 'pom.xml', '.project', '.classpath']
let g:rooter_change_directory_for_non_project_files = 'current'

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
