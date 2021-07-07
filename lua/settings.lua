local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

----- Init -----
cmd 'language en_US'
cmd 'colorscheme desert'
cmd [[call serverstart('\\.\pipe\nvim-pipe-12345')]]

----- Command  -----
cmd [[command! Trim :%s/\s\+$//e]]
cmd [[command! Trimline :%d/^$/g]]
cmd [[command! Editrc :e $MYVIMRC]]

-- global
g.mapleader = ' '
g.maplocalleader = ','

-- language
g.loaded_python_provider = 0
g.python3_host_prog = vim.fn.expand("~/scoop/shims/python3.exe")

----- settings -----
opt.hidden        = true
opt.showmatch     = true
opt.smartcase     = true
opt.autochdir     = true
opt.termguicolors = true
opt.backup        = false
opt.showmode      = false
opt.hlsearch      = false
opt.writebackup   = false
opt.expandtab     = true
opt.smartindent   = true
opt.number        = true
opt.linebreak     = true
opt.cursorline    = true


opt.updatetime    = 300
opt.scrolloff     = 999
opt.timeoutlen    = 1500
opt.updatecount   = 100
opt.showtabline   = 2
opt.tabstop       = 4
opt.softtabstop   = 4
opt.shiftwidth    = 4
opt.textwidth     = 200
opt.synmaxcol     = 200

opt.mouse         = 'a'
opt.showbreak     = '⮎'
opt.signcolumn    = 'yes'
opt.clipboard     = 'unnamed'
opt.shortmess     = 'filnxtToOFc'
opt.whichwrap     = "b,s,<,>,[,],h,l,"
opt.switchbuf     = 'useopen,usetab,newtab'
opt.completeopt   = 'menuone,noinsert,noselect'
