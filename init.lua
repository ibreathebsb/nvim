local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("custom")

require("lazy").setup({
	{ "nvim-tree/nvim-web-devicons" },
	{
		"projekt0n/github-nvim-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
	  enabled = vim.g.vscode == nil,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			print(1111)
			require("github-theme").setup({})
			vim.cmd("colorscheme github_dark")
		end,
	},
	-- {
	--     'kevinhwang91/nvim-ufo',
	--     dependencies = {
	--         "kevinhwang91/promise-async"
	--     },
	--     config = function()
	--         require('ufo').setup()
	--     end
	-- },
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
				},
				ensure_installed = { "javascript", "typescript", "tsx", "css", "json", "lua" },
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
						},
					},
				},
			})
		end,
	}, -- lsp-zero
	-- https://github.com/VonHeikemen/lsp-zero.nvim#keybindings
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
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
	},
	{
		"m4xshen/hardtime.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		-- https://github.com/numToStr/Comment.nvim
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		vscode = true,
		opts = {},
		keys = {},
	},
})
