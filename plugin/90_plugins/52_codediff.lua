vim.pack.add { 'https://github.com/esmuellert/codediff.nvim' }

Config.later(function()
    require('codediff').setup {
        -- 保持注释在删除行和词级差异上的可读性。
        highlights = {
            line_delete = '#FAE1E1',
            char_insert = 'DiffText',
            char_delete = 'DiffText',
        },
        keymaps = {
            view = {
                toggle_explorer = false,
                focus_explorer = false,
                next_hunk = ']h',
                prev_hunk = '[h',
                next_file = '<tab>',
                prev_file = '<S-tab>',
                diff_get = '<leader>gg',
                diff_put = '<leader>gp',
                close_on_open_in_prev_tab = false,
                toggle_stage = false,
                stage_hunk = false,
                unstage_hunk = false,
                discard_hunk = false,
            },
            conflict = {
                accept_incoming = '<leader>ct',
                accept_current = '<leader>co',
                accept_both = '<leader>cb',
                discard = '<leader>cx',
                accept_all_incoming = '<leader>cT',
                accept_all_current = '<leader>cO',
                accept_all_both = '<leader>cB',
                discard_all = '<leader>cX',
                next_conflict = ']x',
                prev_conflict = '[x',
                diffget_incoming = '2do',
                diffget_current = '3do',
            },
        },
    }
end)

vim.keymap.set('n', '<leader>gd', ':CodeDiff ', { desc = 'Diff' })
