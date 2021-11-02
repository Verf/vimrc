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

    -- themes
    use 'ishan9299/nvim-solarized-lua'

    -- ui
    use 'yamatsum/nvim-cursorline'

    use {
        'kyazdani42/nvim-web-devicons',
        module = 'nvim-web-devicons'
    }

    use {
        "projekt0n/circles.nvim",
        module = 'circles',
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    use {
        'rcarriga/nvim-notify',
        config = function ()
            require('notify').setup({
                stages = "fade",
                timeout = 5000,
            })
            vim.notify = require('notify')
        end
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        events = 'BufRead',
        config = function ()
            vim.g.indent_blankline_show_current_context = false
            vim.g.indent_blankline_buftype_exclude = {"terminal", 'NvimTree', 'NeogitStatus'}
            vim.g.indent_blankline_filetype_exclude = {'help', 'conf', 'txt'}
        end
    }

    use {
        'norcalli/nvim-colorizer.lua',
        config = function ()
            require 'colorizer'.setup{
                'lua',
                'css',
                'javascript',
                'typescript',
                'vue',
                'html',
            }
        end,
        ft = {
            'lua',
            'css',
            'javascript',
            'typescript',
            'vue',
            'html'
        }
    }

    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function ()
            require('todo-comments').setup {
                search = {
                    pattern = [[\b(KEYWORDS)\b]],
                }
            }
        end,
        ft = {'python', 'java', 'vue', 'html', 'javascript', 'sh', 'ps1'}
    }

    use {
        'nvim-lualine/lualine.nvim',
        config = [[require('configs.statusline')]]
    }

    use {
        'akinsho/nvim-bufferline.lua',
        config = [[require('configs.bufferline')]]
    }

    -- edit
    use 'windwp/nvim-autopairs'

    use {
        'junegunn/vim-easy-align',
        keys = "<Plug>(EasyAlign)"
    }

    use {
        'L3MON4D3/LuaSnip',
        config = function ()
            require('luasnip.loaders.from_vscode').lazy_load {
                paths = vim.fn.stdpath('config') .. "/vsnip",
            }
        end,
        events = 'InsertEnter'
    }

    use {
        'hrsh7th/nvim-cmp',
        config = [[require('configs.completion')]],
        events = 'InsertEnter',
        requires = {
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
        }
    }

    use {
        'blackCauldron7/surround.nvim',
        config = function ()
            require'surround'.setup{
                brackets = {"(", "{", "[", "<"},
                load_keymaps = false,
                map_insert_mode = false,
            }
        end,
        keys = {
            {'n', 's'}
        }
    }

    use {
        'abecodes/tabout.nvim',
        config = function ()
            require'tabout'.setup{
                tabkey = '',
                backwards_tabkey = '',
            }
        end,
        events = 'InsertEnter'
    }

    use {
        'terrortylor/nvim-comment',
        config = function ()
            require('nvim_comment').setup()
        end,
        ft = {'python', 'java', 'vue', 'html', 'javascript', 'lua', 'sh', 'ps1'}
    }

    use {
        'mg979/vim-visual-multi',
        config = function ()
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
        end,
        keys = {
            {'n', '<C-s>'}
        }
    }

    -- enhance
    use 'nathom/filetype.nvim'

    use {
        'nvim-lua/plenary.nvim',
        module = "plenary"
    }
    use {
        'mhinz/vim-sayonara',
        cmd = 'Sayonara'
    }

    use {
        'chaoren/vim-wordmotion',
        config = function ()
            vim.g.wordmotion_nomap = 1
        end
    }

    use {
        'andymass/vim-matchup',
        config = function ()
            vim.cmd [[xmap r% <Plug>(matchup-i%)]]
            vim.g.matchup_matchparen_offscreen = {
                method = 'popup'
            }
        end
    }

    use {
        'phaazon/hop.nvim',
        config = function ()
            require'hop'.setup { keys = 'tfvnumdecriwsxloqazh' }
        end,
        cmd = {
            'HopWord',
            'HopLine',
            'HopChar2',
        }
    }

    use {
        'ethanholz/nvim-lastplace',
        config = function ()
            require'nvim-lastplace'.setup {
                lastplace_ignore_buftype = {'quickfix', 'nofile', 'help'},
                lastplace_ignore_filetype = {'gitcommit', 'gitrebase', 'svn', 'hgcommit'},
                lastplace_open_folds = true
            }
        end
    }

    use {
        'Pocco81/AutoSave.nvim',
        config = function ()
            require'autosave'.setup(
                {
                    enabled = true,
                    execution_message = '',
                    events = {'InsertLeave', 'TextChanged'},
                    conditions = {
                        exists = true,
                        filetype_is_not = {},
                        modifiable = true
                    },
                    write_all_buffers = true,
                    on_off_commands = true,
                    clean_command_line_interval = 0,
                    debounce_delay = 135
                }
            )
        end
    }

    use {
        'ahmedkhalf/project.nvim',
        config = function ()
            require'project_nvim'.setup{
                patterns = { '.git', '.root', '.project', '.svn', 'make*', 'pom.xml' }
            }
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        config = function ()
            require('telescope').setup{
                defaults = {
                    borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                },
            }
            require'telescope'.load_extension('projects')
        end,
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
        }
    }

    -- integration
    use {
        'TimUntersberger/neogit',
        config = function ()
            require'neogit'.setup({
                disable_signs = false,
                disable_context_highlighting = true,
                integrations = {
                    diffview = true,
                },
            })
        end,
        cmd = {'Neogit'},
        requires = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim'
        },
    }

    use {
        'sindrets/diffview.nvim',
        module = 'diffview',
        cmd = {'DiffviewOpen', 'DiffviewToggleFiles'}
    }

    use {
        'lewis6991/gitsigns.nvim',
        events = 'BufRead',
        config = function ()
            require'gitsigns'.setup()
        end,
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    use {
        'mfussenegger/nvim-dap',
        requires = {'mfussenegger/nvim-dap-python', 'rcarriga/nvim-dap-ui'},
        config = function ()
            require'dapui'.setup()
            require'dap-python'.setup('python')
        end,
        ft = {'python'}
    }

    use {
        'mhartington/formatter.nvim',
        config = [[require('configs.formatter')]],
        ft = {
            'python',
            'json',
            'javascript',
            'typescript',
            'css',
            'html',
            'vue',
        }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = [[require('configs.treesitter')]],
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'RRethy/nvim-treesitter-textsubjects',
            'p00f/nvim-ts-rainbow',
            'windwp/nvim-ts-autotag'
        }
    }

    use {
        'neovim/nvim-lspconfig',
        config = [[require('configs.lsp')]],
        requires = {
            'onsails/lspkind-nvim',
            'ray-x/lsp_signature.nvim',
        }
    }

    use {
        'voldikss/vim-floaterm',
        config = function ()
            vim.g.shell = vim.o.shell
            vim.g.floaterm_weight = 0.9
            vim.g.floaterm_height = 0.8
        end,
        cmd = {'FloatermToggle'}
    }

    use {
        'kyazdani42/nvim-tree.lua',
        config = function ()
            vim.g.nvim_tree_show_icons = {
                git = 0,
                folders = 1,
                files = 1,
                folder_arrows = 1,
            }
            require'nvim-tree'.setup()
        end,
        requires = 'kyazdani42/nvim-web-devicons',
        cmd = {
            'NvimTreeToggle',
            'NvimTreeFocus',
            'NvimTreeOpen',
            'NvimTreeRefresh',
            'NvimTreeFindFile',
        }
    }
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end
})

return plugins
