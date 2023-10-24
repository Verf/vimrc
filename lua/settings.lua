local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

-- leader
g.mapleader = ' '
g.maplocalleader = ','

-- autocmd
-- auto save
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
    desc = 'Auto save and trim space',
    callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand '%' ~= '' and vim.bo.buftype == '' then
            vim.api.nvim_command 'silent update'
            vim.api.nvim_command [[ echo strftime('%X', localtime()) .. " save"]]
        end
    end,
})
-- auto highlight yank range
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight yank range',
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- auto enter insert mode when terminal open
vim.api.nvim_create_autocmd('TermOpen', {
    desc = 'Auto enter insert mode when terminal open',
    callback = function()
        vim.api.nvim_command 'startinsert'
    end,
})

-- auto close terminal when exit
vim.api.nvim_create_autocmd('TermClose', {
    desc = 'Auto close terminal when close',
    callback = function()
        vim.api.nvim_command 'bd!'
    end,
})
-- markdown
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'markdown' },
    callback = function()
        vim.opt_local.conceallevel = 2
    end,
})

-- settings
opt.wrap = false
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.autochdir = false
opt.termguicolors = true
opt.showmode = false
opt.showcmd = false
opt.ruler = false
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

opt.foldenable = true
opt.foldcolumn = '0'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldnestmax = 3
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldtext = 'v:lua.vim.treesitter.foldtext()'

opt.signcolumn = 'yes:1'
opt.mouse = 'a'
opt.showbreak = '⮎'
opt.splitkeep = 'screen'
opt.virtualedit = 'block'
opt.fileformats = 'unix,dos'
opt.clipboard = 'unnamedplus'
opt.shell = 'nu'
opt.shellcmdflag = '-c'
opt.shellquote = ''
opt.shellxquote = ''
opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'
opt.fillchars:append {
    eob = ' ',
    stl = '─',
    stlnc = '─',
    foldopen = '',
    foldsep = ' ',
    foldclose = '',
}
opt.runtimepath:append(vim.fn.stdpath 'config' .. '\\snippets')

-- gui settings
opt.guifont = 'JetBrainsMono Nerd Font Mono:h12'
-- neovide
g.neovide_hide_mouse_when_typing = true
