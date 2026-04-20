return {
    'nvim-mini/mini.diff',
    event = 'BufReadPost',
    keys = { 'gh', 'gH', '[h', ']h', '[H', ']H' },
    opts = { view = { style = 'number' } },
}
