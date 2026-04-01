local ls = require("luasnip")

local function fy_week()
    local now = os.time()
    local today = os.date("*t", now)
    local fy_start_year = today.month >= 4 and today.year or today.year - 1
    local fy_start = os.time({ year = fy_start_year, month = 4, day = 1, hour = 0, min = 0, sec = 0 })
    local days = math.floor((now - fy_start) / 86400)
    return tostring(math.floor(days / 7) + 1)
end

local function week_range()
    local now = os.time()
    local wday = os.date("*t", now).wday
    -- wday: 1=Sun, 2=Mon, ...
    local monday = now - (wday - 2) * 86400
    if wday == 1 then monday = now - 6 * 86400 end
    local thursday = monday + 3 * 86400
    return os.date("%B %d", monday) .. " - " .. os.date("%B %d", thursday)
end

local function daily_nodes(date_fn)
    return {
        ls.text_node("#### "),
        ls.function_node(date_fn),
        ls.text_node({ "", "", "**Intent:** " }),
        ls.insert_node(1),
        ls.text_node({ "", "", "- ...", "", "**Reflection:**", "" }),
    }
end

local function week_nodes()
    return {
        ls.text_node("### Week "),
        ls.function_node(function() return fy_week() end),
        ls.text_node(" ("),
        ls.function_node(function() return week_range() end),
        ls.text_node({ ")", "", "" }),
    }
end

local function today()
    return os.date("%Y-%m-%d %A")
end

local function monday_of_week()
    local now = os.time()
    local wday = os.date("*t", now).wday
    local monday = now - (wday - 2) * 86400
    if wday == 1 then monday = now - 6 * 86400 end
    return os.date("%Y-%m-%d Monday", monday)
end

return {
    ls.snippet("dnote", daily_nodes(today)),
    ls.snippet("wrnote", {
        ls.text_node({ "**Achievements:**", "", "- " }),
        ls.insert_node(1),
        ls.text_node({ "", "", "**Challenges:**", "", "- " }),
        ls.insert_node(2),
        ls.text_node({ "", "", "**Reflection:** " }),
        ls.insert_node(3),
        ls.text_node({ "", "", "**Goals Check:** " }),
        ls.insert_node(4),
        ls.text_node({ "", "", "**Next Week:** " }),
        ls.insert_node(5),
        ls.text_node({ "" }),
    }),
    ls.snippet("wnote", vim.list_extend(
        week_nodes(),
        vim.list_extend(daily_nodes(monday_of_week), { ls.text_node({ "", "---", "" }) })
    )),
    ls.snippet("mnote", vim.list_extend({
        ls.text_node("## "),
        ls.function_node(function() return os.date("%B") end),
        ls.text_node({ "", "" }),
    }, vim.list_extend(
        week_nodes(),
        vim.list_extend(daily_nodes(monday_of_week), { ls.text_node({ "", "---", "" }) })
    ))),
}
