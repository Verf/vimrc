return {
    'nvim-mini/mini.hipatterns',
    version = false,
    lazy = false,
    dependencies = { 'nvim-mini/mini.extra' },
    config = function()
        local hipatterns = require 'mini.hipatterns'
        local extra = require 'mini.extra'
        hipatterns.setup {
            highlighters = {
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        }
    end,
}
