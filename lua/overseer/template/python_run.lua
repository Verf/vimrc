return {
  name = "Run Current buffer by Python",
  builder = function()
    return {
      cmd = { "python" },
      args = { vim.fn.expand("%:p") },
      cwd = vim.fn.getcwd(),
      components = { "default" },
    }
  end,
  condition = {
    filetype = { "python" },
  },
}
