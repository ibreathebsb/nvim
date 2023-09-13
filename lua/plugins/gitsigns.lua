local M = {
	"lewis6991/gitsigns.nvim",
  cond = not vim.g.vscode,
	config = function()
		require("gitsigns").setup()
	end,
}

return M
