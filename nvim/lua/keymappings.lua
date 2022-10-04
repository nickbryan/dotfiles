local map = vim.api.nvim_set_keymap

-- Disable arrow keys
map('n', '<Up>', '', { noremap = true })
map('n', '<Down>', '', { noremap = true })
map('n', '<Left>', '', { noremap = true })
map('n', '<Right>', '', { noremap = true })
map('i', '<Up>', '', { noremap = true })
map('i', '<Down>', '', { noremap = true })
map('i', '<Left>', '', { noremap = true })
map('i', '<Right>', '', { noremap = true })

-- Left and right to switch buffers
map('n', '<Left>', ':bp<CR>', { noremap = true })
map('n', '<Right>', ':bn<CR>', { noremap = true })

-- Escape bindings
map('i', 'jj', '<Esc>', { noremap = true })

-- Quit
map('n', '<C-q>', ':confirm qall<CR>', { noremap = true })

-- Search - align search results in the middle of the screen
map('n', 'n', 'nzz', {  noremap = true, silent = true })
map('n', 'N', 'Nzz', { noremap = true, silent = true })
map('n', '*', '*zz', { noremap = true, silent = true })
map('n', '#', '#zz', { noremap = true, silent = true })
map('n', 'g*', 'g*zz', { noremap = true, silent = true })

-- Move by line (for line that span multiple rows)
map('n', 'j', 'gj', { noremap = true })
map('n', 'k', 'gk', { noremap = true })

-- Show buffer statistics
map('n', '<leader>q', 'g<C-g>', { noremap = true })

-- Jump to start and end of line with hom row keys
map('', 'H', '^', { noremap = true })
map('', 'L', '$', { noremap = true })

-- Ctrl+h to stop searching
map('v', '<C-h>', ':nohlsearch<CR>', { noremap = true })
map('n', '<C-h>', ':nohlsearch<CR>', { noremap = true })

-- Quick save
map('n', '<leader>w', ':w<CR>', { noremap = true })

-- Toggle between buffers
map('n', '<leader><leader>', '<C-^>', { noremap = true })

-- Open new file adjacent to current file
map('n', '<leader>o', ':e <C-R>=expand("%:p:h:) . "/" <CR>', { noremap = true })

-- Floaterm Toggle
map('n', '<F12>', ':FloatermToggle<CR>', { noremap = true, silent = true })
map('t', '<F12>', "<C-\\><C-n>:FloatermToggle<CR>", { noremap = true, silent = true })

-- Fuzzy Finder (Telescope)
map('n', '<leader>f', '<cmd> lua require("telescope.builtin").find_files()<CR>', { noremap = true })
map('n', '<leader>s', '<cmd> lua require("telescope.builtin").live_grep()<CR>', { noremap = true })
map('n', '<leader>b', '<cmd> lua require("telescope.builtin").buffers()<CR>', { noremap = true })
map('n', '<leader>h', '<cmd> lua require("telescope.builtin").help_tags()<CR>', { noremap = true })
map('n', '<leader>e', '<cmd> lua require("telescope").extensions.file_browser.file_browser()<CR>', { noremap = true })
map('n', '<leader>ee', '<cmd> lua require("telescope").extensions.file_browser.file_browser({files = false, hidden = false})<CR>', { noremap = true })

-- LSP
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })

map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })
map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true, silent = true })
map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
map('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
map('n', '<leader>ld', '<cmd>lua vim.diagnostic.open_float(nil, {focusable = false})<CR>', { noremap = true, silent = true })
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })
map('n', '<leader>fu', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', { noremap = true, silent = true })
map('n', '<leader>rr', '<cmd>lua require("rust-tools").runnables.runnables()<CR>', { noremap = true, silent = true })

-- Snippet argument jumping
vim.cmd([[imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>']])
vim.cmd([[smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>']])
vim.cmd([[imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>']])
vim.cmd([[smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>']])
