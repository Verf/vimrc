local utils = require "utils"
local packer = nil
local function init()
    if packer == nil then
        packer = require('packer')
        packer.init({
            compile_path = vim.fn.stdpath('config') .. '/packer_compiled.vim',
            disable_commands = true
        })
    end

    local use = packer.use
    packer.reset()

    use {'wbthomason/packer.nvim', opt = true}

    use {
        'sainnhe/sonokai',
        setup = function()
            vim.g.sonokai_style = 'andromeda'
            vim.g.sonokai_enable_italic = 0
            vim.g.sonokai_disable_italic_comment = 0
        end
    }
    use 'sheerun/vim-polyglot'

    use 'cohama/lexima.vim'
    use 'Verf/vim-surround'
    use 'easymotion/vim-easymotion'
    use 'mg979/vim-visual-multi'
    use 'junegunn/vim-easy-align'
    use 'scrooloose/nerdcommenter'
    use 'sbdchd/neoformat'

    use 'tpope/vim-repeat'
    use '907th/vim-auto-save'
    use 'farmergreg/vim-lastplace'
    use 'airblade/vim-rooter'

    use {'liuchengxu/vista.vim', config = [[require('configs.vista)]]}
    use {'simnalamburt/vim-mundo', config = [[require('configs.mundo')]]}
    use {'voldikss/vim-floaterm', config = [[require('configs.floaterm')]]}

    use 'ervandew/supertab'
    use 'SirVer/ultisnips'

    use 'plasticboy/vim-markdown'

end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end
})

return plugins
