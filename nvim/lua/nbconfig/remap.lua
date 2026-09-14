-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable bindings
vim.keymap.set({ "n", "i" }, "<Up>", "<Nop>", { noremap = true, desc = "Disabled" })
vim.keymap.set({ "n", "i" }, "<Down>", "<Nop>", { noremap = true, desc = "Disabled" })
vim.keymap.set("i", "<Left>", "<Nop>", { noremap = true, desc = "Disabled" })
vim.keymap.set("i", "<Right>", "<Nop>", { noremap = true, desc = "Disabled" })
vim.keymap.set("n", "Q", "<Nop>", { noremap = true, desc = "Disabled" })

-- Exit insert mode
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, desc = "Exit insert mode" })

-- File/buffer navigation
vim.keymap.set("n", "<leader>pv", ":Neotree toggle<CR>", { noremap = true, desc = "Project view - Neo-tree" })
vim.keymap.set("n", "<Left>", ":bp<CR>", { noremap = true, desc = "Previous buffer" })
vim.keymap.set("n", "<Right>", ":bn<CR>", { noremap = true, desc = "Next buffer" })

-- Move by display line, but use actual lines when a count is given (e.g. 3k)
-- so that jumps match relative line numbers.
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, noremap = true, desc = "Down (display line aware)" })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, noremap = true, desc = "Up (display line aware)" })

-- Move selections
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

-- Search - align results to the middle of the screen
vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true, desc = "Next match (centered)" })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true, desc = "Prev match (centered)" })
vim.keymap.set("n", "*", "*zz", { noremap = true, silent = true, desc = "Search word (centered)" })
vim.keymap.set("n", "#", "#zz", { noremap = true, silent = true, desc = "Search word backward (centered)" })
vim.keymap.set("n", "g*", "g*zz", { noremap = true, silent = true, desc = "Search partial word (centered)" })

-- Shortcuts
vim.keymap.set("n", "<leader>vl", ":Lazy<CR>", { noremap = true, desc = "Open Lazy" })
vim.keymap.set("n", "<leader>vm", ":Mason<CR>", { noremap = true, desc = "Open Mason" })
vim.keymap.set("n", "<leader>vi", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { noremap = true, desc = "Toggle inlay hints" })

-- Quick save
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, desc = "Write the current buffer to disk" })
