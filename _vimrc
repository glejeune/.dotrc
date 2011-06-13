" colorscheme ir_black

" enable syntax coloring
syntax enable

" use utf8 encoding for vim files and for default file encoding
set encoding=utf-8
set fileencoding=utf-8

" auto complete on tab
set wildmenu

" disable arrow key mappings
"noremap <Up> ""
"noremap <Down> ""
"noremap <Left> ""
"noremap <Right> ""

" tab are replaced by 3 spaces (a la Vidal :()
set expandtab
set tabstop=3

" << / >> right / left shift by 3 spaces
set shiftwidth=3

" copy indent from current line on <CR> 
set autoindent

" map nerdtree to F2
noremap <F2> :NERDTreeToggle<CR>

" TODO : search how to manipulate windows
" Ctrl+w

" TODO : remap Ctrl+V Ctrl+C Ctrl+X Ctrl+Z to their original mapping (see mswin.vim )
" TODO : search how to use buffers 
" TODO : display marks in buffers 
" TODO : macro recording and usage ??? 

" TODO : backspace in insert mode : backspace option
set backspace=eol,start,indent

" Show line number
set nu

" Change list characters and use \l to show/hide list characters
set listchars=tab:▸\ ,eol:¬
nmap <leader>l :set list!<CR>

