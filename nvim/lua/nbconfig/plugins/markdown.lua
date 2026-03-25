return {
    {
        url = "https://github.com/MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        dependencies = {
            { url = "https://github.com/nvim-treesitter/nvim-treesitter" },
            { url = "https://github.com/nvim-tree/nvim-web-devicons" },
        },
        opts = {
            completions = {
                blink = { enabled = true },
            },
            checkbox = {
                unchecked = { icon = "☐" },
                checked = { icon = "✔", scope_highlight = "@markup.strikethrough" },
            },
        },
        keys = {
            { "<leader>mt", ":RenderMarkdown toggle<CR>", ft = "markdown", desc = "Toggle render-markdown" },
            {
                "<leader>mc",
                function()
                    local line = vim.api.nvim_get_current_line()
                    if line:match("%[ %]") then
                        vim.api.nvim_set_current_line((line:gsub("%[ %]", "[-]", 1)))
                    elseif line:match("%[%-%]") then
                        vim.api.nvim_set_current_line((line:gsub("%[%-%]", "[x]", 1)))
                    elseif line:match("%[x%]") then
                        vim.api.nvim_set_current_line((line:gsub("%[x%]", "[ ]", 1)))
                    end
                end,
                ft = "markdown",
                desc = "Toggle checkbox",
            },
        },
    },
}
