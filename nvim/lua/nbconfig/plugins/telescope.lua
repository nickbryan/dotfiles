return {
    {
        url = "https://github.com/nvim-telescope/telescope.nvim",
        dependencies = {
            { url = "https://github.com/nvim-lua/plenary.nvim" },
            { url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            { url = "https://github.com/nvim-tree/nvim-web-devicons" },
            { url = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
        },
        keys = {
            { "<leader>pf",  function() require("telescope.builtin").find_files({ hidden = true }) end,                          mode = "n", noremap = true, desc = "Search for project files" },
            { "<leader>ps",  function() require("telescope.builtin").live_grep() end,                                            mode = "n", noremap = true, desc = "Search live in project files" },
            { "<leader>psw", function() require("telescope.builtin").grep_string() end,                                          mode = "n", noremap = true, desc = "Search for string in project files" },
            { "<leader>e",   function() require("telescope.builtin").oldfiles({ cwd_only = true, initial_mode = "normal" }) end, mode = "n", noremap = true, desc = "Search for previously opened files" },
            { "<leader>vh",  function() require("telescope.builtin").help_tags() end,                                            mode = "n", noremap = true, desc = "Vim help tags" },
        },
        config = function()
            local telescope = require("telescope")
            local theme = "ivy"

            telescope.setup({
                defaults = {
                    file_ignore_patterns = { "%.git/" },
                },
                extensions = {
                    ["ui-select"] = { require("telescope.themes").get_dropdown() },
                },
                pickers = {
                    colorscheme = { enable_preview = true },
                    find_files = { theme = theme },
                    grep_string = { theme = theme },
                    help_tags = { theme = theme },
                    live_grep = { theme = theme },
                    oldfiles = { theme = theme },
                },
            })

            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
        end,
    },
}
