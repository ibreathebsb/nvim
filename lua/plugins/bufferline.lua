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
    -- keymap
    vim.keymap.set({ "n" }, "<leader><Tab>", function()
      require("bufferline").cycle(1)
    end, { desc = "swith to next tab" })

    vim.keymap.set({ "n" }, "<leader>1", function()
      require("bufferline").go_to(1, true)
    end, { desc = "swith to first tab" })

    vim.keymap.set({ "n" }, "<leader>$", function()
      require("bufferline").go_to(-1, true)
    end, { desc = "swith to last tab" })

    -- keys = {
    --   {
    --     "<leader><Tab>",
    --     function()
    --       require("bufferline").cycle(1)
    --     end,
    --     desc = "swith to next tab",
    --   },
    --   {
    --     "<leader>1",
    --     function()
    --       require("bufferline").go_to(1)
    --     end,
    --     desc = "switch to buffer 1",
    --   },
    --   {
    --     "<leader>2",
    --     function()
    --       require("bufferline").go_to(2)
    --     end,
    --     desc = "switch to buffer 2",
    --   },
    --   {
    --     "<leader>3",
    --     function()
    --       require("bufferline").go_to(3)
    --     end,
    --     desc = "switch to buffer 3",
    --   },
    --   {
    --     "<leader>4",
    --     function()
    --       require("bufferline").go_to(4)
    --     end,
    --     desc = "switch to buffer 4",
    --   },
    --   {
    --     "<leader>5",
    --     function()
    --       require("bufferline").go_to(5)
    --     end,
    --     desc = "switch to buffer 5",
    --   },
    --   {
    --     "<leader>6",
    --     function()
    --       require("bufferline").go_to(6)
    --     end,
    --     desc = "switch to buffer 6",
    --   },
    --   {
    --     "<leader>6",
    --     function()
    --       require("bufferline").go_to(6)
    --     end,
    --     desc = "switch to buffer 6",
    --   },
    --   {
    --     "<leader>7",
    --     function()
    --       require("bufferline").go_to(7)
    --     end,
    --     desc = "switch to buffer 7",
    --   },
    --   {
    --     "<leader>8",
    --     function()
    --       require("bufferline").go_to(8)
    --     end,
    --     desc = "switch to buffer 8",
    --   },
    --   {
    --     "<leader>9",
    --     function()
    --       require("bufferline").go_to(9)
    --     end,
    --     desc = "switch to buffer 9",
    --   },
    -- },
  end,
}
return M
