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

    vim.keymap.set({ "n" }, "<leader>$", function()
      require("bufferline").go_to(-1, true)
    end, { desc = "swith to last tab" })

    -- 1 -> 10
    for i = 1, 10 do
      vim.keymap.set({ "n" }, "<leader>" .. i, function()
        require("bufferline").go_to(i, true)
      end, { desc = "swith to " .. i .. " tab" })
    end
  end,
}
return M
