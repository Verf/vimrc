vim.api.nvim_set_keymap('i', '<C-d>', [[<Plug>(vsnip-jump-next)]], {noremap=false, silent=true})
vim.api.nvim_set_keymap('s', '<C-d>', [[<Plug>(vsnip-jump-next)]], {noremap=false, silent=true})
vim.api.nvim_set_keymap('i', '<C-u>', [[<Plug>(vsnip-jump-prev)]], {noremap=false, silent=true})
vim.api.nvim_set_keymap('s', '<C-u>', [[<Plug>(vsnip-jump-prev)]], {noremap=false, silent=true})

local has_words_before = function ()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function (args)
            vim.fn['vsnip#anonymous'](args.body)
        end,
    },
    mapping = {
        ['<Tab>'] = cmp.mapping(function(fallback)
            if vim.fn['vsnip#expandable']() == 1 then
                feedkey('<Plug>(vsnip-expand)', '')
            elseif cmp.visible() then
                cmp.select_next_item()
            else
                feedkey('<Plug>(Tabout)', '')
            end
        end, {'i', 's'})
    },
    sources = {
        { name = 'vsnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
    }
})
require('nvim-autopairs').setup()
require('nvim-autopairs.completion.cmp').setup({
    map_cr = true,
    map_complete = true,
    auto_select = true,
    map_char = {
        all = '(',
        tex = '{'
    }
})
