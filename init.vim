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
Plug 'ap/vim-buftabline'
Plug 'vimwiki/vimwiki'
Plug 'jiangmiao/auto-pairs'
Plug '907th/vim-auto-save'
Plug 'Verf/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-rooter'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
Plug 'Yggdroot/indentLine'
Plug 'liuchengxu/vista.vim'
Plug 'simnalamburt/vim-mundo'
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
command! Bd :bp | :sp | :bn | :bd " use :Bd to close buffer without close windows
set nowrap                        " close autowrap
set linebreak                     " wrap long line
set smartcase                     " case sensitive only if pattern contains upper letter
set expandtab                     " replace tab to blanks
set smartindent                   " automatically inserts one extra level of indentation in some cases
set nohlsearch                    " don't highlight search pattern
set autochdir                     " change current working directory whenever open a file
set nobackup                      " close auto backup
set nowritebackup                 " close auto write
set hidden                        " buffer became hidden when it is abandoned
set undofile                      " presistent undo file

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
set timeoutlen=500               " timeout for map sequence (ms)
set scrolloff=999                 " keep line in center of screen
set showbreak=⮎                   " label of line break
set textwidth=120                 " autowrap line length
set tabstop=4                     " number of spaces that a <Tab> in the file count for
set softtabstop=4                 " number of spaces that a <Tab> is inserted
set shiftwidth=4                  " number of spaces to use for (auto)indent
set synmaxcol=200                 " maxium column for search syntax items
set updatecount=100               " after type this many characters the swap file will be written to disk
set updatetime=300                " updatetime for CursorHold & CursorHoldI
set mouse=a                       " enable mouse in all mode
set clipboard=unnamedplus         " use system clip board
set signcolumn=yes                " always show signcolumns
set shortmess+=c                  " don't give ins-completion-menu messages

" UI
colorscheme onedark                                        " set colorscheme
set termguicolors                                          " true color support in terminal
set cursorline                                             " highlight current line
set showmatch                                              " highlight matching parenthesis
set showtabline=2                                          " show tabline
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
" ys<textobj>: vim-surround insert surround by text object
noremap u u
noremap r i
noremap l o
noremap h p
noremap a a
noremap s s
noremap e d
" ds: vim-surround delete surround
noremap t f
" g field
noremap g g
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
nmap gl <Plug>(easymotion-overwin-line)
nmap gf <Plug>(easymotion-s)
nmap gw <Plug>(easymotion-bd-w)
nmap ge <Plug>(easymotion-bd-e)

noremap y h
noremap n j
noremap i k
noremap o l
noremap z z
noremap x x
noremap c c
" cs: vim-surround change surround
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
nmap <silent> <leader><leader> <Plug>(easymotion-overwin-f2)
let g:which_key_map.1 = 'which_key_ignore'
let g:which_key_map.2 = 'which_key_ignore'
let g:which_key_map.3 = 'which_key_ignore'
let g:which_key_map.4 = 'which_key_ignore'
let g:which_key_map.5 = 'which_key_ignore'
let g:which_key_map.6 = 'which_key_ignore'
let g:which_key_map.7 = 'which_key_ignore'
let g:which_key_map.8 = 'which_key_ignore'
let g:which_key_map.9 = 'which_key_ignore'
let g:which_key_map.0 = 'which_key_ignore'
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)
let g:which_key_map.a = {
            \ 'name': '+Application',
            \ 'w': {
            \     'name': '+Wiki',
            \     'i': 'Wiki Index',
            \     'n': 'Wiki New',
            \     'd': 'Wiki Delete',
            \     'r': 'Wiki Rename',
            \     'h': 'Wiki2HTML'
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
nmap <silent> <leader>awh <Plug>Vimwiki2HTML
nmap <silent> <leader>adi <Plug>VimwikiDiaryIndex
nmap <silent> <leader>add <Plug>VimwikiMakeDiaryNote
nmap <silent> <leader>ady <Plug>VimwikiMakeYesterdayNote
nmap <silent> <leader>adt <Plug>VimwikiMakeTomorrowDiaryNote
let g:which_key_map.b = {
            \ 'name': '+Buffers',
            \ 'q': 'Close Buffer',
            \ 'n': 'Next Buffer',
            \ 'p': 'Previous Buffer',
            \ 'b': 'Buffer List',
            \ }
nmap <silent> <leader>bq :Bd<CR><CR>
nmap <silent> <leader>bn :bn<CR>
nmap <silent> <leader>bp :bp<CR>
let g:which_key_map.c = {
            \ 'name': '+Commenter',
            \ 'c': 'Toggle Comment',
            \ 'n': 'Nest Comment',
            \ 'm': 'Minimal Comment',
            \ 'i': 'Invert Comment',
            \ 's': 'Sexy Comment',
            \ 'y': 'Yank Comment',
            \ '$': 'Comment To EOL',
            \ 'A': 'Append Comment',
            \ 'a': 'Change Comment Style',
            \ 'l': 'Comment AlignLeft',
            \ 'b': 'Comment AlignRight',
            \ 'u': 'Uncomment',
            \ }
nmap <silent> <leader>cc <Plug>NERDCommenterToggle
xmap <silent> <leader>cc <Plug>NERDCommenterToggle
" let g:which_key_map.d = {}
" let g:which_key_map.e = {}
let g:which_key_map.f = {
    \ 'name': '+Files/Find',
    \ 't': 'Tree View',
    \ 'd': 'Diagnostics',
    \ 'f': 'File Search',
    \ 'a': 'File Search All',
    \ 'h': 'File History',
    \ 'm': 'File Manager',
    \ 'w': 'Find Word',
    \ 'p': 'Find at Ponit',
    \ }
nmap <silent> <leader>ft :Defx<CR>
nmap <silent> <leader>fd :CocList diagnostics<CR>
nmap <silent> <leader>fa :LeaderfFile $HOME<CR>
nmap <silent> <leader>fh :<C-R>=printf("Leaderf mru %s", "")<CR><CR>
nmap <silent> <leader>fm :Vifm<CR>
nmap <silent> <leader>fw :Leaderf rg -e
nmap <silent> <leader>fp :<C-R>=printf("Leaderf rg -e %s ", expand("<cword>"))<CR><CR>
let g:which_key_map.g= {
            \ 'name': 'Goto',
            \ 'd': 'goto definition',
            \ 'y': 'type definition',
            \ 'i': 'goto implementation',
            \ 'r': 'show references',
            \ }
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
" let g:which_key_map.h = {}
" let g:which_key_map.i = {}
" let g:which_key_map.j = {}
" let g:which_key_map.k = {}
" let g:which_key_map.l= {}
" let g:which_key_map.m = {}
let g:which_key_map.n = 'Next Buffer'
nmap <silent> <leader>n :bn<CR>
" let g:which_key_map.o = {}
let g:which_key_map.p = 'Previous Buffer'
nmap <silent> <leader>p :bp<CR>
let g:which_key_map.q = {
            \ 'name': '+Quit',
            \ 'q': 'Quit Buffer',
            \ 'w': 'Save Quit',
            \ 'a': 'Save Quit All',
            \ 'x': 'Force Quit',
            \ }
nmap <silent> <leader>qq :Bd<CR><CR>
nmap <silent> <leader>qw :qw<CR>
nmap <silent> <leader>qa :qa<CR>
nmap <silent> <leader>qx :qa!<CR>
let g:which_key_map.r = {
            \ 'name': '+Rename',
            \ 'n': 'Rename Symbol'
            \ }
nmap <leader>rn <Plug>(coc-rename)
let g:which_key_map.s = {
            \ 'name': '+Session',
            \ 's': 'Save Session',
            \ 'o': 'Open Session',
            \ 'c': 'Close Session',
            \ 'd': 'Delete Session',
            \ }
nmap <leader>ss :SaveSession
nmap <leader>so :OpenSession
nmap <leader>sc :CloseSession<CR>
nmap <leader>sd :DeleteSession<CR>
let g:which_key_map.t = {
            \ 'name': '+Tags',
            \ 't': 'View Tags',
            \ 'f': 'Find Tags',
            \ 'a': 'Find All Tags',
            \ }
nmap <silent> <leader>tt :Vista!!<CR>
nmap <silent> <leader>tf :LeaderfBufTag<CR>
nmap <silent> <leader>ta :LeaderfBufTagAll<CR>
let g:which_key_map.u = {
            \ 'name': 'Undo Tree',
            \ }
nmap <silent> <leader>u :MundoToggle<CR>
let g:which_key_map.v = {
            \ 'name': '+Vimrc',
            \ 'o': 'Open Vimrc',
            \ 'r': 'Reload Vimrc',
            \ }
nmap <silent> <leader>vo :e $MYVIMRC<CR>
nmap <silent> <leader>vr :source $MYVIMRC<CR>
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
            \ 'Y': 'Move to Left Window',
            \ 'N': 'Move to Below Window',
            \ 'I': 'Move to Above Window',
            \ 'O': 'Move to Right Window',
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
nmap <silent> <leader>wY <C-w>h
nmap <silent> <leader>wN <C-w>j
nmap <silent> <leader>wI <C-w>k
nmap <silent> <leader>wO <C-w>l
nmap <silent> <leader>w+ <C-w>+
nmap <silent> <leader>w- <C-w>-
nmap <silent> <leader>wc :only<CR>
" let g:which_key_map.x = {}
" let g:which_key_map.y = {}
" let g:which_key_map.z = {}
" ===================
"     Languages
" ===================
if has('win32')
    let g:python3_host_prog = '~\scoop\shims\python.exe'
endif
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

" easy motion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0

" vimwiki
let g:vimwiki_list = [{'path': '~/Sync/Wiki'}]
let g:vimwiki_global_ext=0
let g:vimwiki_key_mappings = {
            \ 'global': 0,
            \ 'links': 0,
            \ 'html': 0,
            \ 'mouse': 0,
            \ }
augroup vimwiki-mappings
    au!
    au filetype vimwiki nmap <C-CR> <Plug>VimwikiFollowLink
    au filetype vimwiki nmap <Backspace> <Plug>VimwikiGoBackLink
    au filetype vimwiki nmap <Tab> <Plug>VimwikiNextLink
    au filetype vimwiki nmap <S-Tab> <Plug>VimwikiPrevLink
augroup END

" coc.nvim
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

let g:coc_snippet_next = '<Tab>'

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
    nnoremap <silent><buffer><expr> <CR>
                \ defx#is_directory() ?
                \ defx#do_action('open_directory') :
                \ defx#do_action('drop')
    nnoremap <silent><buffer><expr>  c      defx#do_action('copy')
    nnoremap <silent><buffer><expr>  m      defx#do_action('move')
    nnoremap <silent><buffer><expr>  p      defx#do_action('paste')
    nnoremap <silent><buffer><expr>  V      defx#do_action('multi', ['drop', 'vsplit', 'quit'])
    nnoremap <silent><buffer><expr>  o      defx#do_action('open_tree', 'toggle')
    nnoremap <silent><buffer><expr>  D      defx#do_action('new_directory')
    nnoremap <silent><buffer><expr>  N      defx#do_action('new_file')
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
let g:rooter_patterns = ['.git', 'pom.xml', '.project']
let g:rooter_change_directory_for_non_project_files = 'current'

" vim-easy-align
let g:easy_align_delimiters = {
            \ '>': { 'pattern': '>>\|=>\|>' },
            \ '/': {
            \     'pattern':         '//\+\|/\*\|\*/',
            \     'delimiter_align': 'l',
            \     'ignore_groups':   ['!Comment'] },
            \ ']': {
            \     'pattern':       '[[\]]',
            \     'left_margin':   0,
            \     'right_margin':  0,
            \     'stick_to_left': 0
            \   },
            \ ')': {
            \     'pattern':       '[()]',
            \     'left_margin':   0,
            \     'right_margin':  0,
            \     'stick_to_left': 0
            \   },
            \ 'd': {
            \     'pattern':      ' \(\S\+\s*[;=]\)\@=',
            \     'left_margin':  0,
            \     'right_margin': 0
            \   }
            \ }

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" leaderF
let g:Lf_ShortcutF = "<leader>ff"
let g:Lf_ShortcutB = "<leader>bb"
let g:Lf_HideHelp = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_WindowHeight = 0.30
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '更纱黑体 Mono SC Nerd' }
let g:Lf_StlColorscheme = 'one'
let g:Lf_PopupColorscheme = 'one'
let g:Lf_DefaultExternalTool = 'rg'
let g:Lf_RootMarkers = ['.git', '.project', 'pom.xml']
let g:Lf_WildIgnore = {
            \ 'dir': ['.git', '.vscode', '.cache'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \ }
let g:Lf_CommandMap = {
            \ '<C-j>': ['<C-n>'],
            \ '<C-k>': ['<C-i>'],
            \ '<C-]>': ['<C-->'],
            \ '<C-x>': ['<C-|>'],
            \ }

" vista
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_stay_on_open = 0
let g:vista_executive_for = {
            \ 'vimwiki': 'markdown',
            \ 'pandoc': 'markdown',
            \ }

" vim-visual-multi
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-s>'
let g:VM_maps['Find Subword Under'] = '<C-s>'
let g:VM_maps['Add Cursor Down']    = '<M-Down>'
let g:VM_maps['Add Cursor Up']      = '<M-Up>'
let g:VM_maps["Find Next"]          = '<C-s>'
let g:VM_maps["Find Prev"]          = '<C-S-s>'
let g:VM_maps["Goto Next"]          = ']'
let g:VM_maps["Goto Prev"]          = '['
let g:VM_maps["Seek Next"]          = '<C-f>'
let g:VM_maps["Seek Prev"]          = '<C-b>'
let g:VM_maps["Skip Region"]        = '<C-x>'
let g:VM_maps["Remove Region"]      = '<C-S-x>'
let g:VM_maps["Replace"]            = 'R'
let g:VM_maps["Surround"]           = 'S'
let g:VM_maps["Toggle Multiline"]   = 'M'

" vim-autosave
let g:auto_save = 1
let g:auto_save_silent = 0
let g:auto_save_write_all_buffers = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]

" vim-session
set sessionoptions-=help
let g:session_autoload = 'no'
let g:session_autosave = 'yes'

" buftabline
let g:buftabline_numbers = 2
hi link BufTabLineCurrent PmenuSel

" Mundo
let g:mundo_mappings = {
          \ '<CR>': 'preview',
          \ 'n': 'move_older',
          \ 'i': 'move_newer',
          \ 'N': 'move_older_write',
          \ 'I': 'move_newer_write',
          \ 'gg': 'move_top',
          \ 'G': 'move_bottom',
          \ 'P': 'play_to',
          \ 'd': 'diff',
          \ 'l': 'toggle_inline',
          \ '/': 'search',
          \ 'm': 'next_match',
          \ 'M': 'previous_match',
          \ 'p': 'diff_current_buffer',
          \ 'f': 'diff',
          \ '?': 'toggle_help',
          \ 'q': 'quit',
          \ }

" indentLine
let g:indentLine_setConceal = 0
