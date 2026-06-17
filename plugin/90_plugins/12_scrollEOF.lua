Config.now_if_args(function()
    require('plugins.scroll_eof').setup {
        pattern = '*',
        insert_mode = true,
    }
end)
