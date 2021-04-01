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
for i = 1, 9 do g['loaded_' .. disabled_builtin[i]] = 1 end

----- 初始命令 -----
cmd 'language en_US'
cmd 'colorscheme desert'
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
opt('w', 'rnu',           true)
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

opt('o', 'clipboard',     'unnamed')
opt('o', 'shortmess',     'filnxtToOFc')
opt('o', 'switchbuf',     'useopen,usetab,newtab')
opt('o', 'completeopt',   'menuone,noinsert,noselect')

----- 语言支持 -----
-- Python
g.loaded_python_provider = 0

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
map('n', 'd', 'e')
map('n', 'f', 'r')
map('n', 'k', 't')
map('n', 'j', 'y')
map('n', 'r', 'i')
map('n', 'l', 'o')
map('n', 'e', 'd')
map('n', 't', 'f')
map('n', 'y', 'h')
map('n', 'n', 'j')
map('n', 'i', 'k')
map('n', 'o', 'l')
map('n', 'p', 'n')
map('n', 'D', 'E')
map('n', 'F', 'R')
map('n', 'K', 'T')
map('n', 'J', 'Y')
map('n', 'R', 'I')
map('n', 'L', 'O')
map('n', 'E', 'D')
map('n', 'T', 'F')
map('n', 'Y', 'H')
map('n', 'N', 'J')
map('n', 'I', 'K')
map('n', 'O', 'L')
map('n', 'P', 'N')

map('o', 'd', 'e')
map('o', 'f', 'r')
map('o', 'k', 't')
map('o', 'j', 'y')
map('o', 'r', 'i')
map('o', 'l', 'o')
map('o', 'e', 'd')
map('o', 't', 'f')
map('o', 'y', 'h')
map('o', 'n', 'j')
map('o', 'i', 'k')
map('o', 'o', 'l')
map('o', 'p', 'n')
map('o', 'D', 'E')
map('o', 'F', 'R')
map('o', 'K', 'T')
map('o', 'J', 'Y')
map('o', 'R', 'I')
map('o', 'L', 'O')
map('o', 'E', 'D')
map('o', 'T', 'F')
map('o', 'Y', 'H')
map('o', 'N', 'J')
map('o', 'I', 'K')
map('o', 'O', 'L')
map('o', 'P', 'N')

map('x', 'd', 'e')
map('x', 'f', 'r')
map('x', 'k', 't')
map('x', 'j', 'y')
map('x', 'r', 'i')
map('x', 'l', 'o')
map('x', 'e', 'd')
map('x', 't', 'f')
map('x', 'y', 'h')
map('x', 'n', 'j')
map('x', 'i', 'k')
map('x', 'o', 'l')
map('x', 'p', 'n')
map('x', 'D', 'E')
map('x', 'F', 'R')
map('x', 'K', 'T')
map('x', 'J', 'Y')
map('x', 'R', 'I')
map('x', 'L', 'O')
map('x', 'E', 'D')
map('x', 'T', 'F')
map('x', 'Y', 'H')
map('x', 'N', 'J')
map('x', 'I', 'K')
map('x', 'O', 'L')
map('x', 'P', 'N')

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

-- 退出操作
map('n', '<leader>qa', ':wqa<CR>')
map('n', '<leader>qx', 'wq!<CR>')
