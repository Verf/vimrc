vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }

Config.on_filetype('markdown', function()
    require('render-markdown').setup {}
end)
