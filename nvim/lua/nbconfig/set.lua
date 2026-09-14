-- Diagnostics
vim.diagnostic.config({
    virtual_lines = { current_line = true },
    virtual_text = false,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN] = "󰀪",
            [vim.diagnostic.severity.INFO] = "󰋽",
            [vim.diagnostic.severity.HINT] = "󰌶",
        },
    },
    jump = {
        on_jump = function()
            vim.diagnostic.open_float({ scope = "cursor" })
        end,
    },
})

-- LSP features that are off by default. The global form installs its own LspAttach
-- handler and only attaches to servers advertising the capability.
vim.lsp.linked_editing_range.enable(true)
vim.lsp.on_type_formatting.enable(true)

-- Lines
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.wrap = false
vim.o.cursorline = true

-- Modeline
vim.o.modeline = false

-- Folds (treesitter drives foldexpr; start with everything unfolded)
vim.o.foldlevelstart = 99

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Spaces
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4

-- UI
vim.o.colorcolumn = "120"
vim.o.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.timeoutlen = 300
vim.o.updatetime = 200
vim.o.visualbell = true
vim.o.winborder = "rounded"

-- Undo
vim.o.undofile = true
