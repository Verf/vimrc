vim.pack.add { 'https://github.com/Verf/shapeim.nvim' }

Config.now(
    function()
        require('shapeim').setup {
            dict_path = '~/AppData/Roaming/Rime/wubi986n.dict.yaml',
            toggle_key = '<C-\\>',
            persist_state = true,
        }
    end
)
