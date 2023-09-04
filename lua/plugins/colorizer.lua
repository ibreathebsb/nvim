local M = {
  "norcalli/nvim-colorizer.lua",
  cond = not vim.g.vscode,
  config = function()
    require("colorizer").setup()
  end,
}
return M
