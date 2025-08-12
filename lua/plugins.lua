return require('packer').startup(function(use)
    use 'Mofiqul/vscode.nvim'
    use 'catppuccin/nvim'
    use 'EdenEast/nightfox.nvim'
    use 'sainnhe/everforest'
    use 'savq/melange-nvim'
    use 'RRethy/base16-nvim'
    use 'metalelf0/black-metal-theme-neovim'
    use 'slugbyte/lackluster.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim', opt = false},
            {'nvim-telescope/telescope-fzf-native.nvim', opt = true},
            {'nvim-telescope/telescope-ui-select.nvim', opt = true},
        }
    }

    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
end)
