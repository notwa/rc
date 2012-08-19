#!/bin/bash
tags=$1

ip="67.202.114.134" # danbooru.donmai.us
webpage="post/index?tags=$tags&limit=100&page="
pages=0
tempfile=`mktemp`

# wget opts: less verbose, no directories, ignore robots.txt, output to stdout
# can be replaced with curl
get='wget -nvd -erobots=off -O-'

page=1
while true; do
	$get "http://$ip/${webpage}${page}" > "$tempfile"

	image_urls=$(grep -oP '(?<=file_url":")([^"]+)' $tempfile)
	for url in $image_urls; do
		name=$(echo "$url" | cut -d/ -f5)
		if [ -e "$name" ]; then :
		else
			$get $url > $name
		fi
	done

	if (("$pages" == "0")); then
		# first iteration, discover pagecount
		pages=$(grep -oPm1 \
		    '(?<=>)\d+(?=</a> <a href="/post/index[^"]+" >&gt;&gt;)' \
		    $tempfile)
		pages=${pages:-1}
		echo $pages
	fi

	let page++
	if (("$page" > "$pages")); then break; fi
done

rm $tempfile
