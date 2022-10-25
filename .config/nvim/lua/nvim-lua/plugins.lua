--If I save plugins.lua file then run PackerSync
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

--Plugins {{{
return require("packer").startup(function(use)
    -- Packer can manage Packer?!
    use "wbthomason/packer.nvim"
    use "nvim-lua/popup.nvim"

    -- colorscheme of choice
    use "Mofiqul/dracula.nvim"
    use "folke/tokyonight.nvim"

    --nvim completions
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lsp"

    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"

    -- Fuzzy File Finder
    use({
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    -- Git integration
    use "lewis6991/gitsigns.nvim"

    -- LSP
    use "neovim/nvim-lspconfig"

    use "williamboman/nvim-lsp-installer"

    --Tree Sitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

    -- Misc
    use "chrisbra/Colorizer"
    use "godlygeek/tabular"
    use({
        "terrortylor/nvim-comment",
        config = function()
            require("nvim_comment").setup({
                comment_empty = false,
            })
        end,
    })
    use({
        "lewis6991/spellsitter.nvim",
        config = function()
            require("spellsitter").setup()
        end,
    })
    use "gpanders/editorconfig.nvim"
    --Quality of Life
    use "sbdchd/neoformat"

    use({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end,
    })

    -- some fun
    use "nvim-treesitter/playground"
end)
-- }}}
