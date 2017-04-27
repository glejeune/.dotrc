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

" Language common
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'garbas/vim-snipmate'

call neobundle#end()

filetype plugin indent on

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
noremap <F2> :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeToggle<CR>

" Snipmate
let g:snips_author = "Gregoire Lejeune"
let g:my_email_addr = "gregoire.lejeune@gmail.com"

set hidden
