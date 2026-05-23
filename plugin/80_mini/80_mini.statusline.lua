-- mini.statusline
Config.now(function()
    local stsl = require 'mini.statusline'
    stsl.setup {
        content = {
            active = function()
                local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
                local git = MiniStatusline.section_git { trunc_width = 75 }
                local diff = MiniStatusline.section_diff { trunc_width = 75 }
                local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
                local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
                local filename = MiniStatusline.section_filename { trunc_width = 140 }
                local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
                local location = MiniStatusline.section_location { trunc_width = 75 }
                local search = MiniStatusline.section_searchcount { trunc_width = 75 }

                local rec_reg = vim.fn.reg_recording()
                local recording = rec_reg ~= '' and (' REC @' .. rec_reg) or ''

                return MiniStatusline.combine_groups {
                    { hl = mode_hl, strings = { mode .. recording } },
                    { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
                    '%<', -- 截断点
                    { hl = 'MiniStatuslineFilename', strings = { filename } },
                    '%=', -- 右对齐分隔
                    { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                    { hl = mode_hl, strings = { search, location } },
                }
            end,
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
end)

vim.api.nvim_create_autocmd({ 'RecordingEnter', 'RecordingLeave', 'LspProgress' }, {
    group = _G.my_group,
    callback = function() vim.cmd 'redrawstatus' end,
    desc = 'Update statusline on macro recording and LSP progress',
})
