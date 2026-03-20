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
        event = "LspAttach",
        opts = {
            notification = {
                override_vim_notify = true,
            },
        },
    },
    {
        url = "https://github.com/nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { url = "https://github.com/nvim-tree/nvim-web-devicons" },
        opts = {
            sections = {
                lualine_x = {
                    {
                        function()
                            local clients = vim.lsp.get_clients({ bufnr = 0 })
                            if #clients == 0 then return "" end
                            local names = {}
                            for _, c in ipairs(clients) do
                                table.insert(names, c.name)
                            end
                            return table.concat(names, ", ")
                        end,
                    },
                    "filetype",
                },
            },
        },
    },
    {
        url = "https://github.com/prichrd/netrw.nvim",
        dependencies = { url = "https://github.com/nvim-tree/nvim-web-devicons" },
        ft = "netrw",
        config = true,
    },
}
