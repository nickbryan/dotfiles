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
    {
        url = "https://github.com/nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            { url = "https://github.com/MunifTanjim/nui.nvim" },
            { url = "https://github.com/nvim-lua/plenary.nvim" },
            { url = "https://github.com/nvim-tree/nvim-web-devicons" },
        },
        init = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
        opts = {
            close_if_last_window = true,
            filesystem = {
                hijack_netrw_behavior = "open_current",
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_by_name = {
                        ".git",
                    },
                    never_show = {
                        ".DS_Store",
                        "thumbs.db",
                    },
                },
                follow_current_file = { enabled = true },
            },
            default_component_configs = {
                git_status = {
                    symbols = {
                        added = "✚",
                        modified = "●",
                        deleted = "✖",
                        renamed = "󰁕",
                        untracked = "◌",
                        ignored = "◌",
                        unstaged = "󰄱",
                        staged = "✓",
                        conflict = "⚡",
                    },
                },
            },
        },
    },
}
