local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

cmd [[command! Trim :%s/\s\+$//e]]
cmd [[command! Trimline :%g/^$/d]]
cmd [[command! Editrc :e $MYVIMRC]]

-- leader
g.mapleader = ' '
g.maplocalleader = ','

-- autocmd
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
    callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand '%' ~= '' and vim.bo.buftype == '' then
            vim.api.nvim_command 'silent update'
            vim.api.nvim_command [[ echo strftime('%X', localtime()) "autosave"]]
        end
    end,
})

vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- settings
opt.wrap = false
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.autochdir = false
opt.termguicolors = true
opt.foldenable = false
opt.showmode = false
opt.showcmd = false
opt.ruler = false
opt.hlsearch = false
opt.expandtab = true
opt.smartindent = true
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

opt.signcolumn = 'yes:1'
opt.mouse = 'a'
opt.showbreak = '⮎'
opt.virtualedit = 'all'
opt.fileformats = 'unix,dos'
opt.clipboard = 'unnamedplus'
opt.splitkeep = 'screen'
opt.shell = 'nu'
opt.shellcmdflag = '-c'
opt.shellxquote = ''
opt.whichwrap = ''
opt.spelllang = { 'en_us' }
opt.switchbuf = { 'useopen', 'usetab', 'newtab' }
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.sessionoptions = { 'buffers', 'curdir', 'folds', 'tabpages', 'winsize', 'winpos' }
opt.fillchars:append {
    eob = ' ',
    stl = '─',
    stlnc = '─',
    fold = ' ',
    foldopen = '',
    foldsep = ' ',
    foldclose = '',
}
opt.runtimepath:append(vim.fn.stdpath 'config' .. '\\snippets')

-- gui settings
opt.guifont = 'JetBrainsMono Nerd Font Mono:h12'
-- neovide
g.neovide_hide_mouse_when_typing = true
