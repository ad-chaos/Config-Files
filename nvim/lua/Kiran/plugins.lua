--If I save plugins.lua file then run PackerSync
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

--Plugins
return require('packer').startup(function(use)

    -- Packer and manage Packer?!
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/popup.nvim'

    -- colorscheme of choice
    use 'folke/tokyonight.nvim'

    --nvim completions
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp'

    use {
      'nvim-telescope/telescope.nvim',
      requires = {'nvim-lua/plenary.nvim'}
    }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

    --Tree Sitter
    use {'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate",
    }

    --Quality of Life
    use {'pboettch/vim-cmake-syntax', opt = true, ft = {'cmake'}}
    use 'sbdchd/neoformat'
    use 'tpope/vim-surround'
end)
