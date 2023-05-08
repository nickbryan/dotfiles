local opt = vim.opt

-- Shell
opt.shell = "/bin/zsh"

-- nvim specific
opt.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
opt.inccommand = "nosplit"

-- General
opt.hidden = true -- Hide buffer when opening a new file (instead of closing it).
opt.visualbell = true -- Dont make any noise.
opt.undofile = true -- Save the undo history when closing a buffer.
opt.modelines = 0 -- Do not allow modelines in file (potential vulnerability).
opt.modeline = true -- See above.
opt.showmode = false -- Hide the mode hint on the bottom line as we have it in the status bar.
opt.signcolumn = "yes" -- Always draw sign column. Prevent buffer moving when adding/deleting sign.
opt.showcmd = true -- Show ocmmand in status line (bottom right).

-- Mouse
opt.mouse = "n" -- Enable mouse in normal mode. See autocommands.lua for focus callbacks.

-- Completion
-- menuone: popup when there is only one match.
-- noinsert: do not insert text until a selection is made.
-- noselect: do not select, force user to select one from the menu.
opt.completeopt = "menuone,noinsert,noselect"
opt.shortmess:append("c") -- Avpod showing extra messages when using completion.
opt.cmdheight = 2 -- Better display for messages.
opt.updatetime = 300 -- Default: 4000 - takes too long to show completion/diagnostic messages.

-- Search
opt.hlsearch = true -- Search highlighting.
opt.ignorecase = true -- Ignore case during search.
opt.incsearch = true -- Show partial matches during search.
opt.smartcase = true -- Auto switch to case sensitive when uppercase letter is used.

-- Theme
opt.termguicolors = true
opt.background = "dark"
vim.cmd([[colorscheme gruvbox]])
vim.g.everforest_background="medium"

-- Lines and Numbers
opt.wrap = false -- Do not wrap lines.
opt.number = true -- Show line numbers.
opt.relativenumber = true -- Make numbers relative to the cursor. See autocommands.lua for focus toggle.
opt.scrolloff = 2 -- 2 = stop 2 from top or bottom, 999 = Keep cursor in middle of screen so screen scrolls with cursor.

-- Tabs, Spaces and Indenting
opt.autoindent = true
opt.shiftwidth = 4 -- >> will shift by 4 spaces.
opt.tabstop = 4 -- 1 tab is 4 spaces.
opt.softtabstop = 4 -- Spaces used in insert mode.
opt.expandtab = true -- Replace tabes with spaces.
opt.smarttab = true -- Use shiftwidth at beginning of line and tabstop/softabstop elsewhere.

-- Encoding
opt.encoding = "utf-8" -- Output encoding shown in the terminal.
opt.fileencoding = "utf-8" -- Output encoding when writing to file.

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Wildmenu
opt.wildmenu = true
opt.wildmode = "list:longest"
opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor"

-- Line length indicator
opt.colorcolumn = "120"
