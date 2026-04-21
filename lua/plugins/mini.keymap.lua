return {
    'nvim-mini/mini.keymap',
    version = '*',
    lazy = false,
    config = function()
        local map_multistep = require('mini.keymap').map_multistep
        map_multistep('i', '<Tab>', { 'minisnippets_expand', 'pmenu_next' })
        map_multistep('i', '<S-Tab>', { 'minisnippets_prev', 'pmenu_prev' })
        map_multistep('i', '<C-d>', { 'minisnippets_next', 'jump_after_close' })
        map_multistep('i', '<C-u>', { 'minisnippets_prev', 'jump_before_open' })
        map_multistep('i', '<BS>', { 'minipairs_bs' })
    end,
}
