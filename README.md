## obligatory personal dotfiles repository

_(plus some little shell scripts)_

quick install for random boxes:

```
cd && curl -L https://github.com/notwa/rc/archive/master.tar.gz | tar zx && mv rc-master rc && rc/install
```

the following shells are taken into consideration, ordered from most to least compatible:

* zsh
* bash
* dash
* ash (busybox)

**NOTE:** everything below this line is overwritten and automatically [regenerated.](/regenerate)

<!-- DOCUMENT -->

## shell functions

### [argc](/sh/argc#L7)

validate the number of arguments in a function.
```sh
# usage: myfunc() { argc -(eq|le|ge) [0-9] "$0" "$@" || return; }

myfunc() {
    # use one of the following:
    argc -eq N "$0" "$@" || return
    argc -le N "$0" "$@" || return
    argc -ge N "$0" "$@" || return
    # where N is an integer between 0 and 9.
}
```

### [arith](/sh/arith#L9)

perform arithmetic using the shell and display the result.
see also [`hex`](#hex) and [`bin`](#bin).
this example requires zsh:

```
% db=6
% noglob arith 10**(db/20.)
1.9952623149688795
```

### [aur](/sh/aur#L7)

download, edit, make, and install packages from the
[AUR.](https://aur.archlinux.org/)
it's a little broken.

```
$ aur -eyoI cmdpack-uips applyppf
```

### [autosync](/sh/autosync#L8)

combine `inotifywait` and `rsync`.
this is sometimes nicer than `ssh`-ing into a server and running `vim` remotely.

### [bak](/sh/bak#L6)

backup files by creating copies and appending ".bak" to their names.
this calls itself recursively to avoid clobbering existing backups.

```
$ touch -d '2001-12-25 16:30:00' butts
$ bak butts
$ touch butts
$ bak butts
$ ls -l
total 0
-rw-r--r-- 1 notwa None 0 Aug  1 08:02 butts
-rw-r--r-- 1 notwa None 0 Aug  1 08:02 butts.bak
-rw-r--r-- 1 notwa None 0 Dec 25  2001 butts.bak.bak
```

### [baknow](/sh/baknow#L4)

backup a single file by appending its timestamp given by [`now`.](#now)

```
$ touch -d '2001-12-25 16:30:00' butts
$ baknow butts
$ baknow butts
cp: overwrite 'butts.2001-12-26_01800000.bak'? n
$ ls -l
total 0
-rw-r--r-- 1 notwa None 0 Dec 25  2001 butts
-rw-r--r-- 1 notwa None 0 Dec 25  2001 butts.2001-12-26_01800000.bak
```

**TODO:** support multiple files at once.

### [baks](/sh/baks#L7)

backup files by copying each and appending *the current* date-time,
irrespective of when the files were modified or created.

```
$ touch -d '2001-12-25 16:30:00' butts
$ baks butts
$ baks butts
$ ls -l
total 0
-rw-r--r-- 1 notwa None 0 Dec 25  2001 butts
-rw-r--r-- 1 notwa None 0 Dec 25  2001 butts.21-08-01_14-54-07.bak
-rw-r--r-- 1 notwa None 0 Dec 25  2001 butts.21-08-01_14-54-09.bak
```

### [bin](/sh/bin#L9)

perform arithmetic using the shell and display the result as
an unsigned 8-bit integer in binary.
see also [`arith`](#arith) and [`hex`](#hex).

```
$ bin 123
01111011
```

### [cdbusiest](/sh/cdbusiest#L4)

cd to the directory with the most files in it, counted recursively.

```
$ cd
$ cdbusiest
152364 src
$ pwd
/home/notwa/src
```

### [colors](/sh/colors#L6)

display all combinations of foreground and background terminal colors.
this only includes the basic 16-color palette.
excluding boilerplate, this script is a mere a 76-characters long!

![terminal colors](https://eaguru.guru/t/terminal-colors.png)

### [compandy](/sh/compandy#L5)

generate compand arguments for ffmpeg audio filters.
this is kinda pointless now that acompressor is wildly supported.

### [setup_clang_ubuntu (sh/compile)](/sh/compile#L6)

print (but don't execute) the commands necessary to install
a fairly recent version of clang on ubuntu-based distros.

```sh
$ setup_clang_ubuntu bionic
wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
echo -n "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main
# deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic main
# 12
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-12 main
# deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-12 main
" > /etc/apt/sources.list.d/llvm-toolchain-bionic.list
apt-get update
apt-get install clang-12
apt-get install lld-12
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-12 1200
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-12 1200
update-alternatives --install /usr/bin/llvm-symbolizer llvm-symbolizer /usr/bin/llvm-symbolizer-12 1200
```

### [compile](/sh/compile#L49)

compile single-file C and C++ programs, messily.

supports gcc and clang on \*nix, and mingw64 gcc, msvc clang,
and regular msvc on Windows. tested on x86\_64 and on ARMv7 as well.
does not support MacOS, maybe someday…

defaults to gnu11 and gnu++1z as C and C++ standards respectively.
defaults to clang, gcc, and msvc in that order.

`compile` attempts to guess the most sane switches for any program, so that compilation may reduce to:

```sh
# debug build
compile rd.c
compile debug rd.c
# debug build with warning/error flags defined in .-shrc
# (requires .zshrc for global alias expansion)
compile WHOA rd.c
# likewise for C++
compile WHOA WELP rd.cc
compile WHOA WELP rd.cpp
# "derelease" build (release build with debug information)
compile derelease WHOA rd.c
# release build (with symbols stripped)
compile release WHOA rd.c
# hardened build (only useful on *nix)
compile hardened WHOA rd.c
# specifying compiler
compile gcc WHOA rd.c
compile msvc WHOA rd.c
compile release clang WHOA rd.c
# compile and execute (FIXME: writing to /tmp is a security concern)
compile derelease rd.c && /tmp/rd
```

### [confirm](/sh/confirm#L6)

display a simple yes-or-no prompt and return 0-or-1 respectively.

```
$ confirm && echo yay || echo nay
Continue? [y/N] y
yay
$ confirm && echo yay || echo nay
Continue? [y/N] n
nay
```

a real world example:

```
% g1 && confirm && git commit -a --amend --no-edit
daf84e3 document a ton of stuff
Continue? [y/N] y
[master 92bdf76] document a ton of stuff
 Date: Sun Aug 1 09:27:25 2021 -0700
 20 files changed, 406 insertions(+), 29 deletions(-)
```

### [countdiff](/sh/countdiff#L6)

count the number of lines changed between two files.

**TODO:** don't use git for this. also, use patience algorithm.

```
$ countdiff README-old.md README.md
739
```

### [cutv](/sh/cutv#L6)

(WIP) create a short clip of a long video file.

### [days](/sh/days#L6)

compute the number of days since a given date.

```
$ days 'January 1 1970'
18838
```

### [dbusiest](/sh/dbusiest#L6)

list directories ordered descending by the number of files in them,
counted recursively. see also [`cdbusiest`.](#cdbusiest)

```
$ cd
$ dbusiest | head -n3
152364 src
46518 work
20903 play
```

### [dfu](/sh/dfu#L6)

pretty-print `df` in GiB.

```
$ dfu
Filesystem              Used     Max    Left    Misc
/dev                    0.00    0.46    0.46    0.00
/                      17.20   23.22    6.01    1.27
```

### [disf](/sh/disf#L9)

disassemble a single function from an unstripped executable, unreliably.

### [document](/sh/document#L135)

generate a markdown file out of docstrings in shell scripts.

**TODO:** describe. i have a rough outline written in my scrap file.

### [e](/sh/e#L6)

wrap around `$EDITOR` to run it as root if necessary.
this still needs some work to detect root-owned directories.

```
$ e /etc/sudoers
[sudo] password for notwa: 
```

### [ea](/sh/ea#L7)

**TODO:** document.

### [echo2](/sh/echo2#L6)

print arguments joined by spaces to stderr without parsing anything.

```
$ echo -e 'this\nthat' those
this
that those
$ echo2 -e 'this\nthat' those
-e this\nthat those
```

### [explore](/sh/explore#L6)

open a single directory in `explorer.exe`, defaulting to `$PWD`.

### [ff](/sh/ff#L6)

select a file from a given or current directory using
[`fzy`.](https://github.com/jhawthorn/fzy)

### [ghmd](/sh/ghmd#L9)

convert a markdown file to HTML in the style of GitHub.
note that this uses GitHub's API, so it requires internet connectivity.

this script utilizes the CSS provided at
[sindresorhus/github-markdown-css.](https://github.com/sindresorhus/github-markdown-css)

```
~/sh/ghmd < ~/rc/README.md > ~/rc/README.html
```

### [has](/sh/has#L6)

print the result of `which` if the program is found, else simply return 1.

```
export CC="$(has clang || has clang-3.8 || has gcc)"
```

### [hex](/sh/hex#L9)

perform arithmetic using the shell and display the result as
an unsigned 32-bit integer in hexadecimal.
see also [`arith`](#arith) and [`bin`](#bin).

```
$ hex 0x221EA8-0x212020
0000FE88
```

**NOTE:** there also exists a hex(1) program provided by
the *basez* package that i don't use.

### [ify](/sh/ify#L6)

pipe one command through another, so you can still pass arguments to the former.

this is mainly useful for aliases. 99% of the time you'll use this with `less`.

```
$ alias ll="ify less ls -ACX --group-directories-first --color=force"
$ ll /etc
```

### [is_empty](/sh/is_empty#L6)

return 0 if the directory given by argument is empty.

### [isup](/sh/isup#L6)

return 0 if a given website returns a 2xx HTTP code.

```
$ isup google.com && echo yay || echo nay
yay
$ isup fdhafdslkjgfjs.com && echo yay || echo nay
nay
```

### [maybesudo_ (sh/maybesudo)](/sh/maybesudo#L6)

mimic certain features of `sudo` for systems without it installed.
as it stands, this mostly just handles some environment variables.

try this: `maybesudo_ -u "$USER" printenv`

### [minutemaid](/sh/minutemaid#L6)

return 0 and/or execute a command if the current minute
is divisible by a given number. note that a minute is
relative to the seconds since the epoch, not the minute of the hour.
this ensures that commands will run roughly every N minutes,
regardless of the minute hand on the clock.

```
# crontab usage:
* * * * * minutemaid 9 ~/work/do_my_bidding # runs every nine minutes
```

### [monitor](/sh/monitor#L4)

this is [watch(1)](https://www.man7.org/linux/man-pages/man1/watch.1.html)
loosely reimplemented as a shell script.

```
usage: monitor [-fs] [-n {period}] {command} [{args...}]
```

**NOTE:** there also exists monitor(1) programs provided by
the *389-ds-base* and *dmucs* packages that i don't use.

### [noccom](/sh/noccom#L10)

strip C-like comments; both multi-line and single-line.

### [note](/sh/note#L6)

act like [`echo2`,](#echo2) but use a bright color to stand out more.

**NOTE:** there also exists a [note(1)](https://www.daemon.de/projects/note/)
program provided by the *note* package that i don't use.

### [now](/sh/now#L8)

print a date-time (UTC) in a sortable format.
this takes a date or file as an argument,
else it defaults to the current time.
```
$ now
2019-05-27_35083906
$ now ~/sh/monitor
2017-03-14_82387259
$ now '@1234567890'
2009-02-13_84690000
```

### [pacbm](/sh/pacbm#L6)

display and order installed pacman packages by their filesize ascending,
and their sum. requires `expac`.

```
$ pacbm | head -n -1 | tail -2
  204.78M clang
  235.44M linux-firmware
```

### [pause](/sh/pause#L6)

pause — the companion script of [`confirm`.](#confirm)

```
$ pause
Press any key to continue
$ 
```

### [pegg](/sh/pegg#L8)

download and (pip) install a Python "egg" from a project on GitHub,
defaulting to the master branch. this uses [`pippy`](#pippy) internally.

```sh
# install the development version of https://github.com/rthalley/dnspython
$ pegg rthalley dnspython
# or instead install the latest stable version (as of writing)
$ pegg rthalley dnspython 3933b49
```

### [pippy](/sh/pippy#L7)

install Python packages using pip,
but only update their dependencies as required.
this uses [`maybesudo`](#maybesudo_-shmaybesudo) internally.

### [pre](/sh/pre#L6)

dump all the `#define`s that `$CC $CPPFLAGS $CFLAGS $LDFLAGS` would result in.

```
$ pre | shuf | head -n10
#define __GNUC_MINOR__ 3
#define __SIZEOF_LONG__ 4
#define __UINT_LEAST16_TYPE__ short unsigned int
#define __ORDER_BIG_ENDIAN__ 4321
#define __SIZEOF_FLOAT__ 4
#define __INTMAX_MAX__ 0x7fffffffffffffffLL
#define __INT64_C(c) c ## LL
#define __UINT16_MAX__ 0xffff
#define __DEC64_MANT_DIG__ 16
#define __DBL_HAS_INFINITY__ 1
```

### [preload](/sh/preload#L3)

handle dependencies within the [`~/sh/`](/sh) directory.
this function contains more comments than code, so you should read it.

### [psbm](/sh/psbm#L6)

display and order processes by their memory usage ascending, and their sum.

```
$ psbm | head -n -1 | tail -2
  185.08M    1163 chromium
  199.95M    1060 chromium
```

### [randir](/sh/randir#L6)

display a random directory in the current working directory.

```
$ randir
./sh
```

### [refresh](/sh/refresh#L6)

invoke `hash -r`.

### [rot13](/sh/rot13#L6)

rot13 with numbers rotated as well.

```
$ rot13 <<< abc123
nop678
```

**NOTE:** there also exists rot13(1) programs provided by
the *bsdgames* and *hxtools* packages that i don't use.

### [rs](/sh/rs#L4)

record screen. does not record audio.
currently only works on Windows (gdigrab).
i'm sure there's something equivalent for Linux.

**TODO:** consider renaming because rs(1) already exists.

### [sc](/sh/sc#L36)

upload given files to a webserver and return a direct link for sharing them.
you'll want to tweak this if you use it yourself.
this contains some extra logic for screenshots created by `scropt`.

**TODO:** consider renaming because sc(1) already exists.

### [scramble](/sh/scramble#L6)

scrambles text in a predictable way using regex.

sacbremls ttex in a pdrceailtbe way unsig reegx.

**TODO:** consider renaming because scramble(1) already exists.

### [screeny](/sh/screeny#L4)

handle GNU screens.
these days, i typically use tmux instead.

### [scropt](/sh/scropt#L4)

run `scrot` through `optipng` and save the result to `~/play/$(now).png`.

```
$ ~/sh/sc $(~/sh/scropt -s -d0.5)
```

### [shcom](/sh/shcom#L7)

comment out text from stdin and wrap it in a markdown blockquote
for docstrings. this contains some extra logic for
handling already-commented and already-quoted text.
this allows `shcom` to be used with vim's visual selections
to update existing code examples.

as a simple example, `echo hey | shcom` produces, verbatim:

```
hey
```

### [similar](/sh/similar#L6)

highlight adjacent lines up to the first inequivalent character.

### [slit](/sh/slit#L6)

view specific columns of text.

### [slitt](/sh/slitt#L6)

view specific columns of text.
this version of `slit` uses tabs for its field separators.

### [sram](/sh/sram#L4)

convert between a couple saveram formats for N64 emulators.

### [stfu](/sh/stfu#L7)

invoke a command, silencing stdout and stderr *unless* the command fails.

**NOTE:** don't use `stfu` for handling sensitive data or commands!
use it for 7zip.

note that the tail commands in the example below are from `stfu` itself;
they are echoed to reveal the temp paths for any further investigation.

```
$ touch butts
$ STFU_TAIL=5
$ stfu 7z a butts.7z butts
$ stfu 7z a butts.7z asses
command failed with exit status 1:
7z a butts.7z asses

$ tail -n 5 /tmp/stfu.CoJ0vmJsqA/out_1627942118
Scan WARNINGS for files and folders:

asses : The system cannot find the file specified.
----------------
Scan WARNINGS: 1

$ tail -n 5 /tmp/stfu.CoJ0vmJsqA/err_1627942118

WARNING: The system cannot find the file specified.
asses


```

### [mpvs (sh/streamcrap)](/sh/streamcrap#L6)

invoke mpv with some extra flags suited for streamed sources.

### [mpv_watch (sh/streamcrap)](/sh/streamcrap#L66)

watch something in mpv with a bunch of extra audio filtering crap.

### [mpv_stream (sh/streamcrap)](/sh/streamcrap#L78)

watch a stream in mpv with a bunch of extra audio filtering crap.

### [twitch (sh/streamcrap)](/sh/streamcrap#L87)

watch a twitch stream in mpv with a bunch of extra audio filtering crap.

### [yt (sh/streamcrap)](/sh/streamcrap#L94)

watch a youtube video in mpv with a bunch of extra audio filtering crap.
this can be given a full URL or just a video ID.
remaining arguments are passed to mpv.

there exist several variants for more specific use cases.

**NOTE:** there also exists a yt(1) program provided by
the *python3-yt* package that i don't use.

### [ytg (sh/streamcrap)](/sh/streamcrap#L109)

watch a youtube video. like `yt`, but with a preference for different formats.

### [ytll (sh/streamcrap)](/sh/streamcrap#L116)

watch a stream on youtube in mpv, etcetera etcetera.
this is the low latency version that does not support seeking.

### [ytgll (sh/streamcrap)](/sh/streamcrap#L123)

watch a stream on youtube in mpv. like `ytll`, but with a preference for different formats.

### [sum](/sh/sum#L6)

compute the summation of its arguments without forking processes.
this relies on the shell's built-in arithmetic operators.

```
$ sum 1 2 3
6
```

**TODO:** consider renaming because sum(1) already exists.

### [sv](/sh/sv#L6)

collect the lastmost value of every key.
the field separator can be given as its sole argument,
it defaults to a single space otherwise.

```
$ echo "alpha=first\nbeta=second\nalpha=third" | sv =
alpha=third
beta=second
```

this next example uses `sv` to only print the lastmost line
matching a pattern in each file. in other words, it uses
the filename printed by grep as the key in its key-value pairs.

```
$ cd ~/play/hash && grep -r 'ing$' . | sv :
./dic_win32.txt:WriteProfileString
./cracklib-small.txt:zoning
./english-words.txt:zooming
./usernames-125k.txt:flats_gaming
./cain.txt:zoografting
./pokemon.txt:Fletchling
./pokemon8.txt:Fletchling
```

**TODO:** rename because busybox(1) sv already exists.

### [tpad](/sh/tpad#L6)

add a 1px transparent border around an image to prevent twitter from mangling it into a jpg.
sadly, this trick doesn't work anymore.

### [trash](/sh/trash#L6)

output a given number of bytes from `/dev/random`.

```
$ trash 10 | xxp
3A A5 4F C7 6D 89 E7 D7 F7 0C
```

### [trunc](/sh/trunc#L6)

truncate text to fit within your terminal using the unicode character `…`.

```
$ echo $COLUMNS
84
$ seq 1 100 | tr '\n' ' ' | trunc
1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31…
```

### [unscreen](/sh/unscreen#L6)

handle closing of screens — this works alongside [`screeny`](#screeny).
these days, i typically use tmux instead.

### [wat](/sh/wat#L8)

wat — a better and recursive which/whence. for zsh only.

written by [leah2.](https://leahneukirchen.org/)

### [wipe](/sh/wipe#L6)

clear the screen and its scrollback, then print a high-contrast horizontal line.
using this, you'll know with absolute certainty that you're looking at the top of your history,
and that your terminal's scrollback didn't cap out and eat text.

**TODO:** rename because wipe(1) already exists.

### [xxp](/sh/xxp#L6)

act like `xxd -p`, but nicely formatted.

**TODO:** support `-r` (reverse) argument.

```
$ xxd -p ~/rc/install | head -n2
23212f7573722f62696e2f656e762073680a232074686973207363726970
7420697320636f6d70617469626c65207769746820666f6c6c6f77696e67
$ xxp ~/rc/install | head -n2
23 21 2F 75 73 72 2F 62 69 6E 2F 65 6E 76 20 73
68 0A 23 20 74 68 69 73 20 73 63 72 69 70 74 20
```

## miscellaneous

### [dummy (zshrc)](/home/zshrc#L64)

return 0, ignoring arguments.

### [dirprev (zshrc)](/home/zshrc#L71)

rotate and change to the previous directory in the directory stack
without consuming the prompt.

### [dirnext (zshrc)](/home/zshrc#L78)

rotate and change to the next directory in the directory stack
without consuming the prompt.

### [dirup (zshrc)](/home/zshrc#L85)

change to the parent directory of the current working directory
without consuming the prompt.

### [dirview (zshrc)](/home/zshrc#L92)

use a fuzzy finder to select a recent directory in the directory stack
and change to it without consuming the prompt.

### [OMFG (zshrc)](/home/zshrc#L166)

silence stdout.

### [STFU (zshrc)](/home/zshrc#L167)

silence stderr.

### [WHOA (zshrc)](/home/zshrc#L168)

expand to several C/C++ flags to ease development.

### [WELP (zshrc)](/home/zshrc#L169)

expand to C++ flags to enable a C++-as-C facade.

### [pl (zshrc)](/home/zshrc#L173)

print each argument on its own line.

### [tw (zshrc)](/home/zshrc#L176)

invoke `twitch` as a job with both stdout and stderr silenced.

### [reload (zshrc)](/home/zshrc#L220)

reload zsh by wiping temp files, recompiling rc files,
and replacing the current process with a new zsh process.

### [dummy (bashrc)](/home/bashrc#L45)

return 0, ignoring arguments.

### [reload (bashrc)](/home/bashrc#L50)

**TODO:** respect initctl like in `.zshrc`.

### [has (-shrc)](/home/-shrc#L8)

hardcoded here for convenience.

### [ADDPATH (-shrc)](/home/-shrc#L24)

append a directory to `$PATH` if it isn't already present.

### [fils (-shrc)](/home/-shrc#L117)

(GNU du) display human-friendly filesizes for the files in a directory.

### [lsa (-shrc)](/home/-shrc#L118)

(GNU ls) list files with directories and dotfiles ordered first.

### [perlu (-shrc)](/home/-shrc#L119)

invoke perl expecting files with UTF-8 encoding.

### [rgn (-shrc)](/home/-shrc#L120)

invoke ripgrep without respecting `.gitignore` files.

### [cms (-shrc)](/home/-shrc#L121)

invoke cryptominisat5 with less noise.

### [curls (-shrc)](/home/-shrc#L122)

invoke curl with less noise.

### [get (-shrc)](/home/-shrc#L126)

retrieve the most recent files from the default branch of a git repository, and not much else.

### [gs (-shrc)](/home/-shrc#L127)

invoke git's status subcommand.

**TODO:** consider renaming because gs(1) already exists.

### [gd (-shrc)](/home/-shrc#L130)

invoke git's diff subcommand with fewer lines of context.

### [gds (-shrc)](/home/-shrc#L131)

display difference stats from git.

### [gl (-shrc)](/home/-shrc#L132)

invoke git's log subcommand with a single line per commit.

### [glo (-shrc)](/home/-shrc#L133)

navigate git's commit tree succinctly.

### [g1 (-shrc)](/home/-shrc#L134)

display the most recent git commit.

### [gr (-shrc)](/home/-shrc#L135)

display remote git repositories verbosely.

### [gb (-shrc)](/home/-shrc#L136)

display the current git branch.

**NOTE:** there also exists a gb(1) program provided by
the *gb* package that i don't use.

### [revend (-shrc)](/home/-shrc#L146)

reverse the 4-byte endianness of a single file. *this is an in-place operation!*

### [clone (-shrc)](/home/-shrc#L148)

invoke rsync suitably for creating virtually indistinguishable copies of files.

### [aligntabs (-shrc)](/home/-shrc#L149)

align tab-delimited fields in stdin.

### [crawla (-shrc)](/home/-shrc#L150)

play Dungeon Crawl: Stone Soup through ssh on the akrasiac server.

### [crawlz (-shrc)](/home/-shrc#L151)

play Dungeon Crawl: Stone Soup through ssh on the develz server.

### [eahead (-shrc)](/home/-shrc#L153)

deprecated name for [`ea head`.](#ea)

### [eaget (-shrc)](/home/-shrc#L154)

deprecated name for [`ea get`.](#ea)

### [eaput (-shrc)](/home/-shrc#L155)

deprecated name for [`ea put`.](#ea)

### [eamove (-shrc)](/home/-shrc#L156)

deprecated name for [`ea move`.](#ea)

### [eacopy (-shrc)](/home/-shrc#L157)

deprecated name for [`ea copy`.](#ea)

### [eadelete (-shrc)](/home/-shrc#L158)

deprecated name for [`ea delete`.](#ea)

### [eamv (-shrc)](/home/-shrc#L159)

invoke [`ea move`.](#ea)

### [eacp (-shrc)](/home/-shrc#L160)

invoke [`ea copy`.](#ea)

### [earm (-shrc)](/home/-shrc#L161)

invoke [`ea delete`.](#ea)

### [ll (-shrc)](/home/-shrc#L164)

list files verbosely, fancily, ordered, but not recursively.

### [diff (-shrc)](/home/-shrc#L172)

use git's diff subcommand for general diffing.

### [gc (-shrc)](/home/-shrc#L173)

columnize text by using git's column subcommand.

**TODO:** consider renaming because gc(1) already exists.

### [counts (-shrc)](/home/-shrc#L176)

count files in the current directory, including files found recursively.

### [exts (-shrc)](/home/-shrc#L177)

count and sort file extensions in the current directory, including files found recursively.

### [nocom (-shrc)](/home/-shrc#L178)

strip single-line C-like and shell-like comments.

### [sortip (-shrc)](/home/-shrc#L179)

sort numerically by IPv4 segments.

### [jrep (-shrc)](/home/-shrc#L180)

extract strings comprised of basic ASCII or Japanese codepoints.

### [bomb (-shrc)](/home/-shrc#L181)

add a Byte-Order Mark to a file.

### [cleanse (-shrc)](/home/-shrc#L182)

strip unprintable and non-ASCII characters.

### [unwrap (-shrc)](/home/-shrc#L183)

join paragraphs into one line each.

### [double (-shrc)](/home/-shrc#L184)

print every line twice. <br/> print every line twice.

**NOTE:** there also exists a double(1) program provided by
the *plotutils* package that i don't use.

### [join2 (-shrc)](/home/-shrc#L188)

join every other line.

### [katagana (-shrc)](/home/-shrc#L189)

convert katakana codepoints to their equivalent hiragana.
useful for translating [debug text from ancient games.](https://tcrf.net/)

### [picky (-shrc)](/home/-shrc#L191)

TODO

### [unused (-shrc)](/home/-shrc#L192)

TODO

### [makepkgf (-shrc)](/home/-shrc#L193)

make the freakin' package!

### [rakef (-shrc)](/home/-shrc#L194)

make the freakin' gem!

### [eashare (-shrc)](/home/-shrc#L196)

upload a file and copy its URL to the clipboard.

**NOTE:** this only works on MSYS2 for now.

**NOTE:** i lied, this doesn't work at all.
