vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }

Config.on_filetype(
    'markdown',
    function()
        require('render-markdown').setup {
            heading = {
                sign = false,
                position = 'inline',
                icons = { '󰉫 ', '󰉬 ', '󰉭 ', '󰉮 ', '󰉯 ', '󰉰 ' },
            },
            code = { sign = false, width = 'block', right_pad = 1 },
        }
    end
)
