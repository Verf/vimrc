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
    { 'nvim-tree/nvim-web-devicons', event = 'VeryLazy' },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        opts = {
            messages = {
                view = 'mini',
                view_search = 'mini',
            },
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
            },
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
    },
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        opts = {},
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
        'echasnovski/mini.misc',
        config = function()
            require('mini.misc').setup()
            require('mini.misc').setup_auto_root()
            require('mini.misc').setup_restore_cursor()
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {
            disable_in_visualblock = true,
        },
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
        keys = { 'sa', 'sd', 'sc' },
        opts = {
            mappings = {
                add = 'sa',
                delete = 'sd',
                find = '',
                find_left = '',
                highlight = '',
                replace = 'sc',
                update_n_lines = '',
                suffix_last = '',
                suffix_next = '',
            },
        },
    },
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {
            modes = {
                char = {
                    keys = {
                        f = 't',
                        F = 'T',
                        t = 'k',
                        T = 'K',
                    },
                },
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
    {
        'nvim-telescope/telescope.nvim',
        keys = {
            { '<leader><leader>', '<CMD>Telescope buffers<CR>', 'Buffers' },
            { '<leader>ff', '<CMD>Telescope find_files<CR>', 'Files' },
            { '<leader>fh', '<CMD>Telescope oldfiles<CR>', 'History' },
            { '<leader>fe', '<CMD>Telescope everything<CR>', 'Everything' },
            { '<leader>fg', '<CMD>Telescope live_grep<CR>', 'Grep' },
            { '<leader>fd', '<CMD>Telescope diagnostics<CR>', 'Diagnostics' },
            { '<leader>fs', '<CMD>Telescope lsp_document_symbols<CR>', 'Symbols' },
            { 'gd', '<CMD>Telescope lsp_definitions<CR>', 'Definitions' },
            { 'gr', '<CMD>Telescope lsp_references<CR>', 'References' },
            { 'gi', '<CMD>Telescope lsp_implementations<CR>', 'Implementations' },
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
            'nvim-lua/plenary.nvim',
            'natecraddock/telescope-zf-native.nvim',
            'Verf/telescope-everything.nvim',
        },
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        event = 'BufReadPost',
        keys = {
            { 'zR', "<CMD>lua require('ufo').openAllFolds()<CR>", 'Open All Folds' },
            { 'zM', "<CMD>lua require('ufo').closeAllFolds()<CR>", 'Close All Folds' },
        },
        init = function()
            vim.o.foldcolumn = '0'
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
        end,
        opts = {
            provider_selector = function(bufnr, filetype, buftype)
                return { 'treesitter', 'indent' }
            end,
        },
    },
    { 'NMAC427/guess-indent.nvim', opts = {} },
    -- integration
    {
        'mhartington/formatter.nvim',
        keys = {
            { '<leader>m', '<CMD>FormatWrite<CR>', 'Format' },
        },
        opts = function(_, opts)
            local util = require 'formatter.util'
            opts.filetype = {
                lua = {
                    function()
                        return {
                            exe = 'stylua',
                            args = {
                                '--search-parent-directories',
                                '--stdin-filepath',
                                util.get_current_buffer_file_path(),
                                '--',
                                '-',
                            },
                            stdin = true,
                        }
                    end,
                },
                python = {
                    function()
                        return {
                            exe = 'black',
                            args = {
                                '-t',
                                'py36',
                                '--stdin-filename',
                                util.get_current_buffer_file_path(),
                                '-S',
                                '--preview',
                                '-q',
                                '-',
                            },
                            stdin = true,
                        }
                    end,
                },
                vue = {
                    function()
                        return {
                            exe = 'prettier',
                            args = {
                                '--stdin-filepath',
                                util.get_current_buffer_file_path(),
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
                },
                javascript = {
                    function()
                        return {
                            exe = 'prettier',
                            args = {
                                '--stdin-filepath',
                                util.get_current_buffer_file_path(),
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
                },
                typescript = {
                    function()
                        return {
                            exe = 'prettier',
                            args = {
                                '--stdin-filepath',
                                util.get_current_buffer_file_path(),
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
                },
                css = {
                    function()
                        return {
                            exe = 'prettier',
                            args = {
                                '--stdin-filepath',
                                util.get_current_buffer_file_path(),
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
                },
                scss = {
                    function()
                        return {
                            exe = 'prettier',
                            args = {
                                '--stdin-filepath',
                                util.get_current_buffer_file_path(),
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
                },
                html = {
                    function()
                        return {
                            exe = 'prettier',
                            args = {
                                '--stdin-filepath',
                                util.get_current_buffer_file_path(),
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
                },
                json = {
                    function()
                        return {
                            exe = 'prettier',
                            args = {
                                '--stdin-filepath',
                                util.get_current_buffer_file_path(),
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
                },
                yaml = {
                    function()
                        return {
                            exe = 'prettier',
                            args = {
                                '--stdin-filepath',
                                util.get_current_buffer_file_path(),
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
                },
                toml = {
                    function()
                        return {
                            exe = 'prettier',
                            args = {
                                '--stdin-filepath',
                                util.get_current_buffer_file_path(),
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
                },
                markdown = {
                    function()
                        return {
                            exe = 'prettier',
                            args = {
                                '--stdin-filepath',
                                util.get_current_buffer_file_path(),
                            },
                            stdin = true,
                            try_node_modules = true,
                        }
                    end,
                },
                go = {
                    require('formatter.filetypes.go').goimports,
                    require('formatter.filetypes.go').golines,
                },
                rust = {
                    require('formatter.filetypes.rust').rustfmt,
                },
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
        'numToStr/FTerm.nvim',
        keys = {
            { '<F1>', "<CMD>lua require('FTerm').toggle()<CR>", 'Toggle Term', mode = { 'i', 'n', 'x' } },
            { '<F1>', "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>", 'Toggle Term', mode = { 't' } },
        },
        opts = {
            ft = 'terminal',
            cmd = 'nu',
        },
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function()
            local cmp = require 'cmp'
            local snip = require 'snippy'
            local lspkind = require 'lspkind'
            local compare = require('cmp').config.compare

            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
            end

            vim.keymap.set('i', '<C-d>', snip.next)
            vim.keymap.set('i', '<C-u>', snip.previous)

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
                    ['<C-n>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif has_words_before() then
                            cmp.complete()
                        end
                    end, { 'i', 's' }),
                    ['<C-p>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif has_words_before() then
                            cmp.complete()
                        end
                    end, { 'i', 's' }),
                },
                sources = cmp.config.sources {
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'nvim_lsp' },
                    { name = 'snippy' },
                    { name = 'buffer' },
                    { name = 'path' },
                },
                sorting = {
                    priority_weight = 1.0,
                    comparators = {
                        compare.locality,
                        compare.recently_used,
                        compare.score,
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
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'dcampos/nvim-snippy',
            'dcampos/cmp-snippy',
            { 'abecodes/tabout.nvim', opts = {} },
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
                    'scss',
                    'go',
                    'markdown',
                    'markdown_inline',
                    'bash',
                    'sql',
                    'lua',
                    'ini',
                    'xml',
                    'csv',
                    'json',
                    'toml',
                    'yaml',
                    'git_config',
                    'git_rebase',
                    'gitcommit',
                    'gitignore',
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
            'windwp/nvim-ts-autotag',
        },
    },
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        keys = {
            { '<leader>rn', vim.lsp.buf.rename, 'Rename' },
            { '<leader>a', vim.lsp.buf.code_action, 'Code Action' },
        },
        config = function()
            -- diagnostic config
            vim.diagnostic.config {
                virtual_text = false,
            }

            -- capabilities
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            require('lspconfig').pyright.setup {
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            autoImportCompletions = true,
                            typeCheckingMode = 'off',
                        },
                    },
                },
            }
            require('lspconfig').ruff_lsp.setup {
                capabilities = capabilities,
            }
            require('lspconfig').gopls.setup {
                capabilities = capabilities,
            }
            require('lspconfig').rust_analyzer.setup {
                capabilities = capabilities,
            }
            require('lspconfig').volar.setup {
                capabilities = capabilities,
            }
            require('lspconfig').tailwindcss.setup {
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
