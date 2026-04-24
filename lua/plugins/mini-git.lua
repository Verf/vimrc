return {
    'nvim-mini/mini-git',
    version = false,
    main = 'mini.git',
    lazy = false,
    keys = {
        { '<leader>gs', function() require('mini.git').show_at_cursor() end, mode = { 'n', 'x' }, desc = 'Show' },
    },
    opts = {},
}
