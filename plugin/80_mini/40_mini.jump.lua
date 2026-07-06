-- mini.jump
Config.now(
    function()
        require('mini.jump').setup {
            mappings = {
                forward = 's',
                backward = 'S',
                forward_till = 'v',
                backward_till = 'V',
                repeat_jump = '',
            },
        }
    end
)
