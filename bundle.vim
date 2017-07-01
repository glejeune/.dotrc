""" -*- mode: vim -*-
set nocompatible

filetype off
set rtp+=~/.config/nvim/bundle/neobundle.vim
call neobundle#begin(expand('~/.config/nvim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" config
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'felixhummel/setcolors.vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'sjbach/lusty'

" Git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'idanarye/vim-merginal'

" erlang
NeoBundle 'vim-erlang/vim-erlang-runtime'
NeoBundle 'vim-erlang/vim-erlang-tags'
NeoBundle 'vim-erlang/vim-erlang-compiler'
NeoBundle 'vim-erlang/vim-erlang-omnicomplete'
NeoBundle 'vim-erlang/erlang-motions.vim'
NeoBundle 'vim-erlang/vim-erlang-skeletons'

" Elixir
NeoBundle 'elixir-lang/vim-elixir'

" LFE
NeoBundle 'lfe/vim-lfe'

" Ruby
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'

" Elm
NeoBundle 'ElmCast/elm-vim'

"Rust
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'racer-rust/vim-racer'
NeoBundle 'cespare/vim-toml'

" Language common
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'garbas/vim-snipmate'

" vimwiki
NeoBundle 'vimwiki/vimwiki'
NeoBundle 'mattn/calendar-vim'

" kotlin
NeoBundle 'udalov/kotlin-vim'

" Markdown
NeoBundle 'mzlogin/vim-markdown-toc'

" Surround
NeoBundle 'rcarraretto/vim-surround'

" HTML, Javascript
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundle 'othree/yajs.vim'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'slim-template/vim-slim.git'

" Other
NeoBundle 'dpelle/vim-Grammalecte'

call neobundle#end()

NeoBundleCheck

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
syntax on
filetype plugin indent on

" Grammalecte
let g:grammalecte_cli_py='~/bin/dicollecte/cli.py'
