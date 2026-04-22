return {
    'nvim-mini/mini.jump2d',
    version = '*',
    lazy = false,
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
        -- mini.jump2d永远以labels中字母的顺序，按屏幕从上到下，从左到右为spot标记label。
        -- 考虑到一般来说希望跳转过去的位置都是较远的，因此这里设置开头和结尾的字母为更加顺手的字母。
        labels = 'tesfdwvcxqazkgbjyplhmruoin',
        view = { n_steps_ahead = 99 },
        allowed_windows = { not_current = false },
        mappings = { start_jumping = '' },
    },
}
