local map = require('utils').map

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
      },
      lua = {
          -- luafmt
          function()
            return {
              exe = "luafmt",
              args = {"--indent-count", 2, "--stdin"},
              stdin = true
            }
          end
        }
    }
  })

map('n', '<leader>fm', ':Format<CR>')