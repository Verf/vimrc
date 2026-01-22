local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

-- leader
g.mapleader = ' '
g.maplocalleader = ','

-- ui
opt.background = 'light'

-- config
opt.autowrite = true
opt.cindent = true
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.hlsearch = false
opt.ignorecase = true
opt.number = true
opt.relativenumber = true
opt.ruler = true
opt.showcmd = false
opt.showmatch = true
opt.showmode = false
opt.smartcase = true
opt.wrap = false

opt.scrolloff = 999
opt.shiftwidth = 4
opt.showtabline = 2
opt.softtabstop = 4
opt.tabstop = 4
opt.updatetime = 750

opt.completeopt = 'menuone,noselect,popup'
opt.fileformats = 'unix,dos'
opt.fillchars:append { vert = ' ' }
opt.formatoptions:remove { 'c', 'r', 'o' }
opt.mouse = 'a'
opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'
opt.shell = 'nu'
opt.shellcmdflag = '-c'
opt.shellquote = ''
opt.shellxquote = ''
opt.virtualedit = 'block'
