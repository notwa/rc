mkdir -p ~/opt/mingw

_mw_enabled=0
_mw_host=x86_64-w64-mingw32
_mw_bin=~/src/mxe/usr/bin
_mw_misc=~/src/mxe/usr/$_mw_host
_mw_prefix=~/opt/mingw

declare -A _mw_

_mw_export() {
    [ -z "$1" ] && return 1
    [ -n "${ZSH_VERSION:-}" ] && _mw_[$1]=${(P)1} || _mw_[$1]="${!1}"
    export "$1=$2"
}

mingw-disable() {
    [ $_mw_enabled -eq 0 ] && return 1
    _mw_enabled=0

    local e=
    for e in PATH PREFIX CC CPP CXX CFLAGS CPPFLAGS CXXFLAGS LDFLAGS \
      AR RANLIB RC WINDRES SDL_CFLAGS SDL_LDLIBS; do
        export "$e=${_mw_[$e]}"
    done
}

mingw-enable() {
    [ $_mw_enabled -eq 1 ] && return 1
    _mw_enabled=1

    set -- CC gcc CXX g++ CPP cpp AR ar RANLIB ranlib RC windres WINDRES windres
    while _mw_export "$1" "$_mw_bin/$_mw_host-$2"; do
        shift 2
    done

    _mw_export PATH "$PATH:$_mw_bin"
    _mw_export PREFIX "$_mw_prefix"
    _mw_export CFLAGS "-O2 -I $_mw_misc/include -I $_mw_prefix/include"
    _mw_export LDFLAGS "-s -L $_mw_misc/lib -L $_mw_prefix/lib"
    _mw_export CPPFLAGS ''
    _mw_export CXXFLAGS "$CFLAGS"

    # TODO: hackish
    local sdl2c=$_mw_host-sdl2-config
    which $sdl2c >/dev/null && {
        _mw_export SDL_CFLAGS "$($_mw_host-sdl2-config --cflags)"
        _mw_export SDL_LDLIBS "$($_mw_host-sdl2-config --libs)"
    }
}

mw() {
    if [ "$#" -eq 1 ]; then
        if [ "$1" -eq 1 ]
        then; mingw-enable
        else; mingw-disable
        fi
    else
        if [ $_mw_enabled -eq 0 ]; then
            echo "mingw enabled"
            mingw-enable
        else
            echo "mingw disabled"
            mingw-disable
        fi
    fi
}
