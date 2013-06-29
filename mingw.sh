# FYI you use /opt/mingw-w64 for mingw itself
# but /opt/mingw for things built with mingw...
#[ -d "$HOME/opt/mingw-w64" ] || echo -E "crap no mingw" >&2

mkdir -p ~/opt/mingw
alias cmakem='cmake -G "Unix Makefiles" -DCMAKE_TOOLCHAIN_FILE=~/mingw.cmake'

_mw_enabled=0
_mw_name=i686-w64-mingw32
_mw_bin=~/opt/mingw-w64/bin/$_mw_name
_mw_misc=~/opt/mingw-w64/$_mw_name
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
    for e in PATH AR CC CPP CXX CFLAGS CPPFLAGS CXXFLAGS LDFLAGS RANLIB RC WINDRES; do
        export "$e=${_mw_[$e]}"
    done
}

mingw-enable() {
    [ $_mw_enabled -eq 1 ] && return 1
    _mw_enabled=1

    set -- CC gcc CXX g++ CPP cpp AR ar RANLIB ranlib RC windres WINDRES windres
    while _mw_export "$1" "$_mw_bin-$2"; do
        shift 2
    done

    _mw_export PATH "$PATH:$HOME/opt/mingw-w64/bin"
    _mw_export CFLAGS "-O2 -I $_mw_misc/include -I $_mw_prefix/include"
    _mw_export LDFLAGS "-s -L $_mw_misc/lib -L $_mw_prefix/lib"
    _mw_export CPPFLAGS ''
    _mw_export CXXFLAGS "$CFLAGS"
}
