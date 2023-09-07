local M = {
  "stevearc/oil.nvim",
  opts = {},
  cond = not vim.g.vscode,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      float = {
        padding = 0,
        max_width = 70,
        max_height = 20,
        win_options = {
          winblend = 0,
        },
      },
    })
    vim.keymap.set({ "n" }, "<leader>fe", function()
      require("oil").toggle_float()
    end, { desc = "[f]ile [e]xplorer" })
  end,
}

return M
