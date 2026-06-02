vim.pack.add { 'https://github.com/Verf/shapeim.nvim' }

Config.now(
    function()
        require('shapeim').setup {
            dict_path = '~/Syncthing/Config/Rime/wubi986.dict.yaml',
            toggle_key = '<C-\\>',
            persist_state = true,
        }
    end
)
