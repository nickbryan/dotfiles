vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true

vim.wo[0][0].wrap = true
vim.wo[0][0].linebreak = true

vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[0][0].foldenable = false

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
end, { expr = true, buf = 0, desc = "Continue list item" })

-- Tab/S-Tab indent/dedent list items when cursor is within the prefix area.
vim.keymap.set("i", "<Tab>", function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local prefix = list_prefix(line)
    if prefix and col <= #prefix then
        return "<C-t>"
    end
    return "<Tab>"
end, { expr = true, buf = 0, desc = "Indent list item or insert tab" })

vim.keymap.set("i", "<S-Tab>", function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local prefix = list_prefix(line)
    if prefix and col <= #prefix then
        return "<C-d>"
    end
    return "<S-Tab>"
end, { expr = true, buf = 0, desc = "Dedent list item or unindent" })

-- o/O open a new line: continue the list if on a list item.
vim.keymap.set("n", "o", function()
    local line = vim.api.nvim_get_current_line()
    local prefix = list_next_prefix(line)
    return prefix and ("o" .. prefix) or "o"
end, { expr = true, buf = 0, desc = "Open line below (list aware)" })

vim.keymap.set("n", "O", function()
    local prefix = list_prefix(vim.api.nvim_get_current_line())
    return prefix and ("O" .. prefix) or "O"
end, { expr = true, buf = 0, desc = "Open line above (list aware)" })

-- Outline: fuzzy search headings with fzf-lua
vim.keymap.set("n", "<leader>mo", function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local headings = {}
    for i, line in ipairs(lines) do
        if line:match("^#") then
            table.insert(headings, string.format("%d:%s", i, line))
        end
    end
    if #headings == 0 then return end
    require("fzf-lua").fzf_exec(headings, {
        prompt = "Headings> ",
        actions = {
            ["default"] = function(selected)
                local lnum = tonumber(selected[1]:match("^(%d+):"))
                if lnum then vim.api.nvim_win_set_cursor(0, { lnum, 0 }) end
            end,
        },
    })
end, { buf = 0, desc = "Markdown outline" })
