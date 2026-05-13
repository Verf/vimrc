-- =============================================================================
-- Non-mini plugins — all managed via vim.pack (Neovim 0.12+)
-- =============================================================================

vim.pack.add {
    'https://github.com/saghen/blink.lib',
    'https://github.com/saghen/blink.cmp',
    'https://github.com/barrettruth/canola.nvim',
    'https://github.com/esmuellert/codediff.nvim',
    'https://github.com/stevearc/conform.nvim',
    { src = 'https://github.com/Verf/deepwhite.nvim', version = 'dev' },
    'https://github.com/pteroctopus/faster.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/jake-stewart/multicursor.nvim',
    'https://github.com/nvim-orgmode/orgmode',
    'https://github.com/akinsho/org-bullets.nvim',
    'https://github.com/stevearc/quicker.nvim',
    'https://github.com/tiagovla/scope.nvim',
    'https://github.com/Aasim-A/scrollEOF.nvim',
    'https://github.com/chrisgrieser/nvim-spider',
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
    'https://github.com/folke/which-key.nvim',
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}

-- =============================================================================
-- blink.cmp
-- =============================================================================
require('blink.cmp').setup {
    keymap = {
        preset = 'none',
        ['<C-e>'] = { 'hide', 'show' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },
    fuzzy = { implementation = 'lua' },
    snippets = { preset = 'mini_snippets' },
    sources = { default = { 'lsp', 'path', 'buffer' } },
    cmdline = { enabled = false },
    completion = {
        list = { selection = { preselect = false } },
        menu = {
            border = nil,
            draw = {
                components = {
                    kind_icon = {
                        text = function(ctx)
                            local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                            return kind_icon
                        end,
                    },
                },
            },
        },
    },
}

-- =============================================================================
-- canola.nvim (oil)
-- =============================================================================
require('oil').setup {
    skip_confirm_for_simple_edits = false,
    keymaps = {
        ['q'] = { 'actions.close', mode = 'n' },
        ['<bs>'] = { 'actions.parent', mode = 'n' },
        ['jp'] = { 'actions.yank_entry', mode = 'n' },
    },
}

vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'File Explorer' })

-- =============================================================================
-- codediff.nvim
-- =============================================================================
require('codediff').setup {
    keymaps = {
        view = {
            toggle_explorer = false,
            focus_explorer = false,
            next_hunk = ']h',
            prev_hunk = '[h',
            next_file = '<tab>',
            prev_file = '<S-tab>',
            diff_get = '<leader>gg',
            diff_put = '<leader>gp',
            close_on_open_in_prev_tab = false,
            toggle_stage = false,
            stage_hunk = false,
            unstage_hunk = false,
            discard_hunk = false,
            hunk_textobject = 'rh',
        },
        explorer = {
            toggle_view_mode = '.',
        },
        history = {
            toggle_view_mode = '.',
        },
        conflict = {
            accept_incoming = '<leader>ct',
            accept_current = '<leader>co',
            accept_both = '<leader>cb',
            discard = '<leader>cx',
            accept_all_incoming = '<leader>cT',
            accept_all_current = '<leader>cO',
            accept_all_both = '<leader>cB',
            discard_all = '<leader>cX',
            next_conflict = ']x',
            prev_conflict = '[x',
            diffget_incoming = '2do',
            diffget_current = '3do',
        },
    },
}

vim.keymap.set('n', '<leader>gd', ':CodeDiff ', { desc = 'Diff' })

-- =============================================================================
-- conform.nvim
-- =============================================================================
require('conform').setup {
    default_format_opts = { lsp_format = 'fallback' },
    formatters_by_ft = {
        python = { 'ruff_format', 'ruff_organize_imports' },
        lua = { 'stylua' },
        json = { 'biome' },
        nu = { 'nufmt' },
        toml = { 'taplo' },
        yaml = { 'yamlfmt' },
    },
}

vim.keymap.set('n', '<leader>m', function() require('conform').format { async = true } end, { desc = 'Format' })

-- =============================================================================
-- deepwhite.nvim (colorscheme)
-- =============================================================================
require('deepwhite').setup { low_blue_light = true }
vim.cmd.colorscheme 'deepwhite'

-- =============================================================================
-- faster.nvim — no config needed
-- =============================================================================
require('faster').setup()

-- =============================================================================
-- nvim-lspconfig
-- =============================================================================
vim.lsp.enable { 'ty', 'ruff', 'biome', 'nushell' }

vim.api.nvim_create_autocmd('LspAttach', {
    group = _G.my_group,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then client.server_capabilities.semanticTokensProvider = nil end
    end,
    desc = 'Disable semanticTokensProvider for Lsp',
})

-- =============================================================================
-- multicursor.nvim
-- =============================================================================
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

vim.keymap.set('x', 's', function() require('multicursor-nvim').matchCursors() end, { desc = 'Add cursor by regex' })

vim.keymap.set(
    'x',
    '<M-s>',
    function() require('multicursor-nvim').splitCursors '^' end,
    { desc = 'Split on newlines' }
)

-- =============================================================================
-- orgmode + org-bullets
-- =============================================================================
local note_dir = vim.env.NOTE_TAKING_DIR

require('orgmode.utils.treesitter.install').compilers = { 'zig' }
require('orgmode').setup {
    org_agenda_files = note_dir .. '**/*.org',
    org_default_notes_file = note_dir .. 'refile.org',
    org_startup_folded = 'inherit', -- 继承neovim的folded配置
    -- 配置capture模板
    org_capture_templates = {
        -- 待办管理
        t = {
            description = 'Task',
            template = '* TODO %?\n  DEADLINE: %T\n',
            target = note_dir .. 'todos.org',
        },
        -- 会议记录
        m = {
            description = 'Meeting',
            template = '* %U %^{会议标题}\n\n** 纪要\n%?\n\n** 任务\n- [ ] ',
            target = note_dir .. 'meetings.org',
        },
        -- 碎片化记录
        j = {
            description = 'Journal',
            template = '* %U %?\n',
            target = note_dir .. 'refile.org',
        },
    },
    mappings = {
        agenda = {
            org_agenda_goto = false,
        },
        org = {
            org_cycle = false, -- 避免与<Tab>冲突
            org_global_cycle = false, -- 避免与<S-Tab>冲突
            org_return = false, -- 避免<CR>与mini.keymap中<CR>配置冲突
        },
    },
}
require('org-bullets').setup()

vim.lsp.enable 'org'

-- =============================================================================
-- quicker.nvim
-- =============================================================================
require('quicker').setup {
    keys = {
        {
            '>',
            function() require('quicker').expand { before = 2, after = 2, add_to_existing = true } end,
            desc = 'Expand quickfix context',
        },
        {
            '<',
            function() require('quicker').collapse() end,
            desc = 'Collapse quickfix context',
        },
    },
}

vim.keymap.set('n', '<leader>c', function() require('quicker').toggle() end, { desc = 'Toggle quickfix' })

-- =============================================================================
-- scope.nvim
-- =============================================================================
require('scope').setup {}

-- =============================================================================
-- scrollEOF.nvim
-- =============================================================================
require('scrollEOF').setup {
    pattern = '*',
    insert_mode = true,
}

-- =============================================================================
-- nvim-spider
-- =============================================================================
vim.keymap.set({ 'n', 'o', 'x' }, 'w', function() require('spider').motion 'w' end)
vim.keymap.set({ 'n', 'o', 'x' }, 'd', function() require('spider').motion 'e' end)
vim.keymap.set({ 'n', 'o', 'x' }, 'b', function() require('spider').motion 'b' end)

-- =============================================================================
-- nvim-treesitter-textobjects
-- =============================================================================
vim.g.no_plugin_maps = true

local ts_move = require 'nvim-treesitter-textobjects.move'
vim.keymap.set(
    { 'n', 'x', 'o' },
    ']a',
    function() ts_move.goto_next_start('@parameter.outer', 'textobjects') end,
    { desc = 'Goto next parameter' }
)
vim.keymap.set(
    { 'n', 'x', 'o' },
    '[a',
    function() ts_move.goto_previous_start('@parameter.outer', 'textobjects') end,
    { desc = 'Goto previous parameter' }
)

-- =============================================================================
-- nvim-treesitter
-- =============================================================================
local languages = {
    -- config
    'xml',
    'json',
    'yaml',
    'toml',
    -- git
    'diff',
    -- text
    'regex',
    -- front & vue
    'vue',
    'html',
    'css',
    'javascript',
    'typescript',
    'tsx',
    'scss',
    -- backend
    'java',
    'javadoc',
    'properties',
    -- python
    'python',
    'rst',
    -- shell & sql
    'nu',
    'bash',
    'sql',
}

-- 确保parser均已安装
local isnt_installed = function(lang) return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0 end
local to_install = vim.tbl_filter(isnt_installed, languages)
if #to_install > 0 then require('nvim-treesitter').install(to_install) end

-- 插入Neovim自带的tree-sitter
for _, lang in ipairs { 'c', 'lua', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' } do
    table.insert(languages, lang)
end

local filetypes = {}
for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
        table.insert(filetypes, ft)
    end
end

-- 为buffer自动启动tree-sitter
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
    group = _G.my_group,
    callback = function(ev)
        local buftype = vim.bo[ev.buf].buftype
        local filetype = vim.bo[ev.buf].filetype
        local lang = vim.treesitter.language.get_lang(filetype)
        -- 跳过特殊 buffer
        if buftype ~= '' or filetype == '' or filetype == 'qf' or filetype == 'help' then return end
        -- 仅为支持的buffer开启tree-sitter特性
        if vim.tbl_contains(filetypes, filetype) then
            vim.treesitter.start(ev.buf)
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            local indents = vim.treesitter.query.get(lang, 'indents')
            if indents then vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
        end
    end,
})

-- 设置tree-sitter快捷键
vim.api.nvim_create_autocmd('FileType', {
    group = _G.my_group,
    pattern = filetypes,
    callback = function(ev)
        local buftype = vim.bo[ev.buf].buftype
        -- 跳过特殊 buffer
        if buftype ~= '' or filetype == '' or filetype == 'qf' or filetype == 'help' then return end
        -- 增量选择快捷键
        vim.keymap.set({ 'n', 'x' }, '<CR>', function()
            if vim.treesitter.get_parser(ev.buf, nil, { error = false }) then
                require('vim.treesitter._select').select_parent(vim.v.count1 or 1)
            else
                vim.lsp.buf.selection_range(vim.v.count1)
            end
        end, { buffer = ev.buf, desc = 'Incremental expand selection', silent = true })
        vim.keymap.set('x', '<bs>', function()
            if vim.treesitter.get_parser(nil, nil, { error = false }) then
                require('vim.treesitter._select').select_child(vim.v.count1)
            else
                vim.lsp.buf.selection_range(-vim.v.count1)
            end
        end, { buffer = ev.buf, desc = 'Shrink selection', silent = true })
    end,
})

-- =============================================================================
-- which-key.nvim
-- =============================================================================
local wk = require 'which-key'
wk.setup {
    preset = 'modern',
    delay = 250,
    icons = { mappings = false },
    triggers = { { '<auto>', mode = 'nso' } },
}
wk.add {
    { 'gr', group = '+Lsp' },
    { '<leader>g', group = '+Git' },
    { '<leader>gf', group = '+Find' },
    { '<leader>o', group = '+Org' },
    { '<leader>t', group = '+Tab/Term' },
    { '<leader>S', group = '+Session' },
    { '<leader>w', group = '+Window', expand = function() return require('which-key.extras').expand.win() end },
}

-- =============================================================================
-- render-markdown.nvim — no explicit setup needed
-- =============================================================================
