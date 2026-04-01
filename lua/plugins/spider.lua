return {
    'chrisgrieser/nvim-spider',
    keys = {
        { 'w', [[<cmd>lua require('spider').motion('w')<cr>]], mode = { 'n', 'o', 'x' } },
        { 'd', [[<cmd>lua require('spider').motion('e')<cr>]], mode = { 'n', 'o', 'x' } },
        { 'b', [[<cmd>lua require('spider').motion('b')<cr>]], mode = { 'n', 'o', 'x' } },
    },
}
