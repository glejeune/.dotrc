" ============================================================================
" File:        maven.vim
" Description: Vim maven integration
" Author:      Gregoire Lejeune <gregoire.lejeune@free.fr>
" Licence:     Vim licence
" Website:     http://algorithmique.net
" Version:     0.1
" ============================================================================

if &cp || exists('g:loaded_maven')
   finish
endif

if !exists('g:maven_mvn_bin')
   if executable('mvn')
      let g:maven_mvn_bin = 'mvn'
   elseif executable('mvn.exe')
      let g:maven_mvn_bin = 'mvn.exe'
   elseif executable('maven')
      let g:maven_mvn_bin = 'maven'
   elseif executable('maven.exe')
      let g:maven_mvn_bin = 'maven.exe'
   else
      echomsg 'Maven: mvn command not found, skipping plugin'
      finish
   endif
else
   let g:maven_mvn_bin = expand(g:maven_mvn_bin)
   if !executable(g:maven_mvn_bin)
      echomsg 'Maven: mvn command not found in specified place,'
               \ 'skipping plugin'
      finish
   endif
endif

let g:loaded_maven = 1

function! Mvn(args)
   let maven_command=g:maven_mvn_bin . " " . a:args
   "echo system(maven_command . " " . a:args)
   execute "!" . maven_command . ""
endfunction
command! -nargs=* Mvn call Mvn(<q-args>)
command! MvnClean call Mvn("clean")
command! MvnTestCurrent call Mvn("-DfailIfNoTests=false -Dtest=" . expand("%:t:r") . " test")
