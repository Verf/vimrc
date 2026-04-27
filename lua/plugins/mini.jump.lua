return {
    'nvim-mini/mini.jump',
    version = false,
    keys = { 't', 'T', 'k', 'K', 'h' },
    opts = {
        mappings = {
            forward = 't',
            backward = 'T',
            forward_till = 'k',
            backward_till = 'K',
            repeat_jump = 'h',
        },
    },
}
