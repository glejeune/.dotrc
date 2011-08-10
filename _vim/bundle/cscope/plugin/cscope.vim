" cscope integration

if &cp || exists('g:loaded_cscope')
   finish
endif

if !exists('g:cscope_bin')
   if executable('cscope')
      let g:cscope_bin = 'cscope'
   elseif executable('cscope.exe')
      let g:cscope_bin = 'cscope.exe'
   else
      echomsg 'cscope: cscope command not found, skipping plugin'
      finish
   endif
else
   let g:cscope_bin = expand(g:cscope_bin)
   if !executable(g:cscope_bin)
      echomsg 'cscope: cscope command not found in specified place,'
               \ 'skipping plugin'
      finish
   endif
endif

let g:loaded_cscope = 1

let g:cscope_files_exist=0
if !exists('g:cscope_file') 
   let g:cscope_file = "cscope"
end
let g:cscope_reffile = g:cscope_file . ".out"
let g:cscope_sourcefile = g:cscope_file . ".files"
if filereadable(g:cscope_reffile) && filereadable(g:cscope_sourcefile)
   let g:cscope_reffile=expand(g:cscope_reffile)
   let g:cscope_sourcefile=expand(g:cscope_sourcefile)
   let g:cscope_files_exist=1
end

function! CscopeAdd(ext)
   let find_command="find . -name \"*." . a:ext . "\" > " . g:cscope_sourcefile
   let cscope_command=g:cscope_bin . " -b -f " . g:cscope_reffile . " -i " . g:cscope_sourcefile

   let find_result=system(find_command)
   let cscope_result=system(cscope_command)

   let g:cscope_files_exist=1

   echomsg "cscope reference and source files created : " . g:cscope_reffile . ", " . g:cscope_sourcefile
endfunction
if exists('g:cscope_autogen') 
   call CscopeAdd(g:cscope_autogen)
end
command! -nargs=1 CscopeAdd call CscopeAdd(<f-args>)

function! CscopeFind(index, symbol)
   if g:cscope_files_exist == 0
      echomsg "cscope: no reference and source files found. Use :CscopeAdd to generate them"
   else
      let cscope_command=g:cscope_bin . " -f " . g:cscope_reffile . " -i " . g:cscope_sourcefile .  " -L -" . a:index . " " . a:symbol . " | awk '{ printf(\"%s|%s|\", $1, $3); for(i=4; i<NF; i++) { printf(\" %s\", $i) }; printf(\"\\n\") }'"
      cexpr system(cscope_command)
      botright copen
   end
endfunction
command! -nargs=* CscopeFind call CscopeFind(<f-args>)
nmap <leader>a :CscopeFind 0 <c-r>=expand("<cword>")<CR><CR>
nmap <leader>d :CscopeFind 1 <c-r>=expand("<cword>")<CR><CR>
nmap <leader>t :CscopeFind 4 <c-r>=expand("<cword>")<CR><CR>
nmap <leader>g :CscopeFind 6 <c-r>=expand("<cword>")<CR><CR>

