setopt extended_glob

fpath=(~/sh $fpath)

function {
    local f
    for f in ~/sh/^([_.]*)(N^/:t); do
        autoload -Uz $f
    done

    zsc() {
        local s=$1; shift
        zstyle ':completion:*'$s $@
    }
    zsc '*:default' list-colors ''
    zsc '*' completer _complete _ignored _match _correct _approximate _prefix
    zsc '*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3)))'
    #zsc '*:corrections' format '%B%d (errors %e)%b'
    zsc '*:default' list-prompt '%S%M matches%s'
    zsc '*:default' menu select=0
    zsc '*' ignore-parents parent pwd
    zsc '*' ignored-patterns '*?.sw[po]' '*?.pyc' '__pycache__'
    zsc '*:*:rm:*:*' ignored-patterns
    # matching: try exact, case insensitive, then partial word completion.
    # ** for recursive, i think
    zsc '*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
    # caching, for huge lists eg. package managers
    zsc '*' use-cache on
    zsc '*' cache-path ~/.zsh/cache
    zsc '*:pacman:*' force-list always
    zsc '*:*:pacman:*' menu yes select
    # when listing completions, show type names and group by them
    zsc '*:descriptions' format "$fg_bold[black]» %d$reset_color"
    zsc '*' group-name ''
}

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

function {
    local -a opts
    opts=( no_beep
        append_history share_history # across sessions
        hist_expire_dups_first # sharing/appending will result in dups
        hist_ignore_dups # don't push lines identical to the previous
        auto_cd # exec a dir to cd
        auto_pushd pushd_ignore_dups # try `dirs -v` to find N and `is ~N`
        no_match # error on bad tab-complete
        check_jobs notify # automatic job reporting
        chase_links # cd into link resolves link
        complete_aliases # allow original command completion within alias
        complete_in_word # enable tab completion when cursor between words
        rc_quotes # 'you''re dumb' like "you're dumb"
        brace_ccl # for character ranges like {a-z}
    )
    setopt "${opts[@]}"
    unsetopt rm_star_silent rm_star_wait # yolo
}

bindkey -e # emacs-style keybinds
bindkey '^[[A' history-search-backward # up
bindkey '^[[B' history-search-forward # down
bindkey ';5D' emacs-backward-word # ctrl+left
bindkey ';5C' emacs-forward-word # ctrl+right
# we type a space (and delete it afterwards) to force ^Y to yank from ^U
bindkey -s ';3A' ' ^Ucd ..^M^Y^H' # alt+up
bindkey -s '^[s' '^Asudo ^E' # alt+s

autoload edit-command-line
zle -N edit-command-line # new widget of the same function name
bindkey '^Xe' edit-command-line # ctrl+x -> e

. ~/shrc.zsh

alias -g STFU="2>/dev/null"

for x in ack cd cp ebuild gcc gist grep ln man mkdir mv rm
  alias $x="nocorrect $x"
for x in arith fc find ftp history let locate rsync scp sftp wget
  alias $x="noglob $x"

if [[ "$TERM" = xterm* ]]; then
  precmd() { print -Pn "\e]2;%M: %~\a" }
fi

# note: zsh adds a % symbol to newline-less output, so bash prompt is overkill
PROMPT='%b%(?.%2K.%1K)%15F%#%f%k '
RPROMPT='%8F%h%b'

reload() {
  # This doesn't seem to help with _vim_files errors, ehh
  # you wanna rm .zcompdump then exit, that's why
  cd ~
  autoload -U zrecompile
  [ -f .zshrc ] && zrecompile -p .zshrc
  rm -f .zcompdump
  [ -f .zshrc.zwc.old ] && rm -f .zshrc.zwc.old
  [ -f .zcompdump.zwc.old ] && rm -f .zcompdump.zwc.old
  exec zsh # reload shell, inheriting environment
}

unset x
