require('telescope').setup({
    extensions = {
        file_browser = {
            path = "%:p:h",
            grouped = true,
            hidden = true,
            select_buffer = true,
        },
        ["ui-select"] = {
            require("telescope.themes").get_cursor{},
        },
    },
})

require("telescope").load_extension('fzf')
require("telescope").load_extension('file_browser')
require("telescope").load_extension('ui-select')

