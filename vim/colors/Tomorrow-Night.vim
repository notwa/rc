" Tomorrow Night - Full Colour and 256 Colour
" http://chriskempson.com
"
" Hex colour conversion functions were stripped out in favor of csapprox

" Default GUI Colours
let s:foreground = "c5c8c6"
let s:background = "1d1f21"
let s:selection  = "373b41"
let s:line       = "282a2e"
let s:comment    = "969896"
let s:red        = "cc6666"
let s:orange     = "de935f"
let s:yellow     = "f0c674"
let s:green      = "b5bd68"
let s:aqua       = "8abeb7"
let s:blue       = "81a2be"
let s:purple     = "b294bb"
let s:window     = "4d5057"

" Console 256 Colours
if !has("gui_running")
"	let s:background = "303030"
"	let s:window     = "5e5e5e"
	let s:line       = "3a3a3a"
"	let s:selection  = "585858"
end

hi clear
syntax reset

let g:colors_name = "Tomorrow-Night"

" Sets the highlighting for the given group
fun <SID>X(group, fg, bg, attr)
        if a:fg   != "" | exec "hi " . a:group . " guifg=#" . a:fg | endif
        if a:bg   != "" | exec "hi " . a:group . " guibg=#" . a:bg | endif
        if a:attr != "" | exec "hi " . a:group . " gui="  . a:attr | endif
endfun

"exec 'normal yiw' | exec '%s/'.@0.'$//gn'

call <SID>X("Normal",      s:foreground,  s:background,  "")
call <SID>X("_Aqua",       s:aqua,        "",            "") " 3
call <SID>X("_Blue",       s:blue,        "",            "") " 27
call <SID>X("_Comment",    s:comment,     "",            "") " 6
call <SID>X("_Green",      s:green,       "",            "") " 18
call <SID>X("_Orange",     s:orange,      "",            "") " 23
call <SID>X("_Plain",      s:foreground,  "",            "") " 12
call <SID>X("_Purple",     s:purple,      "",            "") " 52
call <SID>X("_Red",        s:red,         "",            "") " 10
call <SID>X("_Selection",  s:selection,   "",            "") " 3

call <SID>X("_AquaNone",    s:aqua,    "",           "none") " 1
call <SID>X("_BlueNone",    s:blue,    "",           "none") " 1
call <SID>X("_Bold",        "",        "",           "bold") " 1
call <SID>X("_LineBGNone",  "",        s:line,       "none") " 3
call <SID>X("_RedNone",     s:red,     "",           "none") " 2
call <SID>X("_SelectBG",    "",        s:selection,  "") " 2
call <SID>X("_LineBlue",    s:line,    s:blue,       "") " 1
call <SID>X("_PurpleNone",  s:purple,  "",           "none") " 1

call <SID>X("_AquaPlainNone",    s:aqua,        s:background,  "none") " 1
call <SID>X("_CommentPlain",     s:comment,     s:background,  "") " 2
call <SID>X("_PlainBG",          "",            s:background,  "") " 1
call <SID>X("_PlainBGNone",      "",            s:background,  "none") " 1
call <SID>X("_RedBGPlain",       s:background,  s:red,         "") " 1
call <SID>X("_YellowPlainNone",  s:yellow,      s:background,  "none") " 1

call <SID>X("_OrangePlainNone",  s:orange,      s:background,  "none") " 1
call <SID>X("_PurplePlainNone",  s:purple,      s:background,  "none") " 1

call <SID>X("_Search",      s:background,  s:yellow,      "") " 1
call <SID>X("_TabLine",     s:window,      s:foreground,  "reverse") " 3
call <SID>X("_VertSplit",   s:window,      s:window,      "none") " 1
call <SID>X("_StatusLine",  s:window,      s:yellow,      "reverse") " 1
call <SID>X("_PMenu",       s:foreground,  s:selection,   "none") " 1
call <SID>X("_PMenuSel",    s:foreground,  s:selection,   "reverse") " 1
call <SID>X("_diffAdd",     "",  "4c4e39",  "") " 1
call <SID>X("_diffChange",  "",  "2b5b77",  "") " 1

delf <SID>X

" Vim Highlighting
hi! link ColorColumn _LineBGNone
hi! link CursorColumn _LineBGNone
hi! link Directory _Blue
hi! link FoldColumn _PlainBGNone
hi! link Folded _CommentPlain
hi! link LineNr _Selection
hi! link MatchParen _SelectBG
hi! link ModeMsg _Green
hi! link MoreMsg _Green
hi! link NonText _Selection
hi! link PMenu _PMenu
hi! link PMenuSel _PMenuSel
hi! link Question _Green
hi! link Search _Search
hi! link SignColumn _PlainBG
hi! link SpecialKey _Selection
hi! link StatusLine _StatusLine
hi! link StatusLineNC _TabLine
hi! link TabLine _TabLine
hi! link TabLineFill _TabLine
hi! link VertSplit _VertSplit
hi! link Visual _SelectBG
hi! link WarningMsg _Red

" Standard Highlighting
hi! link Comment _Comment
hi! link Conditional _Plain
hi! link Constant _Orange
hi! link CursorLine _LineBGNone
hi! link Define _PurpleNone
hi! link Function _Blue
hi! link Identifier _RedNone
hi! link Include _Blue
hi! link Keyword _Orange
hi! link Operator _AquaNone
hi! link PreProc _Purple
hi! link Repeat _Plain
hi! link Special _Plain
hi! link Statement _Plain
hi! link String _Green
hi! link Structure _Purple
hi! link Title _Comment
hi! link Todo _CommentPlain
hi! link Type _BlueNone

hi link vimCommand _RedNone

hi link ShowMarksHLl _OrangePlainNone
hi link ShowMarksHLm _AquaPlainNone
hi link ShowMarksHLo _PurplePlainNone
hi link ShowMarksHLu _YellowPlainNone

hi link cConditional _Purple
hi link cRepeat _Purple
hi link cStorageClass _Purple
hi link cType _Yellow

hi link clojureAnonArg _Blue
hi link clojureBoolean _Orange
hi link clojureCharacter _Orange
hi link clojureCond _Blue
hi link clojureConstant _Orange
hi link clojureDefine _Purple
hi link clojureDeref _Blue
hi link clojureDispatch _Blue
hi link clojureException _Red
hi link clojureFunc _Blue
hi link clojureKeyword _Green
hi link clojureMacro _Blue
hi link clojureMeta _Blue
hi link clojureNumber _Orange
hi link clojureParen _Aqua
hi link clojureQuote _Blue
hi link clojureRegexp _Green
hi link clojureRepeat _Blue
hi link clojureRepeat _Blue
hi link clojureSpecial _Purple
hi link clojureString _Green
hi link clojureUnquote _Blue
hi link clojureVariable _Yellow

hi link coffeeConditional _Purple
hi link coffeeKeyword _Purple
hi link coffeeObject _Yellow
hi link coffeeRepeat _Purple

hi link crystalAccess _Yellow
hi link crystalAttribute _Blue
hi link crystalConditional _Purple
hi link crystalConstant _Yellow
hi link crystalControl _Purple
hi link crystalCurlyBlock _Orange
hi link crystalException _Purple
hi link crystalInclude _Blue
hi link crystalInterpolationDelimiter _Orange
hi link crystalLocalVariableOrMethod _Orange
hi link crystalRepeat _Purple
hi link crystalStringDelimiter _Green
hi link crystalSymbol _Green

hi link cucumberGiven _Blue
hi link cucumberGivenAnd _Blue

hi link diffAdd _diffAdd
hi link diffChange _diffChange
hi link diffDelete _RedBGPlain
hi link diffText _LineBlue
hi link diffAdded _Green
hi link diffRemoved _Red

hi link gitcommitSummary _Bold

hi link goBuiltins _Purple
hi link goConditional _Purple
hi link goConstants _Orange
hi link goDeclType _Blue
hi link goDeclaration _Purple
hi link goDirective _Purple
hi link goLabel _Purple
hi link goRepeat _Purple
hi link goStatement _Purple
hi link goTodo _Yellow

hi link htmlArg _Red
hi link htmlScriptTag _Red
hi link htmlTag _Red
hi link htmlTagName _Red

hi link javaScriptBraces _Plain
hi link javaScriptConditional _Purple
hi link javaScriptFunction _Purple
hi link javaScriptMember _Orange
hi link javaScriptNumber _Orange
hi link javaScriptRepeat _Purple
hi link javascriptGlobal _Blue
hi link javascriptNull _Orange
hi link javascriptStatement _Red

hi link luaCond _Purple
hi link luaCondElseif _Purple
hi link luaCondEnd _Purple
hi link luaCondStart _Purple
hi link luaRepeat _Purple
hi link luaStatement _Purple

hi link phpConditional _Purple
hi link phpKeyword _Purple
hi link phpMemberSelector _Plain
hi link phpRepeat _Purple
hi link phpStatement _Purple
hi link phpVarSelector _Red

hi link pythonConditional _Purple
hi link pythonExClass _Orange
hi link pythonException _Purple
hi link pythonFunction _Blue
hi link pythonInclude _Purple
hi link pythonPreCondit _Purple
hi link pythonRepeat _Aqua
hi link pythonRepeat _Purple
hi link pythonStatement _Purple

hi link rubyAccess _Yellow
hi link rubyAttribute _Blue
hi link rubyConditional _Purple
hi link rubyConstant _Yellow
hi link rubyControl _Purple
hi link rubyCurlyBlock _Orange
hi link rubyException _Purple
hi link rubyInclude _Blue
hi link rubyInterpolationDelimiter _Orange
hi link rubyLocalVariableOrMethod _Orange
hi link rubyRepeat _Purple
hi link rubyStringDelimiter _Green
hi link rubySymbol _Green

hi link scalaAnnotation _Orange
hi link scalaBackTick _Blue
hi link scalaBackTick _Green
hi link scalaBoolean _Orange
hi link scalaCaseType _Yellow
hi link scalaChar _Orange
hi link scalaClass _Purple
hi link scalaClassName _Plain
hi link scalaClassSpecializer _Yellow
hi link scalaComment _Comment
hi link scalaConstructorSpecializer _Yellow
hi link scalaDef _Purple
hi link scalaDefName _Blue
hi link scalaDefSpecializer _Yellow
hi link scalaDocComment _Comment
hi link scalaDocTags _Comment
hi link scalaEmptyString _Green
hi link scalaFqn _Plain
hi link scalaFqnSet _Plain
hi link scalaImport _Purple
hi link scalaKeyword _Purple
hi link scalaKeywordModifier _Purple
hi link scalaLineComment _Comment
hi link scalaMethodCall _Blue
hi link scalaMultiLineString _Green
hi link scalaNumber _Orange
hi link scalaObject _Purple
hi link scalaOperator _Blue
hi link scalaPackage _Red
hi link scalaRoot _Plain
hi link scalaString _Green
hi link scalaStringEscape _Green
hi link scalaSymbol _Orange
hi link scalaTrait _Purple
hi link scalaType _Yellow
hi link scalaTypeSpecializer _Yellow
hi link scalaUnicode _Orange
hi link scalaVal _Purple
hi link scalaValName _Plain
hi link scalaVar _Aqua
hi link scalaVarName _Plain
hi link scalaXml _Green

set background=dark
