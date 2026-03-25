vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.comments = "b:- [ ],b:- [-],b:- [x],b:-,b:*,b:>,b:1."
vim.opt_local.formatoptions:append("r")

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lnum==1?'>1':getline(v:lnum)=~'^#'?'>'..len(matchstr(getline(v:lnum),'^#\\+')):'='"
vim.opt_local.foldenable = false
