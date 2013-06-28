#!/bin/bash 
url="${1:-}"
[[ "$url" =~ ^https?://boards.4chan.org/([A-Za-z]+)/res/([0-9]+) ]] || exit 1
board="${BASH_REMATCH[1]}"
threadnum="${BASH_REMATCH[2]}"

# TODO: curl version

wgetflags="-erobots=off --no-verbose"
wgetflags+=" --no-clobber --recursive --level=1 --span-hosts"
wgetflags+=" --no-directories --directory-prefix=-$board-$threadnum"
wgetflags+=" --accept=jpg,gif,png --domains=images.4chan.org"
wget $wgetflags $url
