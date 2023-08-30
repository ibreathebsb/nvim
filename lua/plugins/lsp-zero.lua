local M = {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	cond = false,
	dependencies = { -- LSP Support
		{ "neovim/nvim-lspconfig" }, -- Required
		{ -- Optional
			"williamboman/mason.nvim",
			build = function()
				pcall(vim.cmd, "MasonUpdate")
			end,
		},
		{ "williamboman/mason-lspconfig.nvim" }, -- Optional
		-- Autocompletion
		{ "hrsh7th/nvim-cmp" }, -- Required
		{ "hrsh7th/cmp-nvim-lsp" }, -- Required
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
		}, -- Required
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "jose-elias-alvarez/null-ls.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "onsails/lspkind.nvim" },
	},

	config = function()
		local lsp = require("lsp-zero").preset({})

		lsp.on_attach(function(client, bufnr)
			lsp.default_keymaps({
				buffer = bufnr,
			})
		end)

		-- (Optional) Configure lua language server for neovim
		require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

		lsp.setup()

		local cmp = require("cmp")
		local cmp_action = require("lsp-zero").cmp_action()

		require("luasnip.loaders.from_vscode").lazy_load()
		cmp.setup({
			preselect = "item",
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = require("lspkind").cmp_format({
					mode = "symbol", -- show only symbol annotations
					maxwidth = 50, -- prevent the popup from showing more than provided characters
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
				}),
			},
			sources = {
				{
					name = "nvim_lsp",
				},
				{
					name = "buffer",
				},
				{
					name = "path",
				},
				{
					name = "luasnip",
				},
			},
			mapping = {
				["<Tab>"] = cmp_action.tab_complete(),
				["<CR>"] = cmp.mapping.confirm({
					select = false,
				}),
				-- ['<S-Tab>'] = cmp_action.select_prev_or_fallback()
			},
		})

		-- setup null-ls

		local null_ls = require("null-ls")

		null_ls.setup({
			sources = { -- Replace these with the tools you want to install
				-- make sure the source name is supported by null-ls
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
				-- https://github.com/JohnnyMorganz/StyLua
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
			},
		})
	end,
}

return M
