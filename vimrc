" vim:cc=79,39
set nocompatible                      " screw vi

if has('multi_byte')
    scriptencoding utf-8              " allow it in this script
    set termencoding=utf-8            " and this terminal supports it
    set encoding=utf-8                " and the default file is in it
endif

if (&term =~ "^xterm")                " enable colors on any xterm
    let &t_Co=256
    let &t_AF="\e[38;5;%dm"
    let &t_AB="\e[48;5;%dm"
endif

if has('syntax')
    syntax enable                     " required for folding as well
    set hlsearch                      " highlight search results
endif

if has('gui_running')
    set guioptions-=m                 " hide menu
    set guioptions-=T                 " hide toolbar
    set guifont=Consolas:h9
    set columns=84
    set lines=36
    cd $HOME                          " might not be ideal...

    colorscheme candycode
else
    colorscheme Tomorrow-Night

    set colorcolumn=79
endif

set history=512                       " command lines to remember

set ruler                             " write out the cursor position
set lazyredraw                        " when executing macros, untyped things

if has('title')|set title|endif       " terminal title

" be less verbose with some terms and tell vim to shut up
set shortmess=atI

" lower the priority of tab-completing files with these extensions
set suffixes=.bak,~,.swp,.o,.log,.out

set noerrorbells visualbell t_vb=     " disable bells

" TODO: check if dir exists
set backupdir=~/.vim/backup           " put tilde files elsewhere

set scrolloff=3                       " row context during scrolling
set sidescrolloff=2                   " col context during scrolling

set number                            " lines
let c_syntax_for_h=1                  " use C highlighting for .h files

set incsearch                         " show first search result as we type
set ignorecase                        " insensitive searching
set smartcase                         " except when uppercase is used

set infercase                         " use existing case when ins-completing

set foldmethod=syntax
set foldlevelstart=99                 " start with everything unfolded

if 0
    set autoindent                    " when creating newline, use same indent
    if has('smartindent')
        set smartindent               " automatic indents with a lot of stuff
    endif
endif " it's really just annoying though

set diffopt+=iwhite                   " ignore whitespace in diff command

" word wrapping
set nowrap
set nolinebreak

set tabstop=8 shiftwidth=8 smarttab   " 8 space tabs

function! TabFour()
    setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
endfunction

if has('autocmd')
    augroup tabs                      " 4 spaces as tabs for various languages
        au!
        au FileType bash,sh,zsh,awk,python,lua,vim call TabFour()
        au BufRead,BufNewFile *.json call TabFour()
    augroup END

    " attempt to preserve cursor position
    " FIXME: waits for input after running
    autocmd BufReadPost *
    \   if line("'\"") > 1 && line("'\"") <= line("$") |
    \     exe "normal! g`\"" |
    \   endif
endif

set backspace=eol,start,indent        " make backspace useful

" easy indent/unindent
nn <tab> >>
nn <s-tab> <<
" indentation without ending selection
vn <silent> <tab> >gv
vn <silent> <s-tab> <gv

" might make return useful
"nn <s-cr> J
"nn <c-cr> dd
" oh wait, terminals don't do that...

nn <F5>    :w<cr>
nn <F8>    :e<cr>
nn <F10>   :q<cr>
nn <c-F5>  :w!<cr>
nn <c-F8>  :e!<cr>
nn <c-F10> :q!<cr>
nn <s-F5>  :wall<cr>
"nn <s-F8>  :eall<cr>
nn <s-F10> :qall<cr>

" bad habits
no <up> <nop>
no <down> <nop>
no <left> <nop>
no <right> <nop>
ino <up> <nop>
ino <down> <nop>
ino <left> <nop>
ino <right> <nop>
nn <c-up> <c-y>
nn <c-down> <c-e>
nn <c-s-up> :m-2<cr>
nn <c-s-down> :m+1<cr>

" rebind annoying things
nn Q gq
nn K <nop>

if v:version < 703                    " even debian stable has 7.3, so...
    set nomodeline
else
    if &termencoding == "utf-8"
        set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
    else
        set list listchars=tab:>-,trail:.,extends:>,nbsp:_
    endif
endif
