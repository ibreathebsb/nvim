local M = {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({
			defaults = {
				layout_config = {
					horizontal = { width = 0.5 },
				},
			},
		})
	end,
}

return M
