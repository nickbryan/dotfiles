return {
    url = "https://github.com/folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme tokyonight-moon]])
    end,
}
