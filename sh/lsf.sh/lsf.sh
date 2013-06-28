#!/bin/bash
# ultra-fancy ultra-pointless `ls -l` alternative
# to be sourced by bash or zsh
# similar project: https://github.com/trapd00r/ls--

# to maintain zsh compatibility:
# $() is surrounded in double quotes
# echo -E is used to avoid \033 expanding
# bare asterisks are escaped to prevent globbing
# arrays are used instead of relying on word expansion
# for loops over "${array[@]}" as it works the same in both

# TODO: set better defaults for quick glances at filesize
# TODO: include sorting somehow
# TODO: handle symlinks nicely
# TODO: append WHI / clr to dir names

_lsf_begin(){
	local begin='
me='$UID'
'"$(
awk -F: '{print "unames["$3"]=\""$1"\""}' < /etc/passwd
awk -F: '{print "gnames["$3"]=\""$1"\""}' < /etc/group
for x in $(groups); do echo "us[\"$x\"]=1"; done
i=0;for x in bla red gre yel blu pur cya whi; do
	echo -E $x'="\033[3'${i}'m"'
	echo -n "$x" | tr a-z A-Z
	echo -E '="\033[1;3'${i}'m"'
	let i++
done
)"'
clr="\033[0m"
BLD="\033[1m" 
s=1
m=60*s
h=60*m
d=24*h
y=365*d 
B=1
K=1024*B
M=1024*K
G=1024*M
T=1024*G 
ff["time"]="%3d%s " clr
ff["size"]="%4d" clr "%s "
'"$(
for x in s m h d y;do echo "u[\"time,$x\"]=$x";done
for x in B K M G T;do echo "u[\"size,$x\"]=$x";done
ft=(-1    m    m\*10  h    h\*12  d    d\*7  30\*d  y    y\*2  y\*10)
fut=(s    s    s      m    m      h    h     d      d    d     y    y)
fct=(RED  PUR  pur    YEL  yel    GRE  gre   CYA    cya  BLU   blu  BLA)
fs=( 0    K    K\*8  M    M\*8  G    G\*8  T    T\*8)
fus=(B    B    B     K    K     M    M     G    G    T)
fcs=(BLA  cya  CYA   CYA  yel   yel  pur   pur  red  red)
pc=(BLA WHI yel YEL blu BLU gre GRE)
i=0;for x in "${ft[@]}"; do echo "f[\"time,$i\"]=$x";     let i++;done
echo "f[\"times\"]=$i"
i=0;for x in "${fs[@]}"; do echo "f[\"size,$i\"]=$x";     let i++;done
echo "f[\"sizes\"]=$i"
i=0;for x in "${fut[@]}";do echo "fu[\"time,$i\"]=\"$x\"";let i++;done
i=0;for x in "${fus[@]}";do echo "fu[\"size,$i\"]=\"$x\"";let i++;done
i=0;for x in "${fct[@]}";do echo "fc[\"time,$i\"]=$x";    let i++;done
i=0;for x in "${fcs[@]}";do echo "fc[\"size,$i\"]=$x";    let i++;done
i=0;for x in "${pc[@]}"; do echo "pc[$i]=$x";             let i++;done
)"
	echo -E "$begin"
}

_lsf_cached=
_lsf_program='
function printff(id, n) {
	len=f[id "s"]
	for(i=0;i<=len;i++) {
		idi=id "," i
		if(i!=len && n>f[idi]) continue
		unit=fu[idi]
		printf(fc[idi] ff[id], n/u[id "," unit], unit)
		break
	}
}

function trunc(str, len) {
	e=length(str)>len?"…":""
	return substr(str,0,len-(e?1:0)) e
}
function fixlen(str, len) {
	return trunc(sprintf("%" len "s", str), len)
}
{
	printff("size", $(NF-14))

	uid=$(NF-11)
	gid=$(NF-10)
	is_me=(uid==me)
	is_us=(gnames[gid] in us)

	bits=("0x" $(NF-12))+0
	# note: we ignore the set and sticky bits... for now
	type=rshift(and(bits, 0170000), 12)
	operm=and(bits, 07)
	gperm=rshift(and(bits, 070), 3)
	uperm=rshift(and(bits, 0700), 6)
	our_perm=or(or((is_me)?uperm:0, (is_us)?gperm:0), operm)

	printf(pc[our_perm] "%o " clr, our_perm)
	if(OSP) {
		printf(pc[uperm] "%o" clr, uperm)
		printf(pc[gperm] "%o" clr, gperm)
		printf(pc[operm] "%o " clr, operm)
	}

	if(OSU) {
		name=fixlen((uid in unames)?unames[uid]:uid, 6)
		if(is_me) name=WHI name clr
		printf("%s ", name)
	}

	if(OSG) {
		name=fixlen((gid in gnames)?gnames[gid]:gid, 6)
		if(is_us) name=WHI name clr
		printf("%s ", name)
	}

	da=$(NF-4)
	dc=$(NF-3)
	dm=$(NF-2)
	if(OMR) {
		max=(da>dm)?da:dm
		max=(max>dc)?max:dc
		printff("time", now-max)
	} else {
		printff("time", now-da)
		printff("time", now-dm)
		printff("time", now-dc)
	}

	# acquire filename by killing all fields not part of it
	NF-=15
	fn=$0

	if (!OSPA) {
		if (NR!=1) fn=substr(fn,firstlen)
		else firstlen=length(fn)+2-(fn ~ /\/$/)
	}

	print fn
}'

lsf(){
	local o_showallperm=1 o_showuser=1 o_showgroup=1
	local o_mostrecent=0 o_showpath=1 opts=mgupfs opt
	while getopts $opts'h' opt; do
		case $opt in
		f) _lsf_cached=;;
		p) o_showallperm=0;;
		u) o_showuser=0;;
		g) o_showgroup=0;;
		m) o_mostrecent=1;;
		s) o_showpath=0;;
		?) echo "usage: $0 [-$opts] [dir]"
		   return 1;;
		esac
	done

	[ "$_lsf_cached" ] || _lsf_cached="$(_lsf_begin)"

	shift $((OPTIND-1))
	find "${1:-.}" -maxdepth 1 -exec stat -t {} + | awk --non-decimal-data \
-v"now=$(date +%s)" -v"OMR=$o_mostrecent" -v"OSU=$o_showuser" \
-v"OSG=$o_showgroup" -v"OSP=$o_showallperm" -v"OSPA=$o_showpath" \
"BEGIN{$_lsf_cached}$_lsf_program"
}
