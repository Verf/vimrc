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
        'nvim-lualine/lualine.nvim',
        config = [[require 'configs.statusline']],
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
                            tab.is_current() and '' or '',
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

    use {
        'lukas-reineke/headlines.nvim',
        config = function()
            require('headlines').setup {
                markdown = {
                    fat_headlines = true,
                    fat_headline_upper_string = '▁',
                    fat_headline_lower_string = '▔',
                },
            }
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
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'dcampos/cmp-snippy',
        },
    }

    use {
        'abecodes/tabout.nvim',
        config = function()
            require('tabout').setup {
                tabkey = '<Tab>',
                backwards_tabkey = '<S-Tab>',
                act_as_tab = true,
                act_as_shift_tab = false,
                default_tab = '<C-t>',
                default_shift_tab = '',
                enable_backwards = true,
                completion = true,
                tabouts = {
                    { open = "'", close = "'" },
                    { open = '"', close = '"' },
                    { open = '`', close = '`' },
                    { open = '(', close = ')' },
                    { open = '[', close = ']' },
                    { open = '{', close = '}' },
                },
                ignore_beginning = true,
                exclude = {},
            }
        end,
        after = { 'nvim-cmp' },
    }

    use {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.align').setup()
            require('mini.bufremove').setup()
            require('mini.comment').setup()
            require('mini.fuzzy').setup()
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
    use 'nvim-lua/plenary.nvim'

    use {
        'stevearc/oil.nvim',
        config = function()
            require('oil').setup {
                skip_confirm_for_simple_edits = true,
            }
        end,
    }

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
            require('telescope').load_extension 'undo'
            require('telescope').load_extension 'everything'
        end,
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'natecraddock/telescope-zf-native.nvim',
            'debugloop/telescope-undo.nvim',
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
        'luukvbaal/statuscol.nvim',
        commit = '5269fb1220f0909c82be8a0c9eab657a55a5f1fa',
        config = function()
            local builtin = require 'statuscol.builtin'
            require('statuscol').setup {
                segments = {
                    { text = { '%s' }, click = 'v:lua.ScSa' },
                    {
                        text = { builtin.lnumfunc, ' ' },
                        condition = { true, builtin.not_empty },
                        click = 'v:lua.ScLa',
                    },
                    { text = { builtin.foldfunc, ' ' }, click = 'v:lua.ScFa' },
                },
            }
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
        'jose-elias-alvarez/null-ls.nvim',
        config = [[require 'configs.nullls']],
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

    use {
        'ellisonleao/glow.nvim',
        config = function()
            require('glow').setup()
        end,
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = [[require 'configs.treesitter']],
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'p00f/nvim-ts-rainbow',
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
