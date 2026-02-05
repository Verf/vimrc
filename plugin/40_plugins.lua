local now, later, add = MiniDeps.now, MiniDeps.later, MiniDeps.add
local now_if_args = _G.Config.now_if_args
local kset = vim.keymap.set

now(function()
    add { source = 'Verf/deepwhite.nvim', checkout = 'dev' }

    require('deepwhite').setup {
        low_blue_light = true,
    }

    vim.cmd 'color deepwhite'
end)

now_if_args(function()
    add 'neovim/nvim-lspconfig'

    vim.lsp.enable { 'ty', 'ruff', 'biome', 'rust_analyzer', 'gopls' }

    kset({ 'n', 'x' }, '<leader>rn', [[<CMD> lua vim.lsp.buf.rename()<CR>]], { desc = 'Rename' })
    kset({ 'n', 'x' }, '<leader>ra', [[<CMD> lua vim.lsp.buf.code_action()<CR>]], { desc = 'Code Action' })
end)

now_if_args(function()
    add {
        source = 'nvim-treesitter/nvim-treesitter',
        hooks = { post_checkout = function() vim.cmd 'TSUpdate' end },
    }
    add {
        source = 'nvim-treesitter/nvim-treesitter-textobjects',
        checkout = 'main',
    }

    local languages = {
        'python',
        'javascript',
        'typescript',
        'vue',
    }
    local isnt_installed = function(lang) return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0 end
    local to_install = vim.tbl_filter(isnt_installed, languages)
    if #to_install > 0 then require('nvim-treesitter').install(to_install) end

    -- 打开文件时启动TreeSitter
    local filetypes = {}
    for _, lang in ipairs(languages) do
        for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
            table.insert(filetypes, ft)
        end
    end
    local ts_start = function(ev) vim.treesitter.start(ev.buf) end
    _G.Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')

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
    -- swap
    local ts_swap = require 'nvim-treesitter-textobjects.swap'
    kset('n', ']p', function() ts_swap.swap_next '@parameter.inner' end)
    kset('n', '[p', function() ts_swap.swap_previous '@parameter.inner' end)
end)

later(function() vim.diagnostic.config { virtual_text = true, severity_sort = true } end)

later(function()
    add 'chrisgrieser/nvim-spider'

    kset({ 'n', 'o', 'x' }, 'w', [[<CMD>lua require('spider').motion('w')<CR>]])
    kset({ 'n', 'o', 'x' }, 'd', [[<CMD>lua require('spider').motion('e')<CR>]])
    kset({ 'n', 'o', 'x' }, 'b', [[<CMD>lua require('spider').motion('b')<CR>]])
end)

later(function()
    add 'stevearc/conform.nvim'

    require('conform').setup {
        default_format_opts = {
            lsp_format = 'fallback', -- 配置lsp的格式化器为默认项
        },
        format_on_save = {
            timeout_ms = 500,
        },

        formatters_by_ft = {
            lua = { 'stylua' },
            json = { 'biome' },
            javascript = { 'dprint' },
            typescript = { 'dprint' },
            vue = { 'dprint' },
        },
    }
end)

later(function()
    add { source = 'jake-stewart/multicursor.nvim', checkout = '1.0' }
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
end)

later(function()
    add { source = 'saghen/blink.cmp', checkout = 'v1.9.0' }

    require('blink.cmp').setup {

        keymap = { preset = 'none' },

        appearance = {
            nerd_font_variant = 'mono',
        },

        -- snippets = { preset = 'mini_snippets' },
        sources = {
            default = { 'lsp', 'buffer', 'path' },
        },

        signature = { enabled = true },

        fuzzy = { implementation = 'prefer_rust_with_warning' },

        completion = {
            list = { selection = { preselect = false, auto_insert = true } },
        },
    }
end)
