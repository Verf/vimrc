-- path-lsp: 文件系统路径补全 LSP
-- 使用 Neovim 内嵌 function transport，无外部进程依赖。
Config.now(function()
    local path_lsp = require 'plugins.path_lsp'

    -- 在所有打开的 buffer 上启动路径补全 LSP
    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile', 'BufWinEnter', 'BufEnter' }, {
        group = _G.MyGroup,
        callback = function(args) path_lsp.start(args.buf) end,
        desc = 'Start path-lsp on buffer open',
    })

    -- 启动时当前 buffer 可能已存在（未命名默认 buffer），手动触发
    path_lsp.start(vim.api.nvim_get_current_buf())
end)
