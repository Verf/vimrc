return {
    'nvim-mini/mini.ai',
    version = '*',
    lazy = false,
    config = function()
        require('mini.ai').setup {
            mappings = {
                inside = 'r',
                inside_next = '',
                inside_last = '',
            },
            custom_textobjects = {
                d = { '%f[%d]%d+' },
                s = {
                    {
                        '%u[%l%d]+%f[^%l%d]',
                        '%f[%S][%l%d]+%f[^%l%d]',
                        '%f[%P][%l%d]+%f[^%l%d]',
                        '^[%l%d]+%f[^%l%d]',
                    },
                    '^().*()$',
                },
            },
        }

        -- mini.ai接管r映射后无法fallback到原始的定义，因此重新映射
        vim.keymap.set({ 'x', 'o' }, 'rw', 'iw')
        vim.keymap.set({ 'x', 'o' }, 'rW', 'iW')
    end,
}
