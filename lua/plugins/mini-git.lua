return {
    'nvim-mini/mini-git',
    main = 'mini.git',
    cmd = 'Git',
    keys = {
        { '<leader>gs', function() require('mini.git').show_at_cursor() end, mode = 'n', desc = 'Git Show' },
    },
    opts = {},
}
