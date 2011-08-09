" Find file in current directory and edit it.
let g:findprg="find\\ .\\ -type\\ f\\ -name\\ "
let g:findprgend="-exec bash -c \"echo '{}':0:0\" \\\;"
function! Find(args)
    let grepprg_bak=&grepprg
    exec "set grepprg=" . g:findprg
    execute "silent! grep \"" . a:args . "\" " . g:findprgend
    botright copen
    let &grepprg=grepprg_bak
    exec "redraw!"
endfunction
command! -nargs=* -complete=file Find call Find(<q-args>)

" Use VF in VIM ;)
function! Vf(name)
   let l:list=system("sh -c \"eval $(ruby $VF_HOME/vf.rb -l)\" | grep " . a:name . " | awk -F: '{print $2}' | sed -e 's/^ *//g'")
   let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
   if l:num < 1
      echo "'".a:name."' not found"
      return
   endif
   if l:num > 1
      echo "'".a:name."' ambigous"
      return
   endif
   execute "silent! cd " . l:list
endfunction
command! -nargs=* -complete=file Vf call Vf(<q-args>)

