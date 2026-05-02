return {
    'nvim-mini/mini.statusline',
    version = false,
    lazy = false,
    config = function()
        local stsl = require 'mini.statusline'
        stsl.setup {
            content = {
                inactive = function()
                    -- 1. 获取当前正在渲染状态栏的真实 Window ID
                    -- Neovim 在渲染非当前窗口状态栏时，会将其 ID 存放在 vim.g.statusline_winid 中
                    local winid = vim.g.statusline_winid or vim.api.nvim_get_current_win()
                    -- 2. 将 Window ID 转换为方便人类跳转的 Window Number (1, 2, 3...)
                    local winnr = vim.api.nvim_win_get_number(winid)
                    -- 3. 获取文件路径（使用 mini.statusline 默认的文件名组件）
                    local filename = MiniStatusline.section_filename { trunc_width = 140 }
                    -- 4. 组合并返回状态栏内容
                    return MiniStatusline.combine_groups {
                        -- 左侧：显示窗口编号，用来替代原先的 Mode 位置
                        { hl = 'MiniStatuslineInactive', strings = { string.format('󰕰 %d', winnr) } },
                        -- 右侧：显示文件路径
                        { hl = 'MiniStatuslineInactive', strings = { filename } },
                    }
                end,
            },
        }
    end,
}
