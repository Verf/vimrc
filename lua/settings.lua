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

-- Functions
function _G.myfoldtext()
    -- local line = vim.fn.getline(vim.v.foldstart)
    local line_indent = vim.fn.indent(vim.fn.nextnonblank(vim.v.foldstart))
    local line_count = vim.v.foldend - vim.v.foldstart + 1
    local omit_text = string.rep(" ", line_indent) .. ""
    return string.format("%-20s 並×%d", omit_text, line_count)
end

-- global
g.mapleader = ' '
g.maplocalleader = ','

-- language
g.loaded_python_provider = 0
g.python3_host_prog = vim.fn.expand("~/scoop/shims/python3.exe")
g.sqlite_clib_path = [[C:\Programes\sqlite\sqlite3.dll]]

cmd [[autocmd filetype org setlocal tabstop=2 softtabstop=2 shiftwidth=2]]

----- settings -----
opt.wrap          = false
opt.hidden        = true
opt.showmatch     = true
opt.smartcase     = true
opt.autochdir     = false
opt.termguicolors = true
opt.foldenable    = true
opt.backup        = false
opt.undofile      = true
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
opt.synmaxcol     = 200

opt.foldlevel    = 99

opt.mouse        = 'a'
opt.showbreak    = '⮎'
opt.signcolumn   = 'yes'
opt.virtualedit  = 'all'
opt.clipboard    = 'unnamed'
opt.shell        = 'pwsh -nol'
opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
opt.shellredir   = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
opt.shellpipe    = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
opt.shellquote   = ''
opt.shellxquote  = ''
opt.shortmess    = 'filnxtToOFc'
opt.whichwrap    = ''
opt.switchbuf    = 'useopen,usetab,newtab'
opt.completeopt  = 'menuone,noselect'
