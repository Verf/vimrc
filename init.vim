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
Plug 'vimwiki/vimwiki'
Plug 'jiangmiao/auto-pairs'
Plug '907th/vim-auto-save'
Plug 'Verf/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'simnalamburt/vim-mundo'
Plug 'farmergreg/vim-lastplace'
Plug 'neovim/nvim-lspconfig'
Plug 'voldikss/vim-floaterm'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'lifepillar/vim-solarized8'
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
colorscheme solarized8                                     " set colorscheme
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
tnoremap <C-o> <C-\><C-n>

noremap <silent> <C-`> :FloatermToggle<CR>
tnoremap <silent> <C-`> <C-\><C-n>:FloatermToggle<CR>
tnoremap <silent> <C-t> <C-\><C-n>:FloatermNew<CR>
tnoremap <silent> <C-q> <C-\><C-n>:FloatermKill<CR>
tnoremap <silent> <C-n> <C-\><C-n>:FloatermNext<CR>
tnoremap <silent> <C-p> <C-\><C-n>:FloatermPrev<CR>

" vim-which-key
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

let g:which_key_map =  {}
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
            \ 'name': '+Buffer',
            \ 'b': 'Buffers',
            \ }
nnoremap <leader>bb <CMD>lua require('telescope.builtin').buffers()<CR>

" let g:which_key_map.c = {}
" let g:which_key_map.d = {}
" let g:which_key_map.e = {}
let g:which_key_map.f = {
            \ 'name': '+Find',
            \ 'f': 'Find File',
            \ 'g': 'Find Word',
            \ 'h': 'Find History File',
            \ 't': 'Find Tags',
            \ }
nnoremap <leader>ff <CMD>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fw <CMD>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fh <CMD>lua require('telescope.builtin').oldfiles()<CR>
nnoremap <leader>ft <CMD>lua require('telescope.builtin').tags()<CR>
" let g:which_key_map.g = {}
" let g:which_key_map.h = {}
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
" let g:which_key_map.r = {}
" let g:which_key_map.s = {}
" let g:which_key_map.t = {
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
" lightline
let g:lightline#bufferline#show_number = 2
let g:lightline = {
            \ 'colorscheme': 'solarized',
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
            \ 'lists': 0,
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
let g:floaterm_shell = 'powershell'
let g:floaterm_rootmarkers = ['.project', '.git', '.gitignore', 'pom.xml']
let g:floaterm_autoclose = 1

" telescope

" ===========
" lua plugin
" ===========
lua <<EOF
require'nvim-web-devicons'.setup {
 default = true;
}

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF
