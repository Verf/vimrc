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

    use 'mhinz/vim-sayonara'

    use 'farmergreg/vim-lastplace'

    use 'junegunn/vim-easy-align'

    use 'bfredl/nvim-miniyank'

    use {
        'lukas-reineke/indent-blankline.nvim',
        branch = 'lua'
    }

    use {
        'AndrewRadev/splitjoin.vim',
        config = function()
            vim.g.splitjoin_split_mapping = ''
            vim.g.splitjoin_join_mapping = ''
        end
    }

    use {
        'chaoren/vim-wordmotion',
        config = function()
            vim.g.wordmotion_nomap = 1
        end
    }

    use {
        'Th3Whit3Wolf/one-nvim',
        config = function()
            vim.cmd 'colorscheme one-nvim'
        end
    }

    use {
        'easymotion/vim-easymotion',
        config = function()
            vim.g.EasyMotion_smartcase = 1
            vim.g.EasyMotion_do_mapping = 0
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
        'ludovicchabant/vim-gutentags',
        config = function()
            vim.g.gutentags_project_root = {'.git', '.project'}
            vim.g.gutentags_cache_dir = vim.fn.stdpath("data") .. '/ctags'
            vim.g.gutentags_generate_on_write = 1
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('telescope').setup()
            require('telescope').load_extension('fzy_native')
        end,
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim',
            'jvgrootveld/telescope-zoxide',
        }
    }

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                show_help = false,
                plugins = {
                    marks = false,
                    registers = false,
                    presets = {
                        operators = false,
                        motions = false,
                        text_objects = false,
                        windows = false,
                        nav = false,
                        z = false,
                        g = false,
                    }
                },
                triggers = {"<leader>"}
            }
        end
    }

    use {
        'plasticboy/vim-markdown',
        config = function()
            vim.cmd 'au FileType markdown map <silent><Plug> <Plug>Markdown_EditUrlUnderCursor'
            vim.cmd 'au FileType markdown map <silent><C-Enter> <Plug>Markdown_EditUrlUnderCursor'
            vim.g.vim_markdown_folding_disabled = 1
        end
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

    -- F1
    use {
        'voldikss/vim-floaterm',
        config = [[require('configs.floaterm')]]
    }

    -- F2
    use {
        'tamago324/lir.nvim',
        config = [[require('configs.filetree')]],
        requires = {'nvim-lua/plenary.nvim'}
    }

    -- F3
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

    -- F4
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
