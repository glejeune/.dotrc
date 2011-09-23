
" Original ! (see :help :DiffOrig)
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

let s:diff_buffer_number = -1

function! s:diffToggle()
   if s:diff_buffer_number == -1
      exec 'vert new | set bt=nofile | set ma | r # | 0d_ | diffthis | set noma | wincmd p | diffthis'
      let s:diff_buffer_number = last_buffer_nr()
   else
      exec s:diff_buffer_number . "bw"
      let s:diff_buffer_number = -1
   endif
endfunction

command! DiffOrigToggle call s:diffToggle()

