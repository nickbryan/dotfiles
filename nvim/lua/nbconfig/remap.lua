-- Disable arrow keys
vim.keymap.set({ "n", "i" }, "<Up>", "", { noremap = true })
vim.keymap.set({ "n", "i" }, "<Down>", "", { noremap = true })
vim.keymap.set({ "n", "i" }, "<Left>", "", { noremap = true })
vim.keymap.set({ "n", "i" }, "<Right>", "", { noremap = true })

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Exit insert mode
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, desc = "Exit insert mode" })

-- File and buffer navigation
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Project view - netrw" })
vim.keymap.set("n", "<Left>", ":bp<CR>", { noremap = true, desc = "Previous buffer" })
vim.keymap.set("n", "<Right>", ":bn<CR>", { noremap = true, desc = "Next buffer" })

-- Search - align results to the middle of the screen
vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true })
vim.keymap.set("n", "*", "*zz", { noremap = true, silent = true })
vim.keymap.set("n", "#", "#zz", { noremap = true, silent = true })
vim.keymap.set("n", "g*", "g*zz", { noremap = true, silent = true })

-- Move by line (for line that span multiple rows)
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })

-- Quick save
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, desc = "Write the current buffer to disk" })
