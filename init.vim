" vim-plug init
call plug#begin('~/.nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'tpope/vim-sensible'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
Plug 'dikiaap/minimalist'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
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
let g:Guifont="DejaVu Sans Mono for Powerline:h16"

" Key Map
map <C-a> <Home>
map <C-e> <End>
map <leader>n :bnext<CR>
map <leader>p :bprevious<CR>

" Easymotion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

" nvim-completion-manger
" disable scratch menu
set completeopt-=preview
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" vim-airline
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" deoplete
let g:deoplete#enable_at_startup = 1

" deoplete-jedi
if (g:isLinux)
    let g:python3_host_prog = '/home/verf/.pyvenv/dl/bin/python'
else
    let g:python3_host_prog = 'C:\Programes\Python3\python'
endif
let g:deoplete#sources#jedi#show_docstring = 0

" deoplete-ternjs
let g:deoplete#sources#ternjs#tern_bin = '/home/verf/.nvm/versions/node/v9.10.1/bin/node'
let g:deoplete#sources#ternjs#timeout = 1

" ctrlp
let g:ctrlp_working_path_mode = 'ra'

" Emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

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

" ale
let g:ale_sign_column_always = 1
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_echo_msg_error_str = '✹ Error'
let g:ale_echo_msg_warning_str = '⚠ Warning'

" tagbar
nmap <F3> :TagbarToggle<CR>

" python-syntax enhance
let g:python_highlight_all = 1
