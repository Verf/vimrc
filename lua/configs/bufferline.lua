require('bufferline').setup {
    options = {
        show_close_icon = false,
        show_buffer_close_icons = false,
        persist_buffer_sort = true,
        separator_style = 'thin',
        enforce_regular_tabs = false,
        sort_by = 'id',

        offsets = {
            {
                filetype = 'NvimTree',
                text = 'File Explorer',
                highlight = 'Directory',
                text_align = 'left',
            },
        },
    },
}
