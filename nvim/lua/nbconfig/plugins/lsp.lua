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
            {
                url = "https://github.com/L3MON4D3/LuaSnip",
                version = "v2.*",
                dependencies = { url = "https://github.com/rafamadriz/friendly-snippets" },
                build = "make install_jsregexp",
                config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
            },
            { url = "https://github.com/saadparwaiz1/cmp_luasnip" },
        },
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            local types = require("cmp.types")
            local luasnip = require("luasnip")
            local cmp_format = require("lsp-zero").cmp_format({ details = true })

            local select_ops = { behavior = types.cmp.SelectBehavior.Select }
            local confirm_opts = { select = true }

            cmp.setup({
                sources = {
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" },
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-y>"] = cmp.mapping.confirm(confirm_opts),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-n>"] = cmp.mapping(function(_)
                        if cmp.visible() then
                            cmp.select_next_item(select_ops)
                        else
                            cmp.complete()
                        end
                    end),
                    ["<C-p>"] = cmp.mapping(function(_)
                        if cmp.visible() then
                            cmp.select_prev_item(select_ops)
                        else
                            cmp.complete()
                        end
                    end),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        local col = vim.fn.col(".") - 1

                        if cmp.visible() then
                            cmp.confirm(confirm_opts)
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                            fallback()
                        else
                            cmp.complete()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                preselect = cmp.PreselectMode.Item,
                completion = { completeopt = "menu,menuone,noinsert" },
                formatting = cmp_format,
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
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
