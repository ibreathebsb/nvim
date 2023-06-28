local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

require("settings")

require("lazy").setup(
    {
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                -- load the colorscheme here
                require("tokyonight").setup(
                    {
                        style = "storm"
                    }
                )
                vim.cmd([[colorscheme tokyonight]])
            end
        }, -- treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate"
        }, -- lsp-zero
        {
            "VonHeikemen/lsp-zero.nvim",
            branch = "v2.x",
            lazy = true,
            config = function()
                -- This is where you modify the settings for lsp-zero
                -- Note: autocompletion settings will not take effect

                require("lsp-zero.settings").preset({})
            end
        }, -- Autocompletion
        {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            dependencies = {{"L3MON4D3/LuaSnip"}},
            config = function()
                -- Here is where you configure the autocompletion settings.
                -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
                -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

                require("lsp-zero.cmp").extend()

                -- And you can configure cmp even more, if you want to.
                local cmp = require("cmp")
                local cmp_action = require("lsp-zero.cmp").action()

                cmp.setup(
                    {
                        mapping = {
                            ["<C-Space>"] = cmp.mapping.complete(),
                            ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                            ["<C-b>"] = cmp_action.luasnip_jump_backward()
                        }
                    }
                )
            end
        }, -- LSP
        {
            "neovim/nvim-lspconfig",
            cmd = "LspInfo",
            event = {"BufReadPre", "BufNewFile"},
            dependencies = {
                {"hrsh7th/cmp-nvim-lsp"},
                {"williamboman/mason-lspconfig.nvim"},
                {
                    "williamboman/mason.nvim",
                    build = function()
                        pcall(vim.cmd, "MasonUpdate")
                    end
                }
            },
            config = function()
                -- This is where all the LSP shenanigans will live

                local lsp = require("lsp-zero")

                lsp.on_attach(
                    function(client, bufnr)
                        lsp.default_keymaps(
                            {
                                buffer = bufnr
                            }
                        )
                    end
                )

                -- (Optional) Configure lua language server for neovim
                require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

                lsp.setup()
            end
        },
        {
            "m4xshen/hardtime.nvim",
            event = "VeryLazy",
            opts = {}
        },
        {
            "kylechui/nvim-surround",
            version = "*", -- Use for stability; omit to use `main` branch for the latest features
            event = "VeryLazy",
            config = function()
                require("nvim-surround").setup({})
            end
        },
        {
            "folke/flash.nvim",
            event = "VeryLazy",
            vscode = true,
            ---@type Flash.Config
            opts = {},
            keys = {
                {
                    "s",
                    mode = {"n", "x", "o"},
                    function()
                        require("flash").jump()
                    end,
                    desc = "Flash"
                },
                {
                    "S",
                    mode = {"n", "o", "x"},
                    function()
                        require("flash").treesitter()
                    end,
                    desc = "Flash Treesitter"
                },
                {
                    "r",
                    mode = "o",
                    function()
                        require("flash").remote()
                    end,
                    desc = "Remote Flash"
                },
                {
                    "R",
                    mode = {"o", "x"},
                    function()
                        require("flash").treesitter_search()
                    end,
                    desc = "Treesitter Search"
                }
            }
        }
    }
)
