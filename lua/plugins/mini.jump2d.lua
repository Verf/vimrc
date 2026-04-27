return {
    'nvim-mini/mini.jump2d',
    version = false,
    keys = {
        {
            'gw',
            function() MiniJump2d.start { spotter = MiniJump2d.gen_spotter.pattern '%f[%w]%w+' } end,
            mode = { 'n', 'x', 'o' },
            desc = 'Goto words',
        },
        {
            'gs',
            function() MiniJump2d.start { spotter = MiniJump2d.gen_spotter.pattern '%p+' } end,
            mode = { 'n', 'x', 'o' },
            desc = 'Goto symbols',
        },
        {
            'gl',
            function()
                MiniJump2d.start {
                    spotter = MiniJump2d.builtin_opts.line_start.spotter,
                    hooks = { after_jump = MiniJump2d.builtin_opts.line_start.hooks.after_jump },
                }
            end,
            mode = { 'n', 'x', 'o' },
            desc = 'Goto lines',
        },
    },
    opts = {
        -- mini.jump2d永远以labels中字母的顺序，按屏幕从上到下，从左到右的顺序为spot标记label。
        -- 根据实际体验+/-10行左右位置是最为常见进行跳转使用的位置，因此考虑设置这里为最常用按键
        -- 同时对于qzkjbp这几个比较难以按到的键位，不安排到labels中
        labels = 'gaxcwdtesfvoinulrmhy',
        view = { dim = true, n_steps_ahead = 99 },
        allowed_windows = { not_current = false },
        mappings = { start_jumping = '' },
    },
}
