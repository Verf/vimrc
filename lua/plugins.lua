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
    use 'rebelot/kanagawa.nvim' -- color theme

    use {
        'kyazdani42/nvim-web-devicons',
        module = 'nvim-web-devicons',
    }

    use {
        'yamatsum/nvim-nonicons',
        requires = { 'kyazdani42/nvim-web-devicons' },
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
        'Verf/eyeliner.nvim',
        config = function()
            vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = '#FF5D62' })
            require('eyeliner').setup {
                highlight_on_key = true,
            }
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
        'akinsho/bufferline.nvim',
        config = [[require('configs.bufferline')]],
    }

    -- edit
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
    use 'lewis6991/impatient.nvim'

    use 'stevearc/dressing.nvim' -- improve default ui interface

    use 'fedepujol/move.nvim'

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
            require('mini.pairs').setup()
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
            require('mini.sessions').setup {
                file = '',
                autowrite = false,
            }
            require('mini.starter').setup()
            require('mini.surround').setup {
                mappings = {
                    replace = 'sc',
                },
            }
        end,
    }

    use {
        'junegunn/vim-easy-align',
        keys = '<Plug>(EasyAlign)',
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
        'Pocco81/auto-save.nvim',
        config = function()
            require('auto-save').setup()
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
        'airblade/vim-rooter',
        config = function()
            vim.g.rooter_patterns = { '.git', 'make.sh', 'MakeFile', 'pom.xml', 'package.json' }
            vim.g.rooter_change_directory_for_non_project_files = 'current'
        end,
    }

    -- integration
    use {
        'voldikss/vim-floaterm',
        config = function()
            vim.g.floaterm_width = 0.8
            vim.g.floaterm_height = 0.8
        end,
    }

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
        requires = { 'rcarriga/nvim-dap-ui', 'leoluz/nvim-dap-go', 'mfussenegger/nvim-dap-python' },
        config = function()
            require('dapui').setup()
            require('dap-python').setup 'python'
            require('dap-go').setup()
        end,
        ft = { 'python', 'go' },
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

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
        tag = 'nightly',
        config = function()
            require('nvim-tree').setup {
                auto_reload_on_write = false,
            }
        end,
    }

    use {
        'nvim-neorg/neorg',
        config = function()
            require('neorg').setup {
                load = {
                    ['core.defaults'] = {},
                    ['core.keybinds'] = {
                        config = {
                            neorg_leader = '<leader>',
                        },
                    },
                    ['core.norg.concealer'] = {},
                    ['core.norg.dirman'] = {
                        config = {
                            workspaces = {
                                daily = vim.g.neorg_daily_path,
                            },
                            index = 'inbox.norg',
                        },
                    },
                    ['core.norg.journal'] = {
                        config = {
                            workspace = 'daily',
                            journal_folder = '',
                            strategy = 'flat',
                        },
                    },
                    ['core.norg.completion'] = {
                        config = {
                            engine = 'nvim-cmp',
                        },
                    },
                    ['core.gtd.base'] = {
                        config = {
                            workspace = 'daily',
                            default_lists = {
                                inbox = 'inbox.norg',
                                someday = 'someday.norg',
                            },
                        },
                    },
                    ['core.presenter'] = {
                        config = {
                            zen_mode = 'truezen',
                        },
                    },
                    ['core.integrations.telescope'] = {},
                    ['external.kanban'] = {
                        config = {
                            task_states = {
                                'urgent',
                                'undone',
                                'done',
                                'pending',
                                'cancelled',
                            },
                        },
                    },
                },
            }
            local neorg_callbacks = require 'neorg.callbacks'
            neorg_callbacks.on_event('core.keybinds.events.enable_keybinds', function(_, keybinds)
                keybinds.map_event_to_mode('norg', {
                    n = { { '<leader>fl', 'core.integrations.telescope.find_linkable' } },
                    i = { { '<C-l>', 'core.integrations.telescope.insert_link' } },
                }, { silent = true, noremap = true })
            end)
            require('neorg').org_file_entered(true, 'silent=true')
        end,
        requires = { 'nvim-neorg/neorg-telescope', 'max397574/neorg-kanban' },
    }

    use {
        'Pocco81/true-zen.nvim',
        config = function()
            require('true-zen').setup {}
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
