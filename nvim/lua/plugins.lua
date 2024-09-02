return require('packer').startup({function(use)
    use "wbthomason/packer.nvim"

    -- GUI enhancements
    --
    use { "ellisonleao/gruvbox.nvim" } -- Theme
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    } -- Status line
    use 'mhinz/vim-startify' -- Startup page
    use 'Yggdroot/indentLine' -- Show lines for indending
    use {
	    "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end,
    } -- Auto match brackets etc.
    use 'danilamihailov/beacon.nvim' -- Show cursor on jump
    use 'voldikss/vim-floaterm' -- Floating terminal window
    use {
        'kosayoda/nvim-lightbulb', -- Show lightbulb for code actions
        config = function() require('nvim-lightbulb').setup({autocmd = {enabled = true}}) end,
    }

    -- Fuzzy Finder
    --
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'}, {'kyazdani42/nvim-web-devicons'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use "nvim-telescope/telescope-file-browser.nvim"
    use "nvim-telescope/telescope-ui-select.nvim"

    -- LSP
    --
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

    -- GO
    --
    use {
        'ray-x/go.nvim',
        requires = { 'ray-x/guihua.lua' },
    }
    use {
        'mfussenegger/nvim-lint',
        config = function() require('lint').linters_by_ft = {
            go = {'golangcilint'},
        } end,
    }
end,
config = {
  package_root = vim.fn.stdpath('config') .. '/site/pack'
}})
