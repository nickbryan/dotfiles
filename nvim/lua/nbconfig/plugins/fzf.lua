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
        { "<leader>ds",       function() require("fzf-lua").lsp_document_symbols() end,    mode = "n", noremap = true, desc = "Document symbols" },
        { "<leader>ws",       function() require("fzf-lua").lsp_workspace_symbols() end,   mode = "n", noremap = true, desc = "Workspace symbols" },
        { "<leader>pd",       function() require("fzf-lua").diagnostics_workspace() end,   mode = "n", noremap = true, desc = "Workspace diagnostics" },
        { "<leader>pgc",      function() require("fzf-lua").git_commits() end,             mode = "n", noremap = true, desc = "Git commits" },
        { "<leader>pgs",     function() require("fzf-lua").git_status() end,              mode = "n", noremap = true, desc = "Git status" },
    },
    opts = {
        oldfiles = {
            cwd_only = true,
        },
    },
}
