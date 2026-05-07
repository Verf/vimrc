return {
    'barrettruth/canola.nvim',
    main = 'oil',
    lazy = false,
    keys = {
        { '-', [[<cmd>Oil<cr>]], mode = 'n', desc = 'File Explorer' },
    },
    opts = {
        skip_confirm_for_simple_edits = false,
        keymaps = {
            ['q'] = { 'actions.close', mode = 'n' },
            ['<bs>'] = { 'actions.parent', mode = 'n' },
            ['jp'] = { 'actions.yank_entry', mode = 'n' },
        },
    },
}
