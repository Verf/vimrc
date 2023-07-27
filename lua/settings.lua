local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

cmd [[command! Trim :%s/\s\+$//e]]
cmd [[command! Trimline :%g/^$/d]]
cmd [[command! Editrc :e $MYVIMRC]]

g.mapleader = ' '
g.maplocalleader = ','

-- autocmd
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
    callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand '%' ~= '' and vim.bo.buftype == '' then
            vim.api.nvim_command 'silent update'
            vim.api.nvim_command [[ echo strftime('%X', localtime()) "autosave"]]
            -- lint trigger
            require('lint').try_lint()
        end
    end,
})

----- settings -----
opt.wrap = false
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.autochdir = false
opt.termguicolors = true
opt.foldenable = false
opt.showmode = false
opt.hlsearch = false
opt.expandtab = true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.shellslash = false
opt.spell = false
opt.autowrite = true

opt.updatetime = 750
opt.scrolloff = 999
opt.timeoutlen = 1500
opt.updatecount = 100
opt.showtabline = 2
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.synmaxcol = 200

opt.mouse = 'a'
opt.showbreak = '⮎'
opt.virtualedit = 'all'
opt.fileformats = 'unix,dos'
opt.clipboard = 'unnamed'
opt.shell = 'pwsh -nol'
opt.shellcmdflag =
    '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
opt.shellxquote = ''
opt.whichwrap = ''
opt.spelllang = { 'en_us' }
opt.switchbuf = { 'useopen', 'usetab', 'newtab' }
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.fillchars:append { eob = ' ', fold = ' ', foldopen = '󰅀', foldclose = '', foldsep = ' ' }
opt.sessionoptions = 'buffers,curdir,folds,tabpages,winsize,winpos'
opt.runtimepath:append(vim.fn.stdpath 'data' .. '\\tsparser')
opt.runtimepath:append(vim.fn.stdpath 'config' .. '\\snippets')
