set nocompatible " screw vi

if (&term =~ "^xterm") " enable colors on any xterm
	let &t_Co=256
	let &t_AF="\e[38;5;%dm"
	let &t_AB="\e[48;5;%dm"
endif

syntax enable " required for folding as well

if has('gui_running')
	set guioptions-=m " hide menu
	set guioptions-=T " hide toolbar"
	set guifont=Consolas:h9
	set columns=84
	set lines=36
	cd $HOME " might not be ideal...

	colorscheme candycode
else
	colorscheme Tomorrow-Night

	set colorcolumn=79
endif

set nomodeline " ignore vim settings in files
set backupdir=~/.vim/backup " put tilde files elsewhere

set number " lines
set hlsearch " highlight
let c_syntax_for_h=1 " use C highlighting for .h files

set foldmethod=syntax
set foldlevelstart=99
"set smartindent " automatic indentation
set nosmartindent

set backspace=eol,start,indent " make backspace useful

" word wrapping
set nowrap
set nolinebreak

" 8 space tabs
set tabstop=8
set shiftwidth=8
set smarttab

" 4 spaces as tabs for various languages
au FileType bash,sh,zsh,awk,python,lua setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
au BufRead,BufNewFile *.json setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
