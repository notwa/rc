" Vim color file -- TODO
" Maintainer:   TODO
" Last Change:  2012-05-15

set background=dark
highlight clear
let g:colors_name="candycode"

let save_cpo = &cpo
set cpo&vim

" basic highlight groups (:help highlight-groups) {{{

" text {{{

hi Normal       ctermfg=7           ctermbg=0           cterm=NONE

hi Folded       ctermfg=8           ctermbg=0           cterm=NONE

hi LineNr       ctermfg=8           ctermbg=0           cterm=NONE

hi Directory    ctermfg=14          ctermbg=NONE        cterm=NONE
hi NonText      ctermfg=11          ctermbg=NONE        cterm=NONE
hi SpecialKey   ctermfg=10          ctermbg=NONE        cterm=NONE

hi SpellBad     ctermfg=15          ctermbg=1
hi SpellCap     ctermfg=15          ctermbg=4
hi SpellLocal   ctermfg=0           ctermbg=14
hi SpellRare    ctermfg=15          ctermbg=5

hi DiffAdd      ctermfg=15          ctermbg=4           cterm=NONE
hi DiffChange   ctermfg=0           ctermbg=5           cterm=NONE
hi DiffDelete   ctermfg=0           ctermbg=9           cterm=NONE
hi DiffText     ctermfg=15          ctermbg=10          cterm=NONE

" }}}
" borders / separators / menus {{{

hi FoldColumn   ctermfg=7           ctermbg=8           cterm=NONE
hi SignColumn   ctermfg=7           ctermbg=8           cterm=NONE
hi ColorColumn  ctermfg=NONE        ctermbg=8

hi Pmenu        ctermfg=15          ctermbg=8           cterm=NONE
hi PmenuSel     ctermfg=15          ctermbg=12          cterm=NONE
hi PmenuSbar    ctermfg=0           ctermbg=0           cterm=NONE
hi PmenuThumb   ctermfg=7           ctermbg=7           cterm=NONE

hi StatusLine   ctermfg=0           ctermbg=15          cterm=NONE
hi StatusLineNC ctermfg=8           ctermbg=15          cterm=NONE
hi WildMenu     ctermfg=15          ctermbg=4           cterm=NONE
hi VertSplit    ctermfg=15          ctermbg=15          cterm=NONE

hi TabLine      ctermfg=0           ctermbg=15          cterm=NONE
hi TabLineFill  ctermfg=0           ctermbg=15          cterm=NONE
hi TabLineSel   ctermfg=15          ctermbg=0           cterm=NONE

"hi Menu
"hi Scrollbar
"hi Tooltip

" }}}
" cursor / dynamic / other {{{

hi Cursor       ctermfg=0           ctermbg=15          cterm=NONE
hi CursorIM     ctermfg=0           ctermbg=15          cterm=reverse
hi CursorLine   ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi CursorColumn ctermfg=NONE        ctermbg=NONE        cterm=NONE

hi Visual       ctermfg=15          ctermbg=12          cterm=NONE

hi IncSearch    ctermfg=15          ctermbg=3           cterm=NONE
hi Search       ctermfg=15          ctermbg=2           cterm=NONE

hi MatchParen   ctermfg=15          ctermbg=6           cterm=NONE

"hi VisualNOS

" }}}
" listings / messages {{{

hi ModeMsg      ctermfg=11          ctermbg=NONE        cterm=NONE
hi Title        ctermfg=9           ctermbg=NONE        cterm=NONE
hi Question     ctermfg=10          ctermbg=NONE        cterm=NONE
hi MoreMsg      ctermfg=10          ctermbg=NONE        cterm=NONE

hi ErrorMsg     ctermfg=15          ctermbg=9           cterm=NONE
hi WarningMsg   ctermfg=11          ctermbg=NONE        cterm=NONE

" }}}

" }}}
" syntax highlighting groups (:help group-name) {{{

hi Comment      ctermfg=3           ctermbg=NONE        cterm=NONE

hi Constant     ctermfg=9           ctermbg=NONE        cterm=NONE
hi Boolean      ctermfg=9           ctermbg=NONE        cterm=NONE

hi Identifier   ctermfg=11          ctermbg=NONE        cterm=NONE

hi Statement    ctermfg=10          ctermbg=NONE        cterm=NONE

hi PreProc      ctermfg=5           ctermbg=NONE        cterm=NONE

hi Type         ctermfg=12          ctermbg=NONE        cterm=NONE

hi Special      ctermfg=7           ctermbg=NONE        cterm=NONE

hi Underlined   ctermfg=NONE        ctermbg=NONE        cterm=underline

hi Ignore       ctermfg=8           ctermbg=NONE        cterm=NONE

hi Error        ctermfg=15          ctermbg=9           cterm=NONE

hi Todo         ctermfg=0           ctermbg=11          cterm=NONE

" }}}

let &cpo = save_cpo

" vim: fdm=marker fdl=0
