return {
    'nvim-mini/mini.nvim',
    lazy = false,
    keys = {
        {
            '<leader>x',
            [[<cmd>lua MiniBufremove.delete(0, true)<cr>]],
            mode = { 'n', 'x' },
            desc = 'Close Buffer',
        },
    },
    config = function()
        local kset = vim.keymap.set

        require('mini.icons').setup()
        require('mini.icons').mock_nvim_web_devicons()
        require('mini.icons').tweak_lsp_kind()

        require('mini.statusline').setup()
        require('mini.tabline').setup()

        require('mini.misc').setup()
        require('mini.misc').setup_auto_root()
        require('mini.misc').setup_restore_cursor()
        require('mini.align').setup()
        require('mini.extra').setup()
        require('mini.notify').setup()
        require('mini.pairs').setup()
        require('mini.trailspace').setup()
        require('mini.bufremove').setup()

        require('mini.operators').setup {
            sort = { prefix = '' },
            replace = { prefix = 'gf' },
        }

        require('mini.surround').setup {
            mappings = {
                add = '<leader>sa',
                delete = '<leader>se',
                find = '<leader>st',
                find_left = '<leader>sT',
                highlight = '<leader>sh',
                replace = '<leader>sc',
                suffix_last = 'l',
                suffix_next = 'n',
            },
        }

        require('mini.move').setup {
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
        }

        local hipatterns = require 'mini.hipatterns'
        hipatterns.setup {
            highlighters = {
                fixme = MiniExtra.gen_highlighter.words({ 'FIXME' }, 'MiniHipatternsFixme'),
                hack = MiniExtra.gen_highlighter.words({ 'HACK' }, 'MiniHipatternsHack'),
                todo = MiniExtra.gen_highlighter.words({ 'TODO' }, 'MiniHipatternsTodo'),
                note = MiniExtra.gen_highlighter.words({ 'NOTE' }, 'MiniHipatternsNote'),
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        }

        local minikeymap = require 'mini.keymap'
        minikeymap.setup()
        minikeymap.map_multistep('i', '<Tab>', { 'minisnippets_expand', 'blink_next' })
        minikeymap.map_multistep('i', '<S-Tab>', { 'minisnippets_prev', 'blink_prev' })
        minikeymap.map_multistep('i', '<C-d>', { 'minisnippets_next', 'jump_after_close' })
        minikeymap.map_multistep('i', '<C-u>', { 'minisnippets_prev', 'jump_before_open' })
        minikeymap.map_multistep('i', '<BS>', { 'minipairs_bs' })

        local snippets = require 'mini.snippets'
        snippets.setup {
            snippets = {
                snippets.gen_loader.from_file(vim.fn.stdpath 'config' .. '/snippets/global.json'),
                snippets.gen_loader.from_lang { lang_patterns = { markdown_inline = { 'markdown.json' } } },
            },
            mappings = { expand = '', jump_next = '', jump_prev = '', stop = '<C-c>' },
            expand = {
                match = function(snips)
                    -- 确保仅会在精确匹配prefix时展开snippet
                    return snippets.default_match(snips, {
                        pattern_exact_boundary = '[^%w_]?',
                        pattern_fuzzy = '',
                    })
                end,
            },
        }

        -- 退出Insert模式时自动停止snippet状态
        vim.api.nvim_create_autocmd('InsertLeave', {
            callback = function()
                if snippets.session.get() then
                    vim.schedule(function()
                        while snippets.session.get() do
                            snippets.session.stop()
                        end
                    end)
                end
            end,
        })
    end,
}
