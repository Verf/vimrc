-- faster.lua — 大文件/长行/宏执行时自动降载，替代 pteroctopus/faster.nvim

local M = {}

local config = {
    bigfile = { filesize_mib = 2, enable = true },
    longline = { filesize_mib = 0.01, avg_bytes_per_line = 250, enable = true },
    macro = { enable = true },
}

-- defer=true 的项后禁用、先恢复。禁用 filetype 会触发 FileType autocmd 重新
-- 启用 treesitter 等，所以 filetype 必须在最后禁用、最先恢复。
local feature_list = {
    {
        defer = false,
        disable = function() pcall(vim.treesitter.stop, 0) end,
        enable = function() pcall(vim.treesitter.start, 0) end,
    },
    {
        defer = false,
        disable = function()
            if vim.fn.exists(':LspStop') == 2 then vim.cmd 'LspStop' end
        end,
        enable = function()
            if vim.bo.filetype ~= '' and vim.fn.exists(':LspStart') == 2 then vim.cmd 'LspStart' end
        end,
    },
    {
        defer = false,
        disable = function()
            if vim.fn.exists(':NoMatchParen') == 2 then vim.cmd 'NoMatchParen' end
        end,
        enable = function()
            if vim.fn.exists(':DoMatchParen') == 2 then vim.cmd 'DoMatchParen' end
        end,
    },
    {
        -- vimopts: 按 buffer 备份/恢复 swapfile, foldmethod, undolevels, undoreload, list, spell
        defer = true,
        backup = {},
        disable = function(self, bufnr)
            if not self.backup[bufnr] then
                self.backup[bufnr] = {
                    swapfile = vim.bo[bufnr].swapfile,
                    foldmethod = vim.bo[bufnr].foldmethod,
                    undolevels = vim.bo[bufnr].undolevels,
                    undoreload = vim.bo[bufnr].undoreload,
                    list = vim.bo[bufnr].list,
                    spell = vim.bo[bufnr].spell,
                }
            end
            vim.bo[bufnr].swapfile = false
            vim.bo[bufnr].foldmethod = 'manual'
            vim.bo[bufnr].undolevels = -1
            vim.bo[bufnr].undoreload = 0
            vim.bo[bufnr].list = false
            vim.bo[bufnr].spell = false
        end,
        enable = function(self, bufnr)
            local bak = self.backup[bufnr]
            if not bak then return end
            vim.bo[bufnr].swapfile = bak.swapfile
            vim.bo[bufnr].foldmethod = bak.foldmethod
            vim.bo[bufnr].undolevels = bak.undolevels
            vim.bo[bufnr].undoreload = bak.undoreload
            vim.bo[bufnr].list = bak.list
            vim.bo[bufnr].spell = bak.spell
            self.backup[bufnr] = nil
        end,
    },
    {
        defer = true,
        backup = {},
        disable = function(self, bufnr)
            if not self.backup[bufnr] then
                self.backup[bufnr] = vim.bo[bufnr].syntax
            end
            vim.api.nvim_buf_call(bufnr, function()
                vim.cmd 'syntax clear'
                vim.bo.syntax = 'off'
            end)
        end,
        enable = function(self, bufnr)
            local bak = self.backup[bufnr]
            if not bak then return end
            vim.bo[bufnr].syntax = bak
            self.backup[bufnr] = nil
        end,
    },
    {
        defer = true,
        backup = {},
        disable = function(self, bufnr)
            if not self.backup[bufnr] then
                self.backup[bufnr] = vim.bo[bufnr].filetype
            end
            vim.bo[bufnr].filetype = ''
        end,
        enable = function(self, bufnr)
            local bak = self.backup[bufnr]
            if not bak then return end
            vim.bo[bufnr].filetype = bak
            self.backup[bufnr] = nil
        end,
    },
}

local function _disable_features(bufnr)
    for _, f in ipairs(feature_list) do
        if not f.defer then
            f.disable(f, bufnr or vim.api.nvim_get_current_buf())
        end
    end
    for _, f in ipairs(feature_list) do
        if f.defer then
            f.disable(f, bufnr or vim.api.nvim_get_current_buf())
        end
    end
end

local function _enable_features()
    for _, f in ipairs(feature_list) do
        if f.defer then f.enable(f, vim.api.nvim_get_current_buf()) end
    end
    for _, f in ipairs(feature_list) do
        if not f.defer then f.enable(f, vim.api.nvim_get_current_buf()) end
    end
end

-- 三遍禁用，因为禁用 filetype (defer=true) 会触发 FileType autocmd 重新启用
-- defer=false 的 feature（如 treesitter），需要在下一帧再禁一次覆盖回去
local function _heavy_disable(bufnr)
    vim.api.nvim_buf_call(bufnr, function() _disable_features(bufnr) end)
    vim.schedule(function()
        if vim.api.nvim_buf_is_valid(bufnr) then
            vim.api.nvim_buf_call(bufnr, function()
                for _, f in ipairs(feature_list) do
                    if not f.defer then f.disable(f, bufnr) end
                end
            end)
        end
    end)
end

local function _get_file_size(bufnr)
    local ok, stat = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
    if not (ok and stat) then return nil end
    local size_mib = math.floor(0.5 + (stat.size / (1024 * 1024)) * 10) / 10
    return size_mib, stat.size
end

-- ============================================================================
-- 大文件检测
-- ============================================================================

local function _bigfile_check(bufnr, threshold_mib)
    vim.schedule(function()
        if not vim.api.nvim_buf_is_valid(bufnr) then return end
        local size_mib = _get_file_size(bufnr)
        if not size_mib or size_mib < threshold_mib then return end
        local ok = pcall(vim.api.nvim_buf_get_var, bufnr, 'faster_bigfile_done')
        if ok then return end
        pcall(vim.api.nvim_buf_set_var, bufnr, 'faster_bigfile_done', true)
        _heavy_disable(bufnr)
    end)
end

local function _bigfile_init()
    if not config.bigfile.enable then return end
    vim.api.nvim_create_autocmd('BufReadPost', {
        group = vim.api.nvim_create_augroup('faster_bigfile', { clear = true }),
        pattern = '*',
        callback = function(args) _bigfile_check(args.buf, config.bigfile.filesize_mib) end,
    })
    local cur = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_get_name(cur) ~= '' then
        _bigfile_check(cur, config.bigfile.filesize_mib)
    end
end

-- ============================================================================
-- 长行检测
-- ============================================================================

local function _longline_check(bufnr, min_mib, avg_threshold)
    vim.schedule(function()
        if not vim.api.nvim_buf_is_valid(bufnr) then return end
        local size_mib, size_bytes = _get_file_size(bufnr)
        if not size_bytes or size_mib < min_mib then return end
        local line_count = vim.api.nvim_buf_line_count(bufnr)
        if line_count == 0 then return end
        if size_bytes / line_count <= avg_threshold then return end
        local ok = pcall(vim.api.nvim_buf_get_var, bufnr, 'faster_longline_done')
        if ok then return end
        pcall(vim.api.nvim_buf_set_var, bufnr, 'faster_longline_done', true)
        _heavy_disable(bufnr)
    end)
end

local function _longline_init()
    if not config.longline.enable then return end
    vim.api.nvim_create_autocmd('BufReadPost', {
        group = vim.api.nvim_create_augroup('faster_longline', { clear = true }),
        pattern = '*',
        callback = function(args)
            _longline_check(args.buf, config.longline.filesize_mib, config.longline.avg_bytes_per_line)
        end,
    })
    local cur = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_get_name(cur) ~= '' then
        _longline_check(cur, config.longline.filesize_mib, config.longline.avg_bytes_per_line)
    end
end

-- ============================================================================
-- 宏加速
-- ============================================================================

local macro_armed = false
local saved_eventignore = nil
local saved_lazyredraw = nil

local function _macro_restore()
    if not macro_armed then return end
    macro_armed = false
    if saved_eventignore ~= nil then
        vim.o.eventignore = saved_eventignore
        saved_eventignore = nil
    end
    if saved_lazyredraw ~= nil then
        vim.o.lazyredraw = saved_lazyredraw
        saved_lazyredraw = nil
    end
    vim.keymap.set('n', '@', _macro_execute)
    _enable_features()
end

local function _macro_poll()
    if not macro_armed then return end
    if vim.fn.reg_executing() ~= '' then
        vim.defer_fn(_macro_poll, 10)
    else
        _macro_restore()
    end
end

function M._macro_cleanup()
    if not macro_armed then return end
    _macro_restore()
end

local function _macro_execute()
    local reg = vim.fn.nr2char(vim.fn.getchar())
    local count = vim.v.count1
    _disable_features()
    vim.keymap.del('n', '@')
    saved_eventignore = vim.o.eventignore
    vim.o.eventignore = 'all'
    saved_lazyredraw = vim.o.lazyredraw
    vim.o.lazyredraw = true
    macro_armed = true
    vim.fn.feedkeys(count .. '@' .. reg, '')
    vim.fn.feedkeys(vim.keycode('<Cmd>lua require("plugins.faster")._macro_cleanup()<CR>'), 'n')
    vim.defer_fn(_macro_poll, 10)
end

local function _macro_init()
    if not config.macro.enable then return end
    vim.keymap.set('n', '@', _macro_execute, { desc = 'Execute macro (faster: 自动降载)' })
end

-- ============================================================================
-- 入口
-- ============================================================================

function M.setup(opts)
    if opts then
        config = vim.tbl_deep_extend('force', config, opts)
    end
    _bigfile_init()
    _longline_init()
    _macro_init()
    vim.g.loaded_faster_nvim = 1
end

return M
