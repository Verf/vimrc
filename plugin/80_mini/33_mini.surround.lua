-- mini.surround
Config.now(
    function()
        require('mini.surround').setup {
            mappings = {
                add = 'ma',
                delete = 'md',
                find = '',
                find_left = '',
                highlight = '',
                replace = 'mc',
                suffix_last = '',
                suffix_next = '',
            },
        }
    end
)
