return {
    url = "https://github.com/ibhagwan/fzf-lua",
    dependencies = {
        { url = "https://github.com/nvim-tree/nvim-web-devicons" },
    },
    keys = {
        { "<leader><leader>", function() require("fzf-lua").global() end,     mode = "n", noremap = true, desc = "Search everything" },
        { "<leader>pf",       function() require("fzf-lua").files() end,      mode = "n", noremap = true, desc = "Search for project files" },
        { "<leader>pb",       function() require("fzf-lua").buffers() end,    mode = "n", noremap = true, desc = "Search for project buffers" },
        { "<leader>ps",       function() require("fzf-lua").live_grep() end,  mode = "n", noremap = true, desc = "Search live in project files" },
        { "<leader>psw",      function() require("fzf-lua").grep_cword() end, mode = "n", noremap = true, desc = "Search for string in project files" },
        { "<leader>e",        function() require("fzf-lua").oldfiles() end,   mode = "n", noremap = true, desc = "Search for previously opened files" },
        { "<leader>vh",       function() require("fzf-lua").helptags() end,   mode = "n", noremap = true, desc = "Vim help tags" },
    },
    opts = {
        oldfiles = {
            cwd_only = true,
        },
    },
}
