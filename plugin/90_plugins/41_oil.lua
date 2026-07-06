vim.pack.add { 'https://github.com/barrettruth/canola.nvim' }

Config.now_if_args(
    function()
        require('oil').setup {
            default_file_explorer = true,
            skip_confirm_for_simple_edits = false,
        }
    end
)

vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'File Explorer' })
