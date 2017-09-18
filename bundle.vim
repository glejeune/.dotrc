""" -*- mode: vim -*-
if &compatible
  set nocompatible
endif

filetype off
set rtp+=~/.config/nvim/bundle/dein.vim

if dein#load_state(expand('~/.config/nvim/bundle/'))
  call dein#begin(expand('~/.config/nvim/bundle/'))

  call dein#add(expand('~/.config/nvim/bundle/dein.vim'))

" config
  call dein#add('scrooloose/nerdtree')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('kien/ctrlp.vim')
  call dein#add('rking/ag.vim')
  call dein#add('scrooloose/syntastic')
  call dein#add('flazz/vim-colorschemes')
  call dein#add('felixhummel/setcolors.vim')
  call dein#add('sjl/gundo.vim')
  call dein#add('sjbach/lusty')

" Git
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('idanarye/vim-merginal')

" erlang
  call dein#add('vim-erlang/vim-erlang-runtime')
  call dein#add('vim-erlang/vim-erlang-tags')
  call dein#add('vim-erlang/vim-erlang-compiler')
  call dein#add('vim-erlang/vim-erlang-omnicomplete')
  call dein#add('vim-erlang/erlang-motions.vim')
  call dein#add('vim-erlang/vim-erlang-skeletons')

" Elixir
  call dein#add('elixir-lang/vim-elixir')

" LFE
  call dein#add('lfe/vim-lfe')

" Ruby
  call dein#add('vim-ruby/vim-ruby')
  call dein#add('tpope/vim-rails')

" Elm
  call dein#add('ElmCast/elm-vim')

"Rust
  call dein#add('rust-lang/rust.vim')
  call dein#add('racer-rust/vim-racer')
  call dein#add('cespare/vim-toml')

" Language common
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('tomtom/tlib_vim')
  call dein#add('MarcWeber/vim-addon-mw-utils')
  call dein#add('garbas/vim-snipmate')

" vimwiki
  call dein#add('vimwiki/vimwiki')
  call dein#add('mattn/calendar-vim')

" Java, Scala, kotlin
  call dein#add('derekwyatt/vim-scala')
  call dein#add('udalov/kotlin-vim')

" Markdown
  call dein#add('mzlogin/vim-markdown-toc')

" Surround
  call dein#add('rcarraretto/vim-surround')

" HTML, Javascript
  call dein#add('pangloss/vim-javascript')
  call dein#add('maksimr/vim-jsbeautify')
  call dein#add('othree/yajs.vim')
  call dein#add('mxw/vim-jsx')
  call dein#add('slim-template/vim-slim.git')

" Haskell
  call dein#add('neovimhaskell/haskell-vim')

" Other
  call dein#add('dpelle/vim-Grammalecte')

  call dein#end()
  call dein#save_state()
endif

" -- config -------------------------------------------------------------------

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
let s:mycolors = ['Benokai', 'brogrammer', 'buddy', 'buttercream', 'carvedwood', 'cobalt2', 'deepsea', 'emacs', 'fruidle']
colorscheme Benokai
"colorscheme badwolf

" Gundo
nmap <leader>u :GundoToggle<CR>

" Ruby
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Elm
let g:elm_format_autosave = 1

" map nerdtree to F2
let g:NERDTreeWinSize=45
nmap <leader>f :NERDTreeToggle<CR>
noremap <F2> :NERDTreeToggle<CR>

" Snipmate
let g:snips_author = "Gregoire Lejeune"
let g:my_email_addr = "gregoire.lejeune@gmail.com"

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

let g:vimwiki_hl_headers = 1
let g:vimwiki_list = [{
      \ 'path': '~/gregoire.lejeune@gmail.com/lejeun.es/wiki',
      \ 'path_html': '~/gregoire.lejeune@gmail.com/lejeun.es/html',
      \ 'template_path': '~/gregoire.lejeune@gmail.com/lejeun.es/vimwiki-assets',
      \ 'template_default': 'default',
      \ 'template_ext': '.tpl',
      \ 'auto_export': 0,
      \ 'auto_toc': 0},
      \ {'path': '~/gregoire.lejeune@gmail.com/work',
      \ 'path_html': '~/gregoire.lejeune@gmail.com/work_html',
      \ 'auto_toc': 0}]
set hidden
syntax enable
filetype plugin indent on

" Grammalecte
let g:grammalecte_cli_py='~/bin/dicollecte/cli.py'
