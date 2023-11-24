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
    { 'Verf/deepwhite.nvim' },
    { 'EdenEast/nightfox.nvim' },
    { 'Mofiqul/dracula.nvim' },
    { -- nvim-tree/nvim-web-devicons
        'nvim-tree/nvim-web-devicons',
        event = 'VeryLazy',
    },
    { -- mawkler/modicator.nvim
        'mawkler/modicator.nvim',
        init = function()
            vim.o.cursorline = true
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        opts = {},
    },
    { -- folke/which-key
        'folke/which-key.nvim',
        event = 'VeryLazy',
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            plugins = {
                presets = {
                    operators = false,
                    motions = false,
                    text_objects = false,
                    windows = false,
                    nav = false,
                    z = true,
                    g = true,
                },
            },
            key_labels = {
                ['<space>'] = 'SPC',
                ['<cr>'] = 'RET',
                ['<tab>'] = 'TAB',
            },
            triggers_blacklist = {
                i = { 'n', 'i', 'y', 'o' },
                v = { 'n', 'i', 'y', 'o' },
            },
            window = {
                border = 'single',
            },
        },
    },
    { -- echasnovski/mini.align
        'echasnovski/mini.align',
        keys = {
            { 'ga', desc = 'Align', mode = { 'n', 'x', 'o' } },
            { 'gA', desc = 'Align Preview', mode = { 'n', 'x', 'o' } },
        },
        opts = {},
    },
    { -- echasnovski/mini.bufremove
        'echasnovski/mini.bufremove',
        keys = {
            { '<leader>qq', '<CMD>lua MiniBufremove.delete(0, true)<CR>', desc = 'Buffer Close' },
        },
        opts = {
            set_vim_settings = false,
        },
    },
    { -- echasnovski/mini.comment
        'echasnovski/mini.comment',
        keys = { 'gc', 'gcc' },
        opts = {
            options = {
                ignore_blank_line = true,
            },
        },
    },
    { -- echasnovski/mini.cursorword
        'echasnovski/mini.cursorword',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {},
    },
    { 'echasnovski/mini.extra', opts = {} },
    { -- echasnovski/mini.files
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
    { -- echasnovski/mini.hipatterns
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
    { -- echasnovski/mini.indentscope
        'echasnovski/mini.indentscope',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            draw = {
                delay = 0,
                animation = function()
                    return 0
                end,
            },
            mappings = {
                object_scope = 'ri',
            },
            options = {
                try_as_border = true,
            },
            symbol = '│',
        },
    },
    { -- echasnovski/mini.jump
        'echasnovski/mini.jump',
        event = 'VeryLazy',
        opts = {
            mappings = {
                forward = 't',
                backward = 'T',
                forward_till = 'k',
                backward_till = 'K',
                repeat_jump = '',
            },
        },
    },
    { -- echasnovski/mini.jump2d
        'echasnovski/mini.jump2d',
        keys = {
            { 'gw', '<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<CR>', desc = 'Goto Word' },
            {
                'gs',
                "<CMD>lua MiniJump2d.start({spotter = MiniJump2d.gen_pattern_spotter('%p+')})<CR>",
                desc = 'Goto Symbol',
            },
        },
        opts = {
            labels = 'tneisoahfdurvcpm',
            view = {
                dim = true,
                n_steps_ahead = 2,
            },
            allowed_lines = {
                blank = false,
                cursor_at = false,
                fold = false,
            },
            allowed_windows = {
                not_current = false,
            },
            mappings = {
                start_jumping = '',
            },
            silent = true,
        },
    },
    { -- echasnovski/mini.move
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
    { -- echasnovski/mini.misc
        'echasnovski/mini.misc',
        config = function()
            require('mini.misc').setup()
            require('mini.misc').setup_auto_root(nil, function(path)
                return vim.fs.dirname(path)
            end)
            require('mini.misc').setup_restore_cursor()
        end,
    },
    { -- echasnovski/mini.pairs
        'echasnovski/mini.pairs',
        event = 'VeryLazy',
        init = function()
            -- disable auto pairs when block edit
            vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
                pattern = '*:[vV\x16]*',
                callback = function()
                    vim.b.minipairs_disable = true
                end,
            })
            -- enable auto pairs after block edit finsih
            vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
                callback = function()
                    vim.b.minipairs_disable = false
                end,
            })
        end,
        opts = {
            modes = {
                command = true,
            },
            mappings = {
                ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][^%a]' },
                ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][^%a]' },
                ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][^%a]' },
                [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
                [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
                ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

                ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\][^%a]', register = { cr = false } },
                ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^\\][^%a]', register = { cr = false } },
                ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\][^%a]', register = { cr = false } },
            },
        },
    },
    { -- echasnovski/mini.pick
        'echasnovski/mini.pick',
        keys = {
            { '<leader>f', '<CMD>Pick files<CR>', desc = 'Files' },
            { '<leader>/', '<CMD>Pick grep_live<CR>', desc = 'Live Grep' },
            { '<leader>h', '<CMD>Pick oldfiles<CR>', desc = 'Oldfiles' },
            { '<leader>s', '<CMD>Pick symbols<CR>', desc = 'Symbols' },
            { '<leader>d', '<CMD>Pick diagnostic<CR>', desc = 'Diagnostics' },
            { '<leader><leader>', '<CMD>Pick buffers<CR>', desc = 'Buffers' },
        },
        config = function()
            require('mini.pick').setup {}
            MiniPick.registry.oldfiles = function()
                local source = {
                    items = vim.v.oldfiles,
                    name = 'Oldfiles',
                }
                local oldfiles = MiniPick.start { source = source }
                if oldfiles == nil then
                    return
                end
                return oldfiles
            end
            MiniPick.registry.symbols = function()
                local bufnr = vim.fn.bufnr()
                local winnr = vim.fn.winnr()
                local params = vim.lsp.util.make_position_params(0)
                vim.lsp.buf_request(bufnr, 'textDocument/documentSymbol', params, function(err, result, _, _)
                    if err then
                        return
                    end
                    if not result or vim.tbl_isempty(result) then
                        return
                    end
                    local locations = vim.lsp.util.symbols_to_items(result or {}, bufnr) or {}
                    if vim.tbl_isempty(locations) then
                        return
                    end
                    local source = {
                        items = locations,
                        name = 'Symbols',
                        choose = function(item)
                            item.bufnr = bufnr
                            MiniPick.default_choose(item)
                        end,
                    }
                    local symbols = MiniPick.start { source = source }
                    if symbols == nil then
                        return
                    end
                    return symbols
                end)
            end
        end,
    },
    { -- echasnovski/mini.surround
        'echasnovski/mini.surround',
        keys = { 'sa', 'sd', 'sc' },
        opts = {
            mappings = {
                add = 'sa',
                find = '',
                delete = 'sd',
                find_left = '',
                highlight = '',
                replace = 'sc',
                update_n_lines = '',
                suffix_last = '',
                suffix_next = '',
            },
        },
    },
    { -- echasnovski/mini.trailspace
        'echasnovski/mini.trailspace',
        keys = {
            { '<leader>ts', '<CMD>lua MiniTrailspace.trim()<CR>', desc = 'Trim Space' },
            { '<leader>tl', '<CMD>lua MiniTrailspace.trim_last_lines()<CR>', desc = 'Trim Lines' },
        },
        opt = {},
    },
    { -- rebelot/heirline.nvim
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
        end,
    },
    { 'tiagovla/scope.nvim', event = 'VeryLazy', opts = {} },
    { -- monaqa/dial.nvim
        'monaqa/dial.nvim',
        keys = {
            { '<C-a>', '<Plug>(dial-increment)', desc = 'Dial Increment' },
            { '<C-x>', '<Plug>(dial-decrement)', desc = 'Dial Decrement' },
        },
        config = function()
            local augend = require 'dial.augend'
            require('dial.config').augends:register_group {
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.constant.alias.bool,
                    augend.date.alias['%Y-%m-%d'],
                    augend.date.alias['%Y年%-m月%-d日(%ja)'],
                },
            }
        end,
    },
    { -- chrisgrieser/nvim-spider
        'chrisgrieser/nvim-spider',
        keys = {
            { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n', 'x', 'o' } },
            { 'd', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n', 'x', 'o' } },
            { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n', 'x', 'o' } },
            { 'ge', "<cmd>lua require('spider').motion('ge')<CR>", mode = { 'n', 'x', 'o' } },
        },
        opts = {
            skipInsignificantPunctuation = false,
        },
    },
    { -- beauwilliams/focus.nvim
        'beauwilliams/focus.nvim',
        keys = {
            { '<leader>wy', '<CMD>FocusSplitLeft<CR>', desc = 'Split Left' },
            { '<leader>wn', '<CMD>FocusSplitDown<CR>', desc = 'Split Down' },
            { '<leader>wi', '<CMD>FocusSplitUp<CR>', desc = 'Split Up' },
            { '<leader>wo', '<CMD>FocusSplitRight<CR>', desc = 'Split Right' },
        },
        init = function()
            vim.api.nvim_create_autocmd('WinEnter', {
                callback = function()
                    if
                        vim.tbl_contains({
                            'nofile',
                            'prompt',
                            'popup',
                        }, vim.bo.buftype)
                    then
                        vim.w.focus_disable = true
                    else
                        vim.w.focus_disable = false
                    end
                end,
            })
        end,
        opts = {},
    },
    { -- NMAC427/guess-indent.nvim
        'NMAC427/guess-indent.nvim',
        opts = {},
    },
    { -- stevearc/conform.nvim
        'stevearc/conform.nvim',
        keys = {
            {
                '<leader>m',
                [[<CMD>lua require('conform').format({async=true, lsp_fallback=true})<CR>]],
                desc = 'Format',
            },
        },
        config = function()
            require('conform').formatters.black = {
                args = {
                    '--stdin-filename',
                    '$FILENAME',
                    '--quiet',
                    '--preview',
                    '-',
                },
            }
            require('conform').setup {
                formatters_by_ft = {
                    lua = { 'stylua' },
                    python = { 'black' },
                    javascript = { 'prettier' },
                    typescript = { 'prettier' },
                    vue = { 'prettier' },
                    json = { 'prettier' },
                    markdown = { 'prettier' },
                    css = { 'prettier' },
                    scss = { 'prettier' },
                    html = { 'prettier' },
                    sql = { 'sql_formatter' },
                    sh = { 'shfmt' },
                },
            }
        end,
    },
    { -- lewis6991/gitsigns.nvim
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        keys = {
            { ']h', '<CMD>Gitsigns next_hunk<CR>', desc = 'Next Hunk' },
            { '[h', '<CMD>Gitsigns prev_hunk<CR>', desc = 'Next Hunk' },
        },
        opts = {
            update_debounce = 1000,
        },
    },
    { -- hrsh7th/nvim-cmp
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        keys = {
            { '<C-d>', [[<CMD>lua require('snippy').next()<CR>]], desc = 'Snip Next', mode = { 'i' } },
            { '<C-u>', [[<CMD>lua require('snippy').previous()<CR>]], desc = 'Snip Previous', mode = { 'i' } },
        },
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
        },
    },
    { -- nvim-treesitter/nvim-treesitter
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = false,
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
                    'ini',
                    'xml',
                    'csv',
                    'json',
                    'toml',
                    'yaml',
                    'regex',
                    'git_config',
                    'git_rebase',
                    'gitcommit',
                    'gitignore',
                },
                highlight = {
                    enable = true,
                    disable = function(lang, bufnr)
                        -- disable for a large file
                        return vim.api.nvim_buf_line_count(bufnr) > 10000
                    end,
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
    { -- neovim/nvim-lspconfig
        'neovim/nvim-lspconfig',
        lazy = false,
        keys = {
            { '<leader>r', vim.lsp.buf.rename, desc = 'Rename' },
            { 'gk', vim.lsp.buf.hover, desc = 'Hover' },
            { 'gd', vim.lsp.buf.definition, desc = 'Goto Definition' },
            { 'gr', vim.lsp.buf.references, desc = 'Find References' },
        },
        config = function()
            -- diagnostic config
            vim.diagnostic.config {
                virtual_text = false,
            }

            -- capabilities
            local capabilities = vim.tbl_deep_extend(
                'force',
                vim.lsp.protocol.make_client_capabilities(),
                require('cmp_nvim_lsp').default_capabilities()
            )
            capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

            require('lspconfig').pyright.setup {
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = 'basic',
                            useLibraryCodeForTypes = false,
                            autoImportCompletions = true,
                        },
                    },
                },
            }
            require('lspconfig').ruff_lsp.setup {
                capabilities = capabilities,
            }
            require('lspconfig').volar.setup {
                capabilities = capabilities,
                filetypes = { 'typescript', 'javascript', 'vue', 'json' },
                init_options = {
                    typescript = {
                        tsdk = vim.fs.normalize '~/AppData/Roaming/npm/node_modules/typescript/lib',
                    },
                },
            }
            require('lspconfig').tailwindcss.setup {
                capabilities = capabilities,
            }
        end,
        dependencies = {
            'onsails/lspkind-nvim',
        },
    },
    { -- weilbith/nvim-code-action-menu
        'weilbith/nvim-code-action-menu',
        keys = {
            { '<leader>a', '<CMD>CodeActionMenu<CR>', desc = 'Code Action' },
        },
        cmd = 'CodeActionMenu',
    },
    { -- mfussenegger/nvim-dap
        'mfussenegger/nvim-dap',
        keys = {
            { '<F4>', [[<CMD>lua require('dap').continue()<CR>]], desc = 'Start Debug' },
            { '<leader>ds', [[<CMD>lua require('dap').continue()<CR>]], desc = 'Start Debug' },
            { '<leader>db', [[<CMD>lua require('dap').toggle_breakpoint()<CR>]], desc = 'Set Breakpoint' },
            { '<leader>di', [[<CMD>lua require('dap').step_into()<CR>]], desc = 'Step Into' },
            { '<leader>dv', [[<CMD>lua require('dap').step_over()<CR>]], desc = 'Step Over' },
            { '<leader>do', [[<CMD>lua require('dap').step_out()<CR>]], desc = 'Step Out' },
            { '<leader>dr', [[<CMD>lua require('dap').repl.open()<CR>]], desc = 'Repl Open' },
            { '<leader>dl', [[<CMD>lua require('dap').run_last()<CR>]], desc = 'Run Last' },
            { '<leader>dt', [[<CMD>lua require('dap').run_last()<CR>]], desc = 'Goto Cursor' },
            { '<leader>du', [[<CMD>lua require('dapui').toggle()<CR>]], desc = 'Goto Cursor' },
            { '<leader>dq', [[<CMD>lua require('dap').terminate()<CR>]], desc = 'Quit Debug' },
        },
        config = function()
            require('dapui').setup()
            require('nvim-dap-virtual-text').setup()
            require('dap-python').setup 'python'
            local listeners = require('dap').listeners
            -- commit
            listeners.after.event_initialized['dapui_config'] = function()
                require('dapui').open()
            end
            listeners.before.event_terminated['dapui_config'] = function()
                require('dapui').close()
            end
            listeners.before.event_exited['dapui_config'] = function()
                require('dapui').close()
            end
        end,
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'mfussenegger/nvim-dap-python',
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
