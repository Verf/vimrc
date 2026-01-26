local now, later, add = MiniDeps.now, MiniDeps.later, MiniDeps.add
local now_if_args = _G.Config.now_if_args

later(function()
    add 'chrisgrieser/nvim-spider'

    vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>")
    vim.keymap.set({ 'n', 'o', 'x' }, 'd', "<cmd>lua require('spider').motion('e')<CR>")
    vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>")
end)

now_if_args(function()
    add 'neovim/nvim-lspconfig'

    vim.lsp.enable { 'ty', 'ruff', 'biome' }

    vim.keymap.set('n', 'gd', [[<CMD>Pick lsp scope="definition"<CR>]], { desc = 'Goto Definition' })
    vim.keymap.set('n', 'gr', [[<CMD>Pick lsp scope="references"<CR>]], { desc = 'Goto References' })
    vim.keymap.set('n', 'gD', [[<CMD>Pick lsp scope="declaration"<CR>]], { desc = 'Goto Declaration' })
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

    -- treesitter-textobject keymaps
    -- select
    local ts_select = require 'nvim-treesitter-textobjects.select'
    vim.keymap.set({ 'x', 'o' }, 'af', function() ts_select.select_textobject('@function.outer', 'textobjects') end)
    vim.keymap.set({ 'x', 'o' }, 'rf', function() ts_select.select_textobject('@function.inner', 'textobjects') end)
    vim.keymap.set({ 'x', 'o' }, 'ac', function() ts_select.select_textobject('@class.outer', 'textobjects') end)
    vim.keymap.set({ 'x', 'o' }, 'rc', function() ts_select.select_textobject('@class.inner', 'textobjects') end)
    vim.keymap.set({ 'x', 'o' }, 'as', function() ts_select.select_textobject('@local.scope', 'locals') end)
    -- move
    local ts_move = require 'nvim-treesitter-textobjects.move'
    vim.keymap.set({ 'n', 'x', 'o' }, ']f', function() ts_move.goto_next_start('@function.outer', 'textobjects') end)
    vim.keymap.set({ 'n', 'x', 'o' }, ']c', function() ts_move.goto_next_start('@class.outer', 'textobjects') end)
    vim.keymap.set(
        { 'n', 'x', 'o' },
        '[f',
        function() ts_move.goto_previous_start('@function.outer', 'textobjects') end
    )
    vim.keymap.set({ 'n', 'x', 'o' }, '[c', function() ts_move.goto_previous_start('@class.outer', 'textobjects') end)
    -- swap
    local ts_swap = require 'nvim-treesitter-textobjects.swap'
    vim.keymap.set('n', ']p', function() ts_swap.swap_next '@parameter.inner' end)
    vim.keymap.set('n', '[p', function() ts_swap.swap_previous '@parameter.inner' end)
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
