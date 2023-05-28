require("isaac")

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- My plugins here

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    use 'tpope/vim-repeat'

    -- leap.nvim
    use({
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end
    })

    -- flit.nvim
    use({
        'ggandor/flit.nvim',
        config = [[require'flit'.setup { labeled_modes = 'nv' }]]
    })

    if vim.g.vscode then

        -- VSCode extension
    else
        -- ordinary Neovim

        -- tree-sitter
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({
                    with_sync = true
                })
                ts_update()
            end
        }
        -- rose-pine
        use({
            'rose-pine/neovim',
            as = 'rose-pine',
            config = function()
                vim.cmd('colorscheme rose-pine')
            end
        })
        -- VonHeikemen/lsp-zero.nvim
        -- https://github.com/VonHeikemen/lsp-zero.nvim#keybindings-1
        use {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v2.x',
            requires = {
              -- LSP Support
              {'neovim/nvim-lspconfig'},             -- Required
              {                                      -- Optional
                'williamboman/mason.nvim',
                run = function()
                  pcall(vim.cmd, 'MasonUpdate')
                end,
              },
              {'williamboman/mason-lspconfig.nvim'}, -- Optional
          
              -- Autocompletion
              {'hrsh7th/nvim-cmp'},     -- Required
              {'hrsh7th/cmp-nvim-lsp'}, -- Required
              {'L3MON4D3/LuaSnip'},     -- Required
            }
          }
    end

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)

