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
                -- 关闭lsp的高亮
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client then client.server_capabilities.semanticTokensProvider = nil end
            end,
            desc = 'Set omnifunc for lsp completion',
        })

        -- 向LSP服务器告知客户端能力
        vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
    end,
}
