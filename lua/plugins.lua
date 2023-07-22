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

    use { 'stevearc/dressing.nvim' }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup {
                show_current_context = true,
            }
        end,
    }

    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'dracula-nvim',
                },
            }
        end,
    }

    use {
        'nanozuki/tabby.nvim',
        config = function()
            local theme = {
                fill = 'Tabline',
                sel = 'lualine_a_normal',
            }
            local filename = require 'tabby.module.filename'
            require('tabby.tabline').set(function(line)
                return {
                    line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                        return {
                            line.sep(' ', theme.sel, theme.fill),
                            win.is_current() and '' or '',
                            filename.relative(win.id),
                            line.sep(' ', theme.sel, theme.fill),
                            hl = theme.sel,
                            margin = ' ',
                        }
                    end),
                    line.spacer(),
                    line.tabs().foreach(function(tab)
                        local hl = tab.is_current() and theme.sel or theme.fill
                        return {
                            line.sep(' ', hl, theme.fill),
                            tab.is_current() and '' or '',
                            tab.number(),
                            line.sep(' ', hl, theme.fill),
                            hl = hl,
                            margin = ' ',
                        }
                    end),
                    hl = theme.fill,
                }
            end)
        end,
    }

    -- edit
    use 'dcampos/nvim-snippy'

    use {
        'hrsh7th/nvim-cmp',
        config = [[require 'configs.completion']],
        events = 'InsertEnter',
        requires = {
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'dcampos/cmp-snippy',
        },
    }

    use {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.align').setup()
            require('mini.bufremove').setup {
                set_vim_settings = false,
            }
            require('mini.comment').setup()
            require('mini.jump').setup {
                mappings = {
                    forward = 't',
                    backward = 'T',
                    forward_till = 'k',
                    backword_till = 'K',
                    repeat_jump = 'h',
                },
            }
            require('mini.pairs').setup()
            require('mini.surround').setup {
                mappings = {
                    add = '<leader>sa',
                    delete = '<leader>sd',
                    find = '',
                    find_left = '',
                    highlight = '',
                    replace = '<leader>sc',
                    update_n_lines = '',
                    suffix_last = '',
                    suffix_next = '',
                },
            }
            vim.keymap.set('n', '<F2>', ':lua MiniFiles.open()<CR>')
            require('mini.files').setup {
                mappings = {
                    close = 'q',
                    go_in = 'o',
                    go_in_plus = 'O',
                    go_out = 'y',
                    go_out_plus = 'Y',
                    reset = '<BS>',
                    reveal_cwd = '@',
                    show_help = 'g?',
                    synchronize = '=',
                    trim_left = '<',
                    trim_right = '>',
                },
            }
            local hipatterns = require 'mini.hipatterns'
            hipatterns.setup {
                highlighters = {
                    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                    todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            }
        end,
    }

    use {
        'woosaaahh/sj.nvim',
        config = function()
            require('sj').setup {
                update_search_register = true,
                separator = ' ',
                keymaps = nil,
                -- stylua: ignore
                labels = {
                    "t", "n", "f", "u", "v", "m", "e", "i", "d", "r", "c", "o",
                    "l", "w", "s", "x", "a", "h", "q", "z", "g", "y", "k", "p",
                },
            }
        end,
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
            vim.keymap.set({ 'n', 'v' }, '<C-a>', '<Plug>(dial-increment)')
            vim.keymap.set({ 'n', 'v' }, '<C-e>', '<Plug>(dial-decrement)')
            vim.keymap.set('v', 'g<C-a>', '<Plug>(dial-increment-additonal)')
            vim.keymap.set('v', 'g<C-e>', '<Plug>(dial-decrement-additonal)')
        end,
    }

    -- enhance
    use {
        'folke/which-key.nvim',
        config = [[require 'configs.whichkey']],
    }

    use {
        'beauwilliams/focus.nvim',
        config = function()
            require('focus').setup()
        end,
    }

    use {
        'chaoren/vim-wordmotion',
        config = function()
            vim.g.wordmotion_nomap = 1
            vim.keymap.set('n', 'w', '<Plug>WordMotion_w')
            vim.keymap.set('n', 'W', '<Plug>WordMotion_W')
            vim.keymap.set('n', 'b', '<Plug>WordMotion_b')
            vim.keymap.set('n', 'B', '<Plug>WordMotion_B')
            vim.keymap.set('n', 'd', '<Plug>WordMotion_e')
            vim.keymap.set('n', 'D', '<Plug>WordMotion_d')
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
        'axkirillov/hbac.nvim',
        config = function()
            require('hbac').setup {
                autoclose = true,
                threshold = 5,
            }
        end,
        requires = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
        },
    }

    use {
        'ethanholz/nvim-lastplace',
        config = function()
            require('nvim-lastplace').setup()
        end,
    }

    use {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('telescope').setup {
                defaults = {
                    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                    layout_strategy = 'vertical',
                    layout_config = {
                        width = 0.8,
                    },
                },
                extensions = {
                    undo = {
                        use_delta = false,
                        side_by_side = false,
                        diff_context_lines = 3,
                    },
                    everything = {
                        match_path = true,
                        regex = true,
                        max_results = 100,
                    },
                },
            }
            require('telescope').load_extension 'zf-native'
            require('telescope').load_extension 'everything'
        end,
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'natecraddock/telescope-zf-native.nvim',
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

    -- integration
    use {
        'voldikss/vim-floaterm',
        config = function()
            vim.g.floaterm_width = 0.8
            vim.g.floaterm_height = 0.8
            vim.keymap.set('n', '<F1>', ':FloatermToggle<CR>')
            vim.keymap.set('t', '<F1>', '<C-\\><C-n>:FloatermToggle<CR>')
            vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
            vim.keymap.set('t', '<C-t>', '<C-\\><C-n>:FloatermNew<CR>')
            vim.keymap.set('t', '<C-n>', '<C-\\><C-n>:FloatermNext<CR>')
            vim.keymap.set('t', '<C-p>', '<C-\\><C-n>:FloatermPrev<CR>')
        end,
    }

    use {
        'mhartington/formatter.nvim',
        config = function()
            require('formatter').setup {
                logging = true,
                log_level = vim.log.levels.WARN,
                filetype = {
                    lua = {
                        require('formatter.filetypes.lua').stylua,
                    },
                    vue = {
                        require('formatter.filetypes.vue').prettier,
                    },
                    json = {
                        require('formatter.filetypes.json').prettier,
                    },
                    javascript = {
                        require('formatter.filetypes.json').prettier,
                    },
                    python = {
                        function()
                            return {
                                exe = 'blue',
                                args = { '-q', '-' },
                                stdin = true,
                            }
                        end,
                    },
                },
            }
        end,
    }

    use {
        'lewis6991/gitsigns.nvim',
        events = 'BufRead',
        config = function()
            require('gitsigns').setup {
                update_debounce = 1000,
            }
        end,
        requires = {
            'nvim-lua/plenary.nvim',
        },
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = [[require 'configs.treesitter']],
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'HiPhish/nvim-ts-rainbow2',
            'windwp/nvim-ts-autotag',
        },
    }

    use {
        'neovim/nvim-lspconfig',
        config = [[require 'configs.lsp']],
        requires = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'onsails/lspkind-nvim',
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
