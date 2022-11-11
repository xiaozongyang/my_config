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

"""""""""""""""""""vim-plug"""""""""""""""""""""
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }" NERD tree
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'xolox/vim-misc'
" Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align'
Plug 'noplans/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'cpiger/NeoDebug'
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
set incsearch
set nu rnu" set number and relativenumber on
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:. " set list chars
set list
set expandtab
set tw=100 ts=4 sts=4 sw=4 ai " set tabwidth, tabstop, softtabstop, shfitwidth, autoindent
set enc=utf8 fenc=utf8 ff=unix " set encoding, fileencoding, fileformat
set fencs=utf8,cp936,cp18030,big5,latin1
set ls=2 " set lastline=2  show statusline
set hls " set highlightsearch
set t_Co=256 " export TERM=xterm-256color before
set et
set cc=100
set spell
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
highlight cursorline ctermbg=gray ctermfg=white
highlight colorcolumn ctermbg=gray ctermfg=white

set nocompatible               " be iMproved
filetype off                   " required!

syntax on
set backspace=indent,eol,start " enable backspace to delete
filetype plugin indent on " auto-detect file type
set sc smd " show command and mode

" set vim colorscheme to solarized-light
syntax enable
"colorscheme solarized
set bg=light
" change hilight search color
hi Search cterm=NONE ctermfg=grey ctermbg=blue
set exrc
set secure
" foldmethod: indent
set fdm=manual
" foldnestedmax
set fdn=3
set showmatch


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


""""""""""""" Event Listeners """""""""""""""""
au BufNewFile *.py call OnNewPython()
au BufNewFIle *.html call OnNewHtml()
au BufNewFile *.tex call OnNewTex()
au BufNewFile *.go set noet

au BufRead *.md set spell tw=1000
au BufRead *.html set ts=2 sts=2 sw=2
au BufRead *.go set noet nolist
au BufRead *.md call OnReadMarkdown()
au BufRead *.git/COMMIT_EDITMSG se cc=50,72
au BufRead *.c,*.cc,*.cpp,*.h call BindCCKeys()

" au BufRead * :loadview
" au BufWrite * :mkview
au BufNewFile *.c call OnNewC()
au FileType nerdtree se nu rnu
au FileType notes,markdown se tw=500

augroup vimrc
    au BufRead * setlocal fdm=indent
    au BufWinEnter * if &fdm == 'indent' | setlocal fdm=manual | endif
augroup END

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

" ale
let g:ale_c_parse_makefile=1
" let g:ale_c_build_dir="/data00/home/xiaozongyang.solaris/code/cpp/bytestore/build"

" LanguageClient
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['/usr/bin/clangd-11'],
  \ 'c': ['/usr/bin/clangd-11'],
  \ 'go': ['gopls']
  \ }
let g:LanguageClient_serverStderr = '/tmp/clangd.stderr'
nmap <C-p> <Plug>(lcn-menu)
" Or map each action separately
nmap <silent>K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> ren <Plug>(lcn-rename)
nmap <silent> gR <Plug>(lcn-references)
nmap <silent> gs <Plug>(lcn-symbols)
nmap <silent> gi <Plug>(lcn-implementation)

func BindCCKeys()
    nnoremap <leader>cc :e %<.cc<CR>
    nnoremap <leader>cpp :e %<.cpp<CR>
    nnoremap <leader>ct :e %<_test.cc<CR>
    nnoremap <leader>h :e %<.h<CR>
    nnoremap <leader>c :e %<.c<CR>
endfunc

" fzf commands mapping
nnoremap <leader>bf :Buffers<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>wd :Windows<CR>
nnoremap <leader>bl :BLines<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>rg :Rg <C-R><C-W><CR>
" scb: scrollbind
nnoremap <leader>hiss :History/<CR>
nnoremap <leader>hisf :History<CR>

func GitBlame()
    set scb
    tabnew
    r !git blame '#'
    set scb
    set nowrap
    w! /tmp/git.blame
    set ft=cpp
endfunc
nnoremap <leader>gbl :call GitBlame()<CR>

func GitLog()
    set scb
    tabnew
    r !git log -p '#'
    set scb
    set nowrap
    w! /tmp/git.log
    set ft=cpp
endfunc
nnoremap <leader>glg :call GitLog()<CR>

" Easy Align
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '<': { 'pattern': '<<' },
\ '/': {
\     'pattern':         '//\+\|/\*\|\*/',
\     'delimiter_align': 'l',
\     'ignore_groups':   ['!Comment'] },
\ ']': {
\     'pattern':       '[[\]]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       '[()]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ 'd': {
\     'pattern':      ' \(\S\+\s*[;=]\)\@=',
\     'left_margin':  0,
\     'right_margin': 0
\   }
\ }
