" property16.vim by notwa

let s:k="0"
let s:r="1"
let s:g="2"
let s:y="3"
let s:b="4"
let s:m="5"
let s:c="6"
let s:w="7"
let s:K="8"
let s:R="9"
let s:G="10"
let s:Y="11"
let s:B="12"
let s:M="13"
let s:C="14"
let s:W="15"

" Theme setup
hi clear
syntax reset
let g:colors_name = "property16"
let g:airline_theme='tomorrow'
set background=dark

" Highlighting function
fu! <SID>X(group, fg, bg)
    let l:fg=a:fg
    let l:bg=a:bg
    if a:fg != "" | exec "hi! ".a:group." ctermfg=".l:fg | endif
    if a:bg != "" | exec "hi! ".a:group." ctermbg=".l:bg | endif
    exec "hi! ".a:group." cterm=NONE"
endfun

" Interface

call <SID>X("Normal",        s:w,  s:k) " good
call <SID>X("Bold",          s:W,  "") " good
call <SID>X("Italic",        s:c,  "") " good
call <SID>X("Underlined",    s:M,  "") " okay
call <SID>X("LineNr",        s:K,  "") " good
call <SID>X("Search",        s:k,  s:Y) " good
call <SID>X("VertSplit",     s:K,  s:K) " good
call <SID>X("Folded",        s:K,  s:k) " good
",
call <SID>X("Error",         s:R,  "")
call <SID>X("Exception",     s:R,  "") " ???
call <SID>X("ErrorMsg",      s:k,  s:R)
call <SID>X("TabLineSel",    s:k,  s:Y) " okay
call <SID>X("Visual",        s:k,  s:C) " okay
call <SID>X("ColorColumn",   "",   s:K) " okay
call <SID>X("MatchParen",    s:W,  s:c) " okay
call <SID>X("Directory",     s:B,  s:k) " airline: normal mode indicator
call <SID>X("CursorLine",    s:w,  "") " airline: plain center text stuff
call <SID>X("PMenu",         s:k,  s:K) " airline: branch and fileformat
call <SID>X("NonText",       s:K,  "") " inactive status lines? bg doesn't work?
call <SID>X("TabLine",       s:w,  "")
call <SID>X("CursorColumn",  s:w,  "")
call <SID>X("SpecialKey",    s:K,  "")
call <SID>X("SignColumn",    s:K,  "")
",
call <SID>X("FoldColumn",    s:k,  "")
call <SID>X("Title",         s:y,  "") " used for tab line actually?
call <SID>X("ModeMsg",       s:G,  "") " --- VISUAL BLOCK ---
call <SID>X("WarningMsg",    s:r,  "") " search hit BOTTOM
"TODO,
call <SID>X("TooLong",       s:R,  "")
call <SID>X("PMenuSel",      s:w,  "")
call <SID>X("MoreMsg",       s:w,  "")
call <SID>X("Question",      s:w,  "")
",
" Syntax highlighting,
",
call <SID>X("Comment",       s:c,  "") " good
call <SID>X("Todo",          s:k,  s:G) " good
call <SID>X("Number",        s:r,  "") " good
",
call <SID>X("Constant",      s:r,  "")
call <SID>X("String",        s:r,  "")
call <SID>X("Structure",     s:m,  "")
call <SID>X("Operator",      s:m,  "")
call <SID>X("Repeat",        s:m,  "")
call <SID>X("Conditional",   s:m,  "")
call <SID>X("Type",          s:m,  "")
call <SID>X("Delimiter",     s:C,  "")
call <SID>X("PreProc",       s:C,  "")
call <SID>X("Special",       s:W,  "")
call <SID>X("Statement",     s:W,  "") " maybe set same as structure?
call <SID>X("Identifier",    s:B,  "")
call <SID>X("Function",      s:b,  "")
call <SID>X("Keyword",       s:b,  "")
call <SID>X("Define",        s:b,  "")
call <SID>X("Include",       s:b,  "")
call <SID>X("Typedef",       s:b,  "")

" TODO: Vim editor colors
"Conceal"
"Cursor"
"CursorLineNr"
"Debug"
"IncSearch"
"Macro"
"StatusLine"
"StatusLineNC"
"TabLineFill"
"VisualNOS"
"WildMenu"

" TODO: Standard syntax highlighting
"Boolean"
"Character"
"Float"
"Label"
"SpecialChar"
"StorageClass"
"Tag"
"Typedef"

hi link vimCommand Keyword
hi link vimCommentString Comment
hi link vimFuncVar Normal
hi link vimVar Normal

hi link pythonBoolean Constant
hi link pythonBuiltin Function
hi link pythonBuiltinFunc Function
hi link pythonConditional Conditional
hi link pythonException Structure
hi link pythonImport Function
hi link pythonInclude Function
hi link pythonOperator Structure
hi link pythonRepeat Repeat
hi link pythonRun Comment
hi link pythonStatement Structure

hi link luaCond Conditional
hi link luaCondElseif Conditional
hi link luaCondEnd Conditional
hi link luaCondStart Conditional
hi link luaFunc Function
hi link luaFunction Function
hi link luaRepeat Repeat
hi link luaStatement Structure

delf <SID>X

" C highlighting
"cCharacter"
"cDefine"
"cInclude"
"cLabel"
"cOperator"
"cPreCondit"
"cPreProc"
"cRepeat"
"cStatement"
"cStorageClass"
"cType"
"cUserLabel"

" C++ highlighting
"cppExceptions"
"cppOperator"
"cppStatement"
"cppStorageClass"
"cppType"
"cppModifier"

" C# highlighting
"csClass"
"csAttribute"
"csModifier"
"csType"
"csUnspecifiedStatement"
"csContextualStatement"
"csNewDecleration"

" CSS highlighting
"cssBraces"
"cssClassName"
"cssColor"

" Diff highlighting
"DiffAdd"
"DiffChange"
"DiffDelete"
"DiffText"
"DiffAdded"
"DiffFile"
"DiffNewFile"
"DiffLine"
"DiffRemoved"

" Git highlighting
"gitCommitOverflow"
"gitCommitSummary"

" GitGutter highlighting
"GitGutterAdd"
"GitGutterChange"
"GitGutterDelete"
"GitGutterChangeDelete"

" HTML highlighting
"htmlBold"
"htmlItalic"
"htmlEndTag"
"htmlTag"

" JavaScript highlighting
"javaScript"
"javaScriptBraces"
"javaScriptNumber"

" Mail highlighting
"mailQuoted1"
"mailQuoted2"
"mailQuoted3"
"mailQuoted4"
"mailQuoted5"
"mailQuoted6"
"mailURL"
"mailEmail"

" Markdown highlighting
"markdownCode"
"markdownError"
"markdownCodeBlock"
"markdownHeadingDelimiter"

" NERDTree highlighting
"NERDTreeDirSlash"
"NERDTreeExecFile"

" PHP highlighting
"phpMemberSelector"
"phpComparison"
"phpParent"

" Python highlighting
"pythonOperator"
"pythonRepeat"

" Ruby highlighting
"rubyAttribute"
"rubyConstant"
"rubyInterpolation"
"rubyInterpolationDelimiter"
"rubyRegexp"
"rubySymbol"
"rubyStringDelimiter"

" SASS highlighting
"sassidChar"
"sassClassChar"
"sassInclude"
"sassMixing"
"sassMixinName"

" Signify highlighting
"SignifySignAdd"
"SignifySignChange"
"SignifySignDelete"

" Spelling highlighting
"SpellBad"
"SpellLocal"
"SpellCap"
"SpellRare"
