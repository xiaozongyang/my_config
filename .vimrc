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


""""" YCM configurations
set completeopt-=preview " remove preview documents diplayed in splited tab
let g:ycm_min_num_of_chars_for_completion = 1 " start matching begin first input character
let g:ycm_seed_identifiers_with_syntax = 1 " enable completion for language keywords
"""""""""""""""""""vim-plug"""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }" NERD tree
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'
Plug 'noplans/lightline.vim'
Plug 'tpope/vim-commentary'
call plug#end()


let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ }

let g:today = strftime("%Y-%m-%d (%A)")
let g:me = "xiaozongyang"

func! AddComment()
    if &filetype == 'python'
        call append(line("."), "'''")
        call append(line(".") + 1, "'''")
    endif

    if &ft == 'c'
        call append(line("."), "/*")
        call append(line(".") + 1, "*/")
    endif
    if &ft == 'html'
        call append(line("."), ["<!--", "-->"])
    endif
    call append(line(".") + 1, "@description: ")
    call append(line(".") + 2, "@parameters: ")
    call append(line(".") + 3, "@return: ")
    call append(line(".") + 4, "@author: ".g:me)
    call append(line(".") + 5, "@created: ".g:today)
    call append(line(".") + 6, "@modified: ".g:today)
endfunc


""""""""""""""""""""program templates"""""""""""""""""""
"autocmd BufNewFile *.py 0r ~/.vim/template/py.tpl
func! HeadComment()
    if &ft == 'python'
        call append(0, "#\!/usr/bin/env python")
        call append(1, "#-*-coding: utf-8-*-")
        call append(2, "#vim:set enc=utf-8 fenc=utf-8:")
        call append(3, "#vim:set tw=100 ts=4 sts=4 sw=4 ai ci:")
        let l:prefix = ""
        let l:start = 4
        let l:multi_beg = "'''"
        let l:multi_end = "'''"
    endif
    if &ft == 'html'
        call append(0, "<!DOCTYPE html>")
        call append(1, ["<!--", "vim:set tw=100 ts=4 sts=4 sw=4 ai ci:","-->"])
        call append(5, ["<html>", "</html>"])
        call append(6, ["<head>", "<title>", "</title>", "</head>"])
        call append(10, ["<body>", "</body>"])
        let l:start = 4
        let l:prefix = "    "
        let l:multi_beg = "<!--"
        let l:multi_end = "-->"
    endif
    call append(l:start, l:multi_beg)
    call append(l:start + 1, l:multi_end)
    call append(l:start + 1, l:prefix."@description: ")
    call append(l:start + 2, l:prefix."@author: ".g:me)
    call append(l:start + 3, l:prefix."@created: ".g:today)
    call append(l:start + 4, l:prefix."@modified: ".g:today)
endfunc


""""""""""""""""""" key maps """""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" map ^T to toggle NERDTree
map <C-t> :NERDTreeToggle<CR>

" bind my shortcuts with prefix C-a
" noremap <C-a>d <Esc>:r !date +\%Y-\%m-\%d <CR>
map <C-a>d :call append(line("."), today) <CR>
map <C-a>c :call AddComment() <CR>

""""""""""""" Event Listeners """""""""""""""""
autocmd BufNewFile *.py,*.html call HeadComment() <CR>
autocmd BufRead *.md set spell

""""""""""""" basic settings """""""""""""""""
set nu rnu" set number and relativenumber on
set listchars=tab:>-,trail:-,eol:$,extends:>,precedes:<,nbsp:. " set list chars
set list
set expandtab
set tw =100 ts=4 sts=4 sw=4 ai " set tabwidth, tabstop, softtabstop, shfitwidth, autoindent
set enc=utf8 fenc=utf8 ff=unix " set encoding, fileencoding, fileformat
set ls=2 " set lastline=2  show statusline
set hls " set highlightsearch
set t_Co=256 " export TERM=xterm-256color before
highlight cursorline ctermbg=gray ctermfg=white

set nocompatible               " be iMproved
filetype off                   " required!

syntax on
set backspace=indent,eol,start " enable backspace to delete
filetype plugin indent on " auto-detect file type
set sc smd " show command and mode

" set vim colorscheme to solarized-light
syntax enable
<<<<<<< HEAD
=======
set bg=dark
>>>>>>> 904d7fe60ce35e2bd1291c37540f3cf35ed2098a
colorscheme solarized
set bg=light
" change hilight search color
hi Search cterm=NONE ctermfg=grey ctermbg=blue

func Lookup()
    let g:vim_dict_window_number = bufwinnr("vim-dict")
    "if the window with name `wim-dict` exists then go to it

    let l:vim_dict_original_file_name = expand("%")
    " generate lookup command with word under cursor
    let l:cmd = "silent $r !ydcv " . expand("<cword>") 

    " jump to `vim-dict` window if exists otherwise create it
    if g:vim_dict_window_number > 0
        exec g:vim_dict_window_number." wincmd w"
    " otherwise create it
    else
        new vim-dict
    endif
    exec cmd
    " jump to orignal window
    let l:vim_dict_original_window_number = bufwinnr(l:vim_dict_original_file_name)
    exec l:vim_dict_original_window_number." wincmd w"

endfunc

"noremap <leader>l :!ydcv <C-r><C-w> <CR>
noremap <leader>l :call Lookup() <CR>
noremap <leader>r :%s/\<<C-r><C-w>\>/
