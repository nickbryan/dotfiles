local cmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup

-- Mouse focus - disable when we leave focus so that we don't move cursor when focus is gained again.
cmd("FocusGained", { pattern = {"*"}, callback = function() vim.opt.mouse = "n" end})
cmd("FocusLost", { pattern = {"*"}, callback = function() vim.opt.mouse = "" end})

-- Relative number focus toggle
group("numbertoggle", { clear = true }) -- Clear current numbertoggle commands.
cmd({ "BufEnter", "FocusGained", "InsertLeave" }, { group = "numbertoggle", pattern = {"*"}, callback = function() vim.opt.relativenumber = true end})
cmd({ "BufLeave", "FocusLost", "InsertEnter" }, { group = "numbertoggle", pattern = {"*"}, callback = function() vim.opt.relativenumber = false end})

-- Leave paste mode when leaving insert mode
cmd("InsertLeave", { pattern = {"*"}, callback = function() vim.opt.paste = false end})

-- Highligh yanked text
group("highlight_yank", { clear = true }) -- Clear current numbertoggle commands.
cmd("TextYankPost", { group = "highlight_yank", pattern = {"*"}, callback = function()
    require('vim.highlight').on_yank{ higroup = 'IncSearch', timeout = 200 }
end})

-- Show diagnostics on cursor hold
cmd("CursorHold", { pattern = {"*"}, callback = function() vim.diagnostic.open_float(nil, { focusable = false }) end})

-- Floaterm create on enter
cmd("VimEnter", { pattern = {"*"}, command = ":FloatermNew --silent <CR>" })

-- Format on save
cmd("BufWritePre", { pattern = {"*.rs", "*.go"}, callback = function() vim.lsp.buf.format({ timeout_ms = 200 }) end})

-- Jump to last edit position on opening file
vim.cmd [[au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]

-- Lint
cmd("BufWritePost", { pattern = {"*.go"}, callback = function() require('lint').try_lint() end})
