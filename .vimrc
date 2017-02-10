""""""""""""" basic settings """""""""""""""""
set nu " set number on
set listchars=tab:->,trail:-,eol:$ " set list chars
set list
set ts=4 sts=4 sw=4 tw=100 " set tablestop softtablestop shiftwidth textwidth
set ai ci " set autoindent set cindent
set encoding=utf8 " set encoding
set ff=unix " set fileformart
set hls " set highlightsearch
" set cursorline
set ruler
set sc " set showcmd
set smd" se showmod
set expandtab
highlight cursorline ctermbg=gray ctermfg=white

set nocompatible               " be iMproved
filetype off                   " required!
 
set backspace=indent,eol,start " enable backspace to delete
filetype plugin indent on " auto-detect file type

""""""""""""" tmux configs """""""""""""""""""
" change cursor shape in tmux
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" display background color in tmux
if exists('$TMUX')
  set term=screen-256color
endif

" use Vundle to manage bundles
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
 
""""""""""""""""""""""vundle"""""""""""""""""
" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'
Bundle 'maksimr/vim-jsbeautify'
Plugin 'editorconfig-vim' " config indent_style and indent_size, etc.

" for js
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" for jsx
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
nmap <c-p> :set paste! <cr>
