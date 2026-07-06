-- mini.ai
Config.now(function()
    local spec_treesitter = require('mini.ai').gen_spec.treesitter
    require('mini.ai').setup {
        n_lines = 200,
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
end)
