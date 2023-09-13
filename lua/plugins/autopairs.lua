local M = {
	"windwp/nvim-autopairs",
  cond = not vim.g.vscode,
	event = "InsertEnter",
	opts = {}, -- this is equalent to setup({}) function
}

return M
