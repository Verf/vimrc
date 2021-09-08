local packer = nil

local function init()
    if packer == nil then
        packer = require('packer')
        packer.init({
            disable_commands = true
        })
    end

    local use = packer.use
    packer.reset()

    use {
        'wbthomason/packer.nvim',
        opt = true
    }

    use 'tpope/vim-repeat'

    use 'Raimondi/delimitMate'

    use 'Verf/vim-surround'

    use {
        'mhinz/vim-sayonara',
        cmd = 'Sayonara'
    }

    use 'farmergreg/vim-lastplace'

    use 'junegunn/vim-easy-align'

    use 'svermeulen/vim-yoink'

    use 'ggandor/lightspeed.nvim'

    use 'jbyuki/venn.nvim'


    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function ()
            vim.g.indent_blankline_show_current_context  = false
        end
    }

    use {
        'pseewald/vim-anyfold',
        config = function()
            vim.g.anyfold_fold_comments = 1
            vim.cmd [[autocmd FileType * AnyFoldActivate]]
        end
    }

    use {
        '907th/vim-auto-save',
        config = function()
            vim.g.auto_save = 1
            vim.g.auto_save_silent = 1
            vim.g.auto_save_events = {"InsertLeave", "TextChanged"}
        end
    }

    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup{
                'lua';
                'css';
                'javascript';
            }
        end,
        ft = {"lua", "css", "javascript"}
    }

    use {
        'chaoren/vim-wordmotion',
        config = function()
            vim.g.wordmotion_nomap = 1
        end
    }

    use {
        'folke/tokyonight.nvim',
        config = function()
            vim.cmd 'colorscheme tokyonight'
            vim.cmd [[highlight Folded ctermbg=NONE guibg=NONE]]
        end
    }

    use {
        'mg979/vim-visual-multi',
        config = function()
            vim.g.VM_maps = {
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
        end
    }

    use {
        'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup()
        end
    }

    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                search = {
                    pattern = [[\b(KEYWORDS)\b]],
                }
            }
        end
    }

    use {
        'ahmedkhalf/project.nvim',
        config = function()
            require'project_nvim'.setup{
                patterns = { ".git", ".root", ".project", ".svn", "make*", "pom.xml" }
            }
        end
    }

    use {
        'kyazdani42/nvim-web-devicons',
        config = function()
            require'nvim-web-devicons'.setup {
                default = true
            }
        end
    }

    use {
        'hrsh7th/vim-vsnip',
        config = function()
            vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/vsnip'
        end
    }

    use {
        'mfussenegger/nvim-dap',
        requires = {'mfussenegger/nvim-dap-python', 'rcarriga/nvim-dap-ui'},
        config = function()
            require'dapui'.setup()
            require'dap-python'.setup('python')
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('telescope').setup{
                defaults = {
                    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                },
                require('telescope').load_extension('projects')
            }
        end,
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
        }
    }

    use {
        'glepnir/galaxyline.nvim',
        config = [[require('configs.statusline')]]
    }

    use {
        'akinsho/nvim-bufferline.lua',
        config = [[require('configs.bufferline')]]
    }

    use {
        'hrsh7th/nvim-cmp',
        config = [[require('configs.completion')]],
        requires = {
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
        }
    }

    use {
        'mhartington/formatter.nvim',
        config = [[require('configs.formatter')]]
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        branch = '0.5-compat',
        config = [[require('configs.treesitter')]],
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'RRethy/nvim-treesitter-textsubjects',
            'p00f/nvim-ts-rainbow'
        }
    }

    use {
        'neovim/nvim-lspconfig',
        config = [[require('configs.lsp')]],
        requires = {
            'glepnir/lspsaga.nvim',
            'onsails/lspkind-nvim',
            'ray-x/lsp_signature.nvim',
        }
    }

    use {
        'simnalamburt/vim-mundo',
        config = function()
            vim.g.mundo_mappings = {
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
        end
    }

    use {
        'voldikss/vim-floaterm',
        config = function()
            vim.g.shell = 'pwsh'
            vim.g.floaterm_weight = 0.8
            vim.g.floaterm_height = 0.8
        end
    }

    use {
        'ludovicchabant/vim-gutentags',
        config = function ()
            vim.g.gutentags_project_root  = {".git", ".project", ".root"}
            vim.g.gutentags_ctags_tagfile = '.tags'
            vim.g.gutentags_modules = {"ctags"}
            vim.g.gutentags_cache_dir = vim.fn.stdpath("data") .. '/tags'
            vim.g.gutentags_auto_add_gtags_cscope = 0
        end
    }
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end
})

return plugins
