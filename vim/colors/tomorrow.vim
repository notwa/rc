" terminal color assuming tomorrow night are the 16 colors
set background=dark
hi clear
syntax reset

let g:colors_name = "tomorrow"

"%s/call <SID>X("\(\w\+\)", \([^,]*\), \([^,]*\), \([^)]*\))/hi \1 ctermfg=\2 ctermbg=\3 cterm=\4/g

" Vim Highlighting
hi Normal ctermfg=7 ctermbg=0
hi LineNr ctermfg=238
hi NonText ctermfg=8
hi SpecialKey ctermfg=8
hi Search ctermfg=0 ctermbg=11
hi TabLine ctermfg=7 ctermbg=0 cterm=reverse
hi StatusLine ctermfg=239 ctermbg=11 cterm=reverse
hi StatusLineNC ctermfg=239 ctermbg=7 cterm=reverse
hi VertSplit ctermfg=239 ctermbg=239 cterm=none
hi Visual ctermbg=8
hi Directory ctermfg=4
hi ModeMsg ctermfg=2
hi MoreMsg ctermfg=2
hi Question ctermfg=2
hi WarningMsg ctermfg=1
hi MatchParen ctermbg=8
hi Folded ctermfg=245 ctermbg=0
hi FoldColumn ctermbg=0
if version >= 700
	hi CursorLine ctermbg=239 cterm=none
	hi CursorColumn ctermbg=239 cterm=none
	hi PMenu ctermfg=7 ctermbg=8 cterm=none
	hi PMenuSel ctermfg=7 ctermbg=8 cterm=reverse
	hi SignColumn ctermbg=0 cterm=none
end
if version >= 703
	hi ColorColumn ctermbg=233 cterm=none
end

" Standard Highlighting
hi Comment ctermfg=245
hi Todo ctermfg=245 ctermbg=0
hi Title ctermfg=245
hi Identifier ctermfg=1 cterm=none
hi Statement ctermfg=7
hi Conditional ctermfg=7
hi Repeat ctermfg=7
hi Structure ctermfg=5
hi Function ctermfg=4
hi Constant ctermfg=3
hi String ctermfg=2
hi Special ctermfg=7
hi PreProc ctermfg=5
hi Operator ctermfg=6 cterm=none
hi Type ctermfg=4 cterm=none
hi Define ctermfg=5 cterm=none
hi Include ctermfg=4
"hi Ignore ctermfg="666666"

" Vim Highlighting
hi vimCommand ctermfg=1 cterm=none

" C Highlighting
hi cType ctermfg=11
hi cStorageClass ctermfg=5
hi cConditional ctermfg=5
hi cRepeat ctermfg=5

" PHP Highlighting
hi phpVarSelector ctermfg=1
hi phpKeyword ctermfg=5
hi phpRepeat ctermfg=5
hi phpConditional ctermfg=5
hi phpStatement ctermfg=5
hi phpMemberSelector ctermfg=7

" Ruby Highlighting
hi rubySymbol ctermfg=2
hi rubyConstant ctermfg=11
hi rubyAttribute ctermfg=4
hi rubyInclude ctermfg=4
hi rubyLocalVariableOrMethod ctermfg=3
hi rubyCurlyBlock ctermfg=3
hi rubyStringDelimiter ctermfg=2
hi rubyInterpolationDelimiter ctermfg=3
hi rubyConditional ctermfg=5
hi rubyRepeat ctermfg=5

" Python Highlighting
hi pythonInclude ctermfg=5
hi pythonStatement ctermfg=5
hi pythonConditional ctermfg=5
hi pythonFunction ctermfg=4

" JavaScript Highlighting
hi javaScriptBraces ctermfg=7
hi javaScriptFunction ctermfg=5
hi javaScriptConditional ctermfg=5
hi javaScriptRepeat ctermfg=5
hi javaScriptNumber ctermfg=3
hi javaScriptMember ctermfg=3

" HTML Highlighting
hi htmlTag ctermfg=1
hi htmlTagName ctermfg=1
hi htmlArg ctermfg=1
hi htmlScriptTag ctermfg=1

" Diff Highlighting
hi diffAdded ctermfg=2
hi diffRemoved ctermfg=1

" ShowMarks Highlighting
hi ShowMarksHLl ctermfg=3 ctermbg=0 cterm=none
hi ShowMarksHLo ctermfg=5 ctermbg=0 cterm=none
hi ShowMarksHLu ctermfg=11 ctermbg=0 cterm=none
hi ShowMarksHLm ctermfg=6 ctermbg=0 cterm=none
