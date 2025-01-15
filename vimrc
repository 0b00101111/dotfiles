"Show line numbers: 
"
"
set number
"set relativenumber

" noncompatible mode. disables Vi compatibility and unlocks Vim's full potential.
set nocompatible

" Turn on syntax highlighting: 
syntax on

" Stop Q from doing its stupid default behaviour: 
nmap Q <Nop>

" Stop the tabs from being so incredibly large: 
set tabstop=4

" Map the arrow keys to display a message suggesting the use of Vim’s hjkl navigation keys instead
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right>  <ESC>:echoe "Use l"<CR>
inoremap <Up>  <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Enable mouse support. You can click to position the cursor.(Not Recommended)
set mouse+=a

" Disable the default Vim startup message.
set shortmess+=I

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Highlight search results
set hlsearch

" Use system clipboard
set clipboard=unnamedplus

" Enhance status line
set ruler              " Show the cursor position (line and column)
set showcmd            " Display incomplete commands in the status line
set statusline=%F%m%r%h%w\ [%{&fileencoding?&fileencoding:&encoding}]\ [POS=%l,%c]\ [LEN=%L]  " Custom status line


" Plugins
call plug#begin()

Plug 'junegunn/fzf.vim'  
Plug 'tpope/vim-commentary'     
Plug 'rhysd/vim-clang-format'   
Plug 'preservim/nerdtree'       
Plug 'itchyny/lightline.vim'    
Plug 'dense-analysis/ale'       

call plug#end()

