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

-- Disable diagnostics when opening a file (netrw seems to enable it again when used),
-- so the plugin can take over for showing long diagnostic lines.
vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    pattern = { "*" },
    callback = function()
        vim.diagnostic.config({ virtual_text = false })
    end,
})

-- Format on save with LSP.
vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client.supports_method("textDocument/formatting", args.buf) then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ async = false, id = args.data.client_id })
                end,
            })
        end
    end,
})
