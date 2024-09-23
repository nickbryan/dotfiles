-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable Bindings
vim.keymap.set({ "n", "i" }, "<Up>", "<Nop>", { noremap = true })
vim.keymap.set({ "n", "i" }, "<Down>", "<Nop>", { noremap = true })
vim.keymap.set({ "n", "i" }, "<Left>", "<Nop>", { noremap = true })
vim.keymap.set({ "n", "i" }, "<Right>", "<Nop>", { noremap = true })
vim.keymap.set("n", "Q", "<Nop>", { noremap = true }) -- Ex Mode

-- Exit insert mode
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, desc = "Exit insert mode" })

-- File and buffer navigation
vim.keymap.set("n", "<leader>pv", vim.cmd.Rex, { desc = "Project view - netrw" })
vim.keymap.set("n", "<Left>", ":bp<CR>", { noremap = true, desc = "Previous buffer" })
vim.keymap.set("n", "<Right>", ":bn<CR>", { noremap = true, desc = "Next buffer" })

-- Move by line (for line that span multiple rows)
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })

-- Move selections
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

-- Search - align results to the middle of the screen
vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true })
vim.keymap.set("n", "*", "*zz", { noremap = true, silent = true })
vim.keymap.set("n", "#", "#zz", { noremap = true, silent = true })
vim.keymap.set("n", "g*", "g*zz", { noremap = true, silent = true })

-- Quick save
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, desc = "Write the current buffer to disk" })
