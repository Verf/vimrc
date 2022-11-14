function _G.print_tb(t)
    local print_r_cache = {}
    local function sub_print_r(t, indent)
        if print_r_cache[tostring(t)] then
            print(indent .. '*' .. tostring(t))
        else
            print_r_cache[tostring(t)] = true
            if type(t) == 'table' then
                for pos, val in pairs(t) do
                    if type(val) == 'table' then
                        print(indent .. '[' .. pos .. '] => ' .. tostring(t) .. ' {')
                        sub_print_r(val, indent .. string.rep(' ', string.len(pos) + 8))
                        print(indent .. string.rep(' ', string.len(pos) + 6) .. '}')
                    elseif type(val) == 'string' then
                        print(indent .. '[' .. pos .. '] => "' .. val .. '"')
                    else
                        print(indent .. '[' .. pos .. '] => ' .. tostring(val))
                    end
                end
            else
                print(indent .. tostring(t))
            end
        end
    end
    if type(t) == 'table' then
        print(tostring(t) .. ' {')
        sub_print_r(t, '  ')
        print '}'
    else
        sub_print_r(t, '  ')
    end
    print()
end

function _G.smart_dd()
    if vim.api.nvim_get_current_line():match("^%s*$") then
        return "\"_dd"
    else
        return "dd"
    end
end

function _G.recompile()
  if vim.bo.buftype == "" then
    if vim.fn.exists ":LspStop" ~= 0 then
      vim.cmd "LspStop"
    end

    for name, _ in pairs(package.loaded) do
      if name:match "^user" then
        package.loaded[name] = nil
      end
    end

    dofile(vim.env.MYVIMRC)
    vim.cmd "PackerCompile"
    vim.notify("Wait for Compile Done", vim.log.levels.INFO)
  else
    vim.notify("Not available in this window/buffer", vim.log.levels.INFO)
  end
end

function _G.visual_at()
    print("@" .. vim.fn.getcmdline())
    vim.fn.execute(":'<,'>normal @" .. vim.fn.nr2char(vim.fn.getchar()))
end
