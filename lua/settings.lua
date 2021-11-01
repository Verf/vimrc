local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

----- Init -----
cmd 'set background=dark'
cmd 'colorscheme solarized'

----- Command  -----
cmd [[command! Trim :%s/\s\+$//e]]
cmd [[command! Trimline :%d/^$/g]]
cmd [[command! Editrc :e $MYVIMRC]]

-- Functions
function _G.myfoldtext()
    local line = vim.fn.getline(vim.v.foldstart)
    local line_count = vim.v.foldend - vim.v.foldstart + 1
    return string.format("%s        並×%d", line, line_count)
end

function _G.print_tb(t)
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

-- global
g.mapleader = ' '
g.maplocalleader = ','

-- language
g.loaded_python_provider = 0

cmd [[autocmd FileType html setlocal shiftwidth=2 tabstop=2]]
cmd [[autocmd FileType css setlocal shiftwidth=2 tabstop=2]]
cmd [[autocmd FileType javascript setlocal shiftwidth=2 tabstop=2]]
cmd [[autocmd FileType vue setlocal shiftwidth=2 tabstop=2]]
cmd [[autocmd FileType json setlocal shiftwidth=2 tabstop=2]]

----- settings -----
opt.wrap           = false
opt.hidden         = true
opt.showmatch      = true
opt.ignorecase     = true
opt.smartcase      = true
opt.autochdir      = false
opt.termguicolors  = true
opt.foldenable     = true
opt.backup         = false
opt.undofile       = true
opt.showmode       = false
opt.hlsearch       = false
opt.writebackup    = false
opt.expandtab      = true
opt.autoindent     = true
opt.smartindent    = true
opt.number         = true
opt.relativenumber = true
opt.linebreak      = true
opt.cursorline     = true

opt.updatetime     = 300
opt.scrolloff      = 999
opt.timeoutlen     = 1500
opt.updatecount    = 100
opt.showtabline    = 2
opt.tabstop        = 4
opt.softtabstop    = 4
opt.shiftwidth     = 4
opt.synmaxcol      = 200

opt.foldlevel      = 99
opt.foldmethod     = 'expr'
opt.foldtext       = 'v:lua.myfoldtext()'
opt.foldexpr       = 'nvim_treesitter#foldexpr()'

opt.mouse          = 'a'
opt.showbreak      = '⮎'
opt.signcolumn     = 'yes'
opt.virtualedit    = 'all'
opt.clipboard      = 'unnamed'
opt.shell          = 'pwsh -nol'
opt.shellcmdflag   = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
opt.shellredir     = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
opt.shellpipe      = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
opt.shellquote     = ''
opt.shellxquote    = ''
opt.shortmess      = 'filnxtToOFc'
opt.whichwrap      = ''
opt.switchbuf      = 'useopen,usetab,newtab'
opt.completeopt    = 'menuone,noselect'
opt.fillchars      = 'fold: '
