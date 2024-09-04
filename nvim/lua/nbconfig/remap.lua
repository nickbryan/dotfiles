-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable arrow keys
vim.keymap.set({ "n", "i" }, "<Up>", "", { noremap = true })
vim.keymap.set({ "n", "i" }, "<Down>", "", { noremap = true })
vim.keymap.set({ "n", "i" }, "<Left>", "", { noremap = true })
vim.keymap.set({ "n", "i" }, "<Right>", "", { noremap = true })

-- Left and right to switch buffers
vim.keymap.set("n", "<Left>", ":bp<CR>", { noremap = true, desc = "Previous buffer" })
vim.keymap.set("n", "<Right>", ":bn<CR>", { noremap = true, desc = "Next buffer" })

-- Exit insert mode
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, desc = "Exit insert mode" })

-- Navigation
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Project view - netrw" })
