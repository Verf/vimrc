-- mini.pick
Config.now(function()
    require('mini.pick').setup {
        options = { use_cache = true },
        mappings = {
            choose_marked = '<C-q>',
        },
    }
end)

vim.keymap.set('n', '<leader>f', function() MiniPick.builtin.files() end, { desc = 'Files' })
vim.keymap.set('n', '<leader>b', function() MiniPick.builtin.buffers() end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>/', function() MiniPick.builtin.grep_live() end, { desc = 'Grep Live' })
