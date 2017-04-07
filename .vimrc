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
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'
Plug 'noplans/lightline.vim'
Plug 'JamshedVesuna/vim-markdown-preview' " markdown preview tool
call plug#end()


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" map ^T to toggle NERDTree
map <C-t> :NERDTreeToggle<CR>

" use grip
let vim_markdown_preview_github = 1
let vim_markdown_preview_toggle = 2

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

let g:today = strftime("%Y-%m-%d (%A)")
let g:me = "xiaozongyang"

func AddComment()
    if &filetype == 'python'
        call append(line("."), "'''")
        call append(line(".") + 1, "'''")
    endif

    if &ft == 'c'
        call append(line("."), "/*")
        call append(line(".") + 1, "*/")
    endif
    call append(line(".") + 1, "@description: ")
    call append(line(".") + 2, "@parameters: ")
    call append(line(".") + 3, "@return: ")
    call append(line(".") + 4, "@author: ".g:me)
    call append(line(".") + 5, "@created: ".g:today)
    call append(line(".") + 6, "@modified: ".g:today)
endfunc

" bind my shortcuts with prefix C-a
" noremap <C-a>d <Esc>:r !date +\%Y-\%m-\%d <CR>
map <C-a>d :call append(line("."), today) <CR>
map <C-a>c :call AddComment() <CR>

""""""""""""""""""""program templates"""""""""""""""""""
"autocmd BufNewFile *.py 0r ~/.vim/template/py.tpl
func HeadComment()
    if &ft == 'python'
        call append(0, "\#\!/usr/bin/env python")
        call append(1, "\#-*-coding: utf8-*-")
        call append(2, "\#vim:set enc=utf8:")
        call append(3, "\#vim:set tw=100 ts=4 sts=4 sw=4 ai ci:")
        let l:prefix = "# "
        let l:start = 4
    endif
    call append(l:start, l:prefix."'''")
    call append(l:start + 1, l:prefix."@description: ")
    call append(l:start + 2, l:prefix."@author: ".g:me)
    call append(l:start + 3, l:prefix."@created: ".g:today)
    call append(l:start + 4, l:prefix."@modified: ".g:today)
    call append(l:start + 5, l:prefix."'''")
endfunc

autocmd BufNewFile *.py call HeadComment()
