return {
    'A7Lavinraj/fyler.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    lazy = false,
    keys = {
        {
            '-',
            function() require('fyler').toggle { kind = 'split_left_most' } end,
            mode = 'n',
            desc = 'Open fyler View',
        },
    },
    opts = {
        views = {
            finder = {
                confirm_simple = true,
                default_explorer = true,
                delete_to_trash = true,
                columns = {
                    permission = { enabled = false },
                    size = { enabled = false },
                },
                mappings = {
                    ['<CR>'] = 'Select',
                    ['-'] = 'CloseView',
                    ['='] = 'GotoCwd',
                    ['.'] = 'GotoNode',
                    ['#'] = 'CollapseAll',
                    ['<BS>'] = 'GotoParent',
                },
            },
        },
    },
}
