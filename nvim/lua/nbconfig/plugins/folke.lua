return {
    {
        url = "https://github.com/folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        url = "https://github.com/folke/snacks.nvim",
        priority = 1000,
        event = "VeryLazy",
        opts = {
            bigfile = { enabled = true },
            bufdelete = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
        keys = {
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
            { "<leader>bda", function() Snacks.bufdelete.all() end, desc = "Delete All Buffers" },
            { "<leader>bD", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
            { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
        },
    }
}
