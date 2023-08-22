local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- ui & theme
    {
        'Verf/deepwhite.nvim',
        branch = 'main',
        lazy = false,
        priority = 1000,
        config = function()
            require('deepwhite').setup {
                low_blue_light = true,
            }
            vim.cmd [[colorscheme deepwhite]]
        end,
    },
    {
        'nvimdev/lspsaga.nvim',
        event = 'LspAttach',
        keys = {
            { '<F3>', '<CMD>Lspsaga outline<CR>', 'Outline' },
            { '<leader>a', '<CMD>Lspsaga code_action<CR>', 'Code Action' },
            { '<leader>rn', '<CMD>Lspsaga rename<CR>', 'Rename' },
            { 'gd', '<CMD>Lspsaga goto_definition<CR>', 'Goto Definition' },
            { 'gr', '<CMD>Lspsaga finder<CR>', 'Goto References' },
            { 'gi', '<CMD>Lspsaga finder imp<CR>', 'Goto Implementation' },
            { 'gk', '<CMD>Lspsaga hover_doc<CR>', 'Hover Doc' },
        },
        opts = {
            code_action = {
                extend_gitsigns = true,
            },
            lightbulb = {
                enable = false,
            },
            symbol_in_winbar = {
                enable = false,
            },
            outline = {
                close_after_jump = true,
                win_width = 35,
                left_width = 0.5,
                keys = {
                    toggle_or_jump = 'l',
                    jump = '<CR>',
                },
            },
            finder = {
                default = 'ref',
                silent = false,
                keys = {
                    shuttle = '[w',
                    toggle_or_open = '<CR>',
                    vsplit = 'v',
                    split = 's',
                    tabe = 't',
                    tabnew = 'T',
                    quit = 'q',
                    close = '<ESC>',
                },
            },
        },
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons', -- optional
        },
    },
    {
        'rcarriga/nvim-notify',
        init = function()
            vim.notify = require 'notify'
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            char = '│',
            filetype_exclude = {
                'help',
                'lspinfo',
                'dashboard',
                'lazy',
                'mason',
                'notify',
                'toggleterm',
                'lazyterm',
            },
            show_current_context = true,
        },
    },
    -- enhance
    {
        'echasnovski/mini.align',
        keys = {
            { 'ga', mode = { 'n', 'x' } },
            { 'gA', mode = { 'n', 'x' } },
        },
        opts = {},
    },
    { 'echasnovski/mini.bracketed', event = 'VeryLazy', opts = {} },
    {
        'echasnovski/mini.bufremove',
        keys = {
            { '<leader>qq', '<CMD>lua MiniBufremove.delete(0, true)<CR>', 'BufRemove' },
        },
        opts = {
            set_vim_settings = false,
        },
    },
    {
        'echasnovski/mini.comment',
        keys = { 'gc', 'gcc' },
        opts = {
            options = {
                ignore_blank_line = true,
            },
        },
    },
    {
        'echasnovski/mini.cursorword',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {},
    },
    {
        'echasnovski/mini.files',
        keys = { { '<F2>', '<CMD>lua MiniFiles.open()<CR>', desc = 'Files' } },
        opts = {
            mappings = {
                close = 'q',
                go_in = 'o',
                go_in_plus = '<CR>',
                go_out = 'y',
                go_out_plus = '-',
                reset = '<BS>',
                reveal_cwd = '@',
                show_help = 'g?',
                synchronize = '=',
                trim_left = '<',
                trim_right = '>',
            },
        },
    },
    {
        'echasnovski/mini.hipatterns',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            local hipatterns = require 'mini.hipatterns'
            hipatterns.setup {
                highlighters = {
                    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                    todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            }
        end,
    },
    {
        'echasnovski/mini.jump',
        keys = { 't', 'T', 'k', 'K', 'h' },
        opts = {
            mappings = {
                forward = 't',
                backward = 'T',
                forward_till = 'k',
                backword_till = 'K',
                repeat_jump = 'h',
            },
        },
    },
    {
        'echasnovski/mini.move',
        keys = { '<M-y>', '<M-n>', '<M-i>', '<M-o>' },
        opts = {
            mappings = {
                left = '<M-y>',
                right = '<M-o>',
                down = '<M-n>',
                up = '<M-i>',
                line_left = '<M-y>',
                line_right = '<M-o>',
                line_down = '<M-n>',
                line_up = '<M-i>',
            },
        },
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            local npairs = require 'nvim-autopairs'
            npairs.setup {
                disable_in_macro = true,
                disable_in_visualblock = true,
                disable_in_replace_mode = true,
                enable_afterquote = false,
            }
            local rule = require 'nvim-autopairs.rule'
            npairs.add_rules {
                rule("f'", "'", 'python'),
                rule('f"', '"', 'python'),
            }
        end,
    },
    {
        'rebelot/heirline.nvim',
        opts = function(_, opts)
            local conditions = require 'heirline.conditions'
            local utils = require 'heirline.utils'
            -- statusline
            local Align = { provider = '%=', hl = 'Normal' }
            local Space = { provider = '───', hl = 'Normal' }
            local Git = {
                condition = conditions.is_git_repo,
                init = function(self)
                    self.status_dict = vim.b.gitsigns_status_dict
                    self.has_changes = self.status_dict.added ~= 0
                        or self.status_dict.removed ~= 0
                        or self.status_dict.changed ~= 0
                end,
                hl = 'Normal',
                Space,
                { -- git branch name
                    provider = function(self)
                        return '  ' .. self.status_dict.head
                    end,
                    hl = { bold = true },
                },
                {
                    provider = function(self)
                        local count = self.status_dict.added or 0
                        return count > 0 and (' +' .. count)
                    end,
                },
                {
                    provider = function(self)
                        local count = self.status_dict.removed or 0
                        return count > 0 and (' -' .. count)
                    end,
                },
                {
                    provider = function(self)
                        local count = self.status_dict.changed or 0
                        return count > 0 and (' ~' .. count)
                    end,
                },
                {
                    condition = function(self)
                        return self.has_changes
                    end,
                    provider = ' ',
                },
            }
            local FileFormat = {
                provider = function()
                    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
                    local fmt = vim.bo.fileformat
                    return ' ' .. enc .. '[' .. fmt .. '] '
                end,
                hl = 'Normal',
            }
            local Ruler = {
                provider = ' %l/%L | %c/%-2{virtcol("$") - 1} ',
                hl = 'Normal',
            }
            -- statusline
            local DefaultStatusline = {
                Git,
                Align,
                FileFormat,
                Ruler,
                Space,
            }
            local InactiveStatusline = {
                condition = conditions.is_not_active,
                Align,
            }
            local SpecialStatusline = {
                condition = function()
                    return conditions.buffer_matches {
                        buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
                        filetype = { '^git.*', 'fugitive' },
                    }
                end,
                Align,
            }
            opts.statusline = {
                fallthrough = false,
                SpecialStatusline,
                InactiveStatusline,
                DefaultStatusline,
            }
            -- tabline
            local TablineFileName = {
                provider = function(self)
                    -- self.filename will be defined later, just keep looking at the example!
                    local filename = self.filename
                    filename = filename == '' and '[No Name]' or vim.fn.fnamemodify(filename, ':t')
                    return filename
                end,
            }
            local TablineFileNameBlock = {
                init = function(self)
                    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
                end,
                hl = function(self)
                    if self.is_active then
                        return 'TabLineSel'
                    else
                        return 'TabLine'
                    end
                end,
                { provider = ' ' },
                TablineFileName,
                { provider = ' ' },
            }
            local BufferLine = utils.make_buflist(TablineFileNameBlock)
            local Tabpage = {
                provider = function(self)
                    return '%' .. self.tabnr .. 'T ' .. self.tabpage .. ' %T'
                end,
                hl = function(self)
                    if not self.is_active then
                        return 'TabLineSel'
                    else
                        return 'TabLine'
                    end
                end,
            }
            local TabPages = {
                -- only show this component if there's 2 or more tabpages
                condition = function()
                    return #vim.api.nvim_list_tabpages() >= 2
                end,
                utils.make_tablist(Tabpage),
            }
            opts.tabline = { BufferLine, Align, TabPages }
            -- winbar
            -- opts.winbar = {
            --     { provider = ' ' },
            -- }
            -- opts.opts = {
            --     disable_winbar_cb = function(args)
            --         return conditions.buffer_matches({
            --             buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
            --             filetype = { '^git.*', 'fugitive', 'Trouble', 'dashboard' },
            --         }, args.buf)
            --     end,
            -- }
        end,
    },
    {
        'echasnovski/mini.surround',
        keys = { '<leader>sa', '<leader>sd', '<leader>sc' },
        opts = {
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
        },
    },
    {
        'woosaaahh/sj.nvim',
        keys = {
            {
                's',
                '<CMD>lua require("sj").run()<CR>',
                desc = 'Jump',
            },
        },
        opts = {
            update_search_register = true,
            separator = ' ',
            keymaps = nil,
            -- stylua: ignore
            labels = {
                't', 'n', 'f', 'u', 'v', 'm', 'e', 'i',
                'd', 'r', 'c', 'o', 'l', 'w', 's', 'x',
                'a', 'h', 'q', 'z', 'g', 'y', 'k', 'p',
            },
        },
    },
    {
        'monaqa/dial.nvim',
        keys = {
            { '<C-a>', '<Plug>(dial-increment)', 'dial-increment' },
            { '<C-x>', '<Plug>(dial-decrement)', 'dial-decrement' },
        },
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
    },
    {
        'beauwilliams/focus.nvim',
        keys = {
            { '<leader>wy', '<CMD>FocusSplitLeft<CR>', 'Split Left' },
            { '<leader>wn', '<CMD>FocusSplitDown<CR>', 'Split Down' },
            { '<leader>wi', '<CMD>FocusSplitUp<CR>', 'Split Up' },
            { '<leader>wo', '<CMD>FocusSplitRight<CR>', 'Split Right' },
        },
        opts = {},
    },
    {
        'axkirillov/hbac.nvim',
        event = 'VeryLazy',
        opts = {
            autoclose = true,
            threshold = 5,
        },
    },
    { 'ethanholz/nvim-lastplace', event = { 'BufReadPost', 'BufNewFile' }, opts = {} },
    {
        'nvim-telescope/telescope.nvim',
        keys = {
            { '<leader><leader>', '<CMD>Telescope buffers<CR>', 'Buffers' },
            { '<leader>ff', '<CMD>Telescope find_files<CR>', 'files' },
            { '<leader>fh', '<CMD>Telescope oldfiles<CR>', 'history' },
            { '<leader>fe', '<CMD>Telescope everything<CR>', 'everything' },
            { '<leader>fg', '<CMD>Telescope live_grep<CR>', 'grep' },
            { '<leader>fd', '<CMD>Telescope diagnostics<CR>', 'diagnostics' },
            { '<leader>fs', '<CMD>Telescope lsp_document_symbols<CR>', 'symbols' },
            { 'gh', '<CMD>Telescope registers<CR>', 'Goto Registers' },
            { 'gm', '<CMD>Telescope marks<CR>', 'Goto Marks' },
        },
        opts = function(_, opts)
            vim.cmd [[au FileType Telescope setlocal nocursorline]]
            opts.defaults = {
                borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                layout_strategy = 'vertical',
                layout_config = {
                    width = 0.8,
                },
            }
            opts.extensions = {
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
            }
            require('telescope').load_extension 'zf-native'
            require('telescope').load_extension 'everything'
        end,
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'natecraddock/telescope-zf-native.nvim',
            'Verf/telescope-everything.nvim',
        },
    },
    {
        'airblade/vim-rooter',
        event = 'VeryLazy',
        config = function()
            vim.g.rooter_patterns = { '.git', 'make.sh', 'MakeFile', 'pom.xml', 'package.json' }
            vim.g.rooter_change_directory_for_non_project_files = 'current'
        end,
    },
    -- integration
    {
        'nvimdev/guard.nvim',
        keys = {
            { '<leader>m', '<CMD>GuardFmt<CR>', 'Format' },
        },
        config = function()
            local ft = require 'guard.filetype'
            ft('lua'):fmt {
                cmd = 'stylua',
                args = { '-' },
                stdin = true,
            }
            ft('typescript,javascript,typescriptreact,vue,json'):fmt {
                cmd = 'prettier.cmd',
                args = { '--stdin-filepath' },
                fname = true,
                stdin = true,
            }
            ft('python'):fmt {
                cmd = 'blue',
                args = { '-q', '-' },
                stdin = true,
            }
            ft('go'):fmt {
                cmd = 'gofmt',
                stdin = true,
            }
            require('guard').setup {
                fmt_on_save = false,
                lsp_as_default_formatter = false,
            }
        end,
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        keys = {
            { ']h', ':Gitsigns next_hunk<CR>', 'Next Hunk' },
            { '[h', ':Gitsigns prev_hunk<CR>', 'Next Hunk' },
        },
        opts = {
            update_debounce = 1000,
        },
    },
    {
        'voldikss/vim-floaterm',
        keys = {
            { '<F1>', '<ESC>:FloatermToggle<CR>', 'Toggle Term', mode = { 'i', 'n', 'x' } },
        },
        config = function()
            vim.g.floaterm_width = 0.8
            vim.g.floaterm_height = 0.8
            vim.keymap.set('t', '<F1>', '<C-\\><C-n>:FloatermToggle<CR>')
            vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
            vim.keymap.set('t', '<C-t>', '<C-\\><C-n>:FloatermNew<CR>')
            vim.keymap.set('t', '<C-n>', '<C-\\><C-n>:FloatermNext<CR>')
            vim.keymap.set('t', '<C-p>', '<C-\\><C-n>:FloatermPrev<CR>')
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        opts = function()
            local cmp = require 'cmp'
            local snip = require 'snippy'
            local lspkind = require 'lspkind'
            local compare = require('cmp').config.compare

            vim.keymap.set({ 'i', 's' }, '<C-d>', '<Plug>(snippy-next)')
            vim.keymap.set({ 'i', 's' }, '<C-u>', '<Plug>(snippy-previous)')

            cmp.setup {
                snippet = {
                    expand = function(args)
                        snip.expand_snippet(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered { border = 'single', scrollbar = false },
                    documentation = cmp.config.window.bordered { border = 'single' },
                },
                formatting = {
                    format = lspkind.cmp_format {
                        maxwidth = 50,
                    },
                },
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm { select = true },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if snip.can_expand() then
                            snip.expand()
                        elseif cmp.visible() then
                            cmp.select_next_item()
                        elseif snip.can_jump(1) then
                            snip.next()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif snip.can_jump(-1) then
                            snip.previous()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                sources = cmp.config.sources {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'buffer' },
                    { name = 'snippy' },
                    { name = 'path' },
                },
                sorting = {
                    comparators = {
                        compare.recently_used,
                        compare.score,
                        compare.locality,
                        compare.offset,
                        compare.order,
                    },
                },
            }

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' },
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                }, {
                    { name = 'cmdline' },
                }),
            })
        end,
        dependencies = {
            'dcampos/nvim-snippy',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'dcampos/cmp-snippy',
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        cmd = 'TSUpdateSync',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    'python',
                    'html',
                    'vue',
                    'javascript',
                    'typescript',
                    'css',
                    'json',
                    'go',
                    'markdown',
                    'markdown_inline',
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<CR>',
                        node_incremental = '<CR>',
                        scope_incremental = false,
                        node_decremental = '<S-CR>',
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ['af'] = '@function.outer',
                            ['rf'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['rc'] = '@class.inner',
                            ['am'] = '@parameter.outer',
                            ['rm'] = '@parameter.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            [']f'] = '@function.outer',
                            [']c'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']F'] = '@function.outer',
                            [']C'] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[f'] = '@function.outer',
                            ['[c'] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[F'] = '@function.outer',
                            ['[C'] = '@class.outer',
                        },
                    },
                },
                rainbow = {
                    enable = true,
                },
                autotag = {
                    enable = true,
                },
                matchup = {
                    enable = true,
                },
            }
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'HiPhish/nvim-ts-rainbow2',
            'windwp/nvim-ts-autotag',
        },
    },
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            -- diagnostic config
            vim.diagnostic.config {
                virtual_text = false,
            }

            -- capabilities
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            require('lspconfig').jedi_language_server.setup {
                capabilities = capabilities,
            }
            require('lspconfig').ruff_lsp.setup {
                capabilities = capabilities,
            }
        end,
        dependencies = {
            'onsails/lspkind-nvim',
        },
    },
}

local opts = {
    install = {
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { 'desert' },
    },
    ui = {
        border = 'single',
    },
    checker = {
        -- automatically check for plugin updates
        enabled = false,
    },
    performance = {
        rtp = {
            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
                'gzip',
                'tutor',
                'tohtml',
                'matchit',
                'matchparen',
                'tarPlugin',
                'zipPlugin',
                'netrwPlugin',
            },
        },
    },
}

require('lazy').setup(plugins, opts)
