-- tab_scope.lua — tab 级独立的 buffer 列表
-- 替代 scope.nvim，仅实现核心的 tab 隔离功能

local M = {}

---@type table<integer, integer[]> tab → buffer 列表映射
M.cache = {}
M.last_tab = 0

local function get_valid_buffers()
    local ids = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then ids[#ids + 1] = buf end
    end
    return ids
end

function M.setup()
    local group = vim.api.nvim_create_augroup('TabScope', { clear = true })

    vim.api.nvim_create_autocmd('TabLeave', {
        group = group,
        callback = function()
            local tab = vim.api.nvim_get_current_tabpage()
            local bufs = get_valid_buffers()
            M.cache[tab] = bufs
            M.last_tab = tab
            for _, buf in ipairs(bufs) do
                pcall(vim.api.nvim_set_option_value, 'buflisted', false, { buf = buf })
            end
        end,
    })

    vim.api.nvim_create_autocmd('TabEnter', {
        group = group,
        callback = function()
            local tab = vim.api.nvim_get_current_tabpage()
            local bufs = M.cache[tab]
            if bufs then
                for _, buf in ipairs(bufs) do
                    if vim.api.nvim_buf_is_valid(buf) then
                        pcall(vim.api.nvim_set_option_value, 'buflisted', true, { buf = buf })
                    end
                end
            end
        end,
    })

    vim.api.nvim_create_autocmd('TabClosed', {
        group = group,
        callback = function() M.cache[M.last_tab] = nil end,
    })

    vim.api.nvim_create_autocmd('TabNewEntered', {
        group = group,
        callback = function() vim.bo.buflisted = true end,
    })
end

return M
