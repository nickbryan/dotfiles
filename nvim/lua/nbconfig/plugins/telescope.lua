local builtin = require('telescope.builtin')

return {
    url = "https://github.com/nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { 
        url = 'https://github.com/nvim-lua/plenary.nvim',
    },
    keys = {
        { '<leader>pf', function() require('telescope.builtin').find_files() end, { mode = 'n', noremap = true, } }, 
    },
}
