-- mini.operators
Config.later(function()
    require('mini.operators').setup {
        -- g= gx gm gf
        sort = { prefix = '' },
        replace = { prefix = 'gf' },
    }
end)
