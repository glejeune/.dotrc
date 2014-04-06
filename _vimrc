source ~/.vimrc.bundle

" set language for messages and gui menus
let s:langCode = has('win32') ? 'en' : 'en_US.UTF-8'

" must be set before syntax highlight
let &langmenu = s:langCode
execute 'language message '.s:langCode

" enable syntax coloring for solarized
syntax enable
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized
set foldmethod=syntax

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

" tab are replaced by 2 spaces
set expandtab
set tabstop=2

" << / >> right / left shift by 3 spaces
set shiftwidth=2

" copy indent from current line on <CR> 
set autoindent

let mapleader = ","

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
nmap <leader>$ <C-]> 
nmap <leader><space> :nohlsearch<CR>

nmap <leader>u :GundoToggle<CR>

" Statusline
" set statusline=%f%m\ %{fugitive#statusline()}\ %y\ [POS=%l,%v]\ %=[\ %{strftime(\"%H:%M:%S\")}\ ]\ %#warningmsg#\ %{SyntasticStatuslineFlag()}\ %* 
" set laststatus=2
" hi StatusLine ctermfg=darkgreen
" hi StatusLineNC cterm=none 
" function! InsertStatuslineColor(mode)
"    if a:mode == 'i'
"       hi StatusLine term=reverse ctermfg=darkred
"    elseif a:mode == 'r'
"       hi StatusLine term=reverse ctermfg=darkmagenta
"    else
"       hi StatusLine term=reverse ctermfg=darkblue
"    endif
" endfunction
" 
" au InsertEnter * call InsertStatuslineColor(v:insertmode)
" au InsertLeave * hi StatusLine term=reverse ctermfg=darkgreen
set encoding=utf8
set termencoding=utf8
let g:Powerline_symbols='unicode'
set t_Co=256
set laststatus=2
set noshowmode
set fillchars+=stl:\ ,stlnc:\

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

" map nerdtree to F2
let g:NERDTreeWinSize=45
noremap <F2> :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeToggle<CR>

" tagbar configuration
let g:tagbar_width=45
let g:tagbar_ctags_bin = "/usr/local/bin/ctags"
noremap <F3> :TagbarToggle<CR>

" DiffTree
noremap <F4> :DiffOrigToggle<CR>

"  Set folding stuff
:set fmr={,}
:set fdm=marker
:set foldlevelstart=1000

" python-mode
let g:pymode_doc = 0
let g:pymode_lint = 1
let g:pymode_lint_ignore = "E501"

" vim-arduino
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

" Set a nicer foldtext function
set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart)
  if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
    let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
    let linenum = v:foldstart + 1
    while linenum < v:foldend
      let line = getline( linenum )
      let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
      if comment_content != ''
        break
      endif
      let linenum = linenum + 1
    endwhile
    let sub = initial . ' ' . comment_content
  else
    let sub = line
    let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
    if startbrace == '{'
      let line = getline(v:foldend)
      let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
      if endbrace == '}'
        let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
      endif
    endif
  endif
  let n = v:foldend - v:foldstart + 1
  let info = " " . n . " lines"
  let sub = sub . "                                                                                                                  "
  let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
  let fold_w = getwinvar( 0, '&foldcolumn' )
  let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
  return sub . info
endfunction

" GUI options OFF
" remove gui icons bar
set guioptions-=T
" remove menus
set guioptions-=m
set guioptions-=g
" remove all scrollbars
set guioptions-=R
set guioptions-=r
set guioptions-=L
set guioptions-=l

let g:fuf_modesDisable=[]
let g:slime_target = "tmux"
set t_Co=256

" vim-notes configuration
let g:notes_directories = ['~/Dropbox/Shared Notes']
