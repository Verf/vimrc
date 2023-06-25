local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

cmd [[command! Trim :%s/\s\+$//e]]
cmd [[command! Trimline :%g/^$/d]]
cmd [[command! Editrc :e $MYVIMRC]]

g.mapleader = ' '
g.maplocalleader = ','

cmd [[autocmd FileType netrw setlocal bufhidden=wipe]]
cmd [[autocmd FileType html setlocal shiftwidth=2 tabstop=2]]
cmd [[autocmd FileType css setlocal shiftwidth=2 tabstop=2]]
cmd [[autocmd FileType javascript setlocal shiftwidth=2 tabstop=2]]
cmd [[autocmd FileType vue setlocal shiftwidth=2 tabstop=2]]
cmd [[autocmd FileType json setlocal shiftwidth=2 tabstop=2]]
cmd [[autocmd FileType markdown setlocal shiftwidth=2 tabstop=2]]

----- settings -----
opt.wrap = false
opt.hidden = true
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.autochdir = false
opt.termguicolors = true
opt.foldenable = true
opt.backup = false
opt.undofile = true
opt.showmode = false
opt.hlsearch = false
opt.writebackup = false
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.linebreak = true
opt.cursorline = true
opt.lazyredraw = true
opt.shellslash = false
opt.spell = false
opt.spelllang = { 'en_us' }

opt.updatetime = 300
opt.scrolloff = 999
opt.timeoutlen = 1500
opt.updatecount = 100
opt.showtabline = 2
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.synmaxcol = 200
opt.winblend = 10

opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99

opt.mouse = 'a'
opt.showbreak = '⮎'
opt.signcolumn = 'yes'
opt.virtualedit = 'all'
opt.fileformats = 'unix,dos'
opt.clipboard = 'unnamed'
opt.shell = 'pwsh -nol'
opt.guifont = 'FiraCode NF:h13'
opt.shellcmdflag =
'-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
opt.shellquote = ''
opt.shellxquote = ''
opt.shortmess = 'filnxtToOFc'
opt.whichwrap = ''
opt.spelllang = { 'en_us' }
opt.switchbuf = { 'useopen', 'usetab', 'newtab' }
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.fillchars:append { eob = ' ', fold = ' ', foldopen = '', foldclose = '', foldsep = ' ' }
opt.sessionoptions = 'buffers,curdir,folds,tabpages,winsize,winpos'
opt.runtimepath:append(vim.fn.stdpath 'data' .. '\\tsparser')
opt.runtimepath:append(vim.fn.stdpath 'config' .. '\\snippets')
