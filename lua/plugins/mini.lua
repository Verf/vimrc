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
        {

            'gw',
            [[<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<CR>]],
            mode = 'n',
            desc = 'Jump Word',
        },
        { '-', [[<CMD>lua MiniFiles.open()<CR>]], mode = 'n', desc = 'Open Files' },
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
        require('mini.operators').setup { replace = { prefix = 'gf' } }
        require('mini.pairs').setup()
        require('mini.trailspace').setup()
        require('mini.bufremove').setup()

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

        require('mini.jump').setup {
            mappings = { forward = 't', backward = 'T', forward_till = 'k', backward_till = 'K', repeat_jump = '' },
        }

        require('mini.jump2d').setup {
            view = { dim = true, n_steps_ahead = 2 },
            mappings = { start_jumping = '' },
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
        minikeymap.map_multistep('i', '<Tab>', { 'minisnippets_expand', 'blink_next', 'jump_after_close' })
        minikeymap.map_multistep('i', '<S-Tab>', { 'blink_prev', 'jump_before_open' })
        minikeymap.map_multistep('i', '<BS>', { 'minipairs_bs' })

        local snippets = require 'mini.snippets'
        snippets.setup {
            snippets = {
                snippets.gen_loader.from_file(vim.fn.stdpath 'config' .. '/snippets/global.json'),
                snippets.gen_loader.from_lang { lang_patterns = { markdown_inline = { 'markdown.json' } } },
            },
            mappings = { expand = '', jump_next = '<C-d>', jump_prev = '<C-u>', stop = '<C-c>' },
            expand = {
                match = function(snips)
                    -- 必须同时覆盖 pattern_exact 和 pattern_fuzzy
                    -- return 会自动将 default_match 的“匹配结果”和“删除范围”两个返回值都传递给插件
                    return snippets.default_match(snips, {
                        pattern_exact_boundary = '[^%w_]?',
                        pattern_fuzzy = '[%w_]+',
                    })
                end,
            },
        }

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

        require('mini.files').setup {
            mappings = {
                close = 'q',
                go_in = 'o',
                go_in_plus = 'O',
                go_out = 'y',
                go_out_plus = 'Y',
                mark_goto = "'",
                mark_set = 'm',
                reset = '<BS>',
                reveal_cwd = '@',
                show_help = 'g?',
                synchronize = '=',
                trim_left = '<',
                trim_right = '>',
            },
        }
    end,
}
