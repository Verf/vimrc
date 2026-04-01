return {
    'Verf/deepwhite.nvim',
    branch = 'dev',
    priority = 1000,
    config = function()
        require('deepwhite').setup { low_blue_light = true }
        vim.cmd.colorscheme 'deepwhite'
    end,
}
