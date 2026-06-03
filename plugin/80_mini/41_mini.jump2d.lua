-- mini.jump2d
Config.now(function()
    require('mini.jump2d').setup {
        -- mini.jump2d永远以labels中字母的顺序，按屏幕从上到下，从左到右的顺序为spot标记label。
        -- 根据实际体验+/-10行左右位置是最为常见进行跳转使用的位置，因此考虑设置这里为最常用按键
        -- 同时对于qzkjbp这几个比较难以按到的键位，不安排到labels中
        labels = 'gaxcwdtesfvoinulrmhy',
        view = { dim = true, n_steps_ahead = 99 },
        allowed_windows = { not_current = false },
        mappings = { start_jumping = '' },
    }
end)

-- keymaps
vim.keymap.set(
    { 'n', 'x', 'o' },
    'gw',
    function() MiniJump2d.start { spotter = MiniJump2d.gen_spotter.pattern '%f[%w]%w+' } end,
    { desc = 'Goto words' }
)
vim.keymap.set(
    { 'n', 'x', 'o' },
    'gs',
    function() MiniJump2d.start { spotter = MiniJump2d.gen_spotter.pattern '%p+' } end,
    { desc = 'Goto symbols' }
)
vim.keymap.set(
    { 'n', 'x', 'o' },
    'gl',
    function() MiniJump2d.start(MiniJump2d.builtin_opts.line_start) end,
    { desc = 'Goto lines' }
)
vim.keymap.set(
    { 'n', 'x', 'o' },
    's',
    function() MiniJump2d.start(MiniJump2d.builtin_opts.single_character) end,
    { desc = 'Goto Single Character' }
)
