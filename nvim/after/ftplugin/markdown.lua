vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
-- Returns the list prefix (indent + marker) for a line, or nil if not a list item.
-- Checkboxes always continue as unchecked regardless of current state.
local function list_prefix(line)
    local checkbox_indent = line:match("^(%s*- )%[[ x%-]%] ")
    if checkbox_indent then return checkbox_indent .. "[ ] " end
    return line:match("^(%s*[-*] )")
        or line:match("^(%s*> )")
        or line:match("^(%s*%d+%. )")
end

-- Like list_prefix but increments the number for ordered lists.
local function list_next_prefix(line)
    local checkbox_indent = line:match("^(%s*- )%[[ x%-]%] ")
    if checkbox_indent then return checkbox_indent .. "[ ] " end
    local plain = line:match("^(%s*[-*] )") or line:match("^(%s*> )")
    if plain then return plain end
    local indent, num = line:match("^(%s*)(%d+)%. ")
    if indent then return indent .. (tonumber(num) + 1) .. ". " end
end

-- Continue list items on Enter, preserving indentation.
-- Handles checkboxes, -, *, > markers. Empty list item exits the list.
vim.keymap.set("i", "<CR>", function()
    local line = vim.api.nvim_get_current_line()
    local prefix = list_prefix(line)
    if prefix then
        if line:sub(#prefix + 1) == "" then
            return "<C-u><CR>"
        end
        return "<CR>" .. list_next_prefix(line)
    end
    return "<CR>"
end, { expr = true, buffer = true, desc = "Continue list item" })

-- Tab/S-Tab indent/dedent list items when cursor is within the prefix area.
vim.keymap.set("i", "<Tab>", function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local prefix = list_prefix(line)
    if prefix and col <= #prefix then
        return "<C-t>"
    end
    return "<Tab>"
end, { expr = true, buffer = true, desc = "Indent list item or insert tab" })

vim.keymap.set("i", "<S-Tab>", function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local prefix = list_prefix(line)
    if prefix and col <= #prefix then
        return "<C-d>"
    end
    return "<S-Tab>"
end, { expr = true, buffer = true, desc = "Dedent list item or unindent" })

-- o/O open a new line: continue the list if on a list item.
vim.keymap.set("n", "o", function()
    local line = vim.api.nvim_get_current_line()
    local prefix = list_next_prefix(line)
    return prefix and ("o" .. prefix) or "o"
end, { expr = true, buffer = true, desc = "Open line below (list aware)" })

vim.keymap.set("n", "O", function()
    local prefix = list_prefix(vim.api.nvim_get_current_line())
    return prefix and ("O" .. prefix) or "O"
end, { expr = true, buffer = true, desc = "Open line above (list aware)" })

vim.opt_local.wrap = true

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lnum==1?'>1':getline(v:lnum)=~'^#'?'>'..len(matchstr(getline(v:lnum),'^#\\+')):'='"
vim.opt_local.foldenable = false
