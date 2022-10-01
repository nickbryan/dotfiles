local util = require "lspconfig/util"
require'lspconfig'.gopls.setup({
    cmd = {"gopls", "serve"},
    filetypes = {"go", "gomod"},
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            analyses = {
                fieldalignment = true,
                nilness = true,
                shadow = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
            },
            gofumpt = true,
            usePlaceholders = true,
            experimentalPostfixCompletions = true,
            staticcheck = true,
        },
    },
})

require('go').setup()

