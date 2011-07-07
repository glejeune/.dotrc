" most intersting stuff is done through breaking things
set nocompatible

" pathogen plugin, requires filetype plugin indent
filetype plugin indent on
call pathogen#infect()
" required to get help on stuff installed through pathogen
call pathogen#helptags()

" set language for messages and gui menus
let s:langCode = has('win32') ? 'en' : 'en_US.UTF-8'

" must be set before syntax highlight
let &langmenu = s:langCode
execute 'language message '.s:langCode

" colorscheme ir_black

" enable syntax coloring
syntax enable
set background=dark
colorscheme solarized

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

let mapleader = ","

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

nmap <leader>n :tabnew<CR>

nmap <leader><up> <C-W>K
nmap <leader><down> <C-W>J
nmap <leader><left> <C-W>H
nmap <leader><right> <C-W>L

set statusline=%f%m\ %{fugitive#statusline()}\ %y\ [POS=%l,%v]\ %=[\ %{strftime(\"%H:%M:%S\")}\ ] 
set laststatus=2
hi StatusLine ctermfg=darkgreen
hi StatusLineNC cterm=none 
function! InsertStatuslineColor(mode)
   if a:mode == 'i'
      hi StatusLine term=reverse ctermfg=darkred
   elseif a:mode == 'r'
      hi StatusLine term=reverse ctermfg=darkmagenta
   else
      hi StatusLine term=reverse ctermfg=darkblue
   endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi StatusLine term=reverse ctermfg=darkgreen

" Find file in current directory and edit it.
function! Find(name)
   let l:list=system("find . -name '".a:name."' | perl -ne 'print \"$.\\t$_\"'")
   let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
   if l:num < 1
      echo "'".a:name."' not found"
      return
   endif
   if l:num != 1
      echo l:list
      let l:input=input("Which ? (CR=nothing)\n")
      if strlen(l:input)==0
         return
      endif
      if strlen(substitute(l:input, "[0-9]", "", "g"))>0
         echo "Not a number"
         return
      endif
      if l:input<1 || l:input>l:num
         echo "Out of range"
         return
      endif
      let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
   else
      let l:line=l:list
   endif
   let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
   execute ":e ".l:line
endfunction
command! -nargs=1 Find :call Find("<args>")

