return {
    url = "https://github.com/folke/tokyonight.nvim",
    tag = "v4.8.0",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme tokyonight-night]])
    end,
}
