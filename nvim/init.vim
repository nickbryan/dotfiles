set shell=/bin/bash " Fish can be a bit of a nightmare

""""" Leader Key """""
let mapleader="\<Space>" " Map this first so that we can use it throught the file

"""""" Plugins """""
call plug#begin('~/.config/nvim/plugged')

" VIM enhancements
Plug 'justinmk/vim-sneak'

" The best color scheme ever
Plug 'caksoylar/vim-mysticaltutor' 

" GUI enhancements
Plug 'itchyny/lightline.vim' " Simple status line
Plug 'machakann/vim-highlightedyank' " Highlight yank
Plug 'andymass/vim-matchup' " Highlight matching brackets etc.
Plug 'tpope/vim-surround' " Easy update matching brackets etc.
Plug 'jiangmiao/auto-pairs' " Auto match brackets etc.

" Fuzzy finder
Plug 'airblade/vim-rooter' " Change the working dir to the project root
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Semantic language support
Plug 'neovim/nvim-lspconfig' " Base config for lsp
Plug 'hrsh7th/nvim-cmp' " A completion engine
Plug 'hrsh7th/cmp-nvim-lsp' " LSP completion sources for nvim-cmp
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline' " Command mode auto complete
Plug 'ray-x/lsp_signature.nvim' " Show function signature when you type

" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Language LSP
Plug 'simrat39/rust-tools.nvim' " To enable more of the features of rust-analyzer, such as inlay hints and more! 

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'dag/vim-fish'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

""""" Sneak """""
let g:sneak#s_next = 1

""""" Lightline """""
let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileencoding', 'filetype' ] ],
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename'
    \ },
    \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

""""" Fuzz Finder (Telescope) """""
" Find files using Telescope command-line sugar.
nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>s <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>h <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>e <cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>
nnoremap <leader>ee <cmd>lua require('telescope').extensions.file_browser.file_browser({files = false})<cr>

""""" Markdown """""
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1

""""" Vim-Go """""
let g:go_gopls_enabled = 0
let g:go_metalinter_autosave = 1
let g:go_fmt_autosave = 0

""""" General """""
set hidden " Hide buffer when opening a new file (instead of closing it)
set visualbell " Don't make any noise
set undofile " Save the undo history when closing a buffer
set undodir=~/.config/nvim/undodir
set modelines=0 " Do not allow modlines in file (potential vilnerablility)
set modeline " See above
set noshowmode " Hide the mode hint on the bottom line as we have it in status bar
set signcolumn=yes " Always draw sign column. Prevent buffer moving when adding/deleting sign.
set showcmd " Show command in status line (bottom right)

""""" Mouse """""
set mouse=n " Enable mouse in normal mode
autocmd FocusGained * set mouse=n " Emable mouse again when we get focus
autocmd FocusLost * set mouse="" " Disable mouse when we leave focus so clicking back in does not move cursor

"""" Completion """""
" Better completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
set shortmess+=c " Avoid showing extra messages when using completion
" Better display for messag
set cmdheight=2 " Better display for messages"
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

""""" Search """""
set hlsearch " Search highlighting
set ignorecase " Ingore case
set incsearch " Show partial matches
set smartcase " Auto switch to case sensitive when uppercase letter used
" Align search results in the middle
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

""""" Colors """""
set background=dark
syntax enable
set termguicolors
colorscheme mysticaltutor
hi Normal ctermbg=none
hi Terminal ctermbg=none
hi Terminal guibg=none
hi Normal guibg=none

""""" Lines + Numbers """""
set nowrap " Don't wrap lines 
set number " Show line numbers
set relativenumber " Make numbers relative to cursor
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber " Relative numbers on in normal mode or focussed
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber " Relative numbers off in insert mode or lost focus
augroup end
set scrolloff=2 "2 = stop 2 from top or bottom; 999 = Keep cursor in middle of screen so screen scrolls with cursor

""""" Tabs, Spaces, Indenting """""
filetype plugin indent on " Recognise file type, load plugins for detected file type, load indents for detected file type
set autoindent
set shiftwidth=4 " >> will shift by 4 spaces
set tabstop=4 " 1 tab is 4 spaces
set softtabstop=4 " Spaces used in insert mode
set expandtab " Replace tabs with spaces
set smarttab " Use shiftwidth at beginning of line and tabstop/softabstop elsewhere

""""" Encoding """""
set encoding=utf-8 " Output encoding shown in terminal
set fileencoding=utf-8 " Output encoding when written to file

""""" Netrw config """""
let g:netrw_liststyle=3 " Tree view
let g:netrw_banner=0 " Hide top banner

""""" Splits """""
set splitbelow
set splitright

""""" Decent wildmenu """""
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

""""" Key Bindings """""
" Disable arrow keys
noremap  <Up> <NOP>
noremap  <Down> <NOP>
noremap  <Left> <NOP>
noremap  <Right> <NOP>
inoremap  <Up> <NOP>
inoremap  <Down> <NOP>
inoremap  <Left> <NOP>
inoremap  <Right> <NOP>

" Left and right to switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Escape bindings
inoremap jj <Esc>

" Move by line (for lines that span multiple rows)
nnoremap j gj
nnoremap k gk

" <leader>q shows stats
nnoremap <leader>q g<c-g>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Quick save
nmap <leader>w :w<CR>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Open new file adjacent to current file
nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>

""""" LSP """""
" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

require "lsp_signature".setup()

require('rust-tools').setup({
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
})

nvim_lsp.gopls.setup {
    cmd = {"gopls", "serve"},
}

-- goimports function for auto running later
function goimports(timeout_ms)
    local context = { only = { "source.organizeImports" } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit)
      end
      if type(action.command) == "table" then
        vim.lsp.buf.execute_command(action.command)
      end
    else
      vim.lsp.buf.execute_command(action)
    end
end

nvim_lsp.intelephense.setup {}

require('nvim-web-devicons').setup {
    default = true;
 }

require('telescope').setup {
    extensions = {
        file_browser = {
            path = "%:p:h",
            grouped = true,
            hidden = true,
            select_buffer = true,
        },
        ["ui-select"] = {
            require("telescope.themes").get_cursor {},
        },
    },
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')
require('telescope').load_extension('ui-select')

EOF

" See `:help vim.lsp.*` for documentation on any of the below functions
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>

nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>D <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>ld <cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>
nnoremap <silent> [d <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>q <cmd>lua vim.diagnostic.set_loclist()<CR>
nnoremap <silent> <leader>fu <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>rr <cmd> lua require('rust-tools.runnables').runnables()<CR>

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },

  experimental = {
    ghost_text = true,
  },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})
EOF

""""" Autocommands """""
" Format on save
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)
autocmd BufWritePre *.go lua goimports(1000)

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.orig set readonly
autocmd BufRead *.pacnew set readonly

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Help filetype detection
autocmd BufRead *.md set filetype=markdown

" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

