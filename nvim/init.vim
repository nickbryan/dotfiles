set shell=/bin/bash " Fish can be a bit of a nightmare

""""" Leader Key """""
let mapleader=" " " Map this first so that we can use it throught the file

"""""" Plugins """""
call plug#begin('~/.config/nvim/plugged')

" VIM enhancements
Plug 'editorconfig/editorconfig-vim' " Suppport for editor config files
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
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Semantic language support
Plug 'neovim/nvim-lspconfig' " Base config for lsp
Plug 'nvim-lua/lsp_extensions.nvim' " Allows inlay hints from rust analyzer
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'} " A completion engine plugin for neovim written in Lua
Plug 'ray-x/lsp_signature.nvim' " Show function signature when you type

" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'dag/vim-fish'
Plug 'plasticboy/vim-markdown'

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

""""" LSP configuration """"
lua << END
local cmp = require'cmp'

local lspconfig = require'lspconfig'
cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  },
  sources = cmp.config.sources({
    -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  })
})

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Get signatures (and _only_ signatures) when in argument lists.
  require "lsp_signature".on_attach({
    doc_lines = 0,
    handler_opts = {
      border = "none"
    },
  })
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
  capabilities = capabilities,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
END

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

""""" FZF/RG """""
" Open file search
nmap <Leader>f :Files<CR>
" Open buffer search
nmap <Leader>b :Buffers<CR>
" History Search
nmap <Leader>h :History<CR>
" <leader>s for Rg search
noremap <leader>s :Rg<CR>
function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

""""" Markdown """""
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1

""""" Rust.vim """""
let g:rustfmt_autosave=1 " Format file on save
let g:rustfmt_emit_files = 1 " Overwrite the file
let g:rustfmt_fail_silently = 0

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
set mouse=a " Enable mouse in all modes

""""" Completion """""
" Better completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
" Better display for messages
set cmdheight=2
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

" ; as :
nnoremap ; :

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

""""" Autocommands """""
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
