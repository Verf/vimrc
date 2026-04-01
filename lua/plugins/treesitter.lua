return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
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

        local to_install = vim.tbl_filter(
            function(lang) return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0 end,
            languages
        )

        if #to_install > 0 then require('nvim-treesitter.install').ensure_installed(to_install) end

        pcall(vim.treesitter.start)

        local kset = vim.keymap.set

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
}
