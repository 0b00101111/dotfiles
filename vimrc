"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Basic Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                      " Show line numbers
set nocompatible               " Use Vim defaults instead of Vi
syntax on                      " Enable syntax highlighting
nmap Q <Nop>                   " Disable Ex mode
set mouse+=a                   " Enable mouse support
set shortmess+=I               " Disable startup message
set laststatus=2               " Always show status line
set backspace=indent,eol,start " Make backspace behave normally
set clipboard=unnamedplus      " Use system clipboard
set ruler                      " Show cursor position
set showcmd                    " Display incomplete commands
set statusline=%F%m%r%h%w\ [%{&fileencoding?&fileencoding:&encoding}]\ [POS=%l,%c]\ [LEN=%L]

" Indentation settings for C
set tabstop=4                  " Show existing tab with 4 spaces width
set shiftwidth=4               " When indenting with '>', use 4 spaces width
set expandtab                  " On pressing tab, insert 4 spaces
set softtabstop=4             " Edit as if tabs are 4 characters
set autoindent                 " Copy indent from current line when starting a new line
set smartindent                " Smart autoindenting when starting a new line
set cindent                    " Stricter rules for C programs

" Your existing arrow key mappings to enforce hjkl usage
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right>  <ESC>:echoe "Use l"<CR>
inoremap <Up>  <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Search settings
set ignorecase                 " Ignore case in search patterns
set smartcase                  " Override ignorecase if search pattern has uppercase
set incsearch                  " Show search matches as you type
set hlsearch                   " Highlight search results

" C programming specific settings
set colorcolumn=80            " Show vertical line at column 80 (common C standard)
set signcolumn=yes           " Always show sign column for error indicators
filetype plugin indent on    " Enable file type based indentation
set wildmenu                 " Enhanced command-line completion
set updatetime=300          " Faster completion
set timeoutlen=500         " By default timeoutlen is 1000 ms

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
" Essential plugins
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  " Fuzzy finder core
Plug 'junegunn/fzf.vim'               " Fuzzy finder integration
Plug 'tpope/vim-commentary'           " Easy code commenting
Plug 'rhysd/vim-clang-format'         " C code formatting
Plug 'preservim/nerdtree'             " File explorer
Plug 'itchyny/lightline.vim'          " Status line enhancement
Plug 'dense-analysis/ale'             " Async linting engine

" Additional plugins for C development
Plug 'ludovicchabant/vim-gutentags'   " Automatic tags management. Ctl+] to jump to function definition, Ctl+o go back.
Plug 'jiangmiao/auto-pairs'           " Auto pair brackets
Plug 'vim-scripts/a.vim'              " Quick switching between .c and .h fileas using F4
Plug 'wellle/context.vim'             " Show function context
Plug 'liuchengxu/vim-which-key'       " Command cheatsheet
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF Configuration
nnoremap <C-p> :Files<CR>             " Quick file search
nnoremap <C-f> :Rg<CR>               " Text search in project
nnoremap <leader>t :Tags<CR>         " Search tags

" NERDTree Configuration
nnoremap <C-n> :NERDTreeToggle<CR>    " Toggle file explorer
let NERDTreeShowHidden=1              " Show hidden files
" Close vim if NERDTree is the only window remaining
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Lightline Configuration
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ }

" ALE Configuration
let g:ale_linters = {
\   'c': ['gcc', 'clang', 'cppcheck']
\}

let g:ale_fixers = {
\   'c': [],
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}
let g:ale_fix_on_save = 1               " Fix files automatically on save
let g:ale_sign_error = 'E>'             " Error symbol
let g:ale_sign_warning = 'W>'           " Warning symbol
let g:ale_c_gcc_options = '-Wall -Wextra -Wpedantic -std=c11'  " GCC options

" Clang Format Configuration
let g:clang_format#style_options = {
            \ "BasedOnStyle": "LLVM",
            \ "IndentWidth": 4,
            \ "UseTab": "Never",
            \ "BreakBeforeBraces": "Stroustrup",
            \ "AllowShortIfStatementsOnASingleLine": "false",
            \ "IndentCaseLabels": "false",
            \ "Standard": "C11"}

" Manual clang-format for C files(format entire file)
nnoremap <leader>cf :!clang-format -i %<CR>

" Gutentags Configuration
let g:gutentags_ctags_exclude = ['.git', 'node_modules', 'build']
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Which Key Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map leader key to space
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" Configure timeoutlen for which-key popup
set timeoutlen=500

" Hide status line when which-key popup is visible
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Define prefix dictionary
let g:which_key_map = {
      \ 'name': 'Leader Commands',
      \ 'f': {
          \ 'name': '+file',
          \ 'f': ['Files', 'find files'],
          \ 's': ['w', 'save file'],
          \ 't': ['NERDTreeToggle', 'toggle file tree'],
          \ 'r': ['History', 'recent files'],
          \ 'n': [':enew', 'new file'],
          \ },
      \ 'c': {
          \ 'name': '+code',
          \ 'f': ['ClangFormat', 'format code'],
          \ 'c': ['Commentary', 'toggle comment'],
          \ 'h': [':call AddCHeader()', 'add header comment'],
          \ 'i': [':call AddIncludeGuard()', 'add include guard'],
          \ 'p': [':call AddPrintf()', 'add printf debug'],
          \ 'l': ['ALELint', 'lint code'],
          \ 't': ['ALEToggle', 'toggle linter'],
          \ },
      \ 'b': {
          \ 'name': '+build',
          \ 'b': [':call CompileC()', 'build'],
          \ 'r': [':call CompileAndRun()', 'build and run'],
          \ 'd': [':call CompileDebug()', 'build with debug'],
          \ 'c': [':call CleanBuild()', 'clean build files'],
          \ },
      \ 's': {
          \ 'name': '+search',
          \ 'f': ['Files', 'files'],
          \ 'b': ['Buffers', 'buffers'],
          \ 't': ['Tags', 'tags'],
          \ 'h': ['History', 'file history'],
          \ 'l': ['Lines', 'lines'],
          \ },
      \ 'g': {
          \ 'name': '+goto',
          \ 'd': ['<C-]>', 'goto definition'],
          \ 'b': ['<C-o>', 'go back'],
          \ 'f': ['<C-i>', 'go forward'],
          \ },
      \ 'h': {
          \ 'name': '+help',
          \ 't': ['help', 'open help'],
          \ 'c': [':e ~/.vimrc', 'edit vimrc'],
          \ 'r': [':source ~/.vimrc', 'reload vimrc'],
          \ },
      \ }

" Explicitly register which-key mapping
call which_key#register('<Space>', "g:which_key_map")

" Ensure which-key is triggered on space
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom Functions for C Development
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function to add C file header comment
function! AddCHeader()
    let filename = expand("%:t")
    let header = "/*\n"
    let header .= " * File: " . filename . "\n"
    let header .= " * Author: " . $USER . "\n"
    let header .= " * Date: " . strftime("%Y-%m-%d") . "\n"
    let header .= " * Description: \n"
    let header .= " */\n\n"
    call append(0, split(header, '\n'))
endfunction

" Function to add include guard for header files
function! AddIncludeGuard()
    let guardname = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    let guardname = "_" . guardname . "_"
    call append(0, "#ifndef " . guardname)
    call append(1, "#define " . guardname)
    call append(line("$"), "#endif /* " . guardname . " */")
endfunction

" Function to add printf debug statement
function! AddPrintf()
    let debug_str = 'printf("DEBUG: %s:%d\\n", __FILE__, __LINE__);'
    call append(line("."), debug_str)
endfunction

" Build functions
function! CompileC()
    write
    !gcc -Wall -Wextra -o %< %
endfunction

function! CompileAndRun()
    write
    !gcc -Wall -Wextra -o %< % && ./%
endfunction

function! CompileDebug()
    write
    !gcc -Wall -Wextra -g -o %< %
endfunction

function! CleanBuild()
    !rm -f %
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Additional Key Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F4 to switch between .c and .h files
nnoremap <F4> :A<CR>

" F5 to compile and run
nnoremap <F5> :call CompileAndRun()<CR>

" F6 to compile only
nnoremap <F6> :call CompileC()<CR>

" F7 to compile with debug symbols
nnoremap <F7> :call CompileDebug()<CR>
