" Property
" a vim color scheme by github.com/notwa
" loosely based on Clearance by Chris Seelus (@ceelus)
" built upon the Tomorrow scheme's functionality <http://chriskempson.com>

" other sources of inspiration:
" colorful
" redblack

" hi \([A-Za-z]\+\) \+guifg=\([^ ]\+\) \+guibg=\([^ ]\+\) \+gui=\(\w\+\)

let s:foreground        = "D6DBD5"
let s:background        = "202121"

let s:white             = "F9FAF7"

let s:backgrounder      = "292B2C"
let s:line_number       = "484E52"
let s:comment           = "80908C"

let s:selection         = "393C41"

" not including C chars ('x' syntax)
let s:string            = "BEE563"
let s:stringer          = "2A3026"

" sometimes true and false too, depending on the language
let s:number            = "FA7A76"

" a language constructor
" maybe not true-blue enough?
" maybe use pure (bold) white instead, and use this elsewhere
let s:language          = "7DB8E8"

" don't overwrite me!
let s:function          = "64CCC5" " old seaweed color
" needs a tad more saturation and brightness?
let s:function          = "5A7FD6"

" TODO: () colors, [] colors, {} colors (background for braces?)

hi clear
if exists("syntax_on") | syntax reset | endif
set background=dark

let g:colors_name = "property2"

" Sets the highlighting for the given group
fu! <SID>X(group, fg, bg, attr)
    let l:fg=a:fg
    let l:bg=a:bg
    if a:fg != "" && a:fg != "NONE" | let l:fg="#".l:fg | endif
    if a:bg != "" && a:bg != "NONE" | let l:bg="#".l:bg | endif
    if a:fg   != "" | exec "hi! ".a:group." guifg=".l:fg | endif
    if a:bg   != "" | exec "hi! ".a:group." guibg=".l:bg | endif
    if a:attr != "" | exec "hi! ".a:group." gui=".a:attr | endif
endfun

" Interface

call <SID>X("Normal",         s:foreground,   s:background,    "")
call <SID>X("LineNr",         s:line_number,  "",              "")
call <SID>X("NonText",        s:foreground,   "",              "")
call <SID>X("SpecialKey",     s:line_number,  "",              "")
call <SID>X("Search",         "NONE",         s:backgrounder,  "underline")
call <SID>X("TabLine",        s:foreground,   "",              "")
call <SID>X("TabLineFill",    s:foreground,   "",              "")
"call <SID>X("StatusLine",    s:foreground,   "",              "")
"call <SID>X("StatusLineNC",  s:foreground,   "",              "")
call <SID>X("VertSplit",      s:foreground,   "",              "")
call <SID>X("Visual",         s:foreground,   s:selection,     "")
call <SID>X("Directory",      s:foreground,   "",              "")
call <SID>X("ModeMsg",        s:foreground,   "",              "")
call <SID>X("MoreMsg",        s:foreground,   "",              "")
call <SID>X("Question",       s:foreground,   "",              "")
call <SID>X("WarningMsg",     s:foreground,   "",              "")
call <SID>X("MatchParen",     s:foreground,   "",              "")
call <SID>X("Folded",         s:foreground,   "",              "")
call <SID>X("FoldColumn",     s:foreground,   "",              "")
call <SID>X("CursorLine",     s:foreground,   "",              "")
call <SID>X("CursorColumn",   s:foreground,   "",              "")
call <SID>X("PMenu",          s:foreground,   "",              "")
call <SID>X("PMenuSel",       s:foreground,   "",              "")
call <SID>X("SignColumn",     s:foreground,   "",              "")
call <SID>X("ColorColumn",    "",             s:backgrounder,  "")

" Syntax highlighting

call <SID>X("Todo",        s:white,       s:background,  "bold,italic")
call <SID>X("Title",       s:foreground,  "",            "")
call <SID>X("Identifier",  s:language,    "",            "")
call <SID>X("Structure",   s:language,    "",            "")
call <SID>X("Constant",    s:number,      "",            "")
call <SID>X("Special",     s:white,       "",            "bold")
call <SID>X("Operator",    s:foreground,  "",            "")
call <SID>X("Delimiter",   s:foreground,  "",            "")

call <SID>X("Comment",      s:comment,     "",          "italic")
call <SID>X("Function",     s:function,    "",          "NONE")
call <SID>X("Statement",    s:white,       "",          "bold")
call <SID>X("Repeat",       s:language,    "",          "bold")
call <SID>X("Keyword",      s:language,    "",          "NONE")
call <SID>X("Conditional",  s:language,    "",          "NONE")
call <SID>X("String",       s:string,      s:stringer,  "")
call <SID>X("Type",         s:function,    "",          "NONE") " not too bad as s:number
call <SID>X("PreProc",      s:foreground,  "",          "NONE")
call <SID>X("Define",       s:function,    "",          "NONE")
call <SID>X("Include",      s:foreground,  "",          "NONE")
call <SID>X("Number",       s:number,      "",          "")

hi link vimCommand Keyword
hi link vimCommentString Comment
hi link vimFuncVar Normal
hi link vimVar Normal

hi link pythonBoolean Constant
hi link pythonBuiltin Function
hi link pythonBuiltinFunc Function
hi link pythonConditional Structure
hi link pythonException Structure
hi link pythonImport Function
hi link pythonInclude Function
hi link pythonOperator Structure
hi link pythonRepeat Structure
hi link pythonRun Comment
hi link pythonStatement Structure

" FIXME: escapes shouldn't override string background
hi link luaCond Structure
hi link luaCondElseif Structure
hi link luaCondEnd Structure
hi link luaCondStart Structure
hi link luaFunc Function
hi link luaFunction Function
hi link luaRepeat Structure
hi link luaStatement Structure

"hi link Operator                   Normal
"hi link Character                  Constant
"hi link Boolean                    Constant
"hi link Float                      Number
"hi link Repeat                     Statement
"hi link Label                      Statement
"hi link Exception                  Statement
"hi link Include                    PreProc
"hi link Define                     PreProc
"hi link Macro                      PreProc
"hi link PreCondit                  PreProc
"hi link StorageClass               Type
"hi link Structure                  Type
"hi link Typedef                    Type
"hi link Tag                        Special
"hi link SpecialChar                Special
"hi link SpecialComment             Special
"hi link Debug                      Special

delf <SID>X
