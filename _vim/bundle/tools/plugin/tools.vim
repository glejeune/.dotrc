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
