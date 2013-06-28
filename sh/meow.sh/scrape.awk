function opentag(str, tag) {
  topen="<"tag">"
  tclose="</"tag">"
  len=length(tag)
  begin=index(str, topen)
  end=index(str, tclose)
  return (begin && end) ? substr(str, begin+len+2, end-begin-len-2) : ""
}

function unescape(str) {
  while (match(str, /&#([0-9]+);/, b))
    str=substr(str, 1, RSTART-1) sprintf("%c",b[1]) substr(str, RSTART+RLENGTH)
  return str
}

function hotdate(str) {
  split(str, d, "[ :]")
  return mktime(d[4]" "months[d[3]]" "d[2]" "d[5]" "d[6]" "d[7])
}

BEGIN{
  # http://stackoverflow.com/a/2123002
  m=split("Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec",d,"|")
  for(o=1;o<=m;o++) months[d[o]]=sprintf("%02d",o)
  glen=length(g)
}

function run(str) {
  title=unescape(opentag(str, "title"))
  if (substr(title,1,glen+2) != "["g"]") return
  pub=unescape(opentag($0, "pubDate"))
# "date -d \""pub "\" +%s" | getline pubunix
  pubunix=hotdate(pub)
  if (pubunix <= timestamp) return
  torrent=unescape(opentag(str, "link"))
  print title sep torrent sep pubunix
}

{run($0)}
