local kset = vim.keymap.set
local add = vim.pack.add

-- 1. 最先添加并加载 lz.n
add { 'https://github.com/lumen-oss/lz.n' }

local languages = {
    'python',
    'javascript',
    'typescript',
    'vue',
    'markdown',
    'markdown_inline',
    'html',
    'css',
    'yaml',
    'json',
    'latex',
    'nu',
}
local filetypes = {}
for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
        table.insert(filetypes, ft)
    end
end

-- 2. 统一的数据源定义（注意 keys 必须遵循 { "按键", "命令", mode = "..." } 的格式）
local plugin_defs = {
    {
        url = 'https://github.com/Verf/deepwhite.nvim',
        version = 'dev',
        colorscheme = 'deepwhite',
        after = function() require('deepwhite').setup { low_blue_light = true } end,
    },
    {
        url = 'https://github.com/nvim-mini/mini.nvim',
        -- 无懒加载条件，启动直接加载
        after = function()
            require('mini.icons').setup()
            require('mini.icons').mock_nvim_web_devicons()
            require('mini.icons').tweak_lsp_kind()
            require('mini.starter').setup()
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
                require('mini.jump').setup { mappings = { forward = 't', backward = 'T', forward_till = 'k', backward_till = 'K', repeat_jump = '' } }
                require('mini.jump2d').setup { view = { dim = true, n_steps_ahead = 2 }, mappings = { start_jumping = '' } }
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
    },
    {
        url = 'https://github.com/neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        after = function()
            vim.lsp.enable { 'ty', 'ruff', 'biome', 'rust_analyzer', 'gopls', 'zls', 'nushell' }
            kset({ 'n', 'x' }, '<leader>rn', [[<cmd>lua vim.lsp.buf.rename()<cr>]], { desc = 'Rename' })
            kset({ 'n', 'x' }, '<leader>ra', [[<cmd>lua vim.lsp.buf.code_action()<cr>]], { desc = 'Code Action' })
            kset({ 'n', 'x' }, '<leader>rh', [[<cmd>lua vim.lsp.buf.hover()<cr>]], { desc = 'Hover Doc' })
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            })
        end,
    },
    {
        url = 'https://github.com/nvim-treesitter/nvim-treesitter',
        ft = filetypes,
        after = function()
            local to_install = vim.tbl_filter(function(lang) return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0 end, languages)
            if #to_install > 0 then require('nvim-treesitter').install(to_install) end
            pcall(vim.treesitter.start)
        end,
    },
    {
        url = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
        ft = filetypes,
        after = function()
            local ts_select = require 'nvim-treesitter-textobjects.select'
            kset({ 'x', 'o' }, 'af', function() ts_select.select_textobject('@function.outer', 'textobjects') end)
            kset({ 'x', 'o' }, 'rf', function() ts_select.select_textobject('@function.inner', 'textobjects') end)
            kset({ 'x', 'o' }, 'ac', function() ts_select.select_textobject('@class.outer', 'textobjects') end)
            kset({ 'x', 'o' }, 'rc', function() ts_select.select_textobject('@class.inner', 'textobjects') end)
            kset({ 'x', 'o' }, 'as', function() ts_select.select_textobject('@local.scope', 'locals') end)

            local ts_move = require 'nvim-treesitter-textobjects.move'
            kset({ 'n', 'x', 'o' }, ']f', function() ts_move.goto_next_start('@function.outer', 'textobjects') end)
            kset({ 'n', 'x', 'o' }, ']c', function() ts_move.goto_next_start('@class.outer', 'textobjects') end)
            kset({ 'n', 'x', 'o' }, '[f', function() ts_move.goto_previous_start('@function.outer', 'textobjects') end)
            kset({ 'n', 'x', 'o' }, '[c', function() ts_move.goto_previous_start('@class.outer', 'textobjects') end)
        end,
    },
    {
        url = 'https://github.com/stevearc/conform.nvim',
        event = { 'BufWritePre', 'BufReadPre' },
        after = function()
            require('conform').setup {
                default_format_opts = { lsp_format = 'fallback' },
                format_after_save = { lsp_format = 'fallback' },
                formatters_by_ft = {
                    python = { 'ruff_format', 'ruff_organize_imports' },
                    lua = { 'stylua' },
                    json = { 'biome' },
                    nu = { 'nufmt' },
                    toml = { 'taplo' },
                    yaml = { 'yamlfmt' },
                },
            }
        end,
    },
    {
        url = 'https://github.com/saghen/blink.cmp',
        version = 'v1.10.1',
        event = { 'InsertEnter', 'CmdlineEnter' },
        after = function()
            require('blink.cmp').setup {
                keymap = {
                    preset = 'none',
                    ['<cr>'] = { 'accept', 'fallback' },
                    ['<C-e>'] = { 'hide', 'show' },
                    ['<C-y>'] = { 'select_and_accept', 'fallback' },
                    ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
                    ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
                    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
                    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
                },
                appearance = { nerd_font_variant = 'mono' },
                snippets = { preset = 'mini_snippets' },
                sources = { default = { 'lsp', 'buffer', 'path' } },
                signature = { enabled = true },
                fuzzy = { implementation = 'prefer_rust_with_warning' },
                completion = {
                    list = { selection = { preselect = false, auto_insert = true } },
                    trigger = { show_on_keyword = true, show_on_trigger_character = false },
                    menu = {
                        draw = {
                            padding = { 0, 1 },
                            components = {
                                kind_icon = {
                                    highlight = function(ctx)
                                        local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                        return hl
                                    end,
                                },
                            },
                        },
                    },
                },
                cmdline = { completion = { menu = { auto_show = true }, list = { selection = { preselect = false, auto_insert = true } } } },
            }
            vim.api.nvim_create_autocmd('InsertLeave', {
                callback = function()
                    vim.schedule(function() require('blink.cmp').cancel() end)
                end,
            })
        end,
    },
    {
        url = 'https://github.com/jake-stewart/multicursor.nvim',
        version = '1.0',
        keys = {
            { 's', [[<cmd>lua require('multicursor-nvim').matchCursors()<cr>]], mode = 'v', desc = 'Add cursor by regex' },
            { '<M-s>', [[<cmd>lua require('multicursor-nvim').splitCursors('^')<cr>]], mode = 'v', desc = 'Split on newlines' },
        },
        after = function()
            local mc = require 'multicursor-nvim'
            mc.setup()
            mc.addKeymapLayer(function(layerSet)
                layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
                layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)
                layerSet({ 'n', 'x' }, '<up>', function() mc.lineAddCursor(-1) end)
                layerSet({ 'n', 'x' }, '<down>', function() mc.lineAddCursor(1) end)
                layerSet({ 'n', 'x' }, '<M-,>', mc.deleteCursor)
                layerSet({ 'n', 'x' }, ',', function()
                    if mc.hasCursors() then mc.clearCursors() end
                end, { desc = 'Clear all cursors' })
            end)
        end,
    },
    {
        url = 'https://github.com/chrisgrieser/nvim-spider',
        keys = {
            { 'w', [[<cmd>lua require('spider').motion('w')<cr>]], mode = { 'n', 'o', 'x' } },
            { 'd', [[<cmd>lua require('spider').motion('e')<cr>]], mode = { 'n', 'o', 'x' } },
            { 'b', [[<cmd>lua require('spider').motion('b')<cr>]], mode = { 'n', 'o', 'x' } },
        },
    },
    {
        url = 'https://github.com/dmtrKovalenko/fff.nvim',
        keys = {
            { '<leader>ff', [[<cmd>lua require('fff').find_files()<cr>]], mode = 'n', desc = 'Find Files' },
            { '<leader>fg', [[<cmd>lua require('fff').live_grep()<cr>]], mode = 'n', desc = 'Live Grep' },
        },
        after = function()
            vim.g.fff = { lazy_sync = true }
            require('fff').setup { prompt = '❯ ', grep = { modes = { 'plain', 'regex' } } }
        end,
    },
    { url = 'https://github.com/MeanderingProgrammer/render-markdown.nvim', ft = 'markdown' },
    {
        url = 'https://github.com/akinsho/toggleterm.nvim',
        keys = { { '<C-\\>', mode = { 'n', 'i', 't' } } },
        after = function() require('toggleterm').setup { open_mapping = [[<C-\>]] } end,
    },
    {
        url = 'https://github.com/Aasim-A/scrollEOF.nvim',
        event = 'BufReadPost',
        after = function() require('scrollEOF').setup { pattern = '*', insert_mode = true } end,
    },
    {
        url = 'https://github.com/lewis6991/gitsigns.nvim',
        event = 'BufReadPost',
        after = function()
            local gitsigns = require 'gitsigns'
            gitsigns.setup()
            kset('n', ']h', gitsigns.next_hunk, { desc = 'Next hunk' })
            kset('n', '[h', gitsigns.prev_hunk, { desc = 'Previous hunk' })
            kset('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Stage Hunk' })
            kset('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset Hunk' })
            kset('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Stage Buffer' })
            kset('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset Buffer' })
            kset('n', '<leader>gb', gitsigns.blame_line, { desc = 'Show Blame Inline' })
            kset('n', '<leader>gB', gitsigns.blame, { desc = 'Show Blame' })
        end,
    },
    {
        url = 'https://github.com/sindrets/diffview.nvim',
        keys = {
            { '<leader>gd', [[<cmd>DiffviewOpen<cr>]], mode = 'n', desc = 'Diff View' },
            { '<leader>gh', [[<cmd>DiffviewFileHistory<cr>]], mode = 'n', desc = 'Diff File History' },
        },
        after = function()
            require('diffview').setup {
                enhanced_diff_hl = true,
                keymaps = {
                    disable_defaults = true,

                    view = {
                        { 'n', '<tab>', actions.select_next_entry, { desc = 'View next file' } },
                        { 'n', '<S-tab>', actions.select_prev_entry, { desc = 'View previous File' } },
                        { 'n', 'q', [[<cmd>tabclose<cr>]], { desc = 'Quit diff view panel' } },
                    },
                    diff1 = {
                        { 'n', 'g?', actions.help { 'view', 'diff1' }, { desc = 'Open the help panel' } },
                        { 'n', 'q', [[<cmd>tabclose<cr>]], { desc = 'Quit diff view panel' } },
                    },
                    diff2 = {
                        { 'n', 'g?', actions.help { 'view', 'diff2' }, { desc = 'Open the help panel' } },
                        { 'n', 'q', [[<cmd>tabclose<cr>]], { desc = 'Quit diff view panel' } },
                    },
                    diff3 = {
                        { { 'n', 'x' }, '2eo', actions.diffget 'ours', { desc = 'Obtain the diff hunk from the OURS version of the file' } },
                        { { 'n', 'x' }, '3eo', actions.diffget 'theirs', { desc = 'Obtain the diff hunk from the THEIRS version of the file' } },
                        { 'n', 'g?', actions.help { 'view', 'diff3' }, { desc = 'Open the help panel' } },
                        { 'n', 'q', [[<cmd>tabclose<cr>]], { desc = 'Quit diff view panel' } },
                    },
                    diff4 = {
                        { { 'n', 'x' }, '1eo', actions.diffget 'base', { desc = 'Obtain the diff hunk from the BASE version of the file' } },
                        { { 'n', 'x' }, '2eo', actions.diffget 'ours', { desc = 'Obtain the diff hunk from the OURS version of the file' } },
                        { { 'n', 'x' }, '3eo', actions.diffget 'theirs', { desc = 'Obtain the diff hunk from the THEIRS version of the file' } },
                        { 'n', 'g?', actions.help { 'view', 'diff4' }, { desc = 'Open the help panel' } },
                        { 'n', 'q', [[<cmd>tabclose<cr>]], { desc = 'Quit diff view panel' } },
                    },
                    file_panel = {
                        { 'n', 'n', actions.next_entry, { desc = 'Next file entry' } },
                        { 'n', 'i', actions.prev_entry, { desc = 'Previous file entry' } },
                        { 'n', '<cr>', actions.select_entry, { desc = 'Select Entry' } },
                        { 'n', 's', actions.toggle_stage_entry, { desc = 'Stage / unstage the selected entry' } },
                        { 'n', 'S', actions.stage_all, { desc = 'Stage all entries' } },
                        { 'n', 'U', actions.unstage_all, { desc = 'Unstage all entries' } },
                        { 'n', 'X', actions.restore_entry, { desc = 'Restore entry' } },
                        { 'n', 'L', actions.open_commit_log, { desc = 'Open commit log' } },
                        { 'n', 'zo', actions.open_fold, { desc = 'Expand fold' } },
                        { 'n', 'zc', actions.close_fold, { desc = 'Collapse fold' } },
                        { 'n', 'za', actions.toggle_fold, { desc = 'Toggle fold' } },
                        { 'n', 'zR', actions.open_all_folds, { desc = 'Expand all folds' } },
                        { 'n', 'zM', actions.close_all_folds, { desc = 'Collapse all folds' } },
                        { 'n', '<C-d>', actions.scroll_view(0.25), { desc = 'Scroll the view down' } },
                        { 'n', '<C-u>', actions.scroll_view(-0.25), { desc = 'Scroll the view up' } },
                        { 'n', '<tab>', actions.select_next_entry, { desc = 'View next file' } },
                        { 'n', '<S-tab>', actions.select_prev_entry, { desc = 'View previous file' } },
                        { 'n', 'o', actions.goto_file_edit, { desc = 'Open file' } },
                        { 'n', 'O', actions.goto_file_split, { desc = 'Open file split' } },
                        { 'n', '.', actions.listing_style, { desc = 'Toggle view style' } },
                        { 'n', 'F', actions.refresh_files, { desc = 'Update stats and entries in the file list' } },
                        { 'n', '[x', actions.prev_conflict, { desc = 'Go to the previous conflict' } },
                        { 'n', ']x', actions.next_conflict, { desc = 'Go to the next conflict' } },
                        { 'n', 'g?', actions.help 'file_panel', { desc = 'Open the help panel' } },
                        { 'n', '<leader>cO', actions.conflict_choose_all 'ours', { desc = 'Choose the OURS version of a conflict for the whole file' } },
                        { 'n', '<leader>cT', actions.conflict_choose_all 'theirs', { desc = 'Choose the THEIRS version of a conflict for the whole file' } },
                        { 'n', '<leader>cB', actions.conflict_choose_all 'base', { desc = 'Choose the BASE version of a conflict for the whole file' } },
                        { 'n', '<leader>cA', actions.conflict_choose_all 'all', { desc = 'Choose all the versions of a conflict for the whole file' } },
                        { 'n', 'eX', actions.conflict_choose_all 'none', { desc = 'Delete the conflict region for the whole file' } },
                        { 'n', 'q', [[<cmd>tabclose<cr>]], { desc = 'Quit diff view panel' } },
                    },
                    file_history_panel = {
                        { 'n', 'g!', actions.options, { desc = 'Open the option panel' } },
                        { 'n', 'gd', actions.open_in_diffview, { desc = 'Open the entry under the cursor in a diffview' } },
                        { 'n', 'j', actions.copy_hash, { desc = 'Copy the commit hash of the entry under the cursor' } },
                        { 'n', 'L', actions.open_commit_log, { desc = 'Show commit details' } },
                        { 'n', 'X', actions.restore_entry, { desc = 'Restore file to the state from the selected entry' } },
                        { 'n', 'zo', actions.open_fold, { desc = 'Expand fold' } },
                        { 'n', 'zc', actions.close_fold, { desc = 'Collapse fold' } },
                        { 'n', 'za', actions.toggle_fold, { desc = 'Toggle fold' } },
                        { 'n', 'zR', actions.open_all_folds, { desc = 'Expand all folds' } },
                        { 'n', 'zM', actions.close_all_folds, { desc = 'Collapse all folds' } },
                        { 'n', 'n', actions.next_entry, { desc = 'Bring the cursor to the next file entry' } },
                        { 'n', 'i', actions.prev_entry, { desc = 'Bring the cursor to the previous file entry' } },
                        { 'n', '<cr>', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
                        { 'n', '<C-d>', actions.scroll_view(0.25), { desc = 'Scroll the view down' } },
                        { 'n', '<C-u>', actions.scroll_view(-0.25), { desc = 'Scroll the view up' } },
                        { 'n', '<tab>', actions.select_next_entry, { desc = 'Open the diff for the next file' } },
                        { 'n', '<S-tab>', actions.select_prev_entry, { desc = 'Open the diff for the previous file' } },
                        { 'n', 'o', actions.goto_file_edit, { desc = 'Open the file in the previous tabpage' } },
                        { 'n', 'O', actions.goto_file_split, { desc = 'Open the file in a new split' } },
                        { 'n', 'g?', actions.help 'file_history_panel', { desc = 'Open the help panel' } },
                        { 'n', 'q', [[<cmd>tabclose<cr>]], { desc = 'Quit diff view panel' } },
                    },
                    option_panel = {
                        { 'n', '<tab>', actions.select_entry, { desc = 'Change the current option' } },
                        { 'n', 'q', actions.close, { desc = 'Close the panel' } },
                        { 'n', 'g?', actions.help 'option_panel', { desc = 'Open the help panel' } },
                    },
                    help_panel = {
                        { 'n', 'q', actions.close, { desc = 'Close help menu' } },
                        { 'n', '<esc>', actions.close, { desc = 'Close help menu' } },
                    },
                },
            } -- 这里填入你原来完整的快捷键
        end,
    },
    { url = 'https://github.com/kevinhwang91/promise-async' },
    {
        url = 'https://github.com/kevinhwang91/nvim-ufo',
        event = 'BufReadPost',
        keys = {
            { 'zR', mode = 'n' },
            { 'zM', mode = 'n' },
        },
        after = function()
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' ... 󰁂 %d lines '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        if curWidth + chunkWidth < targetWidth then suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth) end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'Comment' })
                return newVirtText
            end
            require('ufo').setup { provider_selector = function(_, _, _) return { 'treesitter', 'indent' } end, fold_virt_text_handler = handler }
            kset('n', 'zR', require('ufo').openAllFolds, { desc = 'Open All Folds' })
            kset('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close All Folds' })
        end,
    },
    {
        url = 'https://github.com/lukas-reineke/indent-blankline.nvim',
        event = 'BufReadPost',
        after = function()
            require('ibl').setup {
                indent = { char = '┊' },
                scope = { char = '│', show_start = false, show_end = false },
                exclude = {
                    filetypes = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'trouble', 'lazy', 'mason', 'notify', 'toggleterm', 'NvimTree' },
                },
            }
        end,
    },
}

-- 3. ✨ 核心代码：智能分离解析 ✨
local pack_specs = {}
local lz_specs = {}

for _, def in ipairs(plugin_defs) do
    -- [A] 给 vim.pack 提取链接：只让它负责下载文件
    table.insert(pack_specs, { src = def.url, version = def.version })

    -- [B] 给 lz.n 提取短名：让它只拿目录名去操作
    -- 比如把 'https://github.com/lumen-oss/lz.n' 截断成 'lz.n'
    local folder_name = def.url:match('([^/]+)$'):gsub('%.git$', '')

    local lz_spec = { folder_name }
    for k, v in pairs(def) do
        if k ~= 'url' and k ~= 'version' then lz_spec[k] = v end
    end
    table.insert(lz_specs, lz_spec)
end

-- 4. 执行挂载
-- { load = function() end } 阻止 vim.pack 执行配置解析，完美绕过 #35550
vim.pack.add(pack_specs, { load = function() end })

-- 让 lz.n 接管完整的快捷键与懒加载
require('lz.n').load(lz_specs)

-- 5. 触发 colorscheme 懒加载
vim.cmd 'color deepwhite'
