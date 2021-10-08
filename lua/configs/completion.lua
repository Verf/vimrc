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
            if vim.fn['vsnip#expandable']() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand)', true, true, true), '')
            elseif vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
            else
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(Tabout)', true, true, true), '')
            end
        end,
    },
    sources = {
        { name = 'path' },
        { name = 'vsnip' },
        { name = 'buffer' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
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
