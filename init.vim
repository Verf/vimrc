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
    let VIMHOME = '~/AppData/Local/nvim'
else
    let VIMHOME = '~/.config/nvim'
endif
silent! call plug#begin(VIMHOME.'/plugged')
Plug 'liuchengxu/vim-which-key'
Plug 'ervandew/supertab'
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi'
Plug 'plasticboy/vim-markdown'
Plug 'cohama/lexima.vim'
Plug '907th/vim-auto-save'
Plug 'tpope/vim-repeat'
Plug 'Verf/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'b3nj5m1n/kommentary'
Plug 'simnalamburt/vim-mundo'
Plug 'farmergreg/vim-lastplace'
Plug 'voldikss/vim-floaterm'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/LeaderF'
Plug 'airblade/vim-rooter'
Plug 'liuchengxu/vista.vim'
Plug 'sbdchd/neoformat'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'hoob3rt/lualine.nvim'
Plug 'lifepillar/vim-solarized8'
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
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
filetype plugin indent on
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
set signcolumn=yes                " always show signcolumns
set shortmess+=c                  " don't give ins-completion-menu messages
set completeopt=menu,menuone,noselect

" UI
colorscheme onedark                                        " set colorscheme
set termguicolors                                          " true color support in terminal
set cursorline                                             " highlight current line
set showmatch                                              " highlight matching parenthesis
set showtabline=2                                          " show tabline
set number                                                 " show relative line number
set switchbuf=useopen,usetab,newtab                        " better buffer switch
set noshowmode                                             " don't show insert status (use lightline instead)

" ================
"   Key Bindings
" ================
" The key map for norman key board layout
" q
" w
noremap d e
noremap f r
noremap k t
noremap j y
" ys<textobj>: vim-surround insert surround by text object
" u
noremap r i
noremap l o
noremap h p
" a
" s
nmap s <Plug>(easymotion-s2)
noremap e d
" ds: vim-surround delete surround
noremap t f
" g field
noremap g g
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
nmap gl <Plug>(easymotion-overwin-line)
nmap gw <Plug>(easymotion-bd-w)
nmap ge <Plug>(easymotion-bd-e)
nmap gf <Plug>(easymotion-lineforward)
nmap gb <Plug>(easymotion-linebackward)
nmap gn <Plug>(easymotion-j)
nmap gi <Plug>(easymotion-k)
noremap y h
noremap n j
noremap i k
noremap o l
" z
" x
" c
" cs: vim-surround change surround
" v
" b
noremap p n
" m
" Q
" W
noremap D E
noremap F R
noremap K T
noremap J Y
" U
noremap R I
noremap L O
noremap H P
" A
" S
noremap E D
noremap T F
" G
noremap Y H
noremap N J
noremap I K
noremap O L
" Z
" X
" C
" V
" B
noremap P N
" M

" for easymotion
nmap / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" for terminal
tnoremap <C-o> <C-\><C-n>
noremap <silent> <C-`> :FloatermToggle<CR>
tnoremap <silent> <C-`> <C-\><C-n>:FloatermToggle<CR>
tnoremap <silent> <C-t> <C-\><C-n>:FloatermNew<CR>
tnoremap <silent> <C-q> <C-\><C-n>:FloatermKill<CR>
tnoremap <silent> <C-n> <C-\><C-n>:FloatermNext<CR>
tnoremap <silent> <C-p> <C-\><C-n>:FloatermPrev<CR>

" for lsp diagnostic
nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>

" which key
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

let g:which_key_map =  {}
let g:which_key_map.Space = 'Goto Char'
nmap <silent> <leader><leader> :BufferLinePick<CR>
nmap <silent> <leader><Tab> :e#<CR>
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
nnoremap <leader>1 :lua require"bufferline".go_to_buffer(1)<CR>
nnoremap <leader>2 :lua require"bufferline".go_to_buffer(2)<CR>
nnoremap <leader>3 :lua require"bufferline".go_to_buffer(3)<CR>
nnoremap <leader>4 :lua require"bufferline".go_to_buffer(4)<CR>
nnoremap <leader>5 :lua require"bufferline".go_to_buffer(5)<CR>
let g:which_key_map.a = {
            \ 'name': '+Application',
            \ 'w': 'Wiki',
            \ 'a': 'Action'
            \ }
nmap <silent> <leader>aw :e <CR>
nmap <silent> <leader>aa <CMD>lua require('lspsaga.codeaction').code_action()<CR>
let g:which_key_map.b = {
            \ 'name': '+Buffer',
            \ 'f': 'Find Buffers',
            \ 'b': 'Switch Buffers',
            \ }
let g:Lf_ShortcutB = '<leader>bf'
nmap <silent> <leader>bb :BufferLinePick<CR>
" let g:which_key_map.c = {}
" let g:which_key_map.d = {}
let g:which_key_map.e = {
            \ 'name': '+Edit',
            \ 't': 'Trim Trailing',
            \ 'r': 'Remove Null Line',
            \ }
nmap <silent> <leader>et :%s/\s\+$//e<CR>
nmap <silent> <leader>er :%d/^$/g<CR>
let g:which_key_map.f = {
            \ 'name': '+Find',
            \ 'f': 'Find File',
            \ 'a': 'Find All',
            \ 't': 'Find Tags',
            \ 'p': 'Find Point',
            \ 'w': 'Find Word',
            \ 'h': 'Find History',
            \ 'l': 'Find Lsp Provider',
            \ }
let g:Lf_ShortcutF = '<leader>ff'
nmap <silent> <leader>fa :LeaderfFile $HOME<CR>
nmap <silent> <leader>ft :LeaderfBufTag<CR>
nmap <silent> <leader>fh :Leaderf mru<CR>
nmap <silent> <leader>fp :<C-R>=printf("Leaderf rg -e %s ", expand("<cword>"))<CR><CR>
nmap <silent> <leader>fw :<C-R>=printf("Leaderf rg -e ")<CR>
nmap <silent> <leader>fl <CMD>lua require'lspsaga.provider'.lsp_finder()<CR>
let g:which_key_map.g = {
            \ 'name': '+Goto',
            \ 'd': 'Goto Defination',
            \ 'i': 'Goto Implementation',
            \ 'r': 'Goto References',
            \ }
nmap <silent> <leader>gd <CMD>lua vim.lsp.buf.definition()<CR>
nmap <silent> <leader>gi <CMD>lua vim.lsp.buf.implementation()<CR>
nmap <silent> <leader>gr <CMD>lua require'lspsaga.provider'.lsp_finder()<CR>
let g:which_key_map.h = {
            \ 'name': 'Help'
            \ }
nmap <silent> <leader>h <CMD>lua require('lspsaga.hover').render_hover_doc()<CR>
" let g:which_key_map.i = {}
" let g:which_key_map.j = {}
" let g:which_key_map.k = {}
" let g:which_key_map.l= {}
" let g:which_key_map.m = {}
" let g:which_key_map.n = {}
" let g:which_key_map.o = {}
" let g:which_key_map.p = {}
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
            \ 'name': '+Re',
            \ 'n': 'Rename',
            \ 'm': 'Reformat',
            \ }
nmap <silent> <leader>rn <CMD>lua require('lspsaga.rename').rename()<CR>
nmap <silent> <leader>rm <CMD>lua vim.lsp.buf.formatting()<CR>
" let g:which_key_map.s = {}
" let g:which_key_map.t = {
let g:which_key_map.u = ' Undo Tree'
nmap <silent> <leader>u :MundoToggle<CR>
let g:which_key_map.v = {
            \ 'name': '+Vimrc',
            \ 'o': 'Open Vimrc',
            \ 'r': 'Reload Vimrc',
            \ 't': 'View Tags',
            \ 'f': 'View Files',
            \ }
nmap <silent> <leader>vo :e $MYVIMRC<CR>
nmap <silent> <leader>vr :source $MYVIMRC<CR>
nmap <silent> <leader>vt :Vista!!<CR>
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
nmap <silent> <leader>wY <C-w>H
nmap <silent> <leader>wN <C-w>J
nmap <silent> <leader>wI <C-w>K
nmap <silent> <leader>wO <C-w>L
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
" easy motion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0

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

" floaterm
let g:floaterm_shell = 'pwsh -nologo'
let g:floaterm_rootmarkers = ['.project', '.git', '.gitignore', 'pom.xml']
let g:floaterm_autoclose = 1
let g:floaterm_weight = 0.8
let g:floaterm_height = 0.8

" vim-markdown
autocmd FileType markdown map <Plug> <Plug>Markdown_MoveToParentHeader
autocmd FileType markdown map <C-Enter> <Plug>Markdown_MoveToParentHeader
let g:vim_markdown_folding_disabled = 1

" vim-rooter
let g:rooter_silent_chdir = 1
let g:rooter_patterns = ['.git', '.project', 'pom.xml']

" vista
let g:vista_stay_on_open = 0

" supertab
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = '<C-n>'

" ultisnips
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit = VIMHOME.'/ultisnips'

" leaderf
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


" ===========
" lua plugin
" ===========
lua require('configs.devicons')
lua require('configs.bufferline')
lua require('configs.lualine')
lua require('configs.lsp')
lua require('configs.completion')
