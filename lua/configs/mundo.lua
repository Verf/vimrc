local g = vim.g
local map = require('utils').map

g.mundo_mappings = {
    ["<CR>"] = 'preview',
    n        = 'move_older',
    i        = 'move_newer',
    N        = 'move_older_write',
    I        = 'move_newer_write',
    gg       = 'move_top',
    G        = 'move_bottom',
    P        = 'play_to',
    d        = 'diff',
    l        = 'toggle_inline',
    ["/"]    = 'search',
    m        = 'next_match',
    M        = 'previous_match',
    p        = 'diff_current_buffer',
    f        = 'diff',
    ["?"]    = 'toggle_help',
    q        = 'quit'
}

map('', '<F4>', ':MundoToggle<CR>')