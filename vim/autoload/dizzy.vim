" dizzy.vim - fuzzy wuzzy was a bear
" Maintainer:   Wayne Gretzky <https://aimlabs.com/>
" Version:      1.0

" 1. install fzy: https://github.com/jhawthorn/fzy/
" 2. drop this script in your ~/.vim/autoload directory
" 3. map DizzySelect to something in your ~/.vimrc:
"    nn <leader>e :call DizzySelect(":e")<cr>

fun! DizzyFlagsNow()
    silent let discard = system('find -maxdepth 0 -regextype posix-basic')
    if v:shell_error == 0 " GNU find defaults to emacs
        let flags = ' -regextype posix-basic'
    else " busybox only supports posix-basic to begin with
        let flags = ''
    endif

    " these extensions are commonly capitalized on DOS and early Windows.
    " instead of checking every variation, only check the most prevalent:
    let oldschool = split('BIN COM DAT DLL EXE LIB WAD  BMP DDS GIF JPG PNG TGA WAV')

    let extensions = '\|'
    let directories = '\|'
    let individual = '\|' " NOTE: currently unused.
    for seg in split(&wildignore, ',')
        if match(seg, '^\*\.\w\+$') == 0
            if index(oldschool, seg[2:], 0, 1) != -1
                let extensions ..= seg[2:]->toupper() .. '\|'
            endif
            let extensions ..= seg[2:] .. '\|'
        elseif match(seg, '^\*\.\w\+\.\*$') == 0
            let extensions = '\|' .. seg[2:-3] .. '\..*' .. extensions
        "elseif index(known_directories) != -1
        elseif match(seg, '^\.\?\w\+$') == 0
            let directories ..= seg .. '\|'
        else
            let individual ..= seg .. '\|'
        endif
    endfor

    if directories !=# '\|'
        let directories = '.*/\(' .. directories[2:-3] .. '\)/.*'
        let flags ..= " '!' -regex '" .. directories .. "'"
    endif

    if extensions !=# '\|'
        let extensions = '.*\.\(' .. extensions[2:-3] .. '\)'
        let flags ..= " '!' -regex '" .. extensions .. "'"
    endif

    return flags
endfun

fun! DizzyFlags()
    if !exists('g:dizzyflags')
        let g:dizzyflags = DizzyFlagsNow()
    endif
    return g:dizzyflags
endfun

fun! FuzzySelect(choice_command, vim_command)
    " https://github.com/jhawthorn/fzy/#use-with-vim
    try
        let output = system(a:choice_command .. " | fzy ")
    catch /Vim:Interrupt/
        " Swallow errors from ^C, allow redraw! below
    endtry
    redraw!
    if v:shell_error == 0 && !empty(output)
        exec a:vim_command .. ' ' .. output
    endif
endfun

fun! DizzySelect(vim_command)
    if !exists('g:dizzydepth')
        let depth = 5
    else
        let depth = g:dizzydepth
    endif
    call FuzzySelect('find . -maxdepth '..depth..' -type f' .. DizzyFlags(), a:vim_command)
endfun
