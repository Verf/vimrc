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

add { source = 'Verf/deepwhite.nvim' }
require('deepwhite').setup { low_blue_light = true }
now(function() vim.cmd 'colorscheme deepwhite' end)

add { source = 'echasnovski/mini.nvim' }
require('mini.notify').setup()
vim.notify = require('mini.notify').make_notify()
require('mini.tabline').setup()
require('mini.statusline').setup()
require('mini.align').setup()
require('mini.bufremove').setup()
vim.keymap.set('n', '<leader>qq', '<CMD>lua MiniBufremove.delete()<CR>', { desc = 'Close Buffer' })
require('mini.comment').setup()
require('mini.diff').setup()
require('mini.extra').setup()
require('mini.files').setup {
    mappings = {
        go_in = 'o',
        go_in_plus = 'H',
        go_out = 'y',
        go_out_plus = 'Y',
    },
}
vim.keymap.set('n', '-', '<CMD>lua MiniFiles.open()<CR>', { desc = 'Open Files' })
require('mini.hipatterns').setup {
    highlighters = {
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
    },
}
require('mini.indentscope').setup {
    draw = {
        delay = 0,
        animation = function() return 0 end,
    },
    mappings = {
        object_scope = '',
        object_scope_with_border = '',
    },
    symbol = '│',
}
require('mini.jump').setup {
    mappings = {
        forward = 't',
        backward = 'T',
        forward_till = 'k',
        backward_till = 'K',
        repeat_jump = '',
    },
}
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
vim.keymap.set('n', 'gw', '<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<CR>', { desc = 'Goto Word' })
require('mini.misc').setup()
require('mini.misc').setup_auto_root()
require('mini.misc').setup_restore_cursor()
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
-- disable auto pairs when block edit
vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
    pattern = '*:[vV\x16]*',
    callback = function() vim.b.minipairs_disable = true end,
})
-- enable auto pairs after block edit finsih
vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
    callback = function() vim.b.minipairs_disable = false end,
})
require('mini.pairs').setup {
    modes = {
        insert = true,
        command = true,
    },
}
require('mini.pick').setup {
    delay = {
        async = 200,
        busy = 500,
    },
}
vim.keymap.set('n', '<leader>/', '<CMD>Pick grep_live<CR>', { desc = 'Grep Live' })
vim.keymap.set('n', '<leader>f', '<CMD>Pick files<CR>', { desc = 'Pick Files' })
vim.keymap.set('n', '<leader>h', '<CMD>Pick oldfiles<CR>', { desc = 'Pick Oldfiles' })
vim.keymap.set('n', '<leader>d', '<CMD>Pick diagnostic<CR>', { desc = 'Pick Diagnostics' })
vim.keymap.set('n', '<leader>gb', '<CMD>Pick git_branches<CR>', { desc = 'Pick Diagnostics' })
vim.keymap.set('n', '<leader>gc', '<CMD>Pick git_commits<CR>', { desc = 'Pick Commits' })
vim.keymap.set('n', '<leader>gh', '<CMD>Pick git_hunks<CR>', { desc = 'Pick Hunks' })
vim.keymap.set('n', '<leader>gm', '<CMD>Pick marks<CR>', { desc = 'Pick Marks' })
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
require('mini.trailspace').setup()
vim.api.nvim_create_user_command('Trim', 'lua MiniTrailspace.trim()', {})
vim.api.nvim_create_user_command('TrimLine', 'lua MiniTrailspace.trim_last_lines()', {})

add {
    source = 'iguanacucumber/magazine.nvim',
    name = 'nvim-cmp',
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
later(function()
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
            expand = function(args) snip.expand_snippet(args.body) end,
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
            ['<C-d>'] = cmp.mapping(function(fallback)
                if snip.can_jump(1) then snip.next() end
            end, { 'i', 's' }),
            ['<C-u>'] = cmp.mapping(function(fallback)
                if snip.can_jump(-1) then snip.previous() end
            end, { 'i', 's' }),
        },
        sources = cmp.config.sources {
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lsp' },
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
        sources = { { name = 'buffer' } },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
    })
end)

add { source = 'neovim/nvim-lspconfig' }

local on_attach = function(client, bufnr)
    if client.name == 'ruff' then client.server_capabilities.hoverProvider = false end
    if client.name == 'basedpyright' then client.server_capabilities.semanticTokensProvider = nil end
end

require('lspconfig').ruff.setup { on_attach = on_attach }
require('lspconfig').basedpyright.setup {
    cmd = { 'basedpyright-langserver', '--stdio', '--pythonversion 3.6' },
    on_attach = on_attach,
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = 'basic',
            },
        },
    },
}
require('lspconfig').rust_analyzer.setup {}
require('lspconfig').volar.setup {
    init_options = {
        typescript = {
            tsdk = vim.fn.expand '$HOME/AppData/Roaming/npm/node_modules/typescript/lib',
        },
    },
}
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto Definition' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Goto References' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Goto Implementation' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Doc' })
vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, { desc = 'Code Action' })
vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, { desc = 'Rename' })

add {
    source = 'nvim-treesitter/nvim-treesitter',
    checkout = 'master',
    monitor = 'main',
    hooks = {
        post_checkout = function() vim.cmd 'TSUpdate' end,
    },
}
add { source = 'nvim-treesitter/nvim-treesitter-textobjects' }
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'vue',
        'python',
        'javascript',
        'vimdoc',
        'regex',
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
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['rf'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['rc'] = '@class.inner',
            },
            selection_modes = {
                ['@parameter.outer'] = 'v', -- charwise
                ['@function.outer'] = 'V', -- linewise
                ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = false,
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
            },
        },
    },
}

add { source = 'stevearc/conform.nvim' }
require('conform').setup {
    formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_format' },
        vue = { 'prettier' },
        json = { 'prettier' },
    },
}
vim.keymap.set('n', '<leader>m', '<CMD>lua require("conform").format({async=true})<CR>', { desc = 'Format' })
