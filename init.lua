--   __      _______ __  __ _____   _____
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

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

------------- Plugin ------------------
require('packer').startup(function()
    -- packer itself
    use {'wbthomason/packer.nvim'}
    -- color shceme & indent enchance
    use 'sheerun/vim-polyglot'
    -- colorshceme sonokai
    use 'sainnhe/sonokai'
    -- auto pair
    use 'cohama/lexima.vim'
    -- surround enchance
    use 'Verf/vim-surround'
    -- auto formate
    use 'sbdchd/neoformat'
    -- tag viewer
    use 'liuchengxu/vista.vim'
    -- move enchance
    use 'easymotion/vim-easymotion'
    -- repeat enchance
    use 'tpope/vim-repeat'
    -- auto save
    use '907th/vim-auto-save'
    -- save last place
    use 'farmergreg/vim-lastplace'
    -- auto set root dir
    use 'airblade/vim-rooter'
    -- re/undo enchance & viewer
    use 'simnalamburt/vim-mundo'
    -- float terminal
    use 'voldikss/vim-floaterm'
    -- tab enchance
    use 'ervandew/supertab'
    -- snippet
    use 'SirVer/ultisnips'
    -- multiple edit
    use 'mg979/vim-visual-multi'
    -- align enchance
    use 'junegunn/vim-easy-align'
    -- comment enchance
    use 'scrooloose/nerdcommenter'
    -- markdown enchance
    use 'plasticboy/vim-markdown'
    -- status line
    use {
        'hoob3rt/lualine.nvim',
        config = function()
            require('lualine').setup{
                options = {
                    theme = 'onedark',
                    section_separators = {'', ''},
                    component_separators = {'|', '|'},
                    icons_enabled = true,
                },
                sections = {
                    lualine_a = { {'mode', upper = true} },
                    lualine_b = { {'branch', icon = ''} },
                    lualine_c = { {'filename', file_status = true} },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location'  },
                },
                inactive_sections = {
                    lualine_a = {  },
                    lualine_b = {  },
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {  },
                    lualine_z = {  }
                },
            }
        end
    }
    -- fuzzy search
    use 'Yggdroot/LeaderF'
    -- buffer & tab line
    use {
        'akinsho/nvim-bufferline.lua',
        config = function()
            require'bufferline'.setup{
                options = {
                    view = "multiwindow",
                    numbers = "none",
                    always_show_bufferline = true,
                    buffer_close_icon= '',
                    modified_icon = '●',
                    close_icon = '',
                    left_trunc_marker = '',
                    right_trunc_marker = '',
                    max_name_length = 18,
                    max_prefix_length = 15,
                    tab_size = 18,
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level)
                        return "("..count..")"
                    end,
                    show_buffer_close_icons = false,
                    persist_buffer_sort = true,
                    separator_style = "thin",
                    enforce_regular_tabs = false,
                    sort_by = 'extension',
                }
            }
        end
    }
    -- icons
    use {
        'kyazdani42/nvim-web-devicons',
        config = function()
            require'nvim-web-devicons'.setup {
                default = true;
            }
        end
    }
    -- completion
    use {'hrsh7th/nvim-compe',
        config = function()
            require'compe'.setup{
                enabled = true,
                debug = false,
                autocomplete = true,
                min_length = 1,
                preselect = 'enable',
                source = {
                    path      = true,
                    calc      = true,
                    buffer    = true,
                    nvim_lsp  = true,
                    ultisnips = true,
                    vsnips    = false
                }
            }
        end
    }
    -- lsp
    use {
        'neovim/nvim-lspconfig',
        config = function()
            local nvim_lsp = require('lspconfig')
            local on_attach = function(client, bufnr)
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Set autocommands conditional on server_capabilities
                if client.resolved_capabilities.document_highlight then
                    vim.api.nvim_exec([[
                    hi LspReferenceRead term=underline cterm=underline gui=underline
                    hi LspReferenceText term=underline cterm=underline gui=underline
                    hi LspReferenceWrite term=underline cterm=underline gui=underline
                    augroup lsp_document_highlight
                    au!
                    au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                    augroup END
                        ]], false)
                end
            end
            -- loop to setup
            local servers = { "pyright" }
            for _, lsp in ipairs(servers) do
                nvim_lsp[lsp].setup { on_attach = on_attach }
            end
        end
    }
    use {
        'glepnir/lspsaga.nvim',
        config = function()
            require('lspsaga').init_lsp_saga()
        end
    }
    use {
        'onsails/lspkind-nvim',
        config = function()
            require('lspkind').init()
        end
    }
    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = {"python", "java", "lua"},
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true
                },
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",

                            -- Or you can define your own textobjects like this
                            ["iF"] = {
                                python = "(function_definition) @function",
                                java = "(method_declaration) @function",
                            },
                        },
                    },
                },
            }
        end
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
end
)

----------- Command -------------
cmd 'call serverstart(\'\\\\.\\pipe\\nvim-pipe-12345\')'
cmd 'filetype plugin indent on'
cmd 'colorscheme sonokai'
cmd 'language en_US'
cmd 'nohlsearch'
cmd 'command! Bd :bp | :sp | :bn | :bd'

-------- Basic Config --------
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
opt('b', 'textwidth',     200)
opt('b', 'synmaxcol',     200)
opt('w', 'signcolumn',    'yes')

opt('o', 'shortmess',     'filnxtToOFc')
opt('o', 'switchbuf',     'useopen,usetab,newtab')
opt('o', 'completeopt',   'menuone,noinsert,noselect')

----------- Mappings --------------
g['mapleader'] = ' '
g['maplocalleader'] = ','
-- Norman Keyboard Layout
map('', 'd', 'e')
map('', 'f', 'r')
map('', 'k', 't')
map('', 'j', 'y')
map('', 'r', 'i')
map('', 'l', 'o')
map('', 'h', 'p')
map('', 'e', 'd')
map('', 't', 'f')
map('', 'g', 'g')
map('', 'y', 'h')
map('', 'n', 'j')
map('', 'i', 'k')
map('', 'o', 'l')
map('', 'p', 'n')
map('', 'D', 'E')
map('', 'F', 'R')
map('', 'K', 'T')
map('', 'J', 'Y')
map('', 'R', 'I')
map('', 'L', 'O')
map('', 'H', 'P')
map('', 'E', 'D')
map('', 'T', 'F')
map('', 'Y', 'H')
map('', 'N', 'J')
map('', 'I', 'K')
map('', 'O', 'L')
map('', 'P', 'N')

-- Terminal
map('n', '<C-`>', ':FloatermToggle<CR>')
map('t', '<C-o>', '<C-\\><C-n>')
map('t', '<C-`>', '<C-\\><C-n>:FloatermToggle<CR>')
map('t', '<C-t>', '<C-\\><C-n>:FloatermNew<CR>')
map('t', '<C-q>', '<C-\\><C-n>:FloatermKill<CR>')
map('t', '<C-n>', '<C-\\><C-n>:FloatermNext<CR>')
map('t', '<C-p>', '<C-\\><C-n>:FloatermPrev<CR>')

-- Buffer Switch
map('n', '<leader><leader>', ':BufferLinePick<CR>')
map('n', '<leader><Tab>', ':e#<CR>')

-- Edit
map('n', '<leader>et', ':%s/\\s\\+$//e<CR>')
map('n', '<leader>en', ':%d/^$/g<CR>')

-- Paste
map('n', '<leader>pp', '"+p')
map('n', '<leader>pc', '":p')
map('n', '<leader>ps', '"/p')
map('n', '<leader>py', '"0p')

-- Config
map('n', '<leader>co', ':e $MYVIMRC<CR>')

-- Quit
map('n', '<leader>qq', ':Bd<CR><CR>')
map('n', '<leader>qw', ':qw<CR>')
map('n', '<leader>qa', ':qa<CR>')
map('n', '<leader>qx', ':qa!<CR>')

-- Windows Operate
map('n', '<leader>wh', '<C-w>s')
map('n', '<leader>wv', '<C-w>v')
map('n', '<leader>wq', '<C-w>c')
map('n', '<leader>wt', '<C-w>T')
map('n', '<leader>wy', '<C-w>h')
map('n', '<leader>wn', '<C-w>j')
map('n', '<leader>wi', '<C-w>k')
map('n', '<leader>wo', '<C-w>l')
map('n', '<leader>wY', '<C-w>H')
map('n', '<leader>wN', '<C-w>J')
map('n', '<leader>wI', '<C-w>K')
map('n', '<leader>wO', '<C-w>L')
map('n', '<leader>w+', '<C-w>+')
map('n', '<leader>w-', '<C-w>-')
map('n', '<leader>wc', ':only<CR>')

-- neoformat
map('n', '<leader>fm', ':Neoformat<CR>')

-- nerdcommenter
map('n', '<leader>c', '<Plug>NERDCommenterToggle')

-- nvim-tree
map('n', '<F2>', ':NvimTreeToggle<CR>')

-- vista
map('n', '<F3>', ':Vista!!<CR>')

-- easymotion
map('n', 's', '<Plug>(easymotion-s2)', {noremap=false})
map('n', '/', '<Plug>(easymotion-sn)', {noremap=false})
map('o', '/', '<Plug>(easymotion-tn)', {noremap=false})
map('n', 'gl', '<Plug>(easymotion-overwin-line)', {noremap=false})
map('n', 'gw', '<Plug>(easymotion-bd-w)', {noremap=false})
map('n', 'ge', '<Plug>(easymotion-bd-e)', {noremap=false})
map('n', 'gf', '<Plug>(easymotion-lineforward)', {noremap=false})
map('n', 'gb', '<Plug>(easymotion-linebackward)', {noremap=false})
map('n', 'gn', '<Plug>(easymotion-j)', {noremap=false})
map('n', 'gi', '<Plug>(easymotion-k)', {noremap=false})

-- mundo
map('n','<leader>u', ':MundoToggle<CR>')

-- easy-align
map('x', 'ga', '<Plug>(EasyAlign)', {noremap=false})
map('n', 'ga', '<Plug>(EasyAlign)', {noremap=false})

-- leaderf
map('n', '<leader>fa', ':LeaderfFile $HOME<CR>')
map('n', '<leader>ft', ':LeaderfBufTag<CR>')
map('n', '<leader>fh', ':Leaderf mru<CR>')
map('n', '<leader>fp', ':<C-R>=printf(\'Leaderf rg -e %s \', expand(\'<cword>\'))<CR><CR>')
map('n', '<leader>fw', ':<C-R>=printf(\'Leaderf rg -e \')<CR>')

-- lsp
map('n', '<leader>rn', '<CMD>lua require(\'lspsaga.rename\').rename()<CR>')
map('n', 'gd', '<CMD>lua require\'lspsaga.provider\'.lsp_finder()<CR>')
map('n', '[e', '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_prev()<CR>')
map('n', ']e', '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_next()<CR>')

---- Plugin Config --------
-- sonokai
g['sonokai_style'] = 'andromeda'
g['sonokai_enable_italic'] = 1
g['sonokai_disable_italic_comment'] = 0

-- vista
g['vista_stay_on_open'] = 0

-- easymotion
vim.g['EasyMotion_smartcase'] = 1
vim.g['EasyMotion_do_mapping'] = 0

-- auto-save
g['auto_save'] = 1
g['auto_save_silent'] = 0

-- vim-rooter
g['rooter_silent_chdir'] = 1
g['rooter_patterns'] = {'.git', '.gitignore', '.project', 'pom.xml', 'setup.py'}

-- mundo
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

-- supertab
g['SuperTabDefaultCompletionType'] = 'context'
g['SuperTabContextDefaultCompletionType'] = '<C-n>'

-- ultisnips
g['UltiSnipsExpandTrigger']       = '<Tab>'
g['UltiSnipsJumpForwardTrigger']  = '<Tab>'
g['UltiSnipsJumpBackwardTrigger'] = '<S-Tab>'
g['UltiSnipsEditSplit'] = 'vertical'
g['UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit'] = 'ultisnips'

-- multi edit
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

-- easy-align
g['easy_align_delimiters'] = {
    ['d'] = { pattern = '--',  delimiter_align = 'l', ignore_groups = {'!Comment'}},
}

-- markdown
cmd 'au FileType markdown map <Plug> <Plug>Markdown_EditUrlUnderCursor'
cmd 'au FileType markdown map <C-Enter> <Plug>Markdown_EditUrlUnderCursor'
g['vim_markdown_folding_disabled'] = 1

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

-- nerdcommenter
g['NERDCreateDefaultMappings'] = 0
