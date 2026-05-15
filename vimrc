call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'rakr/vim-one'
call plug#end()

let mapleader = " "
" options
set termguicolors
set background=light
colorscheme one

set confirm            " 退出未保存文件等操作时弹出确认对话框
set autowrite          " 执行 :make 或切换缓冲区前自动保存

set autoindent         " 开启自动缩进
set cindent            " C 风格缩进
set cursorline         " 高亮当前行

set ignorecase         " 搜索忽略大小写
set infercase          " 自动补全时忽略大小写
set smartcase          " 搜索词含大写时区分大小写

set nowrap             " 禁用自动换行

set number             " 显示绝对行号
set relativenumber     " 显示相对行号

set showmatch          " 高亮匹配的括号
set noshowmode         " 不显示模式
set noshowcmd          " 不显示未完成的命令

set nohlsearch         " 不高亮搜索结果

set showtabline=2      " 始终显示标签栏
set cmdheight=1

set mouse=a            " 所有模式启用鼠标

set splitright         " 竖向分屏时新窗口在右侧
set switchbuf=usetab   " 跳转时优先复用标签页
set virtualedit=block  " 块选择模式下光标可超出文本末尾

set expandtab          " Tab 转换为空格
set tabstop=4          " Tab 显示宽度
set shiftwidth=4       " 自动缩进宽度
set softtabstop=4      " 编辑时按 Tab 插入的空格数

set scrolloff=999      " 光标始终保持在屏幕中央
set updatetime=750     " 交换文件写入延迟 (ms)
set pumheight=8        " 补全菜单高度

set complete=.,w,b,kspell  " 补全数据源
set completeopt=noselect,menuone,popup
set fileformats=unix,dos        " 换行符优先 Unix

" 检查系统是否安装了 rg，避免报错
if executable('rg')
    " 设置 grepprg，让 :grep 使用 rg
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    " 设置 grepformat，让 Vim 解析 rg 的输出
    set grepformat=%f:%l:%c:%m
endif

" keymaps
noremap d e
noremap f r
noremap k t
noremap j y
noremap r i
noremap l o
noremap e d
noremap t f
noremap y h
noremap n j
noremap i k
noremap o l
noremap p n
noremap h ;
noremap ; p
noremap D E
noremap F R
noremap K T
noremap J Y
noremap R I
noremap L O
noremap E D
noremap T F
noremap Y H
noremap N J
noremap I K
noremap O L
noremap P N
noremap H :
noremap : P

nnoremap c "_c
xnoremap c "_c

nnoremap <C-s> g*Ncgn

nnoremap <leader>j "+y
vnoremap <leader>j "+y
nnoremap <leader>; "+p
vnoremap <leader>; "+p


nnoremap <leader>q :bd<cr>
nnoremap <leader>x :x<cr>

nnoremap <tab> :bn<cr>
xnoremap <tab> :bn<cr>
nnoremap <s-tab> :bp<cr>
xnoremap <s-tab> :bp<cr>
nnoremap <leader><tab> :b#<cr>
xnoremap <leader><tab> :b#<cr>

nnoremap <leader>wc <C-w>o
nnoremap <leader>wq <C-w>c
nnoremap <leader>ws <C-w>s
nnoremap <leader>wv <C-w>v

nnoremap <leader>wy <C-w>h
nnoremap <leader>wn <C-w>j
nnoremap <leader>wi <C-w>k
nnoremap <leader>wo <C-w>l
nnoremap <leader>wY <C-w>H
nnoremap <leader>wN <C-w>J
nnoremap <leader>wI <C-w>K
nnoremap <leader>wO <C-w>L

nnoremap gw :Grep <C-R><C-W><CR>
