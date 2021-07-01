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

    use 'Raimondi/delimitMate'

    use 'Verf/vim-surround'

    use 'mhinz/vim-sayonara'

    use 'farmergreg/vim-lastplace'

    use 'junegunn/vim-easy-align'

    use 'svermeulen/vim-yoink'

    use 'ggandor/lightspeed.nvim'

    use {
        '907th/vim-auto-save',
        config = function()
            vim.g.auto_save = 1
            vim.g.auto_save_silent = 1
            vim.g.auto_save_events = {"InsertLeave", "TextChanged"}
        end
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        branch = 'lua',
    }

    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup{
                'lua';
                'css';
                'javascript';
            }
        end,
        ft = {"lua", "css", "javascript"}
    }

    use {
        'chaoren/vim-wordmotion',
        config = function()
            vim.g.wordmotion_nomap = 1
        end
    }

    use {
        'folke/tokyonight.nvim',
        config = function()
            vim.cmd 'colorscheme tokyonight'
        end
    }

    use {
        'mg979/vim-visual-multi',
        config = function()
            vim.g.VM_maps = {
                ['Find Under']         = '<C-s>',
                ['Find Subword Under'] = '<C-s>',
                ['Add Cursor Down']    = '<M-Down>',
                ['Add Cursor Up']      = '<M-Up>',
                ['Find Next']          = '<C-s>',
                ['Find Prev']          = '<C-S-s>',
                ['Goto Next']          = ']',
                ['Goto Prev']          = '[',
                ['Seek Next']          = '<C-f>',
                ['Seek Prev']          = '<C-b>',
                ['Skip Region']        = '<C-x>',
                ['Remove Region']      = '<C-S-x>',
                ['Replace']            = 'R',
                ['Surround']           = 'S',
                ['Toggle Multiline']   = 'M',
            }
        end
    }

    use {
        'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup()
        end
    }

    use {
        'airblade/vim-rooter',
        config = function()
            vim.g.rooter_silent_chdir = 1
            vim.g.rooter_patterns = {'.git', '.project'}
        end
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
        'hrsh7th/vim-vsnip',
        config = function()
            vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/vsnip'
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        config = [[require('configs.search')]],
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
        }
    }

    use {
        'glepnir/galaxyline.nvim',
        config = [[require('configs.statusline')]]
    }

    use {
        'akinsho/nvim-bufferline.lua',
        config = [[require('configs.bufferline')]]
    }

    use {
        'hrsh7th/nvim-compe',
        config = [[require('configs.completion')]]
    }

    use {
        'mhartington/formatter.nvim',
        config = [[require('configs.formatter')]]
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        config = [[require('configs.treesitter')]],
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'p00f/nvim-ts-rainbow'
        }
    }

    use {
        'neovim/nvim-lspconfig',
        config = [[require('configs.lsp')]],
        requires = {
            'glepnir/lspsaga.nvim',
            'onsails/lspkind-nvim',
            'ray-x/lsp_signature.nvim',
        }
    }

    use {
        'simnalamburt/vim-mundo',
        config = [[require('configs.mundo')]]
    }

end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end
})

return plugins
