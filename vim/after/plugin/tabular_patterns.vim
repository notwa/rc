try

" Some short phrase , some other phrase
" A much longer phrase here , and another long phrase

AddTabularPattern! lc / *\zs[^,]\+,/l0l1
" Some short phrase,         some other phrase
" A much longer phrase here, and another long phrase

AddTabularPattern! rc /,/r0r1
"         Some short phrase,       some other phrase,              and so on
" A much longer phrase here, and another long phrase, and so on and so forth

AddTabularPattern! sp / *\zs /l0r0
" Some short phrase ,      some other phrase
" A    much  longer phrase here ,     and    another long phrase

catch /E492/
endtry
