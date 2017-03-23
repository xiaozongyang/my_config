""""""""""""" basic settings """""""""""""""""
set nu " set number on
set listchars=tab:->,trail:-,eol:$ " set list chars
set list
set expandtab
highlight cursorline ctermbg=gray ctermfg=white

set nocompatible               " be iMproved
filetype off                   " required!
 
syntax on
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
 
""""""""""""""""""""program templates"""""""""""""""""""
autocmd BufNewFile *.py 0r ~/.vim/template/py.tpl

"""""""""""""""""""vim-plug"""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }" NERD tree
Plug 'Valloric/YouCompleteMe'
Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'
call plug#end()

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
