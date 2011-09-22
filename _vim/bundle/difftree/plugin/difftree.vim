
" command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

let s:next_diff_buffer_number = 1
let s:DiffBufName = 'Diff_buffer_'

function! s:initDiffVariable(var, value)
    if !exists(a:var)
        exec 'let ' . a:var . ' = ' . "'" . substitute(a:value, "'", "''", "g") . "'"
        return 1
    endif
    return 0
endfunction

call s:initDiffVariable("g:DiffWinPos", "left")

function! s:exec(cmd)
    let old_ei = &ei
    set ei=all
    exec a:cmd
    let &ei = old_ei
endfunction

function! s:getDiffWinNum()
   if exists("t:DiffBufName")
      return bufwinnr(t:DiffBufName)
   else 
      return -1
   endif
endfunction

function! s:nextBufferName()
    let name = s:DiffBufName . s:next_diff_buffer_number
    let s:next_diff_buffer_number += 1
    return name
endfunction

function! s:createDiffWin()
    "create the nerd tree window
    let splitLocation = g:DiffWinPos ==# "left" ? "topleft " : "botright "

    if !exists('t:DiffBufName')
        let t:DiffBufName = s:nextBufferName()
        silent! exec splitLocation . 'vertical new' 
" | set bt=nofile | read # | 0d_ | diffthis | wincmd p | diffthis | wincmd p | edit ' . t:DiffBufName . ' | wincmd p'
        silent! exec "edit " . t:DiffBufName
"    else
"        silent! exec splitLocation . 'vertical split'
"        silent! exec "buffer " . t:DiffBufName
    endif
endfunction

"function! s:diffExistsForTab()
"    return exists("t:DiffBufName")
"endfunction

function! s:isDiffOpen()
    return s:getDiffWinNum() != -1
endfunction

function! s:closeDiff()
    if !s:isDiffOpen()
        throw "DiffTree.NoDiffFoundError: no Diff is open"
    endif

    if winnr("$") != 1
        if winnr() == s:getDiffWinNum()
            wincmd p
            let bufnr = bufnr("")
            wincmd p
        else
            let bufnr = bufnr("")
        endif

        call s:exec(s:getDiffWinNum() . " wincmd w")
        close
        call s:exec(bufwinnr(bufnr) . " wincmd w")
    else
        close
    endif
   unlet t:DiffBufName
endfunction

function! s:toggle()
        if !s:isDiffOpen()
            call s:createDiffWin()
        else
            call s:closeDiff()
        endif
endfunction

command! DiffFileToggle :call s:toggle()
