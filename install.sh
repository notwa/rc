#!/usr/bin/env bash
note() {
    echo -E "$@"
}

die() {
    echo -E "$@">&2
    exit 1
}

dotless() {
    [[ "${1:0:1}" == "." ]] && REPLY="${1:1}" || REPLY="$1"
}

hardlink() {
    [ -e "$1" ] && {
        [ "$1" -ef "$2" ] && return
        [ -h "$1" ] && note "removing symbolic link $1" && echo rm "$1"
        [ -s "$1" ] && die "$1 already exists" || echo rm "$1"
    }

    ln "$2" "$1" || die "couldn't hardlink $1"
}

softlink() {
    [ -e "$1" ] && {
        [ -h "$1" ] && {
            [ "$(readlink "$1")" == "$2" ] && return
            note "removing symbolic link $1"
            echo rm "$1"
        } || die "$1 already exists and is not a symbolic link"
    }

    ln -s "$2" "$1" || die "couldn't symlink $1"
}

rc="$(readlink -f "$(dirname "$0")" )"
cd $HOME
PATH="${PATH:?No existing PATH}:$rc/sh"

umask 027

for f in .bashrc .zshrc shrc.zsh mingw.sh .vimrc .conkyrc .inputrc .screenrc .xinitrc; do
    dotless "$f"
    r="$rc/home/$REPLY"
    hardlink "$f" "$r"
done

for d in sh .vim .mpv; do
    dotless "$d"
    r="$rc/$REPLY"
    softlink "$d" "$r"
done

for d in ssh config/menus; do
    mkdir -p ".$d"
    for r in $rc/$d/*; do
        f=".${r#"$rc/"}"
        hardlink "$f" "$r"
    done
done

grep .bashrc .bash_profile >/dev/null 2>&1 \
 || echo -e '\n[[ -f ~/.bashrc ]] && . ~/.bashrc' >> .bash_profile

for d in Desktop Documents Downloads Music Pictures Public Templates Video; do
    [ -d "$d" ] || continue
    is_empty "$d" && rm -r "$d" || note "skipping unempty $d"
done

mkdir -p opt/local/bin src work play