return {
    'stevearc/oil.nvim',
    lazy = false,
    keys = {
        { '-', '<cmd>Oil<cr>', mode = 'n', desc = 'Open parent directory' },
    },
    opts = {
        skip_confirm_for_simple_edits = false,
        keymaps = {
            ['<bs>'] = { 'actions.parent', mode = 'n' },
        },
    },
}
