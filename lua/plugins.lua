local packer = nil

local function init()
    if packer == nil then
        packer = require 'packer'
        packer.init {
            max_jobs = 8,
            disable_commands = true,
        }
    end

    local use = packer.use
    packer.reset()

    use {
        'wbthomason/packer.nvim',
        opt = true,
    }

    -- ui
    use 'rebelot/kanagawa.nvim'

    use {
        'kyazdani42/nvim-web-devicons',
        module = 'nvim-web-devicons',
    }

    use {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup {
                stages = 'fade',
                timeout = 5000,
            }
            vim.notify = require 'notify'
        end,
    }

    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup {
                'lua',
                'css',
                'scss',
                'javascript',
                'typescript',
                'vue',
                'html',
            }
        end,
        ft = {
            'lua',
            'css',
            'scss',
            'javascript',
            'typescript',
            'vue',
            'html',
        },
    }

    use {
        'folke/todo-comments.nvim',
        event = 'BufRead',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup {
                search = {
                    pattern = [[\b(KEYWORDS)\b]],
                },
            }
        end,
    }

    use {
        'nvim-lualine/lualine.nvim',
        config = [[require('configs.statusline')]],
    }

    use {
        'akinsho/nvim-bufferline.lua',
        config = [[require('configs.bufferline')]],
    }

    -- edit
    use {
        'windwp/nvim-autopairs',
        after = 'nvim-cmp',
        config = [[require('nvim-autopairs').setup()]],
    }

    use {
        'junegunn/vim-easy-align',
        keys = '<Plug>(EasyAlign)',
    }

    use {
        'L3MON4D3/LuaSnip',
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load {
                paths = vim.fn.stdpath 'config' .. '/vsnip',
            }
        end,
        events = 'InsertEnter',
    }

    use {
        'hrsh7th/nvim-cmp',
        config = [[require('configs.completion')]],
        events = 'InsertEnter',
        requires = {
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
        },
    }

    use {
        'abecodes/tabout.nvim',
        config = [[require'tabout'.setup()]],
        events = 'InsertEnter',
    }

    use {
        'mg979/vim-visual-multi',
        config = function()
            vim.g.VM_maps = {
                ['Find Under'] = '<C-s>',
                ['Find Subword Under'] = '<C-s>',
                ['Add Cursor Down'] = '<M-Down>',
                ['Add Cursor Up'] = '<M-Up>',
                ['Find Next'] = '<C-s>',
                ['Find Prev'] = '<C-S-s>',
                ['Goto Next'] = ']',
                ['Goto Prev'] = '[',
                ['Seek Next'] = '<C-f>',
                ['Seek Prev'] = '<C-b>',
                ['Skip Region'] = '<C-x>',
                ['Remove Region'] = '<C-S-x>',
                ['Replace'] = 'R',
                ['Surround'] = 'S',
                ['Toggle Multiline'] = 'M',
            }
        end,
    }

    -- enhance
    use 'nathom/filetype.nvim'

    use 'stevearc/dressing.nvim'

    use {
        'nvim-lua/plenary.nvim',
        module = 'plenary',
    }

    use {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.bufremove').setup()
            require('mini.comment').setup()
            require('mini.cursorword').setup()
            require('mini.indentscope').setup {
                draw = {
                    delay = 100,
                    animation = require('mini.indentscope').gen_animation 'none',
                },
                mappings = {
                    object_scope = 'ri',
                    object_scope_with_border = 'ai',
                    goto_top = '[i',
                    goto_bottom = ']i',
                },
            }
            require('mini.jump').setup {
                mappings = {
                    forward = 't',
                    backward = 'T',
                    forward_till = 'k',
                    backward_till = 'K',
                    repeat_jump = ';',
                },
            }
            require('mini.sessions').setup {
                file = '',
            }
            require('mini.starter').setup()
            require('mini.surround').setup {
                mappings = {
                    find = '', -- Find surrounding (to the right)
                    find_left = '', -- Find surrounding (to the left)
                    highlight = '', -- Highlight surrounding
                    replace = 'sc', -- Replace surrounding
                    update_n_lines = '', -- Update `n_lines`
                },
            }
        end,
    }

    use {
        'chaoren/vim-wordmotion',
        config = function()
            vim.g.wordmotion_nomap = 1
        end,
    }

    use {
        'andymass/vim-matchup',
        config = function()
            vim.cmd [[xmap r% <Plug>(matchup-i%)]]
            vim.g.matchup_matchparen_offscreen = {
                method = 'popup',
            }
        end,
    }

    use {
        'phaazon/hop.nvim',
        config = function()
            require('hop').setup { keys = 'tfvnumdecriwsxloqazh' }
        end,
        cmd = {
            'HopWord',
            'HopLine',
            'HopChar2',
        },
    }

    use {
        'ethanholz/nvim-lastplace',
        config = function()
            require('nvim-lastplace').setup {
                lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
                lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
                lastplace_open_folds = true,
            }
        end,
    }

    use {
        'Pocco81/AutoSave.nvim',
        config = function()
            require('autosave').setup {
                enabled = true,
                execution_message = '',
                events = { 'InsertLeave', 'TextChanged' },
                conditions = {
                    exists = true,
                    filetype_is_not = {},
                    modifiable = true,
                },
                write_all_buffers = true,
                on_off_commands = true,
                clean_command_line_interval = 0,
                debounce_delay = 135,
            }
        end,
    }

    use {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('telescope').setup {
                defaults = {
                    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = 'smart_case',
                    },
                },
            }
            require('telescope').load_extension 'fzf'
            require('telescope').load_extension 'neoclip'
        end,
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
        },
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
    }

    use {
        'AckslD/nvim-neoclip.lua',
        requires = { 'tami5/sqlite.lua', module = 'sqlite' },
        config = function()
            require('neoclip').setup()
        end,
    }

    use {
        'jedi2610/nvim-rooter.lua',
        config = function()
            require('nvim-rooter').setup {
                rooter_patterns = { '.git', '.root', '.project', 'Makefile', 'pom.xml', 'pyproject.toml' },
                trigger_patterns = { '*' },
                manual = false,
            }
        end,
    }

    -- integration
    use 'rktjmp/lush.nvim'

    use {
        'mhartington/formatter.nvim',
        config = [[require 'configs.formatter']],
        cmd = 'Format',
    }

    use {
        'lewis6991/gitsigns.nvim',
        events = 'BufRead',
        config = function()
            require('gitsigns').setup {
                keymaps = {
                    noremap = true,
                },
            }
        end,
        requires = {
            'nvim-lua/plenary.nvim',
        },
    }

    use {
        'mfussenegger/nvim-dap',
        requires = { 'mfussenegger/nvim-dap-python', 'rcarriga/nvim-dap-ui' },
        config = function()
            require('dapui').setup()
            require('dap-python').setup 'python'
        end,
        ft = { 'python' },
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = [[require('configs.treesitter')]],
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'RRethy/nvim-treesitter-textsubjects',
            'p00f/nvim-ts-rainbow',
            'windwp/nvim-ts-autotag',
            'yioneko/nvim-yati',
        },
    }

    use {
        'neovim/nvim-lspconfig',
        config = [[require('configs.lsp')]],
        requires = {
            'onsails/lspkind-nvim',
            'ray-x/lsp_signature.nvim',
        },
    }

    use {
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup {}
        end,
    }
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end,
})

return plugins
