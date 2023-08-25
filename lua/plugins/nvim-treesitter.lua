local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = vim.g.vscode == nil,
			},
			ensure_installed = { "javascript", "typescript", "tsx", "css", "json", "lua", "html" },
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["ab"] = "@block.outer",
						["ib"] = "@block.inner",
						["am"] = "@comment.outer",
						["im"] = "@comment.inner",
					},
				},
			},
		})
	end,
}

return M
