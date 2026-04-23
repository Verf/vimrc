return {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    lazy = false,
    init = function()
        -- 关闭Neovim内置的对特定类型文件的按键映射以避免冲突
        -- 配置可见: https://github.com/neovim/neovim/tree/master/runtime/ftplugin
        vim.g.no_plugin_maps = true
    end,
    config = function()
        local move = require 'nvim-treesitter-textobjects.move'
        vim.keymap.set(
            { 'n', 'x', 'o' },
            ']f',
            function() move.goto_next_start('@function.outer', 'textobjects') end,
            { desc = 'Goto next function' }
        )
        vim.keymap.set(
            { 'n', 'x', 'o' },
            '[f',
            function() move.goto_previous_start('@function.outer', 'textobjects') end,
            { desc = 'Goto previous function' }
        )
        vim.keymap.set(
            { 'n', 'x', 'o' },
            ']c',
            function() move.goto_next_start('@class.outer', 'textobjects') end,
            { desc = 'Goto next class' }
        )
        vim.keymap.set(
            { 'n', 'x', 'o' },
            '[c',
            function() move.goto_previous_start('@class.outer', 'textobjects') end,
            { desc = 'Goto previous class' }
        )
        vim.keymap.set(
            { 'n', 'x', 'o' },
            ']a',
            function() move.goto_next_start('@parameter.outer', 'textobjects') end,
            { desc = 'Goto next parameter' }
        )
        vim.keymap.set(
            { 'n', 'x', 'o' },
            '[a',
            function() move.goto_previous_start('@parameter.outer', 'textobjects') end,
            { desc = 'Goto previous parameter' }
        )
        local repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'
        vim.keymap.set({ 'n', 'x', 'o' }, ',', repeat_move.repeat_last_move_next)
    end,
}
