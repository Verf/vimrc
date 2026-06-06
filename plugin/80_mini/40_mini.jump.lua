-- mini.jump
Config.now(
    function()
        require('mini.jump').setup {
            mappings = {
                forward = 't',
                backward = 'T',
                forward_till = 'k',
                backward_till = 'K',
                repeat_jump = '',
            },
        }
    end
)
