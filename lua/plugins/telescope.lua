local M = {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.2",
  cond = not vim.g.vscode,
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        layout_config = {
          horizontal = { width = 0.5 },
        },
      },
      pickers = {
        oldfiles = {
          cwd_only = true,
        },
      },
    })

    local builtin = require("telescope.builtin")

    -- open files
    vim.keymap.set("n", "<leader>ff", function()
      builtin.find_files({ previewer = false })
    end, { silent = true, desc = "[f]ind [f]iles" })

    -- open buffers
    vim.keymap.set("n", "<leader>fb", function()
      builtin.buffers({ previewer = false })
    end, { silent = true, desc = "[f]ind [b]uffers" })

    -- live_grep
    vim.keymap.set("n", "<leader>fg", function()
      builtin.live_grep({ previewer = false })
    end, { silent = true, desc = "[f]ind [g]rep" })

    -- recent files
    vim.keymap.set("n", "<leader>fr", function()
      builtin.oldfiles({ previewer = false })
    end, { silent = true, desc = "[f]ind [r]ecent files" })

    -- keymaps
    vim.keymap.set("n", "<leader>fk", function()
      builtin.keymaps({ previewer = false })
    end, { silent = true, desc = "[f]ind [k]eymaps" })

    -- document symbols
    vim.keymap.set("n", "<leader>fs", function()
      builtin.lsp_document_symbols()
    end, { silent = true, desc = "[f]ind [s]ymbols" })

    -- list diagnostics
    vim.keymap.set("n", "<leader>fd", function()
      builtin.diagnostics({ bufnr = 0 })
    end, { silent = true, desc = "[f]ind [d]iagnostics" })
  end,
}

return M
