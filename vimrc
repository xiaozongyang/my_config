if has('python3')
    silent! python3 1
endif

""""""""""""" tmux configs """""""""""""""""""
" change cursor shape in tmux
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

""""" YCM configurations
set completeopt-=preview " remove preview documents diplayed in splited tab
let g:ycm_min_num_of_chars_for_completion = 1 " start matching begin first input character
let g:ycm_seed_identifiers_with_syntax = 1 " enable completion for language keywords
let g:ycm_server_python_interpreter='python3'

"""""""""""""""""""vim-plug"""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe', {'do': 'python3 install.py --java-completer'}
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }" NERD tree
Plug 'junegunn/fzf'
Plug 'Shougo/vimshell.vim'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'xolox/vim-misc'
Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'
Plug 'noplans/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'tomtom/tcomment_vim'
Plug 'danchoi/elinks.vim'
Plug 'xolox/vim-notes'
Plug 'udalov/kotlin-vim'
Plug 'elzr/vim-json'
Plug 'cespare/vim-toml'
Plug 'puremourning/vimspector'
Plug 'rderik/vim-markdown-toc', { 'branch': 'add-anchors-to-headings/drc2r' }
call plug#end()


let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ }

let g:today = strftime("%Y-%m-%d (%A)")
let g:me = "xiaozongyang"
let g:tpl_dir = "~/.vim/templates/"

"""""""""""""""' fzf configurations """""""""""
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

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
    noremap <leader>e python %
endfunc

func OnNewHtml()
    call InsertTemplate('html.tpl')
    call MySubstitute('<AUTHOR>', g:me, 'g')
    call MySubstitute('<TODAY>', g:today, 'g')
    set ts=2 sts=2 sw=2
endfunc

func OnReadMarkdown()
    let g:vmt_insert_anchors = 1
    let g:vmt_auto_update_on_save = 1
endfunc

""""""""""""""""""" key maps """""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" map ^T to toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" bind my shortcuts with prefix C-a
noremap <leader>today <Esc>:r !date +\%Y-\%m-\%d <CR>
map <C-a>d :call append(line("."), today) <CR>
map <C-a>c :call AddComment() <CR>


""""""""""""" basic settings """""""""""""""""
set nu rnu" set number and relativenumber on
set listchars=tab:>-,trail:-,eol:$,extends:>,precedes:<,nbsp:. " set list chars
set list
set expandtab
set tw =100 ts=4 sts=4 sw=4 ai " set tabwidth, tabstop, softtabstop, shfitwidth, autoindent
set enc=utf8 fenc=utf8 ff=unix " set encoding, fileencoding, fileformat
set fencs=utf8,cp936,cp18030,big5,latin1
set ls=2 " set lastline=2  show statusline
set hls " set highlightsearch
set t_Co=256 " export TERM=xterm-256color before
set et
highlight cursorline ctermbg=gray ctermfg=white

set nocompatible               " be iMproved
filetype off                   " required!

syntax on
set backspace=indent,eol,start " enable backspace to delete
filetype plugin indent on " auto-detect file type
set sc smd " show command and mode

" set vim colorscheme to solarized-light
syntax enable
"colorscheme solarized
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

function OnNewC()
    noremap <leader>c :!gcc % -o %:r -g -Wall <CR>
    noremap <leader>e :!./%:r <CR>
    noremap <leader>d :!gdb %:r <CR>
endfunc

function OnNewCpp()
    noremap <leader>c :!g++ % -o %:r -g -Wall -std=c++11<CR>
    noremap <leader>e :!./%:r <CR>
    noremap <leader>d :!gdb %:r <CR>
endfunc


""""""""""""" Event Listeners """""""""""""""""
au BufNewFile *.py call OnNewPython()
au BufNewFIle *.html call OnNewHtml()
au BufNewFile *.tex call OnNewTex()
au BufRead *.md set spell tw=1000
au BufRead *.html set ts=2 sts=2 sw=2
au BufRead *.go noremap <leader>e :!go run % <CR>
au BufRead * :loadview
au BufWrite * :mkview
au BufNewFile *.c call OnNewC()
au BufNewFile *.cc,*.cpp call OnNewCpp()
au BufRead *.c call OnNewC()
au BufRead *.cc,*.cpp call OnNewCpp()
au FileType nerdtree se nu rnu
au FileType notes,markdown se tw=500
au BufRead *.md call OnReadMarkdown();

augroup vimrc
    au BufRead * setlocal fdm=indent
    au BufWinEnter * if &fdm == 'indent' | setlocal fdm=manual | endif
augroup END

noremap <leader>l :call Lookup() <CR>
" replace current word
noremap <leader>r :%s/\<<C-r><C-w>\>
" remove trailing spaces
noremap <leader>t :%s/\s\+$// <CR>
" search selected text as exact text
vnoremap // y/\V<C-R>"<CR>
vnoremap <leader>64 :'<,'>!python -m base64 -d <CR>

command DiffOrig vert new | se bt=nofile | r ++edit #
    \ | 0d_ | diffthis | wincmd p | diffthis

" notes
let g:notes_directories = ['~/Documents/Notes']
