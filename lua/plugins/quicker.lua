return {
  'stevearc/quicker.nvim',
  ft = "qf",
  keys = {
      {'<leader>c', [[<cmd>lua require("quicker").toggle()<cr>]], mode = 'n', desc = 'Quicker'},
  },
  opts = {},
}
