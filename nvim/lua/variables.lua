-- Update the packpath
local packer_path = vim.fn.stdpath('config') .. '/site'
vim.o.packpath = vim.o.packpath .. ',' .. packer_path

-- Netrw
vim.g.netrw_liststyle = 3 -- Tree view.
vim.g.netrw_banner = 0 -- Hide the top banner.
