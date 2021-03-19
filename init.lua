--   __      _______ __  __ _____   _____
--   \ \    / /_   _|  \/  |  __ \ / ____|
--    \ \  / /  | | | \  / | |__) | |
--     \ \/ /   | | | |\/| |  _  /| |
--      \  /   _| |_| |  | | | \ \| |____
--       \/   |_____|_|  |_|_|  \_\\_____|
--
--  For Verf
local utils = require('utils')
local opt = utils.opt
local map = utils.map
local g = vim.g
local cmd = vim.cmd

-- 关闭无用的内置模块
local disabled_builtin = {
    'gzip', 'man', 'matchit', 'matchparen', 'tarPlugin', 'tar',
    'zipPlugin', 'zip', 'netrwPlugin'
}
for i = 1, 10 do g['loaded_' .. disabled_builtin[i]] = 1 end

----- 初始命令 -----
cmd 'language en_US'
cmd 'colorscheme sonokai'
cmd 'filetype plugin indent on'
cmd [[call serverstart('\\.\pipe\nvim-pipe-12345')]]

----- 自定义命令 ----
cmd [[command! Trim :%s/\s\+$//e]]
cmd [[command! Trimline :%d/^$/g]]
cmd [[command! Editrc :e $MYVIMRC]]

----- 基础设置 -----
opt('o', 'hidden',        true)
opt('o', 'showmatch',     true)
opt('o', 'smartcase',     true)
opt('o', 'autochdir',     true)
opt('o', 'termguicolors', true)
opt('o', 'backup',        false)
opt('o', 'showmode',      false)
opt('o', 'hlsearch',      false)
opt('o', 'writebackup',   false)
opt('b', 'expandtab',     true)
opt('b', 'smartindent',   true)
opt('w', 'number',        true)
opt('w', 'linebreak',     true)
opt('w', 'cursorline',    true)

opt('o', 'mouse',         'a')
opt('o', 'showbreak',     '⮎')
opt('o', 'updatetime',    300)
opt('o', 'scrolloff',     999)
opt('o', 'timeoutlen',    1500)
opt('o', 'updatecount',   100)
opt('o', 'showtabline',   2)
opt('b', 'tabstop',       4)
opt('b', 'softtabstop',   4)
opt('b', 'shiftwidth',    4)
opt('b', 'textwidth',     200)
opt('b', 'synmaxcol',     200)
opt('w', 'signcolumn',    'yes')

opt('o', 'shortmess',     'filnxtToOFc')
opt('o', 'switchbuf',     'useopen,usetab,newtab')
opt('o', 'completeopt',   'menuone,noinsert,noselect')

----- 语言支持 -----
g.loaded_python_provider = 0
-- g.python_host_prog = ''
-- g.python3_host_prog = ''


----- 插件管理 -----
cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

----- 按键映射 -----
g.mapleader = ' '
g.maplocalleader = ','
-- Norman Keyboard Layout
map('', 'd', 'e')
map('', 'f', 'r')
map('', 'k', 't')
map('', 'j', 'y')
map('', 'r', 'i')
map('', 'l', 'o')
map('', 'h', 'p')
map('', 'e', 'd')
map('', 't', 'f')
map('', 'y', 'h')
map('', 'n', 'j')
map('', 'i', 'k')
map('', 'o', 'l')
map('', 'p', 'n')
map('', 'D', 'E')
map('', 'F', 'R')
map('', 'K', 'T')
map('', 'J', 'Y')
map('', 'R', 'I')
map('', 'L', 'O')
map('', 'H', 'P')
map('', 'E', 'D')
map('', 'T', 'F')
map('', 'Y', 'H')
map('', 'N', 'J')
map('', 'I', 'K')
map('', 'O', 'L')
map('', 'P', 'N')

-- 粘贴
map('n', '<leader>pp', '"+p')
map('n', '<leader>pc', '":p')
map('n', '<leader>ps', '"/p')
map('n', '<leader>py', '"0p')

-- 窗口操作
map('n', '<leader>wh', '<C-w>s')
map('n', '<leader>wv', '<C-w>v')
map('n', '<leader>wq', '<C-w>c')
map('n', '<leader>wt', '<C-w>T')
map('n', '<leader>wy', '<C-w>h')
map('n', '<leader>wn', '<C-w>j')
map('n', '<leader>wi', '<C-w>k')
map('n', '<leader>wo', '<C-w>l')
map('n', '<leader>wY', '<C-w>H')
map('n', '<leader>wN', '<C-w>J')
map('n', '<leader>wI', '<C-w>K')
map('n', '<leader>wO', '<C-w>L')
map('n', '<leader>w+', '<C-w>+')
map('n', '<leader>w-', '<C-w>-')
map('n', '<leader>wc', ':only<CR>')

-- 切换到上一个Buffer
map('n', '<leader><Tab>', ':e#<CR>')
