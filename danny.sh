#!/bin/bash
set -o nounset

# danny wants $20 to search for more than 2 tags
# so we'll search for realtags and grep for faketags
# note that special tags like "score:>10" must be the first or second
realtags="$1"
faketags=${2:-}

ip="67.202.114.134" # danbooru.donmai.us
webpage="post/index?tags=$realtags&limit=100&page="
pages=0
tempfile=`mktemp`
current=

term()
{
	rm $current # don't leave it incomplete so it may be redownloaded
	exit 1
}
trap 'term' TERM INT

get='wget -q -erobots=off -O-' # mimic curl
#get='curl'

page=1
while true; do
	$get "http://$ip/${webpage}${page}" > "$tempfile"

	posts=$(grep 'Post\.register({' "$tempfile")
	IFS=$'\n'
	for post in $posts; do
		IFS=' '
		tags=$(echo $post | grep -oP '(?<=tags":")([^"]+)')
		if [ -z "$tags" ]; then continue; fi

		nomatch=0
		for faketag in $faketags; do
			unwanted=0
			if [[ $faketag == -* ]]; then
				faketag=${faketag:1}
				unwanted=1
			fi
			echo $tags | grep -F -- "$faketag" > /dev/null
			result=$?
			if [[ $result != $unwanted ]]; then
				nomatch=1
				break
			fi
		done
		if (($nomatch)); then continue; fi

		url=$(echo "$post" | grep -oP '(?<=file_url":")([^"]+)')
		if [ -z "$url" ]; then continue; fi
		name=$(echo "$url" | cut -d/ -f5)
		current="$name"
		if [ -n "$name" ]; then
			echo $name
			$get "$url" > $name
		fi
	done
	IFS=' '

	if (("$pages" == "0")); then
		# first iteration, discover pagecount
		pages=$(grep -oPm1 \
		    '(?<=>)\d+(?=</a> <a href="/post/index[^"]+" >&gt;&gt;)' \
		    $tempfile)
		pages=${pages:-1}
	fi

	let page++
	if (("$page" > "$pages")); then break; fi
done

rm $tempfile
