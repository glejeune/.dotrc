au FileType ruby map <leader>r :!ruby % <CR>
au FileType scala map <leader>r :!scala % <CR>
au FileType php map <leader>r :!php % <CR>
au FileType python map <leader>r :!python % <CR>
au FileType perl map <leader>r :!perl % <CR>
au FileType lua map <leader>r :!lua % <CR>
au FileType sh map <leader>r :!sh % <CR>

au BufEnter *.scala setl formatprg=scala\ -cp\ ./ext/scalariform_2.8.0-0.1.0.jar\ scalariform.commandline.Main\ --forceOutput
