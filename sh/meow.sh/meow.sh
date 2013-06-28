#!/usr/bin/env bash
SEP=$'\1'

die() {
  echo -E "$@" 1>&2
  exit 1
}

nullcheck() {
  [[ -n "$1" ]] || die "Null group name";
}

sanitize() {
  sed -e 's/[^0-9a-zA-Z_]/_/g'
}

splittags() {
  awk -v tag="$1" -f "$SRCDIR/splittags.awk"
}

scrape() {
  TZ=UTC0 awk -v g="$1" -v timestamp="${2:-0}" -v sep="$SEP" -f "$SRCDIR/scrape.awk"
}

declare -A groupinsane # unsanitized group names
declare -A groupshows # regexes
watch() { # {group name} [regex...]
  nullcheck "$1"
  local gs="$(sanitize<<<"$1")"
  groupinsane[$gs]="$1"
  shift
  while (( "$#" )); do
    groupshows[$gs]+="|($1)"
    shift
  done
}

declare -A grouptimes # last times timestamp
touchgroup() { # {group name} {unix time}
  nullcheck "$1"
  local gs="$(sanitize<<<"$1")"
  grouptimes[$gs]="$2"
}

groupreleases() { # groupname [timestamp]
  nullcheck "$1"
  # TODO: escapeurl $1
  local URL="http://www.nyaa.eu/?page=search&term=%5B$1%5D&page=rss"
  curl -LsS "$URL" > "$1.xml" || die "Failed to retrieve releases for $1"
  tr -d '\r\n'"$SEP" < "$1.xml" | splittags item | scrape "$1" "${2:-}"
}

groupfilter() { # groupname regex [timestamp]
  groupreleases "$1" "${3:-}" | while IFS=$SEP read -r title etc; do
    grep -P "$2" <<< "$title" 1>/dev/null && echo -E "$title$SEP$etc"
  done
  [ ${PIPESTATUS[0]} = 0 ] || exit 1
}

cleanup() {
  for gs in "${!grouptimes[@]}"; do
    local v="${grouptimes[$gs]}"
    echo -E "touchgroup $gs $v" >> times.sh
    [ -e "$gs.xml" ] && rm "$gs.xml"
  done
  exit ${1:-1}
}

rungroup() {
  local insane regex timestamp res recent
  insane="${groupinsane[$1]}"
  regex="${groupshows[$1]:1}"
  timestamp="${grouptimes[$1]}"
  res="$(groupfilter "$insane" "$regex" "$timestamp")"
  [ $? = 0 ] || return $?
  IFS=$SEP read -r _ _ recent <<< "$res"
  [ -n "$recent" ] && {
    grouptimes[$1]="$recent"
    echo -E "$res"
  }
  return 0
}

runall() {
  trap cleanup INT
  ret=0
  for gs in "${!groupshows[@]}"; do rungroup "$gs" || ret=1; done
  cleanup $ret
}
