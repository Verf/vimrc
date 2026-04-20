return {
    'nvim-mini/mini.hipatterns',
    lazy = false,
    dependencies = { 'nvim-mini/mini.extra' },
    config = function()
        local hipatterns = require 'mini.hipatterns'
        local extra = require 'mini.extra'
        hipatterns.setup {
            highlighters = {
                fixme = extra.gen_highlighter.words({ 'FIXME' }, 'MiniHipatternsFixme'),
                hack = extra.gen_highlighter.words({ 'HACK' }, 'MiniHipatternsHack'),
                todo = extra.gen_highlighter.words({ 'TODO' }, 'MiniHipatternsTodo'),
                note = extra.gen_highlighter.words({ 'NOTE' }, 'MiniHipatternsNote'),
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        }
    end,
}
