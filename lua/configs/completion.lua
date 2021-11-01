vim.api.nvim_set_keymap('i', '<C-d>', [[:lua require'luasnip'.jump(1)<CR>]], {noremap=false, silent=true})
vim.api.nvim_set_keymap('s', '<C-d>', [[:lua require'luasnip'.jump(1)<CR>]], {noremap=false, silent=true})
vim.api.nvim_set_keymap('i', '<C-u>', [[:lua require'luasnip'.jump(-1)<CR>]], {noremap=false, silent=true})
vim.api.nvim_set_keymap('s', '<C-u>', [[:lua require'luasnip'.jump(-1)<CR>]], {noremap=false, silent=true})

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function (args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function (_)
            if luasnip.expandable() then
                luasnip.expand()
            elseif cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                feedkey('<Plug>(Tabout)', '')
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function (fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
    },
    sources = {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
    }
})

require('nvim-autopairs').setup()
