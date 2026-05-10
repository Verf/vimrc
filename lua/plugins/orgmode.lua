return {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
        require('orgmode.utils.treesitter.install').compilers = { 'zig' }
        require('orgmode').setup {
            org_agenda_files = vim.env.NOTE_TAKING_DIR .. '**/*',
            org_default_notes_file = vim.env.NOTE_TAKING_DIR .. 'refile.org',
        }

        vim.lsp.enable 'org'
    end,
}
