return {
    'nvim-mini/mini.icons',
    lazy = false,
    config = function()
        require('mini.icons').setup()
        require('mini.icons').mock_nvim_web_devicons()
        require('mini.icons').tweak_lsp_kind()
    end,
}
