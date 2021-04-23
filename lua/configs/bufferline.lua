local map = require('utils').map

require'bufferline'.setup{
    options = {
        view = "multiwindow",
        numbers = "none",
        always_show_bufferline = true,
        buffer_close_icon= '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
            return "("..count..")"
        end,
        show_buffer_close_icons = false,
        persist_buffer_sort = true,
        separator_style = "thin",
        enforce_regular_tabs = false,
        sort_by = 'extension',
    }
}


map('n', '<leader><space>', ':BufferLinePick<CR>', {noremap=false})
map('n', '[b', ':BufferLineCyc}leNext<CR>', {noremap=false})
map('n', 'b]', ':BufferLineCyclePrev<CR>', {noremap=false})
