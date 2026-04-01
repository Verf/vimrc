return {
    'nvim-mini/mini.nvim',
    config = function()
        local kset = vim.keymap.set

        require('mini.icons').setup()
        require('mini.icons').mock_nvim_web_devicons()
        require('mini.icons').tweak_lsp_kind()

        require('mini.statusline').setup()
        require('mini.tabline').setup()

        vim.schedule(function()
            require('mini.misc').setup()
            require('mini.misc').setup_auto_root()
            require('mini.misc').setup_restore_cursor()
            require('mini.align').setup()
            require('mini.extra').setup()
            require('mini.notify').setup()
            require('mini.operators').setup { replace = { prefix = '' } }
            require('mini.pairs').setup()
            require('mini.trailspace').setup()
            require('mini.bufremove').setup()

            kset('n', '<leader>qq', '<CMD>lua MiniBufremove.delete(0, true)<CR>', { desc = 'Buffer Close' })

            require('mini.bracketed').setup {
                diagnostic = { suffix = 'd', options = { severity = vim.diagnostic.severity.ERROR } },
                conflict = { suffix = 'x' },
                quickfix = { suffix = 'q' },
                undo = { suffix = 'u' },
                -- 其他 suffix = '' 的保持原样
                buffer = { suffix = '' },
                comment = { suffix = '' },
                file = { suffix = '' },
                indent = { suffix = '' },
                jump = { suffix = '' },
                location = { suffix = '' },
                oldfile = { suffix = '' },
                treesitter = { suffix = '' },
                window = { suffix = '' },
                yank = { suffix = '' },
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

            require('mini.jump').setup {
                mappings = { forward = 't', backward = 'T', forward_till = 'k', backward_till = 'K', repeat_jump = '' },
            }

            require('mini.jump2d').setup {
                view = { dim = true, n_steps_ahead = 2 },
                mappings = { start_jumping = '' },
            }
            kset('n', 'gw', [[<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<CR>]], {})

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
                expand = { match = function(snips) return snippets.default_match(snips, { pattern_fuzzy = '%S+' }) end },
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

            local miniclue = require 'mini.clue'
            miniclue.setup {
                clues = {
                    { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
                    { mode = 'n', keys = '<Leader>f', desc = '+Find' },
                    { mode = 'n', keys = '<Leader>g', desc = '+Git' },
                    { mode = 'n', keys = '<Leader>q', desc = '+Quit' },
                    { mode = 'n', keys = '<Leader>r', desc = '+Lsp' },
                    { mode = 'n', keys = '<Leader>s', desc = '+Surround' },
                    { mode = 'n', keys = '<Leader>t', desc = '+Tab' },
                    { mode = 'n', keys = '<Leader>w', desc = '+Window' },
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                },
                triggers = {
                    { mode = { 'n', 'x' }, keys = '<Leader>' },
                    { mode = { 'n', 'x' }, keys = "'" },
                    { mode = { 'n', 'x' }, keys = '`' },
                    { mode = { 'n', 'x' }, keys = '"' },
                    { mode = { 'i', 'c' }, keys = '<C-r>' },
                    { mode = { 'n', 'x' }, keys = 'z' },
                },
            }

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
            kset('n', '-', [[<CMD>lua MiniFiles.open()<CR>]], { desc = 'Open Files' })
        end)
    end,
}
