return {
    url = "https://github.com/nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    dependencies = {
        url = "https://github.com/nvim-treesitter/nvim-treesitter-context",
    },
    lazy = false,
    config = function()
        local ensure_installed = {
            "bash",
            "comment",
            "css",
            "diff",
            "dockerfile",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "go",
            "gomod",
            "gosum",
            "gowork",
            "hcl",
            "html",
            "http",
            "javascript",
            "json",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            "php",
            "python",
            "regex",
            "rust",
            "sql",
            "ssh_config",
            "templ",
            "typescript",
            "toml",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        }

        local not_installed = function(lang)
            return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) ==
                0
        end
        local to_install = vim.tbl_filter(not_installed, ensure_installed)
        if #to_install > 0 then require('nvim-treesitter').install(to_install) end

        local filetypes = {}
        for _, lang in ipairs(ensure_installed) do
            for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
                table.insert(filetypes, ft)
            end
        end

        vim.api.nvim_create_autocmd('FileType', {
            desc = 'Start treesitter',
            group = vim.api.nvim_create_augroup('start_treesitter', { clear = true }),
            pattern = filetypes,
            callback = function(ev)
                vim.treesitter.start(ev.buf)
                vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        })
    end,
}
