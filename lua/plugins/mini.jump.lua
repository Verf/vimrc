return {
    'nvim-mini/mini.jump',
    version = '*',
    lazy = false,
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
