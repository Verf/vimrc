require('formatter').setup({
    logging = false,
    filetype = {
        python = {
            -- prettier
            function()
                return {
                    exe = "yapf",
                    args = {},
                    stdin = true
                }
            end
        }
    }
})
