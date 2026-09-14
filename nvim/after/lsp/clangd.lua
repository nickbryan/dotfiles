-- Must live in after/ - nvim-lspconfig ships its own lsp/clangd.lua later in the
-- runtimepath, and vim.lsp.config merges with "force" (later wins, lists replaced
-- wholesale), so a cmd set in nvim/lsp/clangd.lua would be silently discarded.
return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=never",
        "--completion-style=detailed",
        "--function-arg-placeholders=1",
    },
    init_options = {
        -- Used for files not covered by compile_commands.json: standalone .c
        -- files, scratch files, and headers clangd can't map to a TU.
        fallbackFlags = { "-std=c17", "-Wall", "-Wextra" },
    },
}
