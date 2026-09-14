-- Header/source toggle and symbol info. Both commands are created by
-- nvim-lspconfig's clangd on_attach; they just have no keymaps by default.
vim.keymap.set("n", "<leader>ch", "<Cmd>LspClangdSwitchSourceHeader<CR>",
    { buf = 0, desc = "Switch source/header" })
vim.keymap.set("n", "<leader>ci", "<Cmd>LspClangdShowSymbolInfo<CR>",
    { buf = 0, desc = "Show symbol info" })

-- Build into the quickfix list ('makeprg' already defaults to make).
vim.keymap.set("n", "<leader>cb", "<Cmd>make!<CR><Cmd>copen<CR>",
    { buf = 0, desc = "Build (make -> quickfix)" })

-- Regenerate compile_commands.json so clangd sees the real flags.
vim.api.nvim_buf_create_user_command(0, "CompileCommands", function()
    vim.system({ "bear", "--", "make", "-B" }, { text = true }, function(out)
        vim.schedule(function()
            if out.code ~= 0 then
                return vim.notify(out.stderr, vim.log.levels.ERROR)
            end
            vim.notify("compile_commands.json regenerated")
            for _, c in ipairs(vim.lsp.get_clients({ name = "clangd" })) do
                c:stop()
            end
        end)
    end)
end, { desc = "bear -- make -B, then restart clangd" })
