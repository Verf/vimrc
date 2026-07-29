-- mini.pick
Config.now(
    function()
        require('mini.pick').setup {
            options = { use_cache = true },
            mappings = {
                choose_marked = '<C-q>',
            },
        }
    end
)

-- 在 git 仓库中，用 git ls-files 替代 rg --files。
-- 原因：内网 Win10 + 360天擎/亚信/DLP 的安全软件在内核层拦截所有文件系统调用。
-- rg --files 遍历目录树会产生成百上千次被审计的 I/O 操作（每次 stat/readdir ~5-20ms），
-- 几十个文件的项目也要好几秒。git ls-files 直接读 .git/index 单文件，完全绕过遍历。
function _G._files_picker(cwd)
    cwd = cwd or vim.fn.getcwd()
    cwd = vim.fn.fnamemodify(cwd, ':p'):gsub('[/\\]$', '')

    local use_git = vim.fn.isdirectory(cwd .. '/.git') == 1 and vim.fn.executable('git') == 1
    local cmd, name
    if use_git then
        cmd = { 'git', '-C', cwd, 'ls-files', '--cached', '--others', '--exclude-standard' }
        name = 'Files (git)'
    elseif vim.fn.executable('rg') == 1 then
        cmd = { 'rg', '--files', '-j', '1', '--color=never' }
        name = 'Files (rg)'
    end

    local source_opts = {
        cwd = cwd,
        show = function(buf_id, items, query)
            MiniPick.default_show(buf_id, items, query, { show_icons = true })
        end,
    }

    if cmd then
        source_opts.name = name
        MiniPick.builtin.cli({ command = cmd }, { source = source_opts })
    else
        MiniPick.builtin.files({}, { source = source_opts })
    end
end

vim.keymap.set('n', '<leader>f', function() _files_picker() end, { desc = 'Files' })
vim.keymap.set('n', '<leader>b', function() MiniPick.builtin.buffers() end, { desc = 'Buffers' })
