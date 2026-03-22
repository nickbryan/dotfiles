local group = vim.api.nvim_create_augroup("nbconfig", { clear = true })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    pattern = { "*" },
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

-- Jump to last edit position when opening a file
vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    pattern = { "*" },
    callback = function()
        local current_file = vim.fn.expand("%:p")
        local last_position = vim.fn.line("'\"")
        local last_line = vim.fn.line("$")

        if not string.match(current_file, "/%.git/") and last_position > 1 and last_position <= last_line then
            vim.cmd("normal! g'\"")
        end
    end,
})

-- Markdown settings
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "markdown",
    callback = function(args)
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true

        -- Heading navigation: ]] next heading, [[ previous heading
        vim.keymap.set("n", "]]", function()
            vim.fn.search("^#\\+\\s", "W")
        end, { buffer = args.buf, desc = "Next markdown heading" })
        vim.keymap.set("n", "[[", function()
            vim.fn.search("^#\\+\\s", "bW")
        end, { buffer = args.buf, desc = "Previous markdown heading" })

        -- Preview with glow in a zellij pane (press q to close)
        vim.keymap.set("n", "<leader>mp", function()
            local file = vim.fn.shellescape(vim.fn.expand("%:p"))
            vim.fn.system("zellij action new-pane -d right -c -- glow -p " .. file)
        end, { buffer = args.buf, desc = "Preview markdown with glow" })

        -- Open URL under cursor
        vim.keymap.set("n", "gx", function()
            local url = vim.fn.expand("<cWORD>")
            -- Extract URL from markdown link syntax [text](url)
            local md_url = url:match("%((.+)%)")
            if md_url then
                url = md_url
            end
            -- Strip surrounding punctuation
            url = url:match("https?://[%w%-%._~:/?#%[%]@!$&'()*+,;=%%]+")
            if url then
                vim.ui.open(url)
            end
        end, { buffer = args.buf, desc = "Open URL under cursor" })
    end,
})

-- Format on save with LSP.
vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method("textDocument/formatting") then
            if vim.b[args.buf]._format_on_save then return end
            vim.b[args.buf]._format_on_save = true

            vim.api.nvim_create_autocmd("BufWritePre", {
                group = group,
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end
    end,
})
