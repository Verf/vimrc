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
    use {
        'rebelot/kanagawa.nvim',
        config = function()
            require('kanagawa').setup {
                commentStyle = { italic = false },
                keywordStyle = { italic = false, bold = true },
                statementStyle = { bold = false },
            }
            vim.cmd 'colorscheme kanagawa'
        end,
    }

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
        'nanozuki/tabby.nvim',
        config = function()
            require('tabby').setup {
                tabline = require('tabby.presets').active_wins_at_tail,
            }
        end,
    }

    -- edit
    use {
        'L3MON4D3/LuaSnip',
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load {
                paths = { vim.fn.stdpath 'config' .. '/vsnip' },
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
        config = function()
            require('tabout').setup {}
        end,
        after = { 'nvim-cmp' },
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
            require('mini.surround').setup {
                mappings = {
                    replace = 'sc',
                },
            }
        end,
    }

    use {
        'folke/which-key.nvim',
        config = [[require('configs.whichkey')]],
    }

    use {
        'beauwilliams/focus.nvim',
        config = function()
            require('focus').setup()
        end,
    }

    use {
        'Pocco81/auto-save.nvim',
        config = function()
            trigger_events = { 'InsertLeave', 'BufLeave', 'TabLeave', 'WinLeave', 'UILeave', 'VimLeave', 'FocusLost' }
            debounce_delay = 500
        end,
    }

    use {
        'rmagatti/auto-session',
        config = function()
            require('auto-session').setup {
                auto_session_create_enabled = false,
            }
        end,
    }

    use {
        'rmagatti/session-lens',
        requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
        config = function()
            require('session-lens').setup()
        end,
    }

    use {
        'windwp/nvim-spectre',
        event = 'BufRead',
        coinfig = function()
            require('spectre').setup {
                mapping = {
                    ['toggle_line'] = {
                        map = 'ee',
                        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
                        desc = 'toggle current item',
                    },
                },
            }
        end,
        requires = { 'nvim-lua/plenary.nvim' },
    }

    use {
        'monaqa/dial.nvim',
        event = 'BufRead',
        config = function()
            local augend = require 'dial.augend'
            local config = require 'dial.config'
            config.augends:register_group {
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.semver.alias.semver,
                    augend.date.alias['%Y/%m/%d'],
                    augend.date.alias['%Y-%m-%d'],
                    augend.date.alias['%Y年%-m月%-d日'],
                    augend.constant.alias.bool,
                    augend.constant.new {
                        elements = { 'and', 'or' },
                        word = true,
                        cyclic = true,
                    },
                    augend.constant.new {
                        elements = { 'True', 'False' },
                        word = true,
                        cyclic = true,
                    },
                    augend.constant.new {
                        elements = { '&&', '||' },
                        cyclic = true,
                    },
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
            require('telescope').load_extension 'everything'
            require('telescope').load_extension 'session-lens'
        end,
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'Verf/telescope-everything.nvim',
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
        event = 'BufRead',
        config = [[require 'configs.formatter']],
    }

    use {
        'lewis6991/gitsigns.nvim',
        events = 'BufRead',
        config = function()
            require('gitsigns').setup()
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
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
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
        'renerocksai/telekasten.nvim',
        config = function()
            require('telekasten').setup {
                home = vim.g.notes_home,
                dailies = vim.g.notes_daily,
                weeklies = vim.g.notes_weekly,
                templates = vim.g.notes_template,
                template_new_note = vim.g.notes_home .. '\\note_template.md',
                template_new_daily = vim.g.notes_daily .. '\\daily_template.md',
                template_new_weekly = vim.g.notes_weekly .. '\\weekly_template.md',
            }
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
