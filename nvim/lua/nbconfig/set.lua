-- Encoding
vim.opt.fileencoding = "utf-8"

-- Lines
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.wrap = false

-- Modeline
vim.opt.modeline = false

-- Netrw
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 30
vim.g.netrw_preview = 1
vim.g.netrw_localmkdir = "mkdir -p"
vim.g.netrw_localcopycmd = "cp -r"
vim.g.netrw_localrmdir = "rm -r"
vim.g.netrw_list_hide = ".DS_Store,.git/"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Shell
vim.opt.shell = "/bin/zsh"

-- Spaces
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- UI
vim.opt.colorcolumn = "120"
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.updatetime = 100
vim.opt.visualbell = true

-- Undo
vim.opt.undofile = true
