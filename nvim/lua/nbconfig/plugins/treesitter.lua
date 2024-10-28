return {
    url = "https://github.com/nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        url = "https://github.com/nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash",
                "comment",
                "css",
                "diff",
                "dockerfile",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitcommit",
                "gitignore",
                "go",
                "gomod",
                "gosum",
                "gowork",
                "hcl",
                "html",
                "http",
                "javascript",
                "json",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "regex",
                "rust",
                "sql",
                "ssh_config",
                "typescript",
                "toml",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
            },
        })
    end,
}
