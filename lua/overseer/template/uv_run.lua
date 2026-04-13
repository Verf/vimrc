return {
    name = 'uv run',
    builder = function()
        return {
            cmd = { 'uv', 'run' },
            args = { vim.fn.expand '%:p' },
            cwd = vim.fn.getcwd(),
            name = 'uv run: ' .. vim.fn.expand '%:t',
            components = { 'default' },
        }
    end,
    condition = {
        filetype = { 'python' },
    },
}
