""" -*- mode: vim -*-
if &compatible
  set nocompatible
endif

filetype off
" set rtp+=~/.config/nvim/bundle/dein.vim

call plug#begin('~/.vim/plugged')

" config
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'scrooloose/syntastic'
Plug 'flazz/vim-colorschemes'
Plug 'felixhummel/setcolors.vim'
Plug 'sjl/gundo.vim'
Plug 'sjbach/lusty'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'idanarye/vim-merginal'
Plug 'gregsexton/gitv'

" erlang
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-erlang/vim-erlang-tags'
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-omnicomplete'
Plug 'vim-erlang/erlang-motions.vim'
Plug 'vim-erlang/vim-erlang-skeletons'

" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'mhinz/vim-mix-format'

" LFE
Plug 'lfe/vim-lfe'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" Elm
Plug 'ElmCast/elm-vim'

"Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'cespare/vim-toml'

" Language common
Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'

" vimwiki
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'

" Java, Scala, kotlin
Plug 'derekwyatt/vim-scala'
Plug 'udalov/kotlin-vim'

" Markdown
Plug 'mzlogin/vim-markdown-toc'

" Surround
Plug 'rcarraretto/vim-surround'

" HTML, Javascript
Plug 'pangloss/vim-javascript'
Plug 'maksimr/vim-jsbeautify'
Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'
Plug 'slim-template/vim-slim'

" Haskell
Plug 'neovimhaskell/haskell-vim'

" Other
Plug 'dpelle/vim-Grammalecte'
Plug 'godlygeek/tabular'
Plug 'amadeus/vim-mjml'

call plug#end()

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
