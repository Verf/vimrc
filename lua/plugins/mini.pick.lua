return {
    'nvim-mini/mini.pick',
    version = false,
    dependencies = { 'nvim-mini/mini.icons' },
    lazy = false,
    keys = {
        { '<leader>f', function() MiniPick.builtin.files() end, mode = 'n', desc = 'Files' },
        { '<leader>b', function() MiniPick.builtin.buffers() end, mode = 'n', desc = 'Buffers' },
        { '<leader>/', function() MiniPick.builtin.grep_live() end, mode = 'n', desc = 'Grep Live' },
        -- for orgmode.nvim
        {
            '<leader>of',
            function() MiniPick.builtin.files({}, { source = { cwd = vim.fn.expand(vim.env.NOTE_TAKING_DIR) } }) end,
            mode = 'n',
            desc = 'Find Notes',
        },
    },
    opts = {
        options = { use_cache = true },
        mappings = {
            choose_marked = '<C-q>',
        },
    },
}
