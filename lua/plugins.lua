local packer = nil
local function init()
    if packer == nil then
        packer = require('packer')
        packer.init({
            disable_commands = true
        })
    end

    local use = packer.use
    packer.reset()

    use {
        'wbthomason/packer.nvim',
        opt = true
    }

    use 'tpope/vim-repeat'

    use 'cohama/lexima.vim'

    use 'Verf/vim-surround'

    use 'sheerun/vim-polyglot'

    use {
        'chaoren/vim-wordmotion',
        config = [[require('configs.wordmotion')]]
    }

    use {'junegunn/vim-easy-align', config=[[require('configs.easyalign')]]}

    use 'farmergreg/vim-lastplace'

    use {
        'mhinz/vim-sayonara',
        config = [[require('configs.sayonara')]]
    }

    use {
        'sainnhe/sonokai',
        setup = function()
            vim.g.sonokai_style = 'andromeda'
            vim.g.sonokai_enable_italic = 0
            vim.g.sonokai_disable_italic_comment = 0
        end,
        config = function ()
            vim.cmd 'packadd sonokai'
            vim.cmd 'colorscheme sonokai'
        end
    }

    use {
        'easymotion/vim-easymotion',
        config = [[require('configs.easymotion')]]
    }

    use {
        'mg979/vim-visual-multi',
        config = [[require('configs.visualmulti')]]
    }
    use {
        'scrooloose/nerdcommenter',
        config = [[require('configs.nerdcommenter')]]
    }
    use {
        'mhartington/formatter.nvim',
        config = [[require('configs.formatter')]]
    }

    use {
        '907th/vim-auto-save',
        config = function()
            vim.g.auto_save = 1
            vim.g.auto_save_silent = 0
        end
    }

    use {
        'airblade/vim-rooter',
        config = function()
            vim.g.rooter_silent_chdir = 1
            vim.g.rooter_patterns = {'.git', '.gitignore', '.project', 'pom.xml', 'setup.py'}
        end
    }

    use {
        'liuchengxu/vista.vim',
        config = [[require('configs.vista')]]
    }

    use {
        'simnalamburt/vim-mundo',
        config = [[require('configs.mundo')]]
    }

    use {
        'voldikss/vim-floaterm',
        config = [[require('configs.floaterm')]]
    }

    use {
        'hrsh7th/vim-vsnip',
        config = [[require('configs.vsnip')]]
    }

    use {
        'plasticboy/vim-markdown',
        config = [[require('configs.markdown')]]
    }

    use {
        'hoob3rt/lualine.nvim',
        config = [[require('configs.lualine')]]
    }

    use {
        'Yggdroot/LeaderF',
        config = [[require('configs.leaderf')]]
    }

    use {
        'akinsho/nvim-bufferline.lua',
        config = [[require('configs.bufferline')]]
    }

    use {
        'kyazdani42/nvim-web-devicons',
        config = function()
            require'nvim-web-devicons'.setup {
                default = true
            }
        end
    }

    use {
        'hrsh7th/nvim-compe',
        config = [[require('configs.compe')]]
    }

    use {
        'neovim/nvim-lspconfig',
        config = [[require('configs.lsp')]],
        requires = {'glepnir/lspsaga.nvim', 'onsails/lspkind-nvim'}
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        config = [[require('configs.treesitter')]],
        requires = {'nvim-treesitter/nvim-treesitter-textobjects'}
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        branch = 'lua'
    }

    use {
        'bfredl/nvim-miniyank',
        config = [[require('configs.miniyank')]]
    }
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end
})

return plugins
