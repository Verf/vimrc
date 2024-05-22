local path_package = vim.fn.stdpath 'data' .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd 'echo "Installing `mini.nvim`" | redraw'
    local clone_cmd = {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/echasnovski/mini.nvim',
        mini_path,
    }
    vim.fn.system(clone_cmd)
    vim.cmd 'packadd mini.nvim | helptags ALL'
end

require('mini.deps').setup { path = { package = path_package } }

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add { source = 'echasnovski/mini.nvim' }

now(function()
    add {
        source = 'Verf/deepwhite.nvim',
    }
    require('deepwhite').setup {
        low_blue_light = true,
    }
    vim.cmd 'colorscheme deepwhite'
end)

now(function()
    require('mini.notify').setup()
    vim.notify = require('mini.notify').make_notify()
end)
now(function()
    require('mini.tabline').setup()
end)
now(function()
    require('mini.statusline').setup()
end)
now(function()
    require('mini.starter').setup()
end)

later(function()
    require('mini.align').setup()
end)
later(function()
    require('mini.bufremove').setup()
    vim.keymap.set('n', '<leader>qq', '<CMD>lua MiniBufremove.delete()<CR>')
end)
later(function()
    require('mini.comment').setup()
end)
later(function()
    require('mini.diff').setup()
end)
later(function()
    require('mini.extra').setup()
end)
later(function()
    require('mini.files').setup {
        mappings = {
            go_in = 'o',
            go_in_plus = 'H',
            go_out = 'y',
            go_out_plus = 'Y',
        },
    }
    vim.keymap.set('n', '-', '<CMD>lua MiniFiles.open()<CR>', { desc = 'Open Files' })
end)
later(function()
    require('mini.git').setup()
end)
later(function()
    require('mini.hipatterns').setup {
        highlighters = {
            fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
            hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
            todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
            note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
            hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
        },
    }
end)
later(function()
    require('mini.indentscope').setup {
        draw = {
            delay = 0,
            animation = function()
                return 0
            end,
        },
        mappings = {
            object_scope = '',
            object_scope_with_border = '',
        },
        symbol = '│',
    }
end)
later(function()
    require('mini.jump').setup {
        mappings = {
            forward = 't',
            backward = 'T',
            forward_till = 'k',
            backward_till = 'K',
            repeat_jump = '',
        },
    }
end)
later(function()
    require('mini.jump2d').setup {
        labels = 'tneisoahfdurvcpm',
        view = {
            dim = true,
            n_steps_ahead = 2,
        },
        allowed_lines = {
            blank = false,
            cursor_at = false,
        },
        allowed_windows = {
            not_current = false,
        },
        mappings = {
            start_jumping = 'gw',
        },
    }
    vim.keymap.set(
        'n',
        'gw',
        '<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<CR>',
        { desc = 'Goto Word' }
    )
end)
later(function()
    require('mini.misc').setup()
    require('mini.misc').setup_auto_root()
    require('mini.misc').setup_restore_cursor()
end)
later(function()
    require('mini.move').setup {
        mappings = {
            left = '<M-y>',
            right = '<M-o>',
            down = '<M-n>',
            up = '<M-i>',
            line_left = '<M-y>',
            line_right = '<M-o>',
            line_up = '<M-i>',
            line_down = '<M-n>',
        },
    }
end)
later(function()
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
    require('mini.pairs').setup {
        modes = {
            insert = true,
            command = true,
        },
        mappings = {
            ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][^%a]' },
            ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][^%a]' },
            ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][^%a]' },
            ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\][^%a]', register = { cr = false } },
            ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^\\][^%a]', register = { cr = false } },
            ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\][^%a]', register = { cr = false } },
        },
    }
end)
later(function()
    require('mini.pick').setup()
    vim.keymap.set('n', '<leader>/', '<CMD>Pick grep_live<CR>', { desc = 'Grep Live' })
    vim.keymap.set('n', '<leader>f', '<CMD>Pick files<CR>', { desc = 'Pick Files' })
    vim.keymap.set('n', '<leader>h', '<CMD>Pick oldfiles<CR>', { desc = 'Pick Oldfiles' })
    vim.keymap.set('n', '<leader>d', '<CMD>Pick diagnostic<CR>', { desc = 'Pick Diagnostics' })
    vim.keymap.set('n', '<leader>gb', '<CMD>Pick git_branches<CR>', { desc = 'Pick Diagnostics' })
    vim.keymap.set('n', '<leader>gc', '<CMD>Pick git_commits<CR>', { desc = 'Pick Commits' })
    vim.keymap.set('n', '<leader>gh', '<CMD>Pick git_hunks<CR>', { desc = 'Pick Hunks' })
end)
later(function()
    require('mini.sessions').setup {
        directory = vim.fn.stdpath 'data' .. '/session',
        file = '',
    }
end)
later(function()
    require('mini.surround').setup {
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
    }
end)
later(function()
    require('mini.trailspace').setup()
    vim.api.nvim_create_user_command('Trim', 'lua MiniTrailspace.trim()', {})
    vim.api.nvim_create_user_command('TrimLine', 'lua MiniTrailspace.trim_last_lines()', {})
end)

later(function()
    add {
        source = 'hrsh7th/nvim-cmp',
        depends = {
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'dcampos/nvim-snippy',
            'dcampos/cmp-snippy',
            'onsails/lspkind-nvim',
        },
    }
    local cmp = require 'cmp'
    local snip = require 'snippy'
    local lspkind = require 'lspkind'
    local compare = require('cmp').config.compare

    local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
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
end)

later(function()
    add { source = 'neovim/nvim-lspconfig' }
    require('lspconfig').basedpyright.setup {
        cmd = { 'basedpyright-langserver', '--stdio', '--pythonversion 3.6' },
        settings = {
            basedpyright = {
                analysis = {
                    typeCheckingMode = 'basic',
                },
            },
        },
    }
end)

later(function()
    add {
        source = 'nvim-treesitter/nvim-treesitter',
        checkout = 'master',
        monitor = 'main',
        hooks = {
            post_checkout = function()
                vim.cmd 'TSUpdate'
            end,
        },
    }
    require('nvim-treesitter.configs').setup {
        ensure_installed = {
            'vue',
            'python',
            'javascript',
            'vimdoc',
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
    }
end)

later(function()
    add { source = 'stevearc/conform.nvim' }
    require('conform').setup {
        formatters_by_ft = {
            lua = { 'stylua' },
            python = { 'ruff_format' },
            javascript = { 'prettier' },
            typescript = { 'prettier' },
            vue = { 'prettier' },
            json = { 'prettier' },
            markdown = { 'prettier' },
            css = { 'prettier' },
            scss = { 'prettier' },
            html = { 'prettier' },
        },
    }
    vim.keymap.set('n', '<leader>m', '<CMD>lua require("conform").format()<CR>', { desc = 'Format' })
end)
