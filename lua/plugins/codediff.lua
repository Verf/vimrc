return {
    'esmuellert/codediff.nvim',
    cmd = 'CodeDiff',
    opts = {
        keymaps = {
            view = {
                toggle_explorer = false, -- Toggle explorer visibility (explorer mode only)
                focus_explorer = false, -- Focus explorer panel (explorer mode only)
                diff_get = '<leader>gg', -- Get change from other buffer (like vimdiff)
                diff_put = '<leader>gp', -- Put change to other buffer (like vimdiff)
                close_on_open_in_prev_tab = false, -- Close codediff tab after gf opens file in previous tab
                toggle_stage = false, -- Stage/unstage current file (works in explorer and diff buffers)
                stage_hunk = false, -- Stage hunk under cursor to git index
                unstage_hunk = false, -- Unstage hunk under cursor from git index
                discard_hunk = false, -- Discard hunk under cursor (working tree only)
                hunk_textobject = 'rh', -- Textobject for hunk (vih to select, yih to yank, etc.)
            },
            explorer = {
                toggle_view_mode = '.', -- Toggle between 'list' and 'tree' views
            },
            history = {
                toggle_view_mode = '.', -- Toggle between 'list' and 'tree' views
            },
            conflict = {
                accept_incoming = '<leader>ct', -- Accept incoming (theirs/left) change
                accept_current = '<leader>co', -- Accept current (ours/right) change
                accept_both = '<leader>cb', -- Accept both changes (incoming first)
                discard = '<leader>cx', -- Discard both, keep base
                -- Accept all (whole file) - uppercase versions
                accept_all_incoming = '<leader>cT', -- Accept ALL incoming changes
                accept_all_current = '<leader>cO', -- Accept ALL current changes
                accept_all_both = '<leader>cB', -- Accept ALL both changes
                discard_all = '<leader>cX', -- Discard ALL, reset to base
                next_conflict = ']x', -- Jump to next conflict
                prev_conflict = '[x', -- Jump to previous conflict
                diffget_incoming = '2do', -- Get hunk from incoming (left/theirs) buffer
                diffget_current = '3do', -- Get hunk from current (right/ours) buffer
            },
        },
    },
}
