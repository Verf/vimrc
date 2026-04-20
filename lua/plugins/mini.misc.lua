return {
    'nvim-mini/mini.misc',
    lazy = false,
    config = function()
        require('mini.misc').setup()
        require('mini.misc').setup_auto_root()
        require('mini.misc').setup_restore_cursor()
    end,
}
