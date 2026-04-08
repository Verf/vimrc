return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        preset = 'modern',
        delay = 250,
        icons = { mappings = false },
        triggers = { { '<auto>', mode = 'nso' } },
    },
}
