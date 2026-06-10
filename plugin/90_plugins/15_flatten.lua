vim.pack.add { 'https://github.com/willothy/flatten.nvim' }

Config.now(function()
    require('flatten').setup {
        hooks = {
            post_open = function(opts)
                -- gitcommit/gitrebase 写入后自动关闭 buffer
                if opts.filetype == 'gitcommit' or opts.filetype == 'gitrebase' then
                    vim.api.nvim_create_autocmd('BufWritePost', {
                        buffer = opts.bufnr,
                        once = true,
                        callback = function()
                            vim.defer_fn(function() pcall(vim.api.nvim_buf_delete, opts.bufnr, {}) end, 50)
                        end,
                    })
                end
            end,
        },
    }
end)
