return {
    'nvim-mini/mini.completion',
    version = '*',
    dependencies = { 'nvim-mini/mini.icons' },
    lazy = false,
    config = function(_, opts)
        -- 开启lsp kind图标
        require('mini.icons').tweak_lsp_kind()

        -- 截断补全菜单内容避免过长
        local process_items = function(items, base)
            -- 获取原始的补全输出
            local processed_items = MiniCompletion.default_process_items(items, base, {
                kind_priority = { Snippet = 99 },
            }) or items

            -- 清空labelDetails避免菜单项过长
            for _, item in ipairs(processed_items) do
                item.labelDetails = nil
            end

            return processed_items
        end

        require('mini.completion').setup {
            lsp_completion = {
                -- 使用omnifunc而不是默认的completefunc以应用lsp
                source_func = 'omnifunc',
                auto_setup = false,
                process_items = process_items,
            },
        }

        -- 自动设置omnifunc以用于lsp自动补全
        vim.api.nvim_create_autocmd('LspAttach', {
            group = _G.my_group,
            callback = function(args)
                vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
            end,
            desc = 'Set omnifunc for lsp completion',
        })

        -- 向LSP服务器告知客户端能力
        vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })

        -- 实现补全时自动覆盖/合并光标后已存在的重复后缀
        vim.api.nvim_create_autocmd('CompleteDone', {
            pattern = '*',
            group = _G.my_group,
            callback = function()
                -- 获取刚刚被确认插入的补全项
                local item = vim.v.completed_item
                if not item or not item.word or item.word == '' then return end

                -- 获取当前光标位置和当前行的完整内容
                local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                local line = vim.api.nvim_get_current_line()

                -- 获取光标后的文本 (col 是 0-based 字节索引，所以 col+1 就是光标后的内容)
                local after_cursor = line:sub(col + 1)
                if after_cursor == '' then return end

                local word = item.word
                local match_len = 0

                -- 寻找补全词的后缀与光标后文本前缀的最大重叠长度
                for i = 1, #word do
                    local suffix = word:sub(-i)
                    -- 判断光标后文本的前缀是否与 suffix 一致
                    if after_cursor:sub(1, i) == suffix then match_len = i end
                end

                -- 如果发现有重合的部分，删除光标后对应的重复字符
                if match_len > 0 then
                    local new_line = line:sub(1, col) .. line:sub(col + 1 + match_len)
                    vim.api.nvim_set_current_line(new_line)
                end
            end,
        })
    end,
}
