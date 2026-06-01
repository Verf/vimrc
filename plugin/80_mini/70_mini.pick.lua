-- mini.pick
Config.now(
    function()
        require('mini.pick').setup {
            options = { use_cache = true },
            mappings = {
                choose_marked = '<C-q>',
            },
        }
    end
)

vim.keymap.set('n', '<leader>f', function()
    -- 使用 rg -j 1 限制单线程，避免内网安全审计对每个线程额外扫描带来的性能开销
    if vim.fn.executable 'rg' == 1 then
        MiniPick.builtin.cli({ command = { 'rg', '--files', '-j', '1', '--color=never' } }, {
            source = {
                name = 'Files (rg)',
                show = function(buf_id, items, query)
                    MiniPick.default_show(buf_id, items, query, { show_icons = true })
                end,
            },
        })
    else
        MiniPick.builtin.files()
    end
end, { desc = 'Files' })
vim.keymap.set('n', '<leader>b', function() MiniPick.builtin.buffers() end, { desc = 'Buffers' })
