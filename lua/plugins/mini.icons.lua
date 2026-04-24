return {
    'nvim-mini/mini.icons',
    version = false,
    lazy = false,
    config = function()
        require('mini.icons').setup()
        require('mini.icons').mock_nvim_web_devicons()
    end,
}
