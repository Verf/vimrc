return {
    name = 'Run Current buffer by Python',
    builder = function()
        return {
            cmd = { 'python' },
            args = { vim.fn.expand '%:p' },
            cwd = vim.fn.getcwd(),
            name = 'Python: ' .. vim.fn.expand '%:t',
            components = { 'default', { 'on_complete_notify' }, { 'display_duration', detail_level = 2 } },
        }
    end,
    condition = {
        filetype = { 'python' },
    },
}
