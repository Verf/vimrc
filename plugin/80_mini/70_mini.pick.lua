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

-- 首先尝试 git ls-files ，若非 git 目录则回退到 rg --files。
function _G._files_picker(cwd)
    cwd = cwd or vim.fn.getcwd()
    cwd = vim.fn.fnamemodify(cwd, ':p'):gsub('[/\\]$', '')

    local use_git = vim.fn.isdirectory(cwd .. '/.git') == 1 and vim.fn.executable 'git' == 1
    local cmd, name
    if use_git then
        cmd = { 'git', '-C', cwd, 'ls-files', '--cached', '--others', '--exclude-standard' }
        name = 'Files (git)'
    elseif vim.fn.executable 'rg' == 1 then
        cmd = { 'rg', '--files', '-j', '1', '--color=never' }
        name = 'Files (rg)'
    end

    local source_opts = {
        cwd = cwd,
        show = function(buf_id, items, query) MiniPick.default_show(buf_id, items, query, { show_icons = true }) end,
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
