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

		local builtin = require("telescope.builtin")

		-- open files
		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({ previewer = false })
		end, { silent = true, desc = "[F]ind [F]iles" })

		-- open buffers
		vim.keymap.set("n", "<leader>fb", function()
			builtin.buffers({ previewer = false })
		end, { silent = true, desc = "[F]ind [B]uffers" })

		-- live_grep
		vim.keymap.set("n", "<leader>fg", function()
			builtin.live_grep({ previewer = false })
		end, { silent = true, desc = "[F]ind [G]rep" })

		-- recent files
		vim.keymap.set("n", "<leader>fr", function()
			builtin.oldfiles({ previewer = false })
		end, { silent = true, desc = "[F]ind [R]ecent Files" })

		-- keymaps
		vim.keymap.set("n", "<leader>fk", function()
			builtin.keymaps({ previewer = false })
		end, { silent = true, desc = "[F]ind [K]eymaps" })
	end,
}

return M
