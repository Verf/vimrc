return {
    'dmtrKovalenko/fff.nvim',
    enabled = false,
    build = function() require('fff.download').download_or_build_binary() end,
    keys = {
        { '<leader>ff', [[<cmd>lua require('fff').find_files()<cr>]], mode = 'n', desc = 'Find Files' },
        { '<leader>fg', [[<cmd>lua require('fff').live_grep()<cr>]], mode = 'n', desc = 'Live Grep' },
    },
    lazy = false,
    opts = {

        prompt = '❯ ',
        grep = { modes = { 'plain', 'regex' } },
    },
}
