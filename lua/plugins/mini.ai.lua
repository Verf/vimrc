return {
    'nvim-mini/mini.ai',
    version = '*',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    lazy = false,
    config = function()
        local spec_treesitter = require('mini.ai').gen_spec.treesitter
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
                c = spec_treesitter { a = '@class.outer', i = '@class.inner' },
                f = spec_treesitter { a = '@function.outer', i = '@function.inner' },
            },
        }

        -- mini.ai接管r映射后无法fallback到原始的定义，因此重新映射
        vim.keymap.set({ 'x', 'o' }, 'rw', 'iw')
        vim.keymap.set({ 'x', 'o' }, 'rW', 'iW')
    end,
}
