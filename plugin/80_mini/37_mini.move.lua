-- mini.move
Config.now(
    function()
        require('mini.move').setup {
            mappings = {
                left = '',
                right = '',
                down = '',
                up = '',
                line_left = '<M-left>',
                line_right = '<M-right>',
                line_down = '<M-down>',
                line_up = '<M-up>',
            },
        }
    end
)
