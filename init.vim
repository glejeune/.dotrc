source ~/.config/nvim/bundle.vim

" use utf8 encoding for vim files and for default file encoding
set encoding=utf-8
set fileencoding=utf-8

" auto complete on tab
set wildmenu

" tab are replaced by 2 spaces
set expandtab
set tabstop=2

" << / >> right / left shift by 3 spaces
set shiftwidth=2

" copy indent from current line on <CR>
set autoindent

let mapleader = ","
let maplocalleader = ";"

" backspace in insert mode : backspace option
set backspace=eol,start,indent

" Show line number
set nu

" Change list characters and use \l to show/hide list characters
set listchars=tab:▸\ ,eol:¬
nmap <leader>l :set list!<CR>

nmap <leader>n :tabnew<CR>

nmap <leader><up> <C-W>K
nmap <leader><down> <C-W>J
nmap <leader><left> <C-W>H
nmap <leader><right> <C-W>L
nmap <leader>$ <C-]>
nmap <leader><space> :nohlsearch<CR>
nmap <leader>t :vsplit term://zsh<CR>

" search
set hlsearch
hi Search term=underline cterm=underline ctermfg=5

" Bubble multiple lines
nmap <C-S-Up> ddkP
nmap <C-S-Down> ddp
" Bubble single lines
vmap <C-S-Up> xkP`[V`]
vmap <C-S-Down> xp`[V`]

" Page Up/Down
nmap <C-Up> <C-b>
nmap <C-Down> <C-f>

" Window
noremap w <C-w>
noremap W <C-w><C-w>

"  Set folding stuff
" set foldmethod=syntax
set foldmethod=manual   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

set clipboard=unnamedplus
set mouse-=a

nmap <leader>M :!shiba --detach %<CR><CR>

if filereadable(expand('.local.vimrc'))
  source .local.vimrc
endif
