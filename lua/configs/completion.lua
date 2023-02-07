local cmp = require 'cmp'
local snip = require 'snippy'
local lspkind = require 'lspkind'

vim.keymap.set({ 'i', 's' }, '<C-d>', '<Plug>(snippy-next)')
vim.keymap.set({ 'i', 's' }, '<C-u>', '<Plug>(snippy-previous)')

cmp.setup {
    snippet = {
        expand = function(args)
            snip.expand_snippet(args.body)
        end,
    },
    formatting = {
        format = lspkind.cmp_format {
            mode = 'symbol',
            maxwidth = 50,
        },
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if snip.can_expand() then
                snip.expand()
            elseif cmp.visible() then
                cmp.select_next_item()
            elseif snip.can_jump(1) then
                snip.next()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif snip.can_jump(-1) then
                snip.previous()
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'snippy' },
        { name = 'path', option = {
            trailing_slash = true,
        } },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp_signature_help' },
    }, {
        { name = 'buffer' },
    }),
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
})
