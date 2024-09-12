return {
    {
        url = "https://github.com/williamboman/mason.nvim",
        tag = "v1.10.0",
        config = true,
    },
    {
        url = "https://github.com/VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        lazy = true,
    },
    {
        url = "https://github.com/hrsh7th/nvim-cmp",
        branch = "main", -- Convert this to a tag/release version one day.
        event = "InsertEnter",
        opts = {
            sources = {
                { name = "nvim_lsp" },
            },
            -- Be Explicit with mappings
            -- Snippets?
        },
    },
    {
        url = "https://github.com/neovim/nvim-lspconfig",
        tag = "v1.0.0",
        dependencies = {
            { url = "https://github.com/hrsh7th/cmp-nvim-lsp" },
            { url = "https://github.com/williamboman/mason.nvim" },
            { url = "https://github.com/williamboman/mason-lspconfig.nvim" },
        },
        cmd = "LspInfo",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- TODO: preoperly configure all of this
            require("lsp-zero").extend_lspconfig({
                sign_text = true,
                lsp_attach = function(_, bufnr)
                    local opts = { buffer = bufnr }

                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                end,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            require('mason-lspconfig').setup({
                automatic_installation = false,
                ensure_installed = { "lua_ls" },
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                },
            })
        end,
    },
}
