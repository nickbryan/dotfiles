return {
    url = "https://github.com/ray-x/go.nvim",
    dependencies = {
        { url = "https://github.com/neovim/nvim-lspconfig" },
        { url = "https://github.com/nvim-treesitter/nvim-treesitter" },
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    config = true,
}
