-- require'compe'.setup{
--     enabled = true,
--     debug = false,
--     autocomplete = true,
--     min_length = 1,
--     preselect = 'enable',
--     source = {
--         path     = true,
--         calc     = true,
--         buffer   = true,
--         nvim_lsp = true,
--         nvim_lua = true,
--         vsnip    = true,
--         orgmode  = true,
--     }
-- }
-- vim.api.nvim_set_keymap('i', '<CR>',    [[compe#confirm({ "keys": "\<Plug>delimitMateCR", "mode": "" })]], {noremap=false, silent=true, expr=true})
-- vim.api.nvim_set_keymap('i', '<Tab>',   [[vsnip#expandable() ? "<Plug>(vsnip-expand)" : pumvisible() ? "\<C-n>" : "<Tab>"]], {noremap=false, silent=true, expr=true})
-- vim.api.nvim_set_keymap('s', '<Tab>',   [[vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"]], {noremap=false, silent=true, expr=true})
-- vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "<S-Tab>"]], {noremap=false, silent=true, expr=true})
-- vim.api.nvim_set_keymap('s', '<S-Tab>', [[vsnip#jumpable(1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"]], {noremap=false, silent=true, expr=true})
vim.api.nvim_set_keymap('i', '<C-d>', [[<Plug>(vsnip-jump-next)]], {noremap=false, silent=true})
vim.api.nvim_set_keymap('s', '<C-d>', [[<Plug>(vsnip-jump-next)]], {noremap=false, silent=true})
vim.api.nvim_set_keymap('i', '<C-u>', [[<Plug>(vsnip-jump-prev)]], {noremap=false, silent=true})
vim.api.nvim_set_keymap('s', '<C-u>', [[<Plug>(vsnip-jump-prev)]], {noremap=false, silent=true})

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

require'cmp'.setup({
    snippet = {
        expand = function (args)
            vim.fn['vsnip#anonymous'](args.body)
        end,
    },
    mapping = {
        ['<Tab>'] = function (fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
            elseif check_back_space() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n')
            elseif vim.fn['vsnip#available']() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = 'path' },
        { name = 'buffer' },
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }
})
