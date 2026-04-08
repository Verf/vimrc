return {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    keys = {
        { ']h', [[<cmd>lua require('gitsigns').next_hunk()<cr>]], mode = 'n', desc = 'Next hunk' },
        { '[h', [[<cmd>lua require('gitsigns').prev_hunk()<cr>]], mode = 'n', desc = 'Previous hunk' },
        { '<leader>gs', [[<cmd>lua require('gitsigns').stage_hunk()<cr>]], mode = 'n', desc = 'Stage Hunk' },
        { '<leader>gu', [[<cmd>lua require('gitsigns').reset_hunk()<cr>]], mode = 'n', desc = 'Unstage Hunk' },
        {
            '<leader>gS',
            [[<cmd>lua require('gitsigns').stage_buffer()<cr>]],
            mode = 'n',
            desc = 'Stage Buffer',
        },
        {
            '<leader>gU',
            [[<cmd>lua require('gitsigns').reset_buffer()<cr>]],
            mode = 'n',
            desc = 'Unstage Buffer',
        },
        {
            '<leader>gb',
            [[<cmd>lua require('gitsigns').blame_line()<cr>]],
            mode = 'n',
            desc = 'Show Blame Inline',
        },
        { '<leader>gB', [[<cmd>lua require('gitsigns').blame()<cr>]], mode = 'n', desc = 'Show Blame' },
    },
}
