return {
    'jake-stewart/multicursor.nvim',
    keys = {
        { 'S', [[<cmd>lua require('multicursor-nvim').matchCursors()<cr>]], mode = 'x', desc = 'Add cursor by regex' },
        {
            '<M-s>',
            [[<cmd>lua require('multicursor-nvim').splitCursors('^')<cr>]],
            mode = 'x',
            desc = 'Split on newlines',
        },
    },
    config = function()
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
    end,
}
