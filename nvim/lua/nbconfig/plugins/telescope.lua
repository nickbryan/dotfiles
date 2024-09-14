return {
    {
        url = "https://github.com/nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            {
                url = "https://github.com/nvim-lua/plenary.nvim",
            },
            {
                url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                config = function()
                    require("telescope").load_extension("fzf")
                end,
            },
            {
                url = "https://github.com/nvim-tree/nvim-web-devicons",
            },
        },
        keys = {
            { "<leader>pf", function() require("telescope.builtin").find_files({ hidden = true }) end, mode = "n", noremap = true, desc = "Search for project files" },
            { "<leader>ps", function() require("telescope.builtin").live_grep() end,                   mode = "n", noremap = true, desc = "Search for string in project files" },
            { "<leader>e",  function() require("telescope.builtin").oldfiles({ cwd_only = true }) end, mode = "n", noremap = true, desc = "Search for previously opened files" },
            { "<leader>vh", function() require("telescope.builtin").help_tags() end,                   mode = "n", noremap = true, desc = "Vim help tags" },
        },
        opts = {
            defaults = {
                initial_mode = "normal",
                file_ignore_patterns = { "%.git/" },
            },
        },
    },
}
