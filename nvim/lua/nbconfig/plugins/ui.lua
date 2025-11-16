return {
    {
        url = "https://github.com/folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },
    {
        url = "https://github.com/j-hui/fidget.nvim",
        opts = {
            notification = {
                override_vim_notify = true,
            },
        },
    },
    {
        url = "https://github.com/nvim-lualine/lualine.nvim",
        dependencies = { url = "https://github.com/nvim-tree/nvim-web-devicons" },
        config = true,
    },
    {
        url = "https://github.com/prichrd/netrw.nvim",
        dependencies = { url = "https://github.com/nvim-tree/nvim-web-devicons" },
        config = true,
    },
}
