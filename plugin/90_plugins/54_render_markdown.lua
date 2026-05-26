vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }

Config.on_filetype('markdown', function()
    require('render-markdown').setup {
        heading = { sign = true, icons = { ' ', ' ', ' ', ' ', ' ', ' ' } },
        code = { sign = true, width = 'block', right_pad = 1 },
        dash = { width = 'full' },
        checkbox = { enabled = true },
    }
end)
