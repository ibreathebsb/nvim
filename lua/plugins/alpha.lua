local M = {
	"goolord/alpha-nvim",
	config = function()
		require("alpha").setup(require("alpha.themes.dashboard").config)
	end,
	-- TODO: enable
	cond = false, -- not vim.g.vscode,
}
return M
