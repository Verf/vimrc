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
        'Mofiqul/dracula.nvim',
        config = function()
            vim.cmd 'colorscheme dracula'
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
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup {
                show_current_context = true,
            }
        end,
    }

    use {
        'folke/todo-comments.nvim',
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

    -- edit
    use 'fedepujol/move.nvim'

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
            'hrsh7th/cmp-cmdline',
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
        'echasnovski/mini.nvim',
        config = function()
            require('mini.bufremove').setup()
            require('mini.comment').setup()
            require('mini.pairs').setup()
            require('mini.align').setup()
            require('mini.fuzzy').setup()
            require('mini.surround').setup {
                mappings = {
                    add = '<leader>sa', -- Add surrounding in Normal and Visual modes
                    delete = '<leader>sd', -- Delete surrounding
                    find = '', -- Find surrounding (to the right)
                    find_left = '', -- Find surrounding (to the left)
                    highlight = '', -- Highlight surrounding
                    replace = '<leader>sc',
                    update_n_lines = '', -- Update `n_lines`
                    suffix_last = 'l', -- Suffix to search with "prev" method
                    suffix_next = 'n', -- Suffix to search with "next" method
                },
            }
            require('mini.jump').setup {
                mappings = {
                    forward = 't',
                    backward = 'T',
                    forward_till = 'k',
                    backword_till = 'K',
                    repeat_jump = 'h',
                },
            }
        end,
    }

    use {
        'woosaaahh/sj.nvim',
        config = function()
            local sj = require 'sj'
            sj.setup {
                separator = ' ',
            }
            vim.keymap.set('n', 's', sj.run)
        end,
    }

    -- enhance
    use 'lewis6991/impatient.nvim'

    use 'nvim-lua/plenary.nvim'

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
        '907th/vim-auto-save',
        config = function()
            vim.g.auto_save = true
            vim.g.auto_save_events =
                { 'InsertLeave', 'BufLeave', 'TabLeave', 'WinLeave', 'VimLeave', 'FocusLost', 'CursorHold' }
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
        'Verf/auto-session',
        config = function()
            require('auto-session').setup {
                auto_session_create_enabled = false,
                auto_save_enabled = true,
                auto_restore_enabled = true,
                auto_session_use_git_branch = false,
                pre_save_cmds = { 'FloatermKill!' },
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
                file_browser = {
                    theme = 'ivy',
                    hijack_netrw = true,
                },
            }
            require('telescope').load_extension 'file_browser'
            require('telescope').load_extension 'session-lens'
            require('telescope').load_extension 'everything'
        end,
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'rmagatti/session-lens',
            'Verf/telescope-everything.nvim',
        },
    }

    use {
        'airblade/vim-rooter',
        config = function()
            vim.g.rooter_patterns = { '.git', 'make.sh', 'MakeFile', 'pom.xml', 'package.json' }
            vim.g.rooter_change_directory_for_non_project_files = 'current'
        end,
    }

    use { 'preservim/vim-markdown', ft = 'markdown' }

    use {
        'kevinhwang91/nvim-ufo',
        config = function()
            require('ufo').setup {
                provider_selector = function()
                    return { 'treesitter', 'indent' }
                end,
            }
        end,
        requires = 'kevinhwang91/promise-async',
    }

    use {
        'nvim-orgmode/orgmode',
        config = function()
            require('orgmode').setup_ts_grammar()
            require('orgmode').setup {
                org_agenda_files = { vim.g.org_agenda_files },
                org_default_notes_file = vim.g.org_refile_file,
            }
            require('org-bullets').setup()
        end,
        requires = { 'akinsho/org-bullets.nvim' },
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
            require('gitsigns').setup {
                update_debounce = 500,
            }
        end,
        requires = {
            'nvim-lua/plenary.nvim',
        },
    }

    use 'mbbill/undotree'

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
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end,
})

return plugins
