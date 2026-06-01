vim.pack.add { 'https://github.com/Aasim-A/scrollEOF.nvim' }

Config.now_if_args(
    function()
        require('scrollEOF').setup {
            pattern = '*',
            insert_mode = true,
        }
    end
)
