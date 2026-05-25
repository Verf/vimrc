-- mini.hipatterns
Config.now_if_args(function()
    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
        highlighters = {
            fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
            hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
            note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
            todo = { pattern = '%f[%w]()TODO()%f[%W]', group = hipatterns.compute_hex_color_group('#ff0000', 'fg') },
            done = { pattern = '%f[%w]()DONE()%f[%W]', group = hipatterns.compute_hex_color_group('#00ff00', 'fg') },
            hex_color = hipatterns.gen_highlighter.hex_color(),
        },
    }
end)
