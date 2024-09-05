local builtin = require("telescope.builtin")

return {
    url = "https://github.com/nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { 
        { url = "https://github.com/nvim-lua/plenary.nvim" },
        { url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
        { "<leader>pf", function() require("telescope.builtin").find_files({ hidden = true }) end, mode = "n", noremap = true, desc = "Search for project files" },
        { "<leader>ps", function() require("telescope.builtin").live_grep() end, mode = "n", noremap = true, desc = "Search for string in project files" },
        { "<leader>e", function() require("telescope.builtin").oldfiles({ cwd_only = true }) end, mode = "n", noremap = true, desc = "Search for previously opened files" },
    },
}