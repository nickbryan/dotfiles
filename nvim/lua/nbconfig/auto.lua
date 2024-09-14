local group = vim.api.nvim_create_augroup("nbconfig", { clear = true })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    pattern = { "*" },
    callback = function()
        require("vim.highlight").on_yank({ higroup = "IncSearch", timeout = 200 })
    end
})
