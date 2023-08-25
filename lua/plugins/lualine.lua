local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cond = not vim.g.vscode,
	config = function()
		require("lualine").setup()
	end,
}

return M
