local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",                                                                              -- latest stable release
            lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("settings")

require("lazy").setup({ {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- load the colorscheme here
        if vim.g.vscode then
            -- VSCode extension
        else
            -- ordinary Neovim
            require("tokyonight").setup({
                style = "storm"
            })
            vim.cmd([[colorscheme tokyonight]])
        end
    end
}, -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    }, -- lsp-zero
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {       -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                  -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end
            }, { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },           -- Required
            { 'hrsh7th/cmp-nvim-lsp' },       -- Required
            { 'L3MON4D3/LuaSnip' },           -- Required
            { 'jose-elias-alvarez/null-ls.nvim' }, { 'nvim-lua/plenary.nvim' } },
        config = function()
            local lsp = require('lsp-zero').preset({})

            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({
                    buffer = bufnr
                })
            end)

            -- (Optional) Configure lua language server for neovim
            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

            lsp.setup()

            -- setup null-ls

            local null_ls = require('null-ls')

            null_ls.setup({
                sources = { -- Replace these with the tools you want to install
                    -- make sure the source name is supported by null-ls
                    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
                    null_ls.builtins.formatting.prettier }
            })
        end
    }, {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    opts = {}
}, {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end
}, {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({})
    end
}, {
    -- https://github.com/numToStr/Comment.nvim
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end

}, {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {},
    keys = { {
        "s",
        mode = { "n", "x", "o" },
        function()
            require("flash").jump()
        end,
        desc = "Flash"
    }, {
        "S",
        mode = { "n", "o", "x" },
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
        mode = { "o", "x" },
        function()
            require("flash").treesitter_search()
        end,
        desc = "Treesitter Search"
    } }
} })
