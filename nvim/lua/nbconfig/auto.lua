local group = vim.api.nvim_create_augroup("nbconfig", { clear = true })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    pattern = { "*" },
    callback = function()
        require("vim.highlight").on_yank({ higroup = "IncSearch", timeout = 200 })
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
