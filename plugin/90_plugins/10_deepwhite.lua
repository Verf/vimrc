vim.pack.add { { src = 'https://github.com/Verf/deepwhite.nvim' } }

Config.now(function()
    require('deepwhite').setup { low_blue_light = true }
    vim.cmd.colorscheme 'deepwhite'
end)
