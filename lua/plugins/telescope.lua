return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release ; cmake --build build --config Release --target install',
        },
    },
    event = 'VimEnter',
    config = function()
        local actions = require 'telescope.actions'

        require('telescope').setup {
            defaults = {
                prompt_prefix = ' ',
                selection_caret = ' ',
                path_display = { 'truncate' },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
                },
                live_grep = {
                    only_sort_text = true,
                },
                buffers = {
                    theme = 'dropdown',
                    previewer = false,
                    mappings = {
                        i = { ['<C-d>'] = actions.delete_buffer },
                    },
                },
            },
            extensions = {
                ['ui-select'] = { require('telescope.themes').get_dropdown() },
            },
        }

        -- 启用telescope插件
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find Diagnostics' })
        vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Find Resume' })
        vim.keymap.set('n', '<leader>fh', builtin.oldfiles, { desc = 'Find History' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
        vim.keymap.set({ 'n', 'v' }, '<leader>fw', builtin.grep_string, { desc = 'Find Current Word' })

        -- Lsp快捷键使用telescope，需要在LspAttach时绑定
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
            callback = function(event)
                local buf = event.buf

                vim.keymap.set('n', 'gr', builtin.lsp_references, { buffer = buf, desc = 'Goto References' })
                vim.keymap.set('n', 'gi', builtin.lsp_implementations, { buffer = buf, desc = 'Goto Implementation' })
                vim.keymap.set('n', 'gd', builtin.lsp_definitions, { buffer = buf, desc = 'Goto Definition' })
                vim.keymap.set(
                    'n',
                    '<leader>fs',
                    builtin.lsp_document_symbols,
                    { buffer = buf, desc = 'Open Document Symbols' }
                )
                vim.keymap.set(
                    'n',
                    '<leader>fS',
                    builtin.lsp_dynamic_workspace_symbols,
                    { buffer = buf, desc = 'Open Workspace Symbols' }
                )
                vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, { buffer = buf, desc = 'Goto Type Definition' })
            end,
        })
    end,
}
