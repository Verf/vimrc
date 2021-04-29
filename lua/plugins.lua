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

    use 'farmergreg/vim-lastplace'

    use {
        'chaoren/vim-wordmotion',
        config = [[require('configs.wordmotion')]]
    }

    use {
        'junegunn/vim-easy-align',
        config=[[require('configs.easyalign')]]
    }

    use {
        'mhinz/vim-sayonara',
        config = [[require('configs.sayonara')]]
    }

    use {
        'Th3Whit3Wolf/one-nvim',
        config = [[vim.cmd 'colorscheme one-nvim']]
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
        'terrortylor/nvim-comment',
        config = [[require('configs.comment')]]
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
        requires = {
            'glepnir/lspsaga.nvim',
            'onsails/lspkind-nvim',
            'ray-x/lsp_signature.nvim',
            'folke/lsp-trouble.nvim'
        }
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

    use {
        'nvim-telescope/telescope.nvim',
        config = [[require('configs.telescope')]],
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim'
        }
    }

    use {
        'tamago324/lir.nvim',
        config = [[require('configs.filetree')]],
        requires = {'nvim-lua/plenary.nvim'}
    }

    use {
        'ludovicchabant/vim-gutentags',
        config = [[require('configs.tags')]]
    }
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end
})

return plugins
