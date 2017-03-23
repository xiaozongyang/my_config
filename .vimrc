""""""""""""" basic settings """""""""""""""""
set nu " set number on
set listchars=tab:->,trail:-,eol:$ " set list chars
set list
set expandtab
set tw =100 ts=4 sts=4 sw=4 ai " set tabwidth, tabstop, softtabstop, shfitwidth, autoindent
set enc=utf8 fenc=utf8 ff=unix " set encoding, fileencoding, fileformat
set sc smd " show command and mode
set ls=2 " set lastline=2  show statusline
set hls " set highlightsearch
set t_Co=256 " export TERM=xterm-256color before
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

""""""""""""""""""""program templates"""""""""""""""""""
autocmd BufNewFile *.py 0r ~/.vim/template/py.tpl

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

"""""""""""""""""""vim-plug"""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }" NERD tree
Plug 'Valloric/YouCompleteMe', {'do': function('BuildYCM')}
Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/noplans/lightline.vim.git'
call plug#end()


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" map ^T to toggle NERDTree
map <C-t> :NERDTreeToggle<CR>

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

