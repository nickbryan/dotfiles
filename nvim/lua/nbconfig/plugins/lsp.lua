return {
    {
        url = "https://github.com/williamboman/mason.nvim",
        config = true,
    },
    {
        url = "https://github.com/VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        lazy = true,
    },
    {
        url = "https://github.com/hrsh7th/nvim-cmp",
        dependencies = {
            { url = "https://github.com/hrsh7th/cmp-path" },
            { url = "https://github.com/hrsh7th/cmp-buffer" },
            { url = "https://github.com/hrsh7th/cmp-nvim-lsp" },
            { url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help" },
        },
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                sources = {
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "nvim_lsp_signature_help" },
                },
                snippet = {
                    expand = function(args)
                        -- TODO: Should I use luasnip? What is this actually doing?
                        -- This is the default so I can remove it (confirmed) if I don"t use a different engine.
                        vim.snippet.expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    -- TODO: custom key mappings.
                }),
                -- TODO: use formatting function to show source https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
            })
        end,
    },
    {
        url = "https://github.com/hrsh7th/cmp-cmdline",
        event = "CmdlineEnter",
        config = function()
            local cmp = require("cmp")
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "buffer" } }
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline({}),
                sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
            })
        end,
    },
    {
        url = "https://github.com/neovim/nvim-lspconfig",
        dependencies = {
            { url = "https://github.com/hrsh7th/cmp-nvim-lsp" },
            { url = "https://github.com/williamboman/mason.nvim" },
            { url = "https://github.com/williamboman/mason-lspconfig.nvim" },
        },
        cmd = "LspInfo",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lsp_zero = require("lsp-zero")

            -- TODO: preoperly configure all of this
            lsp_zero.extend_lspconfig({
                sign_text = true,
                lsp_attach = function(_, bufnr)
                    local opts = { buffer = bufnr }

                    lsp_zero.buffer_autoformat()

                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                    -- workspace symbol? leader vws
                    -- vim diagnostics open float? leader vd
                end,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            require("mason-lspconfig").setup({
                automatic_installation = false,
                ensure_installed = { "gopls", "lua_ls" },
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                },
            })
        end,
    },
}
