return {
    name = 'Run Pytest',
    builder = function(params)
        local args = { '-q' }
        if params.file then table.insert(args, params.file) end
        return {
            cmd = { 'pytest' },
            args = args,
            cwd = vim.fn.getcwd(),
            components = {
                'default',
                { 'on_output_parse', problem_matcher = '$pytest' },
            },
        }
    end,
    params = {
        file = { type = 'string', optional = true },
    },
    condition = {
        filetype = { 'python' },
    },
}
