return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
        labels = 'sdfghjkqwtyuiopzxcvbnm',
        modes = {
            search = { enabled = true },
            char = {
                enabled = true,
                keys = { f = 't', F = 'T', t = 'k', T = 'K' }, -- 调整为Norman布局按键
                label = { exclude = 'yniorafec' }, -- jump时不使用的标签，同样调整为Norman布局
            },
        },
    },
    keys = {
        { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Jump' },
        {
            'gt',
            mode = { 'n', 'x', 'o' },
            function()
                require('flash').treesitter {
                    jump = { pos = 'end' },
                    label = { before = false },
                }
            end,
            desc = 'To After TS',
        },
        {
            'gT',
            mode = { 'n', 'x', 'o' },
            function()
                require('flash').treesitter {
                    jump = { pos = 'start' },
                    label = { after = false },
                }
            end,
            desc = 'To Before TS',
        },
        { 'at', mode = { 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Select Tree-Sitter' },
        { 'rt', mode = { 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Select Tree-Sitter' },
    },
}
