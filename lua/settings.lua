local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

-- leader
g.mapleader = ' '
g.maplocalleader = ','

opt.wrap = false
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.autochdir = false
opt.showmode = false
opt.showcmd = false
opt.ruler = true
opt.hlsearch = false
opt.expandtab = true
opt.cindent = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.shellslash = false
opt.spell = false
opt.autowrite = true
opt.confirm = true

opt.updatetime = 750
opt.scrolloff = 999
opt.timeoutlen = 1500
opt.updatecount = 100
opt.showtabline = 2
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.synmaxcol = 200
opt.pumheight = 10

opt.mouse = 'a'
opt.splitkeep = 'screen'
opt.virtualedit = 'block'
opt.fileformats = 'unix,dos'
opt.shell = 'nu'
opt.shellcmdflag = '-c'
opt.shellquote = ''
opt.shellxquote = ''
opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'
opt.formatoptions:remove { 'c', 'r', 'o' }
