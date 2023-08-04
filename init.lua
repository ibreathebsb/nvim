local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("custom")

local isNativeNvim = not vim.g.vscode

require("lazy").setup({{
    "folke/tokyonight.nvim",
    lazy = false,
    enabled = isNativeNvim,
    priority = 1000,
    opts = {},
    config = function()
        if not vim.g.vscode then
            require('tokyonight').setup({})
            vim.cmd('colorscheme tokyonight-night')
        end
    end
}, -- {
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
    enabled = isNativeNvim,
    config = function()
        require("better_escape").setup()
    end
}, {
    "nvim-treesitter/nvim-treesitter",
    enabled = isNativeNvim,
    build = ":TSUpdate"
}, -- lsp-zero
-- https://github.com/VonHeikemen/lsp-zero.nvim#keybindings
{
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    enabled = isNativeNvim,
    dependencies = { -- LSP Support
    {'neovim/nvim-lspconfig'}, -- Required
    { -- Optional
        'williamboman/mason.nvim',
        build = function()
            pcall(vim.cmd, 'MasonUpdate')
        end
    }, {'williamboman/mason-lspconfig.nvim'}, -- Optional
    -- Autocompletion
    {'hrsh7th/nvim-cmp'}, -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {
        'L3MON4D3/LuaSnip',
        dependencies = {"rafamadriz/friendly-snippets"}
    }, -- Required
    {'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-path'}, {'saadparwaiz1/cmp_luasnip'}, {'jose-elias-alvarez/null-ls.nvim'},
    {'nvim-lua/plenary.nvim'}, {'onsails/lspkind.nvim'}},

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

        -- local null_ls = require('null-ls')

        -- null_ls.setup({
        --     sources = { -- Replace these with the tools you want to install
        --     -- make sure the source name is supported by null-ls
        --     -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
        --     null_ls.builtins.formatting.prettier}
        -- })
        if isNativeNvim then
            local cmp = require('cmp')
            local cmp_action = require('lsp-zero').cmp_action()

            require('luasnip.loaders.from_vscode').lazy_load()
            cmp.setup({
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                formatting = {
                    fields = {'abbr', 'kind', 'menu'},
                    format = require('lspkind').cmp_format({
                        mode = 'symbol', -- show only symbol annotations
                        maxwidth = 50, -- prevent the popup from showing more than provided characters
                        ellipsis_char = '...' -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                    })
                },
                sources = {{
                    name = 'nvim_lsp'
                }, {
                    name = 'buffer'
                }, {
                    name = 'path'
                }, {
                    name = 'luasnip'
                }},
                mapping = {
                    ['<Tab>'] = cmp_action.tab_complete(),
                    ['<CR>'] = cmp.mapping.confirm({
                        select = false
                    })
                    -- ['<S-Tab>'] = cmp_action.select_prev_or_fallback()
                }
            })
        end
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
    enabled = isNativeNvim,
    -- optional for icon support
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
            winopts = {
                width = 0.5,
                preview = {
                    hidden = "hidden"
                }
            },
            files = {
                file_ignore_patterns = {"node_modules"}
            }
        })
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
