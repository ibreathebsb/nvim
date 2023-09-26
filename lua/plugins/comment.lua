local M = {
  -- https://github.com/numToStr/Comment.nvim
  "numToStr/Comment.nvim",
  -- cond = not vim.g.vscode,
  config = function()
    require("Comment").setup()
  end,
}

return M
