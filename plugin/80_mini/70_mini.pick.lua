-- mini.pick
require('mini.pick').setup {
    options = { use_cache = true },
    mappings = {
        choose_marked = '<C-q>',
    },
}

vim.keymap.set('n', '<leader>f', function() MiniPick.builtin.files() end, { desc = 'Files' })
vim.keymap.set('n', '<leader>b', function() MiniPick.builtin.buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>/', function() MiniPick.builtin.grep_live() end, { desc = 'Grep Live' })
vim.keymap.set(
    'n',
    '<leader>of',
    function() MiniPick.builtin.files({}, { source = { cwd = vim.fn.expand(vim.env.NOTE_TAKING_DIR) } }) end,
    { desc = 'Find Notes' }
)
