local M = {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	cond = not vim.g.vscode,
	config = function()
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})
	end,
}

return M
