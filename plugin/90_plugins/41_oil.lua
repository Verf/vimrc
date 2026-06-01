vim.pack.add { 'https://github.com/barrettruth/canola.nvim' }

Config.now_if_args(
    function()
        require('oil').setup {
            default_file_explorer = true,
            skip_confirm_for_simple_edits = false,
            keymaps = {
                ['q'] = { 'actions.close', mode = 'n' },
                ['<bs>'] = { 'actions.parent', mode = 'n' },
                ['jp'] = { 'actions.yank_entry', mode = 'n' },
            },
        }
    end
)

vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'File Explorer' })
