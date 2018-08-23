" vim-plug init
call plug#begin('~/.nvim/plugged')
" The default config for everyone
Plug 'tpope/vim-sensible'
" supertab
Plug 'ervandew/supertab'
" LSP support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Completion framework for neovim
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" python completion plugin for deoplete
Plug 'zchee/deoplete-jedi'
" snip
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" quick way to move cursor
Plug 'easymotion/vim-easymotion'
" statue line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" file fzf search
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm', { 'do': 'env PY3=ON ./install.sh' }
" add punctuation easy
Plug 'tpope/vim-surround'
" display file tree; bind on F2
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeFind', 'NERDTreeToggle'] }
Plug 'Xuyuanp/nerdtree-git-plugin'
" multiple line editor
Plug 'terryma/vim-multiple-cursors'
" material color style
Plug 'dikiaap/minimalist'
" auto pair punctuation
Plug 'jiangmiao/auto-pairs'
" Commenting support (gc)
Plug 'tpope/vim-commentary'
" display func and variable defination
Plug 'majutsushi/tagbar'
" python syntax highlight enhance
Plug 'vim-python/python-syntax'
call plug#end()

" OS
let g:isWindows = 0
let g:isLinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:isWindows = 1
else
    let g:isLinux = 1
endif

" Basic
let mapleader = " "
set clipboard=unnamedplus
set nohlsearch
set tabstop=4 shiftwidth=4 expandtab
set hidden
set scrolloff=999
set relativenumber
set autochdir
set t_Co=256
syntax on
colorscheme minimalist
let g:Guifont="FuraCode Nerd Font 13"

" Key Map
map <leader>n :bnext<CR>
map <leader>p :bprevious<CR>
" terminal
tnoremap ,<ESC> <C-\><C-n>

" Easymotion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

" vim-airline
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" LSP
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'python': ['/home/verf/.local/bin/pyls'],
    \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" deoplete
let g:deoplete#enable_at_startup = 1

" deoplete-jedi
if (g:isWindows)
    let g:python3_host_prog = 'C:\Programes\Python3\python'
endif
let g:deoplete#sources#jedi#show_docstring = 0

" snip
" Plugin key-mappings.
"inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" ctrlp
let g:ctrlp_working_path_mode = 'ra'

" nerdtree
map <F2> :NERDTreeToggle<CR>

" nerdtree-git
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" vim-multiple-cursors
function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete = 1
endfunction

function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete = 0
endfunction

" nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" tagbar
nmap <F3> :TagbarToggle<CR>

" python-syntax enhance
let g:python_highlight_all = 1
