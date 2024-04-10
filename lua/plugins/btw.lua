local M = {
  "letieu/btw.nvim",
  cond = not vim.g.vscode,
  config = function ()
    require('btw').setup()
  end
}

return M
