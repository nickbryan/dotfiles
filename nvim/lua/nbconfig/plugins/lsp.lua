return {
    {
        url = "https://github.com/saghen/blink.cmp",
        version = "1.*",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            {
                url = "https://github.com/L3MON4D3/LuaSnip",
                version = "v2.*",
                dependencies = { url = "https://github.com/rafamadriz/friendly-snippets" },
                build = "make install_jsregexp",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                    require("luasnip.loaders.from_lua").lazy_load({
                        paths = vim.fn.stdpath("config") ..
                            "/lua/nbconfig/snippets"
                    })
                end,
            },
        },
        opts = {
            signature = { enabled = true },
            snippets = { preset = "luasnip" },
        },
    },
    {
        url = "https://github.com/williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { url = "https://github.com/williamboman/mason.nvim", opts = {} },
            { url = "https://github.com/neovim/nvim-lspconfig" },
        },
        config = function()
            vim.lsp.config("gopls", {
                settings = {
                    gopls = {
                        buildFlags = { "-tags=unit,integration" },
                        gofumpt = true,
                    },
                },
            })

            vim.lsp.config("harper_ls", {
                settings = {
                    ["harper-ls"] = {
                        userDictPath = "~/.dotfiles/harper/dict.txt",
                        fileDictPath = "~/.dotfiles/harper/file_dictionaries/",
                        dialect = "British",
                        linters = {
                            LongSentences = false,
                        },
                    },
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = { "biome", "gopls", "harper_ls", "lua_ls", "marksman", "pyright", "rust_analyzer", "tailwindcss", "ts_ls" },
            })

            require("fzf-lua").register_ui_select();
        end,
    },
    {
        url = "https://github.com/stevearc/conform.nvim",
        event = "BufWritePre",
        dependencies = {
            { url = "https://github.com/williamboman/mason.nvim" },
        },
        opts = {
            formatters_by_ft = {
                markdown = { "prettier" },
            },
            format_on_save = {},
        },
    },
    {
        url = "https://github.com/zapling/mason-conform.nvim",
        dependencies = {
            { url = "https://github.com/williamboman/mason.nvim" },
            { url = "https://github.com/stevearc/conform.nvim" },
        },
        opts = {},
    },
    {
        url = "https://github.com/mfussenegger/nvim-lint",
        dependencies = {
            { url = "https://github.com/williamboman/mason.nvim" },
            { url = "https://github.com/rshkarin/mason-nvim-lint" },
        },
        event = { "BufWritePost", "BufReadPost", "InsertLeave" },
        config = function()
            require("mason-nvim-lint").setup({
                ensure_installed = { "golangcilint", "markdownlint" },
                automatic_installation = false,
            })
            local lint = require("lint")
            lint.linters.golangcilint.args = vim.list_extend(
                lint.linters.golangcilint.args,
                { "--build-tags=unit,integration" }
            )
            lint.linters.markdownlint.args = vim.list_extend(
                lint.linters.markdownlint.args,
                { "--disable", "MD013", "--" }
            )
            lint.linters_by_ft = {
                go = { "golangcilint" },
                markdown = { "markdownlint" },
            }
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
                group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
                callback = function()
                    lint.try_lint()
                end,
            })
            -- Run lint on the initial load event that triggered this plugin
            lint.try_lint()
        end,
    },
}
