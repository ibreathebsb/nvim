local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    -- Autocompletion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    {
      "L3MON4D3/LuaSnip",
      dependencies = { "rafamadriz/friendly-snippets" },
    },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "onsails/lspkind.nvim" },
  },

  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
      end,
    })

    local lspconfig = require("lspconfig")
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "tsserver",
        "cssls",
        "html",
      },
      automatic_installation = true,
    })
    local luasnip = require("luasnip")
    local cmp = require("cmp")
    require("luasnip.loaders.from_vscode").lazy_load()
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      preselect = "item",
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = require("lspkind").cmp_format({
          mode = "symbol",  -- show only symbol annotations
          maxwidth = 50,    -- prevent the popup from showing more than provided characters
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
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
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

    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
    require("mason-lspconfig").setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = lsp_capabilities,
        })
      end,
    })

    -- fix: Undefined global `vim`
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
  end,
}

return M
