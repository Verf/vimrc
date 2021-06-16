--   __      _______ __  __ _____   _____
--   \ \    / /_   _|  \/  |  __ \ / ____|
--    \ \  / /  | | | \  / | |__) | |
--     \ \/ /   | | | |\/| |  _  /| |
--      \  /   _| |_| |  | | | \ \| |____
--       \/   |_____|_|  |_|_|  \_\\_____|
--
--  For Verf
local utils = require('utils')
local g = vim.g
local cmd = vim.cmd
local opt = utils.opt
local map = utils.map

-- Disable builtin module
local disabled_builtin = {
    'gzip', 'man', 'matchit', 'matchparen', 'tarPlugin', 'tar',
    'zipPlugin', 'zip', 'netrwPlugin'
}
for i = 1, 9 do g['loaded_' .. disabled_builtin[i]] = 1 end

----- Init -----
cmd 'language en_US'
cmd 'colorscheme desert'
cmd [[call serverstart('\\.\pipe\nvim-pipe-12345')]]

----- Command  ----
cmd [[command! Trim :%s/\s\+$//e]]
cmd [[command! Trimline :%d/^$/g]]
cmd [[command! Editrc :e $MYVIMRC]]

----- Basic -----
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

opt('o', 'clipboard',     'unnamed')
opt('o', 'shortmess',     'filnxtToOFc')
opt('o', 'switchbuf',     'useopen,usetab,newtab')
opt('o', 'completeopt',   'menuone,noinsert,noselect')

----- Language -----
-- Python
g.loaded_python_provider = 0
g.python3_host_prog = vim.fn.expand("~/scoop/shims/python3.exe")

----- Packer -----
cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

----- Mappings -----
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

-- Plugin Key Binding
map('',  '<F1>', ':FloatermToggle<CR>')
map('i', '<F1>', ':FloatermToggle<CR>')
map('',  '<F2>', [[:lua require'lir.float'.toggle()<CR>]])
map('i', '<F2>', [[:lua require'lir.float'.toggle()<CR>]])
map('',  '<F3>', ':MundoToggle<CR>')
map('i', '<F3>', ':MundoToggle<CR>')

map('t', '<F1>', '<C-\\><C-n>:FloatermToggle<CR>')
map('t', '<C-o>', '<C-\\><C-n>')
map('t', '<C-`>', '<C-\\><C-n>:FloatermToggle<CR>')
map('t', '<C-t>', '<C-\\><C-n>:FloatermNew<CR>')
map('t', '<C-q>', '<C-\\><C-n>:FloatermKill<CR>')
map('t', '<C-n>', '<C-\\><C-n>:FloatermNext<CR>')
map('t', '<C-p>', '<C-\\><C-n>:FloatermPrev<CR>')

map('x', 'ga', '<Plug>(EasyAlign)', {noremap=false})
map('n', 'ga', '<Plug>(EasyAlign)', {noremap=false})

map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gr', ':Lspsaga lsp_finder<CR>')

map('n', '/', '<CMD>Telescope current_buffer_fuzzy_find<CR>', {noremap=false})

map('',  '[y',    '<plug>(YoinkRotateBack)',                 {noremap=false})
map('',  ']y',    '<plug>(YoinkRotateForward)',              {noremap=false})
map('x', 'j',     '<plug>(YoinkYankPreserveCursorPosition)', {noremap=false})
map('n', 'j',     '<plug>(YoinkYankPreserveCursorPosition)', {noremap=false})
map('x', 'h',     '<plug>(YoinkPaste_p)',                    {noremap=false})
map('n', 'h',     '<plug>(YoinkPaste_p)',                    {noremap=false})
map('n', 'gh',    '<plug>(YoinkPaste_gp)',                   {noremap=false})
map('n', 'gH',    '<plug>(YoinkPaste_gP)',                   {noremap=false})
map('n', '<c-n>', '<plug>(YoinkPostPasteSwapBack',           {noremap=false})
map('n', '<c-p>', '<plug>(YoinkPostPasteSwapForwrd)',        {noremap=false})

map('n', 'w', '<Plug>WordMotion_w', {noremap=false})
map('n', 'W', '<Plug>WordMotion_W', {noremap=false})
map('n', 'b', '<Plug>WordMotion_b', {noremap=false})
map('n', 'B', '<Plug>WordMotion_B', {noremap=false})
map('n', 'd', '<Plug>WordMotion_e', {noremap=false})
map('n', 'D', '<Plug>WordMotion_d', {noremap=false})

map('n', '[b', ':BufferLineCyc}leNext<CR>', {noremap=false})
map('n', ']b', ':BufferLineCyclePrev<CR>',  {noremap=false})

map('n', ']e', ':Lspsaga diagnostic_jump_next<CR>')
map('n', '[e', ':Lspsaga diagnostic_jump_prev<CR>')

-- Key Binding by Which-Key
map('n', '<leader><tab>', ':e#<CR>')
map('n', '<leader><space>', ':BufferLinePick<CR>')

map('n', '<leader>ff', '<CMD>Telescope find_files<CR>')
map('n', '<leader>fh', '<CMD>Telescope oldfiles<CR>')
map('n', '<leader>fg', '<CMD>Telescope live_grep<CR>')
map('n', '<leader>fb', '<CMD>Telescope buffers<CR>')
map('n', '<leader>ft', [[<CMD>lua require('telescope.builtin').tags({ctags_file=vim.fn.tagfiles()[1]})<CR>]])
map('n', '<leader>fz', '<CMD>Telescope zoxide list<CR>')

map('n', '<leader>qa', ':wqa<CR>')
map('n', '<leader>qx', ':wqa!<CR>')
map('n', '<leader>qq', ':Sayonara!<CR>')

map('n', '<leader>wc', '<C-w>o')
map('n', '<leader>wq', '<C-w>c')
map('n', '<leader>wh', '<C-w>s')
map('n', '<leader>wv', '<C-w>v')
map('n', '<leader>wy', '<C-w>h')
map('n', '<leader>wn', '<C-w>j')
map('n', '<leader>wi', '<C-w>k')
map('n', '<leader>wo', '<C-w>l')
map('n', '<leader>wY', '<C-w>H')
map('n', '<leader>wN', '<C-w>J')
map('n', '<leader>wI', '<C-w>K')
map('n', '<leader>wO', '<C-w>L')

map('n', '<leader>w+','<C-w>+')
map('n', '<leader>w-','<C-w>-')
map('n', '<leader>w=', '<C-w>=')

map('n', '<leader>rn', ':Lspsaga rename<CR>')
