source ~/.vimrc.bundle

" set language for messages and gui menus
let s:langCode = has('win32') ? 'en' : 'en_US.UTF-8'

" must be set before syntax highlight
let &langmenu = s:langCode
execute 'language message '.s:langCode

" enable syntax coloring
syntax enable
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
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

" tab are replaced by 2 spaces
set expandtab
set tabstop=2

" << / >> right / left shift by 3 spaces
set shiftwidth=2

" copy indent from current line on <CR> 
set autoindent

let mapleader = ","
let maplocalleader = ";"

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
" -> powerline
let g:Powerline_symbols = 'unicode'
set laststatus=2
set t_Co=256
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
" set foldmethod=syntax
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use
":set fmr={,}
":set fdm=marker
":set foldlevelstart=1000

" python-mode
let g:pymode_doc = 0
let g:pymode_lint = 1
let g:pymode_lint_ignore = "E501"

" vim-arduino
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

" TaskJuggler
au BufRead,BufNewFile *.tjp set filetype=taskjuggler
au BufRead,BufNewFile *.tji set filetype=taskjuggler

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

" javascript-libraries-syntax.cim
let g:used_javascript_libs = 'jquery,angularjs'

autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 0
autocmd BufReadPre *.js let b:javascript_lib_use_backbone = 0
autocmd BufReadPre *.js let b:javascript_lib_use_prelude = 0
autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 1

" angularjs
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" vim-easy-align
" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign with a Vim movement
nmap <Leader>a <Plug>(EasyAlign)

command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
function! s:Dec2hex(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    else
      let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No decimal number found'
    endtry
  else
    echo printf('%x', a:arg + 0)
  endif
endfunction

command! -nargs=? -range Hex2dec call s:Hex2dec(<line1>, <line2>, '<args>')
function! s:Hex2dec(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V0x\x\+/\=submatch(0)+0/g'
    else
      let cmd = 's/0x\x\+/\=submatch(0)+0/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No hex number starting "0x" found'
    endtry
  else
    echo (a:arg =~? '^0x') ? a:arg + 0 : ('0x'.a:arg) + 0
  endif
endfunction

"set path to wrangler directory
let g:erlangWranglerPath = '~/bin/wrangler'

"sample wrangler bindings
autocmd FileType erlang vnoremap <leader>e :WranglerExtractFunction<ENTER>
autocmd FileType erlang noremap  <leader>m :WranglerRenameModule<ENTER>
autocmd FileType erlang noremap  <leader>f :WranglerRenameFunction<ENTER>
autocmd FileType erlang noremap  <leader>v :WranglerRenameVariable<ENTER>
autocmd FileType erlang noremap  <leader>p :WranglerRenameProcess<ENTER>
autocmd FileType erlang noremap  <leader>mv :WranglerMoveFunction<ENTER>
autocmd FileType erlang noremap  <leader>u :WranglerUndo<ENTER>

let g:snips_author = "Gregoire Lejeune"
let g:my_email_addr = "gregoire.lejeune@gmail.com"
