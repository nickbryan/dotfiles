return require('packer').startup({function(use)
    use "wbthomason/packer.nvim"

    -- GUI enhancements
    --
    use "sainnhe/everforest" -- Theme
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    } -- Status line
    use 'mhinz/vim-startify' -- Startup page
    use 'Yggdroot/indentLine' -- Show lines for indending
    use {
	    "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    } -- Auto match brackets etc.
    use 'danilamihailov/beacon.nvim' -- Show cursor on jump
    use 'voldikss/vim-floaterm' -- Floating terminal window

    -- Fuzzy Finder
    --
    use 'airblade/vim-rooter' -- Change the working directory to the project root
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'}, {'kyazdani42/nvim-web-devicons'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use "nvim-telescope/telescope-file-browser.nvim"
    use "nvim-telescope/telescope-ui-select.nvim"

    -- LSP
    --
    use {
        'williamboman/mason.nvim',
        config = function() require('mason').setup {} end
    }
    use {
        'williamboman/mason-lspconfig.nvim',
        config = function() require('mason-lspconfig').setup {} end
    }
    use 'neovim/nvim-lspconfig' -- Base configurations for a collection of lsp clients

    -- Rust
    --
    use 'simrat39/rust-tools.nvim'

    -- Completion
    --
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'                             
    use 'hrsh7th/cmp-path'                              
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/vim-vsnip'

    -- Parsing
    --
    use 'nvim-treesitter/nvim-treesitter'
end,
config = {
  package_root = vim.fn.stdpath('config') .. '/site/pack'
}})
