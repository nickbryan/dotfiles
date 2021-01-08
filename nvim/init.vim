""""" Leader Key """""
let mapleader=" " " Map this first so that we can use it throught the file

"""""" Plugins """""
call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Auto completion
Plug 'caksoylar/vim-mysticaltutor' " The best color scheme ever
Plug 'rust-lang/rust.vim' " Rust configuration
Plug 'airblade/vim-gitgutter' " Git in the gutter
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " Fuzzy finder
Plug 'vim-airline/vim-airline' " Status bar
Plug 'tpope/vim-surround' " Easy update matching brackets etc.
Plug 'jiangmiao/auto-pairs' " Auto match brackets etc.
Plug 'preservim/nerdcommenter' " Easy line commenting
Plug 'fatih/vim-go' " Go support
call plug#end()

"""""" Conquer of Code """""
let g:coc_global_extensions=['coc-rust-analyzer', 'coc-docker', 'coc-explorer', 'coc-phpls']
set nobackup " Some servers have issues with backup files
set nowritebackup " We should be under version control so this is less of an issue
set cmdheight=2 " Give more space for messages at bottom of screen
set updatetime=300 " Default is 4s. Set it to 300ms for quicker auto completion
set shortmess+=c " Don't send messages to |ins-completion-menu|

" Always show signcolumn, otherwise it would shift the text each time
if has("patch-8.1.1564")
    set signcolumn=number " Vim can now merge signcolumn and numbercolumn
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <Leader>rn <Plug>(coc-rename)

""""" CoC Explorer """""
" Open explorer
nmap <Leader>e :CocCommand explorer<CR> 

""""" FZF/RG """""
" Open file search
nmap <Leader>f :Files<CR>
" Open buffer search
nmap <Leader>b :Buffers<CR>
" Search with RipGrep from cwd
nmap <Leader>r :Rg<CR>
" History Search
nmap <Leader>h :History<CR>

""""" Nerd Commenter """""
let g:NERDSpaceDelims=1 " Add one space after commenting
let g:NERDDefaultAlign='left' " Align line-wise comment delimiters flish left instead of following indentation
let g:NERDTrimTrailingWhitespace=1 " Trim white space when uncommenting

""""" Rust.vim """""
let g:rustfmt_autosave=1 " Format file on save

""""" air-line """"
let g:airline_powerline_fonts=1
let g:airline_skip_empty_sections=1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

""""" Vim Go """""
let g:go_def_mapping_enabled=0
let g:go_code_completion_enabled=0
let g:go_fmt_command="goimports"

""""" General """""
set hidden " Hide buffer when opening a new file (instead of closing it)
set visualbell " Don't make any noise
set undofile " Save the undo history when closing a buffer
set undodir=~/.config/nvim/undodir
set modelines=0 " Do not allow modlines in file (potential vilnerablility)
set modeline " See above

""""" Search """""
set hlsearch " Search highlighting
set ignorecase " Ingore case
set incsearch " Show partial matches
set smartcase " Auto switch to case sensitive when uppercase letter used

""""" Colors """""
syntax enable
set termguicolors
colorscheme mysticaltutor
hi Normal ctermbg=none
hi Terminal ctermbg=none
hi Terminal guibg=none
hi Normal guibg=none

""""" Lines + Numbers """""
set number " Show line numbers
set relativenumber " Make numbers relative to cursor
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber " Relative numbers on in normal mode or focussed
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber " Relative numbers off in insert mode or lost focus
augroup end
set scrolloff=999 " Keep cursor in middle of screen so screen scrolls with cursor

""""" Tabs, Spaces, Indenting """""
filetype plugin indent on " Recognise file type, load plugins for detected file type, load indents for detected file type
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

""""" Disable Arrow Keys """""
noremap  <Up> <NOP>
noremap  <Down> <NOP>
noremap  <Left> <NOP>
noremap  <Right> <NOP>
inoremap  <Up> <NOP>
inoremap  <Down> <NOP>
inoremap  <Left> <NOP>
inoremap  <Right> <NOP>

""""" Bindings """""
inoremap jj <Esc>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
