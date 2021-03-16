--  __      _______ __  __ _____   _____
--   \ \    / /_   _|  \/  |  __ \ / ____|
--    \ \  / /  | | | \  / | |__) | |
--     \ \/ /   | | | |\/| |  _  /| |
--      \  /   _| |_| |  | | | \ \| |____
--       \/   |_____|_|  |_|_|  \_\\_____|
--
--  For Verf

----------- Variable -------------
local cmd, fn, g = vim.cmd, vim.fn, vim.g
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }

----------- Function --------------
local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

------------ Server --------------
cmd 'call serverstart(\'\\\\.\\pipe\\nvim-pipe-12345\')'

----------  Plugin ----------
cmd 'packadd paq-nvim'
local paq = require'paq-nvim'.paq
paq{'savq/paq-nvim', opt=true}
-- Fuzzy Search
paq 'Yggdroot/LeaderF'
paq 'liuchengxu/vista.vim'
paq 'easymotion/vim-easymotion'
-- Completion
paq 'hrsh7th/nvim-compe'
paq 'glepnir/lspsaga.nvim'
paq 'onsails/lspkind-nvim'
paq 'neovim/nvim-lspconfig'
-- Edit Enchance
paq 'SirVer/ultisnips'
paq 'sbdchd/neoformat'
paq 'tpope/vim-repeat'
paq 'cohama/lexima.vim'
paq 'Verf/vim-surround'
paq 'b3nj5m1n/kommentary'
paq 'mg979/vim-visual-multi'
paq 'junegunn/vim-easy-align'
-- UI Plugin
paq 'joshdick/onedark.vim'
paq 'hoob3rt/lualine.nvim'
paq 'kyazdani42/nvim-tree.lua'
paq 'akinsho/nvim-bufferline.lua'
paq 'kyazdani42/nvim-web-devicons'
-- Others
paq 'ervandew/supertab'
paq '907th/vim-auto-save'
paq 'airblade/vim-rooter'
paq 'voldikss/vim-floaterm'
paq 'simnalamburt/vim-mundo'
paq 'farmergreg/vim-lastplace'
paq {'nvim-treesitter/nvim-treesitter', run='TSUpdate'}
-- Language
paq 'plasticboy/vim-markdown'

----------- Command -------------
cmd 'filetype plugin indent on'
cmd 'language en_US'
cmd 'colorscheme onedark'
cmd 'nohlsearch'
cmd 'command! Bd :bp | :sp | :bn | :bd'

---------- Config ----------
opt('o', 'number',        true)
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
opt('b', 'textwidth',     120)
opt('b', 'synmaxcol',     200)
opt('w', 'signcolumn',    'yes')

opt('o', 'shortmess',     'filnxtToOFc')
opt('o', 'switchbuf',     'useopen,usetab,newtab')
opt('o', 'completeopt',   'menu,menuone,noselect')

----------- Mappings --------------
g['mapleader'] = ' '
g['maplocalleader'] = ','
require('configs.keymaps')

---------- Lua Plugins --------------
require('configs.lsp')
require('configs.lualine')
require('configs.devicons')
require('configs.nvim-tree')
require('configs.bufferline')
require('configs.completion')
require('configs.treesitter')

---------- Vim Plugins --------------
-- easy motion
g['EasyMotion_smartcase'] = 1
g['EasyMotion_do_mapping'] = 0

-- easy-align
g['easy_align_delimiters'] = {
    ['d'] = { pattern = '--',  delimiter_align = 'l', ignore_groups = {'!Comment'}},
}

-- vim-visual-multi
g['VM_maps'] = {
    ['Find Under']         = '<C-s>',
    ['Find Subword Under'] = '<C-s>',
    ['Add Cursor Down']    = '<M-Down>',
    ['Add Cursor Up']      = '<M-Up>',
    ['Find Next']          = '<C-s>',
    ['Find Prev']          = '<C-S-s>',
    ['Goto Next']          = ']',
    ['Goto Prev']          = '[',
    ['Seek Next']          = '<C-f>',
    ['Seek Prev']          = '<C-b>',
    ['Skip Region']        = '<C-x>',
    ['Remove Region']      = '<C-S-x>',
    ['Replace']            = 'R',
    ['Surround']           = 'S',
    ['Toggle Multiline']   = 'M',
}

-- vim-autosave
g['auto_save'] = 1
g['auto_save_silent'] = 0

-- Mundo
g['mundo_mappings'] = {
    ["<CR>"] = 'preview',
    n        = 'move_older',
    i        = 'move_newer',
    N        = 'move_older_write',
    I        = 'move_newer_write',
    gg       = 'move_top',
    G        = 'move_bottom',
    P        = 'play_to',
    d        = 'diff',
    l        = 'toggle_inline',
    ["/"]    = 'search',
    m        = 'next_match',
    M        = 'previous_match',
    p        = 'diff_current_buffer',
    f        = 'diff',
    ["?"]    = 'toggle_help',
    q        = 'quit'
}

-- floaterm
g['floaterm_weight']      = 0.8
g['floaterm_height']      = 0.8
g['floaterm_autoclose']   = 1
g['floaterm_shell']       = 'pwsh -nologo'
g['floaterm_rootmarkers'] =  {'.project', '.git', '.gitignore', 'pom.xml'}

-- vim-markdown
cmd 'au FileType markdown map <Plug> <Plug>Markdown_MoveToParentHeader'
cmd 'au FileType markdown map <C-Enter> <Plug>Markdown_MoveToParentHeader'
g['vim_markdown_folding_disabled'] = 1

-- vim-rooter
g['rooter_silent_chdir'] = 1
g['rooter_patterns'] = {'.git', '.gitignore', '.project', 'pom.xml', 'setup.py'}

-- vista
g['vista_stay_on_open'] = 0

-- supertab
g['SuperTabDefaultCompletionType'] = 'context'
g['SuperTabContextDefaultCompletionType'] = '<C-n>'

-- ultisnips
g['UltiSnipsExpandTrigger']       = '<Tab>'
g['UltiSnipsJumpForwardTrigger']  = '<Tab>'
g['UltiSnipsJumpBackwardTrigger'] = '<S-Tab>'
g['UltiSnipsEditSplit'] = 'vertical'
g['UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit'] = 'ultisnips'

-- leaderf
g['Lf_ShortcutF'] = '<leader>ff'
g['Lf_ShortcutB'] = '<leader>bb'
g['Lf_WindowHeight'] = 0.30
g['Lf_StlColorscheme'] = 'one'
g['Lf_PopupColorscheme'] = 'one'
g['Lf_WindowPosition'] = 'popup'
g['Lf_DefaultExternalTool'] = 'rg'
g['Lf_IgnoreCurrentBufferName'] = 1
g['Lf_RootMarkers'] = {'.git', '.gitignore', '.project', 'pom.xml', 'setup.py'}
g['Lf_StlSeparator'] = { left= '', right = '', font = '更纱黑体 Mono SC Nerd' }
g['Lf_WildIgnore'] = {
    dir = {'.git', '.vscode', '.cache', '.vim'},
    file = {'*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]'}
}
g['Lf_CommandMap'] = {
    ['<C-j>'] = {'<C-n>'},
    ['<C-k>'] = {'<C-i>'},
    ['<C-]>'] = {'<C-->'},
    ['<C-x>'] = {'<C-|>'},
}
