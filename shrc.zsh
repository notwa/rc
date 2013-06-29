# for both zsh and bash

umask 027 # screw others

export PATH="$PATH:$HOME/opt/local/bin"

# cleanup in case of inherited exports
for x in AR CC CPP CXX CFLAGS CPPFLAGS CXXFLAGS LDFLAGS RANLIB RC WINDRES; do
    export $x=
done

export PREFIX="$HOME/opt/local"
export CC=clang
export CFLAGS='-march=native -O2'
export LDFLAGS='-Wl,-O1,--sort-common,-z,relro'
export CFLAGS="$CFLAGS -I'$HOME/opt/local/include'"
export LDFLAGS="$LDFLAGS -L'$HOME/opt/local/lib'"
export LD_LIBRARY_PATH= # -n isn't an option in zsh's export

export EDITOR='vim -p'
export GOPATH="$HOME/go"

# colors
for x in ls dir vdir grep fgrep egrep; do
    alias $x="$x --color=auto"
done
alias make="colormake"

# just flags
export LESS='-SR'
alias makedbg='CFLAGS="-O0" LDFLAGS="-g" make'
alias fils="du -bad1"
alias lsfm="lsf -ugpms"
alias lsa="ls -A --group-directories-first"
alias logs="logs -o cat -b -e"
alias logsf="logs -f"
alias diff="git --no-pager diff --color=auto --no-ext-diff --no-index"

# being specific
alias erc="e ~/.zshrc ~/shrc.zsh ~/.bashrc"
alias irc="screen -dR irc irssi"
alias crawl='screen -dR crawl ssh crawl@crawl.develz.org -i ~/.ssh/crawl'
alias crawla='screen -dR crawl ssh crawl@crawl.akrasiac.org -l joshua -i ~/.ssh/crawl'

# providing extra functionality
# TODO: dotfiles first, like `LC_ALL=C ls -A` which doesnt work with -X flag
alias ll="ls -ACX --group-directories-first --color=force | less"
alias counts='find . | wc -l'
alias exts='print -l *(:e:l) | sort | uniq -c | sort -n'
alias meow='( cd ~/play/meow; ~/sh/meow.sh/run -pa )'
alias nocom='grep -oP --line-buffered --color=never "^[^#]+"'
alias unwrap='awk '"'"'BEGIN{RS="\n\n";FS="\n"}{for(i=1;i<=NF;i++)printf "%s ",$i;print "\n"}'"'"
alias picky='{ pacman -Qgq base base-devel; pacman -Qtq; } | sort | uniq -u'
alias unused='{ pacman -Qt; pacman -Qe | tee -; } | sort | uniq -u'

. ~/mingw.sh
. ~/sh/lsf.sh/lsf.sh
. ~/sh/z/z.sh
