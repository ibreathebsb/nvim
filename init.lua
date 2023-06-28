local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("settings")

require("lazy").setup({{
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
}, {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {},
    keys = {{
        "s",
        mode = {"n", "x", "o"},
        function()
            require("flash").jump()
        end,
        desc = "Flash"
    }, {
        "S",
        mode = {"n", "o", "x"},
        function()
            require("flash").treesitter()
        end,
        desc = "Flash Treesitter"
    }, {
        "r",
        mode = "o",
        function()
            require("flash").remote()
        end,
        desc = "Remote Flash"
    }, {
        "R",
        mode = {"o", "x"},
        function()
            require("flash").treesitter_search()
        end,
        desc = "Treesitter Search"
    }}
}})

