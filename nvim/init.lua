-- Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Imports
require('variables')
require('options')
require('keymappings')
require('autocommands')
require('plugins')
require('lualine_setup')
require('rust_analyzer_setup')
require('lsp_config')
require('telescope_setup')
require('treesitter_setup')
require('go_setup')

