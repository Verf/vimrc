return {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    keys = {
        { ']h', function() require('gitsigns').next_hunk() end, mode = 'n', desc = 'Next hunk' },
        { '[h', function() require('gitsigns').prev_hunk() end, mode = 'n', desc = 'Previous hunk' },
        { '<leader>gs', function() require('gitsigns').stage_hunk() end, mode = 'n', desc = 'Stage Hunk' },
        { '<leader>gu', function() require('gitsigns').reset_hunk() end, mode = 'n', desc = 'Unstage Hunk' },
        {
            '<leader>gS',
            function() require('gitsigns').stage_buffer() end,
            mode = 'n',
            desc = 'Stage Buffer',
        },
        {
            '<leader>gU',
            function() require('gitsigns').reset_buffer() end,
            mode = 'n',
            desc = 'Unstage Buffer',
        },
        {
            '<leader>gb',
            function() require('gitsigns').blame_line() end,
            mode = 'n',
            desc = 'Show Blame Inline',
        },
        { '<leader>gB', function() require('gitsigns').blame() end, mode = 'n', desc = 'Show Blame' },
    },
}
