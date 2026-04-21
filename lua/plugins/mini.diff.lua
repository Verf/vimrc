return {
    'nvim-mini/mini.diff',
    version = '*',
    event = 'BufReadPost',
    keys = { 'gh', 'gH', '[h', ']h', '[H', ']H' },
    opts = { view = { style = 'number' } },
}
