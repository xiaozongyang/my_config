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
if !exists("g:ycm_semantic_triggers")
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
"""""""""""""""""""vim-plug"""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }" NERD tree
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'
Plug 'noplans/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Valloric/YouCompleteMe'
call plug#end()


let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ }

let g:today = strftime("%Y-%m-%d (%A)")
let g:me = "xiaozongyang"
let g:tpl_dir = "~/.vim/templates/"

func! AddComment()
    let l:tpl_name = expand('%:e').'-comment.tpl'
    call InsertTemplate(l:tpl_name)
    call MySubstitute('<AUTHOR>', g:me, 'g')
    call MySubstitute('<TODAY>', g:today, 'g')
    "if &ft == 'python':
    "    call InsertTemplate('python-comment.tpl')
    "    call MySubstitute('<AUTHOR>', g:me, 'g')
    "    call MySubstitute('<TODAY>', g:today, 'g')
    "endif
    "if &ft == 'c'
    "    call InsertTemplate('c-comment.tpl')
    "    call MySubstitute('<AUTHOR>', g:me, 'g')
    "    call MySubstitute('<TODAY>', g:today, 'g')
    "endif
    "if &ft == 'html'
    "    call InsertTemplate('html-comment.tpl')
    "    call MySubstitute('<AUTHOR>', g:me, 'g')
    "    call MySubstitute('<TODAY>', g:today, 'g')
    "endif
endfunc

func InsertTemplate(tpl_name)
    exec '0r '.g:tpl_dir.a:tpl_name
endfunc

""""""""""""""""""""program templates"""""""""""""""""""
func OnNewPython()
    call InsertTemplate('py.tpl')
    call MySubstitute('<AUTHOR>', g:me, 'g')
    call MySubstitute('<TODAY>', g:today, 'g')
endfunc

func OnNewHtml()
    call InsertTemplate('html.tpl')
    call MySubstitute('<AUTHOR>', g:me, 'g')
    call MySubstitute('<TODAY>', g:today, 'g')
    set ts=2 sts=2 sw=2
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
colorscheme solarized
set bg=dark
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

func GenerateMakefileOfTex()
    let l:out = expand('%:r').('.pdf')
    new Makefile
    exec '0r '.g:tpl_dir.'tex-makefile.tpl'
    call MySubstitute('<OUT>', l:out, '')
    wq
endfunc

func MySubstitute(pat, expr, flags)
    exec '%s/'.a:pat.'/'.a:expr.'/'.a:flags
endfunc

function OnNewTex()
    exec '0r '.g:tpl_dir.'tex.tpl'
    call MySubstitute('<AUTHOR>', g:me, '')
    call GenerateMakefileOfTex()
endfunc

""""""""""""" Event Listeners """""""""""""""""
autocmd BufNewFile *.py call OnNewPython()
autocmd BufNewFIle *.html call OnNewHtml()
autocmd BufNewFile *.tex call OnNewTex()
autocmd BufRead *.md set spell tw=1000

noremap <leader>l :call Lookup() <CR>
noremap <leader>r :%s/\<<C-r><C-w>\>/
