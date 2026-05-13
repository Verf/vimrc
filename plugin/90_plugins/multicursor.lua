vim.pack.add { 'https://github.com/jake-stewart/multicursor.nvim' }

local mc = require 'multicursor-nvim'
mc.setup()
mc.addKeymapLayer(function(layerSet)
    layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
    layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)
    layerSet({ 'n', 'x' }, '<up>', function() mc.lineAddCursor(-1) end)
    layerSet({ 'n', 'x' }, '<down>', function() mc.lineAddCursor(1) end)
    layerSet({ 'n', 'x' }, '<M-,>', mc.deleteCursor)
    layerSet({ 'n', 'x' }, ',', function()
        if mc.hasCursors() then mc.clearCursors() end
    end, { desc = 'Clear all cursors' })
end)

vim.keymap.set('x', 's', function() require('multicursor-nvim').matchCursors() end, { desc = 'Add cursor by regex' })

vim.keymap.set(
    'x',
    '<M-s>',
    function() require('multicursor-nvim').splitCursors '^' end,
    { desc = 'Split on newlines' }
)
