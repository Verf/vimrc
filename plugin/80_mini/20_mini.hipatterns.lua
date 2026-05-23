-- mini.hipatterns
Config.now_if_args(function()
    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
        highlighters = {
            hex_color = hipatterns.gen_highlighter.hex_color(),
        },
    }
end)
