local kset = vim.keymap.set
local add = vim.pack.add

add { 'https://github.com/nvim-mini/mini.nvim' }

require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()
require('mini.icons').tweak_lsp_kind()

require('mini.misc').setup()
require('mini.misc').setup_auto_root()
require('mini.misc').setup_restore_cursor()

require('mini.align').setup()
require('mini.extra').setup()
require('mini.notify').setup()
require('mini.operators').setup { replace = { prefix = '' } }
require('mini.pairs').setup()
require('mini.starter').setup()
require('mini.statusline').setup()
require('mini.tabline').setup()
require('mini.trailspace').setup()

require('mini.bufremove').setup()
kset('n', '<leader>qq', '<CMD>lua MiniBufremove.delete(0, true)<CR>', { desc = 'Buffer Close' })

require('mini.bracketed').setup {
    buffer = { suffix = '', options = {} },
    comment = { suffix = '', options = {} },
    conflict = { suffix = 'x', options = {} },
    diagnostic = { suffix = 'd', options = { severity = vim.diagnostic.severity.ERROR } },
    file = { suffix = '', options = {} },
    indent = { suffix = '', options = {} },
    jump = { suffix = '', options = {} },
    location = { suffix = '', options = {} },
    oldfile = { suffix = '', options = {} },
    quickfix = { suffix = 'q', options = {} },
    treesitter = { suffix = '', options = {} },
    undo = { suffix = 'u', options = {} },
    window = { suffix = '', options = {} },
    yank = { suffix = '', options = {} },
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
    mappings = {
        forward = 't',
        backward = 'T',
        forward_till = 'k',
        backward_till = 'K',
        repeat_jump = '',
    },
}

require('mini.jump2d').setup {
    view = {
        dim = true,
        n_steps_ahead = 2,
    },
    mappings = {
        start_jumping = '',
    },
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
local hi_words = MiniExtra.gen_highlighter.words
hipatterns.setup {
    highlighters = {
        fixme = hi_words({ 'FIXME' }, 'MiniHipatternsFixme'),
        hack = hi_words({ 'HACK' }, 'MiniHipatternsHack'),
        todo = hi_words({ 'TODO' }, 'MiniHipatternsTodo'),
        note = hi_words({ 'NOTE' }, 'MiniHipatternsNote'),
        hex_color = hipatterns.gen_highlighter.hex_color(),
    },
}

local minikeymap = require 'mini.keymap'
minikeymap.setup()
-- 使用 <Tab>/<S-Tab> 选择补全菜单项
minikeymap.map_multistep('i', '<Tab>', { 'minisnippets_expand', 'blink_next', 'jump_after_close' })
minikeymap.map_multistep('i', '<S-Tab>', { 'blink_prev', 'jump_before_open' })
-- <CR> 用于选择补全项或应用mini.pairs
-- <BS> 用于消除mini.pairs
minikeymap.map_multistep('i', '<BS>', { 'minipairs_bs' })

local snippets = require 'mini.snippets'
local config_path = vim.fn.stdpath 'config'
local match_strict = function(snips) return snippets.default_match(snips, { pattern_fuzzy = '%S+' }) end
snippets.setup {
    snippets = {
        snippets.gen_loader.from_file(config_path .. '/snippets/global.json'),
        snippets.gen_loader.from_lang { lang_patterns = { markdown_inline = { 'markdown.json' } } },
    },
    mappings = {
        expand = '',
        jump_next = '<C-d>',
        jump_prev = '<C-u>',
        stop = '<C-c>',
    },
    -- 禁止对snippet的prefix进行模糊匹配，仅允许准确的prefix展开
    expand = {
        match = match_strict,
    },
}
-- 退出insert时自动退出snippets
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
    desc = 'Cancel mini.snippets session when leave insert',
})

local miniclue = require 'mini.clue'
local leader_group_clues = {
    { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
    { mode = 'n', keys = '<Leader>f', desc = '+Find' },
    { mode = 'n', keys = '<Leader>g', desc = '+Git' },
    { mode = 'n', keys = '<Leader>q', desc = '+Quit' },
    { mode = 'n', keys = '<Leader>r', desc = '+Lsp' },
    { mode = 'n', keys = '<Leader>s', desc = '+Surround' },
    { mode = 'n', keys = '<Leader>t', desc = '+Tab' },
    { mode = 'n', keys = '<Leader>w', desc = '+Window' },
}
miniclue.setup {
    clues = {
        leader_group_clues,
        -- miniclue.gen_clues.builtin_completion(),
        -- miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        -- miniclue.gen_clues.square_brackets(),
        -- miniclue.gen_clues.z(),
    },
    -- Explicitly opt-in for set of common keys to trigger clue window
    triggers = {
        { mode = { 'n', 'x' }, keys = '<Leader>' }, -- Leader triggers
        -- { mode = 'n', keys = '\\' }, -- mini.basics
        -- { mode = { 'n', 'x' }, keys = '[' }, -- mini.bracketed
        -- { mode = { 'n', 'x' }, keys = ']' },
        -- { mode = 'i', keys = '<C-x>' }, -- Built-in completion
        -- { mode = { 'n', 'x' }, keys = 'g' }, -- `g` key
        { mode = { 'n', 'x' }, keys = "'" }, -- Marks
        { mode = { 'n', 'x' }, keys = '`' }, -- Marks
        { mode = { 'n', 'x' }, keys = '"' }, -- Registers
        { mode = { 'i', 'c' }, keys = '<C-r>' },
        -- { mode = { 'n', 'x' }, keys = 's' }, -- `s` key (mini.surround, etc.)
        { mode = { 'n', 'x' }, keys = 'z' }, -- `z` key
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

add { { src = 'https://github.com/Verf/deepwhite.nvim', version = 'dev' } }
require('deepwhite').setup { low_blue_light = true }
vim.cmd 'color deepwhite'

add { 'https://github.com/neovim/nvim-lspconfig' }
vim.lsp.enable { 'ty', 'ruff', 'biome', 'rust_analyzer', 'gopls', 'zls', 'nushell' }
kset({ 'n', 'x' }, '<leader>rn', [[<cmd> lua vim.lsp.buf.rename()<cr>]], { desc = 'Rename' })
kset({ 'n', 'x' }, '<leader>ra', [[<cmd> lua vim.lsp.buf.code_action()<cr>]], { desc = 'Code Action' })
kset({ 'n', 'x' }, '<leader>rh', [[<cmd> lua vim.lsp.buf.hover()<cr>]], { desc = 'Hover Doc' })
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end,
    desc = 'Disable Semantic Tokens',
})

add {
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
}
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
local isnt_installed = function(lang) return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0 end
local to_install = vim.tbl_filter(isnt_installed, languages)
if #to_install > 0 then require('nvim-treesitter').install(to_install) end
local filetypes = {}
for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
        table.insert(filetypes, ft)
    end
end
local ts_start = function(ev) vim.treesitter.start(ev.buf) end
vim.api.nvim_create_autocmd('FileType', { pattern = filetypes, callback = ts_start, desc = 'Start tree-sitter' })
-- treesitter-textobject按键设置
-- select
local ts_select = require 'nvim-treesitter-textobjects.select'
kset({ 'x', 'o' }, 'af', function() ts_select.select_textobject('@function.outer', 'textobjects') end)
kset({ 'x', 'o' }, 'rf', function() ts_select.select_textobject('@function.inner', 'textobjects') end)
kset({ 'x', 'o' }, 'ac', function() ts_select.select_textobject('@class.outer', 'textobjects') end)
kset({ 'x', 'o' }, 'rc', function() ts_select.select_textobject('@class.inner', 'textobjects') end)
kset({ 'x', 'o' }, 'as', function() ts_select.select_textobject('@local.scope', 'locals') end)
-- move
local ts_move = require 'nvim-treesitter-textobjects.move'
kset({ 'n', 'x', 'o' }, ']f', function() ts_move.goto_next_start('@function.outer', 'textobjects') end)
kset({ 'n', 'x', 'o' }, ']c', function() ts_move.goto_next_start('@class.outer', 'textobjects') end)
kset({ 'n', 'x', 'o' }, '[f', function() ts_move.goto_previous_start('@function.outer', 'textobjects') end)
kset({ 'n', 'x', 'o' }, '[c', function() ts_move.goto_previous_start('@class.outer', 'textobjects') end)

add { 'https://github.com/chrisgrieser/nvim-spider' }
kset({ 'n', 'o', 'x' }, 'w', [[<cmd>lua require('spider').motion('w')<cr>]])
kset({ 'n', 'o', 'x' }, 'd', [[<cmd>lua require('spider').motion('e')<cr>]])
kset({ 'n', 'o', 'x' }, 'b', [[<cmd>lua require('spider').motion('b')<cr>]])

add { 'https://github.com/stevearc/conform.nvim' }
require('conform').setup {
    default_format_opts = {
        lsp_format = 'fallback', -- 配置lsp的格式化器为默认项
    },
    format_after_save = {
        lsp_format = 'fallback',
    },

    formatters_by_ft = {
        python = { 'ruff_format', 'ruff_organize_imports' },
        lua = { 'stylua' },
        json = { 'biome' },
        nu = { 'nufmt' },
        toml = { 'taplo' },
        yaml = { 'yamlfmt' },
    },
}

add { { src = 'https://github.com/jake-stewart/multicursor.nvim', version = '1.0' } }
local mc = require 'multicursor-nvim'
mc.setup()

-- 类似于helix的多光标快捷键
-- s: 在选中范围内按正则拆分
kset('v', 's', mc.matchCursors, { desc = 'Add cursor by regex' })
-- Alt-s: 按换行符拆分
kset('v', '<M-s>', function() mc.splitCursors '^' end, { desc = 'Split on newlines' })
-- 定义多光标状态下的快捷键
mc.addKeymapLayer(function(layerSet)
    -- 选择前/后光标作为主光标
    layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
    layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)
    -- 使用上下键添加或减少行光标
    layerSet({ 'n', 'x' }, '<up>', function() mc.lineAddCursor(-1) end)
    layerSet({ 'n', 'x' }, '<down>', function() mc.lineAddCursor(1) end)
    -- 删除主光标
    layerSet({ 'n', 'x' }, '<M-,>', mc.deleteCursor)
    -- 删除主光标外的其他光标
    layerSet({ 'n', 'x' }, ',', function()
        if mc.hasCursors() then mc.clearCursors() end
    end, { desc = 'Clear all cursors' })
end)

add { { src = 'https://github.com/saghen/blink.cmp', version = 'v1.10.1' } }
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

    appearance = {
        nerd_font_variant = 'mono',
    },

    snippets = { preset = 'mini_snippets' },

    sources = {
        default = { 'lsp', 'buffer', 'path' },
    },

    signature = { enabled = true },

    fuzzy = { implementation = 'prefer_rust_with_warning' },

    completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        trigger = {
            show_on_keyword = true,
            show_on_trigger_character = false,
        },
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

    cmdline = {
        completion = {
            menu = { auto_show = true },
            list = { selection = { preselect = false, auto_insert = true } },
        },
    },
}
vim.api.nvim_create_autocmd('InsertLeave', {
    callback = function()
        vim.schedule(function() require('blink.cmp').cancel() end)
    end,
    desc = 'Cancel completion when leave insert',
})

add { 'https://github.com/dmtrKovalenko/fff.nvim' }
vim.g.fff = { lazy_sync = true }
require('fff').setup {
    prompt = '❯ ',
    grep = {
        modes = { 'plain', 'regex' },
    },
}
kset('n', '<leader>ff', function() require('fff').find_files() end, { desc = 'Find Files' })
kset('n', '<leader>fg', function() require('fff').live_grep() end, { desc = 'Live Grep' })

add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }

add { 'https://github.com/akinsho/toggleterm.nvim' }

require('toggleterm').setup {
    open_mapping = [[<C-\>]],
}

add { 'https://github.com/Aasim-A/scrollEOF.nvim' }

require('scrollEOF').setup {
    pattern = '*',
    insert_mode = true,
}

add { 'https://github.com/lewis6991/gitsigns.nvim' }
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

add { 'https://github.com/sindrets/diffview.nvim' }

local actions = require 'diffview.actions'
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
}

kset('n', '<leader>gd', [[:DiffviewOpen ]], { desc = 'Diff View' })
kset('n', '<leader>gh', [[<cmd>DiffviewFileHistory<cr>]], { desc = 'Diff File History' })

add {
    'https://github.com/kevinhwang91/promise-async',
    'https://github.com/kevinhwang91/nvim-ufo',
}

-- nvim-ufo 的自定义虚拟文本处理函数
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

-- 执行配置
require('ufo').setup {
    provider_selector = function(bufnr, filetype, buftype) return { 'treesitter', 'indent' } end,
    fold_virt_text_handler = handler,
}

kset('n', 'zR', require('ufo').openAllFolds, { desc = 'Open All Folds' })
kset('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close All Folds' })

add { 'https://github.com/lukas-reineke/indent-blankline.nvim' }
require('ibl').setup {
    indent = {
        char = '┊',
    },
    scope = {
        char = '│',
        show_start = false, -- 通常关掉，避免顶部横线太显眼
        show_end = false, -- 同上，关掉底部横线
    },
    exclude = {
        filetypes = {
            'help',
            'alpha',
            'dashboard',
            'neo-tree',
            'Trouble',
            'trouble',
            'lazy',
            'mason',
            'notify',
            'toggleterm',
            'NvimTree',
        },
    },
}
