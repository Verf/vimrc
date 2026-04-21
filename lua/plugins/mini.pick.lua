return {
    'nvim-mini/mini.pick',
    version = '*',
    dependencies = { 'nvim-mini/mini.extra' },
    keys = {
        { '<leader>f', function() MiniPick.builtin.files() end, mode = 'n', desc = 'Files' },
        { '<leader>b', function() MiniPick.builtin.buffers() end, mode = 'n', desc = 'Buffers' },
        { '<leader>/', function() MiniPick.builtin.grep_live() end, mode = 'n', desc = 'Grep Live' },
    },
    opts = {},
}
