local M = {
  "akinsho/bufferline.nvim",
  cond = not vim.g.vscode,
  config = function()
    require("bufferline").setup({
      options = {
        numbers = "ordinal",
        indicator = {
          style = "underline",
        },
      },
    })
  end,
  keys = {
    {
      "<leader>1",
      function()
        require("bufferline").go_to(1)
      end,
      desc = "switch to buffer 1",
    },
    {
      "<leader>2",
      function()
        require("bufferline").go_to(2)
      end,
      desc = "switch to buffer 2",
    },
    {
      "<leader>3",
      function()
        require("bufferline").go_to(3)
      end,
      desc = "switch to buffer 3",
    },
    {
      "<leader>4",
      function()
        require("bufferline").go_to(4)
      end,
      desc = "switch to buffer 4",
    },
    {
      "<leader>5",
      function()
        require("bufferline").go_to(5)
      end,
      desc = "switch to buffer 5",
    },
  },
}
return M