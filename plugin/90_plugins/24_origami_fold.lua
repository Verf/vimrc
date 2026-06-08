vim.pack.add { 'https://github.com/chrisgrieser/nvim-origami' }

Config.now(function()
    require('origami').setup {
        useLspFoldsWithTreesitterFallback = {
            enabled = true,
            foldmethodIfNeitherIsAvailable = 'indent',
        },
        pauseFoldsOnSearch = true,
        foldtext = {
            enabled = true,
            padding = {
                character = ' ',
                width = 3,
                hlgroup = nil,
            },
            lineCount = {
                template = '%d lines',
                hlgroup = 'Comment',
            },
            diagnosticsCount = true,
            gitsignsCount = true,
            disableOnFt = {},
        },
        autoFold = {
            enabled = true,
            kinds = { 'comment', 'imports' },
        },
        foldKeymaps = { setup = false },
    }

    vim.keymap.set('n', 'y', function() require('origami').h() end)
    vim.keymap.set('n', 'o', function() require('origami').l() end)
    vim.keymap.set('n', '^', function() require('origami').caret() end)
    vim.keymap.set('n', '$', function() require('origami').dollar() end)
end)
