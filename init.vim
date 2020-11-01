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
    silent! call plug#begin('~\AppData\Local\nvim\plugged')
else
    silent! call plug#begin('~/.config/nvim/plugged')
endif
Plug 'liuchengxu/vim-which-key'
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'vimwiki/vimwiki'
Plug 'jiangmiao/auto-pairs'
Plug '907th/vim-auto-save'
Plug 'Verf/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-rooter'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
Plug 'liuchengxu/vista.vim'
Plug 'joshdick/onedark.vim'
call plug#end()


" ==========
"   Server
" ==========
if has('win32')
    silent! call serverstart('\\.\pipe\nvim-pipe-12345')
endif

" =========
"   Basic
" =========
filetype plugin on
language en_US
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
set timeoutlen=1000                                        " timeout for map sequence (ms)

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

set undofile
set undolevels=1000
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
set termguicolors                                          " true color support in terminal
set cursorline                                             " highlight current line
set showmatch                                              " highlight matching parenthesis
set showtabline=2                                          " show tabline
set relativenumber                                         " show relative line number
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
" g field
noremap g g
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

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

nmap / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)


" vim-which-key
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

let g:which_key_map =  {}
let g:which_key_map.Space = 'Goto Char'
nmap <silent> <leader><leader> <Plug>(easymotion-overwin-f)
let g:which_key_map.a = {
            \ 'name': '+Application',
            \ 'w': {
            \     'name': '+Wiki',
            \     'i': 'Wiki Index',
            \     'n': 'Wiki New',
            \     'd': 'Wiki Delete',
            \     'r': 'Wiki Rename',
            \     },
            \ 'd': {
            \     'name': '+Diary',
            \     'i': 'Diary Index',
            \     'd': 'Make Today',
            \     'y': 'Make Yesterday',
            \     't': 'Make Tomorrow',
            \   },
            \ }
nmap <silent> <leader>awi <Plug>VimwikiIndex
nmap <silent> <leader>awn <Plug>VimwikiGoto
nmap <silent> <leader>awd <Plug>VimwikiDeleteFile
nmap <silent> <leader>awr <Plug>VimwikiRenameFile
nmap <silent> <leader>adi <Plug>VimwikiDiaryIndex
nmap <silent> <leader>add <Plug>VimwikiMakeDiaryNote
nmap <silent> <leader>ady <Plug>VimwikiMakeYesterdayNote
nmap <silent> <leader>adt <Plug>VimwikiMakeTomorrowDiaryNote
let g:which_key_map.b = {
            \ 'name': '+Buffers',
            \ 'q': 'Close Buffer',
            \ 'n': 'Next Buffer',
            \ 'p': 'Previous Buffer',
            \ 'Tab': 'Buffer Jump',
            \ }
nmap <silent> <leader>bq :BufferClose<CR><CR>
nmap <silent> <leader>bn :BufferNext<CR>
nmap <silent> <leader>bp :BufferPrevious<CR>
nmap <silent> <leader><Tab> :BufferPick<CR>
let g:which_key_map.c = {
            \ 'name': '+Commenter',
            \ }
" let g:which_key_map.d = {}
" let g:which_key_map.e = {}
let g:which_key_map.f = {
    \ 'name': '+Files',
    \ 'f': 'File Search',
    \ 'd': 'Directory View',
    \ 't': 'Tags View',
    \ 'm': 'File MRU'
    \ }
nmap <silent> <leader>fd :Defx<CR>
nmap <silent> <leader>ft :Vista!!<CR>
nmap <silent> <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
let g:which_key_map.g= {
            \ 'name': 'Goto',
            \ 'd': 'goto definition',
            \ 'y': 'type definition',
            \ 'i': 'goto implementation',
            \ 'r': 'show references',
            \ 'l': 'goto line',
            \ }
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gl <Plug>(easymotion-overwin-line)
" let g:which_key_map.h = {}
" let g:which_key_map.i = {}
" let g:which_key_map.j = {}
" let g:which_key_map.k = {}
" let g:which_key_map.l= {}
" let g:which_key_map.m = {}
let g:which_key_map.n = 'Next Tab'
nmap <silent> <leader>n :bn<CR>
" let g:which_key_map.o = {}
let g:which_key_map.p = 'Previous Tab'
nmap <silent> <leader>p :bp<CR>
let g:which_key_map.q = {
            \ 'name': '+Quit',
            \ 'q': 'Quit Buffer',
            \ 'w': 'Save Quit',
            \ 'a': 'Save Quit All',
            \ 'x': 'Force Quit',
            \ }
nmap <silent> <leader>qq :BufferClose<CR><CR>
nmap <silent> <leader>qw :qw<CR>
nmap <silent> <leader>qa :qa<CR>
nmap <silent> <leader>qx :qa!<CR>
let g:which_key_map.r = {
            \ 'name': '+Rename',
            \ 'n': 'Rename Symbol'
            \ }
nmap <leader>rn <Plug>(coc-rename)
let g:which_key_map.s = {
            \ 'name': '+Settings',
            \ 'o': 'Open Vimrc',
            \ 'r': 'Reload Vimrc',
            \ }
nmap <silent> <leader>so :e $MYVIMRC<CR>
nmap <silent> <leader>sr :source $MYVIMRC<CR>
" let g:which_key_map.t = {}
" let g:which_key_map.u = {}
" let g:which_key_map.v = {}
let g:which_key_map.w = {
            \ 'name': '+Windows',
            \ 'h': 'Split Window Horizontal',
            \ 'v': 'Split Window Vertical',
            \ 'q': 'Close Current Window',
            \ 't': 'Window to New Tab',
            \ 'y': 'Jump to Left Window',
            \ 'n': 'Jump to Below Window',
            \ 'i': 'Jump to Above Window',
            \ 'o': 'Jump to Right Window',
            \ 'c': 'Close All The Other Windows'
            \ }
nmap <silent> <leader>wh <C-w>s
nmap <silent> <leader>wv <C-w>v
nmap <silent> <leader>wq <C-w>c
nmap <silent> <leader>wt <C-w>T
nmap <silent> <leader>wy <C-w>h
nmap <silent> <leader>wn <C-w>j
nmap <silent> <leader>wi <C-w>k
nmap <silent> <leader>wo <C-w>l
nmap <silent> <leader>wc :only<CR>
" let g:which_key_map.x = {}
" let g:which_key_map.y = {}
" let g:which_key_map.z = {}
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
            \ 'component_function': {
            \     'gitbranch': 'gitbranch#name',
            \ },
            \ }

" Calendar.vim
let g:calendar_first_day = 'monday'
" easy motion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0

" vimwiki
let g:vimwiki_list = [{'path': '~/Sync/Wiki'}]
let g:vimwiki_global_ext=0

" coc.nvim
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd FileType vimwiki let b:coc_suggest_disable = 1

" defx
call defx#custom#option('_', {
            \ 'winwidth': 26,
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
let g:easy_align_delimiters = {
            \ 'b': { 
            \     'pattern': '::',
            \     'right_margin': 1},
            \ }

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" leaderF
let g:Lf_ShortcutF = "<leader>ff"
let g:Lf_ShortcutB = "<leader>bb"
let g:Lf_RootMarkers = ['.git', '.project', 'pom.xml']
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_StlSeparator = { 'left': '►', 'right': '◄', 'font': '等距更纱黑体 SC' }

" vista
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" ultisnips
let g:UltiSnipsExpandTrigger       = "<C-l>"
let g:UltiSnipsJumpForwardTrigger  = "<C-n>"
let g:UltiSnipsJumpBackwardTrigger = "<C-i>"

" vim-visual-multi
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-s>'
let g:VM_maps['Find Subword Under'] = '<C-s>'
let g:VM_maps['Add Cursor Down']    = '<M-Down>'
let g:VM_maps['Add Cursor Up']      = '<M-Up>'


let g:VM_maps["Find Next"]          = '<C-s>'
let g:VM_maps["Find Prev"]          = '<C-S>'
let g:VM_maps["Goto Next"]          = ']'
let g:VM_maps["Goto Prev"]          = '['
let g:VM_maps["Seek Next"]          = '<C-b>'
let g:VM_maps["Seek Prev"]          = '<C-b>'
let g:VM_maps["Skip Region"]        = '<C-x>'
let g:VM_maps["Remove Region"]      = '<C-X>'
let g:VM_maps["Replace"]            = 'R'
let g:VM_maps["Surround"]           = 'S'
let g:VM_maps["Toggle Multiline"]   = 'M'

" vim-autosave
let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_write_all_buffers = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]

" web-devicons
lua << EOF
require'nvim-web-devicons'.setup {
 default = true;
}
EOF
" barbar.nvim
let bufferline = {}
let bufferline.shadow = v:true
let bufferline.animation = v:true
let bufferline.icons = v:true
let bufferline.closable = v:false
let bufferline.clickable = v:false
let bufferline.semantic_letters = v:true
let bufferline.letters = 
  \ 'aseqwdzxcftvkgb'
let bufferline.maximum_padding = 4

