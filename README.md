## obligatory personal dotfiles repository

_(plus some little shell scripts)_

quick install for random boxes:

```
# with curl:
cd && curl -L https://github.com/notwa/rc/archive/master.tar.gz | tar zx && mv rc-master rc && rc/install
# with wget:
cd && wget -O - https://github.com/notwa/rc/archive/master.tar.gz | tar zx && mv rc-master rc && rc/install
```

the following shells are taken into consideration, ordered from most to least compatible:

* zsh
* bash
* dash
* ash (busybox)

refer to the [compatibility table](#compatibility) for specifics.

**NOTE:** everything below this line is overwritten and automatically [regenerated.](/regenerate)

<!-- DOCUMENT -->

## shell functions

### [archive](/sh/archive#L4)

create an archive file in one of a few formats.

borrowed from [prezto.](https://github.com/sorin-ionescu/prezto)

### [argc](/sh/argc#L4)

validate the number of arguments in a function.

```sh
# usage: myfunc() { argc $# -(eq|le|ge) [0-9] "$0" || return; }

myfunc() {
    # use one of the following:
    argc $# -eq N "$0" || return
    argc $# -le N "$0" || return
    argc $# -ge N "$0" || return
    # where N is an integer between 0 and 9.
}
```

### [arith](/sh/arith#L7)

perform arithmetic using the shell and display the result.
see also [`hex`](#hex) and [`bin`](#bin).
this example requires zsh:

```
% db=6
% noglob arith 10**(db/20.)
1.9952623149688795
```

### [aur](/sh/aur#L5)

download, edit, make, and install packages from the
[AUR.](https://aur.archlinux.org/)
it's a little broken.

```
$ aur -eyoI cmdpack-uips applyppf
```

### [autosync](/sh/autosync#L6)

combine `inotifywait` and `rsync`.
this is sometimes nicer than `ssh`-ing into a server and running `vim` remotely.

### [bak](/sh/bak#L4)

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

backup files by appending their timestamps given by [`now`.](#now)

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

### [baks](/sh/baks#L5)

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

### [bin](/sh/bin#L7)

perform arithmetic using the shell and display the result as
an unsigned 8-bit integer in binary.
see also [`arith`](#arith) and [`hex`](#hex).

```
$ bin 123
01111011
```

### [burl](/sh/burl#L4)

turn bash into a makeshift HTTP client.
inspired by [hackshell.sh.](https://thc.org/hs)
also works in most other shells thanks to netcat.

minimal/minified version: https://eaguru.guru/t/burl.sh (416 bytes)

```
$ burl httpbin.org/get

HTTP/1.1 200 OK
Date: Tue, 01 Jul 2024 00:00:00 GMT
Content-Type: application/json
Content-Length: 192
Connection: close
Server: gunicorn/19.9.0
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true

{
  "args": {},
  "headers": {
    "Host": "httpbin.org",
    "X-Amzn-Trace-Id": "Root=1-12345678-deadfadefeedfacebeefcafe"
  },
  "origin": "0.0.0.0",
  "url": "http://httpbin.org/get"
}
```

### [busiest](/sh/busiest#L4)

list directories in descending order by the number of files in them,
counted recursively.

```
$ cd && busiest | head -n3
144181 src
48840 work
21042 play
```

### [clash](/sh/clash#L4)

run a command through 9 different shells.

only returns false when no arguments are given.

### [colors](/sh/colors#L4)

display all combinations of foreground and background terminal colors.
this only includes the basic 16-color palette.
excluding boilerplate, this script is a mere 76 characters long!

![terminal colors](https://eaguru.guru/t/terminal-colors.png)

### [setup_clang_ubuntu (sh/compile)](/sh/compile#L4)

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

### [compile](/sh/compile#L47)

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
# debug build with warning/error flags defined in ~/sh/arrays
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

### [confirm](/sh/confirm#L4)

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
$ g1 && confirm && git commit -a --amend --no-edit
daf84e3 document a ton of stuff
Continue? [y/N] y
[master 92bdf76] document a ton of stuff
 Date: Sun Aug 1 09:27:25 2021 -0700
 20 files changed, 406 insertions(+), 29 deletions(-)
```

### [countdiff](/sh/countdiff#L4)

count the number of lines changed between two files.

**TODO:** don't use git for this. also, use patience algorithm.

```
$ countdiff README-old.md README.md
739
```

### [cutv](/sh/cutv#L4)

(WIP) create a short clip of a long video file.

### [days](/sh/days#L4)

compute the number of days since a given date.

```
$ days 'January 1 1970'
18838
```

### [decently](/sh/decently#L6)

given a list of directories, update the last-modified timestamp
of each argument to that of the most recent file that it contains.

note that *files* are found recursively, but only the
*outermost directory* (the one specified by argument)
has its timestamp updated. symlinks are followed.
`.git` subdirectories are skipped over.
the timestamps of subdirectories are ignored.

### [dfu](/sh/dfu#L4)

pretty-print `df` in GiB.

```
$ dfu
Filesystem              Used     Max    Left    Misc
/dev                    0.00    0.46    0.46    0.00
/                      17.20   23.22    6.01    1.27
```

### [disowned](/sh/disowned#L4)

find files in system directories that aren't associated with any pacman packages.

### [document](/sh/document#L147)

generate a markdown file out of docstrings in shell scripts.

**TODO:** describe. i have a rough outline written in my scrap file.

### [e](/sh/e#L4)

wrap around `$EDITOR` to run it as root if necessary.
this still needs some work to detect root-owned directories.

```
$ e /etc/sudoers
[sudo] password for notwa: 
```

**NOTE:** there also exists an e(1) program provided by
the *e-wrapper* package that i don't use.

### [ea](/sh/ea#L24)

**TODO:** document.

### [echo2](/sh/echo2#L4)

print arguments joined by spaces to stderr without parsing anything.

```
$ echo -e 'this\nthat' those
this
that those
$ echo2 -e 'this\nthat' those
-e this\nthat those
```

### [explore](/sh/explore#L4)

open a single directory in `explorer.exe`, defaulting to `$PWD`.

### [ff](/sh/ff#L4)

select a file from a given or current directory using
[`fzy`.](https://github.com/jhawthorn/fzy)

### [ghmd](/sh/ghmd#L7)

convert a markdown file to HTML in the style of GitHub.
note that this uses GitHub's API, so it requires internet connectivity.

this script utilizes the CSS provided at
[sindresorhus/github-markdown-css.](https://github.com/sindresorhus/github-markdown-css)

```
~/sh/ghmd < ~/rc/README.md > ~/rc/README.html
```

### [grab](/sh/grab#L4)

download a file from my site and verify its integrity by its [minisign](https://github.com/jedisct1/minisign/) signature.

### [grop](/sh/grop#L5)

invoke grep with `-oP`.

**NOTE:** there also exists a grop(1) program provided by
the *grop* package that i don't use.

### [grop4](/sh/grop4#L4)

[`grop`](#grop) for IPv4s.

### [has](/sh/has#L4)

[`have`,](#have) silently.

### [have](/sh/have#L4)

print the result of `which` if the program is found, else simply return 1.

```
export SOLVER="$(have kissat || have picosat || have cadical || have minisat)"
```

### [hex](/sh/hex#L7)

perform arithmetic using the shell and display the result as
an unsigned 32-bit integer in hexadecimal.
see also [`arith`](#arith) and [`bin`](#bin).

```
$ hex 0x221EA8-0x212020
0000FE88
```

**NOTE:** there also exists a hex(1) program provided by
the *basez* package that i don't use.

### [ify](/sh/ify#L4)

pipe one command through another, so you can still pass arguments to the former.

this is mainly useful for aliases. 99% of the time you'll use this with `less`.

```
$ alias ll="ify less ls -ACX --group-directories-first --color=force"
$ ll /etc
```

### [is_empty](/sh/is_empty#L4)

return 0 if the directory given by argument is empty.

### [isup](/sh/isup#L4)

return 0 if a given website returns a 2xx HTTP code.

```
$ isup google.com && echo yay || echo nay
yay
$ isup fdhafdslkjgfjs.com && echo yay || echo nay
nay
```

### [join2](/sh/join2#L4)

join every other line.

### [lsarchive](/sh/lsarchive#L4)

list the contents of an archive file in one of many formats.

borrowed from [prezto.](https://github.com/sorin-ionescu/prezto)

### [maybesudo](/sh/maybesudo#L4)

mimic certain features of `sudo` for systems without it installed.
as it stands, this mostly just handles some environment variables.

try this: `maybesudo_ -u "$USER" printenv`

### [minutemaid](/sh/minutemaid#L4)

check if the current minute is divisible by a given number,
and optionally execute a command if it is. if a command is given,
either execute the command and return its exit value,
or execute nothing and return 0. if a command is omitted,
either return 0 on the minute, or return 1.

note that a "minute" is relative to the seconds since the epoch,
not the minute of the hour. this ensures that commands will run
roughly every N minutes, regardless of the minute hand on the clock.

note that `minutemaid 1` will always return 0,
and `minutemaid 1 command` will always execute the command,
since every integral interval is evenly divisible by 1.
`minutemaid 0`, and any negative interval, is an error.

```
# crontab usage:
* * * * * minutemaid 9 ~/work/do_my_bidding # runs every nine minutes
# loop usage:
until minutemaid 9; do sleep 5; done
echo the wait is finally over; date
# improper usage:
while minutemaid 1; do sleep 1; done
echo this will never happen
```

### [monitor](/sh/monitor#L4)

this is [watch(1)](https://www.man7.org/linux/man-pages/man1/watch.1.html)
loosely reimplemented as a shell script.

```
usage: monitor [-fs] [-n {period}] {command} [{args...}]
```

**NOTE:** there also exists monitor(1) programs provided by
the *389-ds-base* and *dmucs* packages that i don't use.

### [morecolors](/sh/morecolors#L4)

print all 256 colors that are available on most terminals.

### [noccom](/sh/noccom#L6)

strip C-like comments; both multi-line and single-line.

### [note](/sh/note#L4)

act like [`echo2`,](#echo2) but use a bright color to stand out more.

**NOTE:** there also exists a [note(1)](https://www.daemon.de/projects/note/)
program provided by the *note* package that i don't use.

### [now](/sh/now#L4)

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

### [oshi](/sh/oshi#L4)

upload files (or stdin) to [oshi.at.](https://oshi.at)
this script exits with the number of failed uploads; up to 255 at once.
directories are skipped. for now, file expiry is hard-coded at 2 weeks.

```
$ echo test | oshi
MANAGE: https://oshi.at/a/7809e5e8a8b5c28555b1e8cadc99b069d08a5d09
DL: https://oshi.at/ReTn/Dxzy

$ oshi ~/play/{hey,you,fake,empty}
MANAGE: https://oshi.at/a/9b56e4c5843006d491fabe859ea5746a8f36760c
DL: https://oshi.at/obFf/hey
oshi: expires in 14 days: /home/notwa/play/hey
MANAGE: https://oshi.at/a/f2dc46ae900ca7465a377d7a7942e722f87ff483
DL: https://oshi.at/JLBc/you
oshi: expires in 14 days: /home/notwa/play/you
oshi: no such file: /home/notwa/play/fake
oshi: skipping directory: /home/notwa/play/empty
oshi: successfully uploaded 2/4 files
oshi: failed to upload 2/4 files
```

### [oxo](/sh/oxo#L14)

upload files (or stdin) to [0x0.st.](https://0x0.st)
this script exits with the number of failed uploads; up to 255 at once.
file retention period (30 to 365 days) is only computed for arguments.
directories are skipped. please review the terms of service
[on the website](https://0x0.st) before uploading files.

```
$ echo test | oxo
https://0x0.st/sj2.txt
oxo: successfully uploaded 1/1 file

$ oxo ~/play/{hey,you,fake,empty}
https://0x0.st/-3rz.txt
oxo: expires in 365 days: /home/notwa/play/hey
https://0x0.st/-3ri.txt
oxo: expires in 365 days: /home/notwa/play/you
oxo: no such file: /home/notwa/play/fake
oxo: skipping empty file: /home/notwa/play/empty
oxo: successfully uploaded 2/4 files
oxo: failed to upload 2/4 files
```

### [pacbm](/sh/pacbm#L6)

display and order installed pacman packages by their filesize ascending,
and their sum. requires `expac`.

```
$ pacbm | head -n -1 | tail -2
  204.78M clang
  235.44M linux-firmware
```

### [pause](/sh/pause#L4)

pause — the companion script of [`confirm`.](#confirm)

```
$ pause
Press any key to continue
$ 
```

### [pegg](/sh/pegg#L4)

download and (pip) install a Python "egg" from a project on GitHub,
defaulting to the master branch. this uses [`pippy`](#pippy) internally.

```sh
# install the development version of https://github.com/rthalley/dnspython
$ pegg rthalley dnspython
# or instead install the latest stable version (as of writing)
$ pegg rthalley dnspython 3933b49
```

### [pippy](/sh/pippy#L4)

install Python packages using pip,
but only update their dependencies as required.
this uses [`maybesudo`](#maybesudo) internally.

### [pre](/sh/pre#L4)

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

### [preload](/sh/preload#L7)

handle dependencies within the [`~/sh/`](/sh) directory.

this function contains more comments than code, so you should read it.

### [psbm](/sh/psbm#L4)

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

### [running](/sh/running#L6)

WIP

### [scount](/sh/scount#L4)

perform `sort | uniq -c | sort -n`, preferring GNU awk when available.

### [scramble](/sh/scramble#L6)

scrambles text in a predictable way using regex.

sacbremls ttex in a pdrceailtbe way unsig reegx.

**TODO:** consider renaming because scramble(1) already exists.

### [scropt](/sh/scropt#L4)

run `scrot` through `optipng` and save the result to `~/play/$(now).png`.

### [shcom](/sh/shcom#L4)

comment out text from stdin and wrap it in a markdown blockquote
for docstrings. this contains some extra logic for
handling already-commented and already-quoted text.
this allows `shcom` to be used with vim's visual selections
to update existing code examples.

as a simple example, `echo hey | shcom` produces, verbatim:

```
hey
```

### [shelly](/sh/shelly#L2)

(perl 5) invoke the first shell found from a list of shells
as an interactive, non-login shell. arguments are ignored.

### [similar](/sh/similar#L4)

highlight adjacent lines up to the first inequivalent character.

### [slit](/sh/slit#L6)

view specific columns of text.

### [slitt](/sh/slitt#L6)

view specific columns of text.
this version of `slit` uses tabs for its field separators.

### [sortip](/sh/sortip#L4)

sort lines numerically by IPv4 segments.

### [sram](/sh/sram#L4)

convert between a couple saveram formats for N64 emulators.

### [stfu](/sh/stfu#L4)

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

### [sum](/sh/sum#L4)

compute the summation of its arguments without forking processes.
this relies on the shell's built-in arithmetic operators.

```
$ sum 1 2 3
6
```

**TODO:** consider renaming because sum(1) already exists.

### [sv](/sh/sv#L4)

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

### [trash](/sh/trash#L4)

output a given number of bytes from `/dev/random`.

```
$ trash 10 | xxp
3A A5 4F C7 6D 89 E7 D7 F7 0C
```

**TODO:** consider renaming because trash(1) already exists.

### [trunc](/sh/trunc#L4)

truncate text to fit within your terminal using the unicode character `…`.

```
$ echo $COLUMNS
84
$ seq 1 100 | tr '\n' ' ' | trunc
1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31…
```

### [unarchive](/sh/unarchive#L4)

extract the contents of an archive file in one of many formats.

borrowed from [prezto.](https://github.com/sorin-ionescu/prezto)

### [unwrap](/sh/unwrap#L4)

join paragraphs into one line each.

### [v_lower](/sh/v_lower#L4)

transform the contents of a variable to lowercase.

### [v_upper](/sh/v_upper#L4)

transform the contents of a variable to uppercase.

### [wat](/sh/wat#L6)

wat — a better and recursive which/whence. for zsh only.

written by [leah2.](https://leahneukirchen.org/)

### [wipe](/sh/wipe#L4)

clear the screen and its scrollback, then print a high-contrast horizontal line.
using this, you'll know with absolute certainty that you're looking at the top of your history,
and that your terminal's scrollback didn't cap out and eat text.

**TODO:** rename because wipe(1) already exists.

### [xxp](/sh/xxp#L4)

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

### [dummy (zshrc)](/home/zshrc#L81)

return 0, ignoring arguments.

### [dirprev (zshrc)](/home/zshrc#L86)

rotate and change to the previous directory in the directory stack
without consuming the prompt.

### [dirnext (zshrc)](/home/zshrc#L93)

rotate and change to the next directory in the directory stack
without consuming the prompt.

### [dirup (zshrc)](/home/zshrc#L100)

change to the parent directory of the current working directory
without consuming the prompt.

### [dirview (zshrc)](/home/zshrc#L107)

use a fuzzy finder to select a recent directory in the directory stack
and change to it without consuming the prompt.

### [OMFG (zshrc)](/home/zshrc#L212)

silence stdout.

### [STFU (zshrc)](/home/zshrc#L213)

silence stderr.

### [SWAP (zshrc)](/home/zshrc#L214)

swap stdout and stderr. uses fd 3 as an intermediary.

### [WHOA (zshrc)](/home/zshrc#L215)

expand to several C/C++ flags to ease development.

### [WHEE (zshrc)](/home/zshrc#L216)

WHOA but for C++ (specifically g++) only.

### [WELP (zshrc)](/home/zshrc#L217)

expand to C++ flags to enable a C++-as-C facade.

### [reload (zshrc)](/home/zshrc#L264)

reload zsh by wiping temp files, recompiling rc files,
and replacing the current process with a new zsh process.

### [dummy (bashrc)](/home/bashrc#L51)

return 0, ignoring arguments.

### [reload (bashrc)](/home/bashrc#L56)

**TODO:** respect initctl like in `.zshrc`.

### [ADDPATH (shrc)](/home/shrc#L14)

append a directory to `$PATH` if it isn't already present.

### [refresh (shrc)](/home/shrc#L91)

invoke `hash -r`.

### [pl (shrc)](/home/shrc#L94)

print each argument on its own line.

### [ll (shrc)](/home/shrc#L97)

list files verbosely, fancily, ordered, but not recursively.

### [gdp (shrc)](/home/shrc#L107)

invoke `gd` to diff a commit from its parent. the commit defaults to "HEAD".

### [gd (shrc)](/home/shrc#L113)

invoke git's diff subcommand with fewer lines of context.

### [rgn (shrc)](/home/shrc#L116)

invoke ripgrep without respecting `.gitignore` files.

### [curls (shrc)](/home/shrc#L122)

invoke curl with less noise.

### [revend (shrc)](/home/shrc#L134)

reverse the 4-byte endianness of a single file. *this is an in-place operation!*

### [clone (shrc)](/home/shrc#L137)

invoke rsync suitably for creating virtually indistinguishable copies of files.

### [aligntabs (shrc)](/home/shrc#L140)

align tab-delimited fields in stdin.

### [crawla (shrc)](/home/shrc#L151)

play Dungeon Crawl: Stone Soup through ssh on the akrasiac server.

### [crawlz (shrc)](/home/shrc#L154)

play Dungeon Crawl: Stone Soup through ssh on the develz server.

### [diff (shrc)](/home/shrc#L157)

use git's diff subcommand for general diffing.

### [gc (shrc)](/home/shrc#L160)

columnize text by using git's column subcommand.

**TODO:** consider renaming because gc(1) already exists.

### [counts (shrc)](/home/shrc#L164)

count files in the current directory, including files found recursively.

### [exts (shrc)](/home/shrc#L167)

count and sort file extensions in the current directory, including files found recursively.

### [nocom (shrc)](/home/shrc#L170)

strip single-line C-like and shell-like comments.

### [jrep (shrc)](/home/shrc#L173)

extract strings comprised of basic ASCII or Japanese codepoints.

### [bomb (shrc)](/home/shrc#L176)

add a Byte-Order Mark to a file.

### [cleanse (shrc)](/home/shrc#L179)

strip unprintable and non-ASCII characters.

### [double (shrc)](/home/shrc#L182)

print every line twice. <br/> print every line twice.

**NOTE:** there also exists a double(1) program provided by
the *plotutils* package that i don't use.

### [katagana (shrc)](/home/shrc#L187)

convert katakana codepoints to their equivalent hiragana.

this is occasionally useful when translating [debug text from ancient games.](https://tcrf.net/)

### [makepkgf (shrc)](/home/shrc#L191)

make the freakin' package!

### [rakef (shrc)](/home/shrc#L194)

make the freakin' gem!

### [relog (shrc)](/home/shrc#L197)

log on again to refresh your unix groups, etc.

### [carry (shrc)](/home/shrc#L200)

copy files in a plain way using rsync. affected by umask.

## compatibility

| script                                        | preference | zsh  | bash | dash | ash  |
| --------------------------------------------- | ---------- | ---- | ---- | ---- | ---- |
| [archive](#archive)                           |        zsh | ✔️    | ⭕    | ⭕    | ⭕    |
| [argc](#argc)                                 |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [arith](#arith)                               |        zsh | ✔️    | ✔️    | ✔️    | ✔️    |
| [arrays](#arrays)                             |  **false** | ✔️    | ✔️    | ⭕    | ⭕    |
| [askey](#askey)                               |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [aur](#aur)                                   |       bash | ⭕    | ✔️    | ⭕    | ⭕    |
| [autosync](#autosync)                         |        zsh | ✔️    | ⭕    | ⭕    | ⭕    |
| [bak](#bak)                                   |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [baknow](#baknow)                             |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [baks](#baks)                                 |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [bin](#bin)                                   |        zsh | ✔️    | ✔️    | ✔️    | ✔️    |
| [burl](#burl)                                 |       bash | ✔️    | ✔️    | ✔️    | ✔️    |
| [busiest](#busiest)                           |        zsh | ✔️    | ⭕    | ⭕    | ⭕    |
| [clash](#clash)                               |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [colors](#colors)                             |       bash | ✔️    | ✔️    | ⭕    | ⭕    |
| [colors2](#colors2)                           |       bash | ✔️    | ✔️    | ✔️    | ✔️    |
| [compile](#compile)                           |        zsh | ✔️    | ⭕    | ⭕    | ⭕    |
| [confirm](#confirm)                           |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [countdiff](#countdiff)                       |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [cutv](#cutv)                                 |        zsh | ✔️    | ⭕    | ⭕    | ⭕    |
| [dated](#dated)                               |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [days](#days)                                 |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [decently](#decently)                         |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [dfu](#dfu)                                   |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [disowned](#disowned)                         |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [document](#document)                         |       dash | ✔️    | ✔️    | ✔️    | ✔️    |
| [e](#e)                                       |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [ea](#ea)                                     |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [echo2](#echo2)                               |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [explore](#explore)                           |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [ff](#ff)                                     |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [ghmd](#ghmd)                                 |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [glug](#glug)                                 |       dash | ✔️    | ✔️    | ✔️    | ✔️    |
| [grab](#grab)                                 |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [grop](#grop)                                 |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [grop4](#grop4)                               |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [has](#has)                                   |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [have](#have)                                 |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [hex](#hex)                                   |        zsh | ✔️    | ✔️    | ✔️    | ✔️    |
| [ify](#ify)                                   |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [is_empty](#is_empty)                         |       bash | ✔️    | ✔️    | ⭕    | ⭕    |
| [isup](#isup)                                 |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [join2](#join2)                               |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [lsarchive](#lsarchive)                       |        zsh | ✔️    | ⭕    | ⭕    | ⭕    |
| [maybesudo](#maybesudo)                       |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [minutemaid](#minutemaid)                     |       dash | ✔️    | ✔️    | ✔️    | ✔️    |
| [monitor](#monitor)                           |        zsh | ✔️    | ⭕    | ⭕    | ⭕    |
| [morecolors](#morecolors)                     |       bash | ✔️    | ✔️    | ⭕    | ⭕    |
| [noccom](#noccom)                             |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [note](#note)                                 |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [now](#now)                                   |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [obtain](#obtain)                             |       *sh* | ❔    | ❔    | ❔    | ❔    |
| [oshi](#oshi)                                 |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [oxo](#oxo)                                   |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [pacbm](#pacbm)                               |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [pause](#pause)                               |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [pegg](#pegg)                                 |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [pippy](#pippy)                               |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [pre](#pre)                                   |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [preload](#preload)                           |  **false** | ✔️    | ✔️    | ✔️    | ✔️    |
| [psbm](#psbm)                                 |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [randir](#randir)                             |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [rot13](#rot13)                               |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [rs](#rs)                                     |        zsh | ✔️    | ⭕    | ⭕    | ⭕    |
| [running](#running)                           |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [scount](#scount)                             |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [scramble](#scramble)                         |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [scropt](#scropt)                             |       bash | ✔️    | ✔️    | ✔️    | ✔️    |
| [shcom](#shcom)                               |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [shelly](#shelly)                             |   **perl** | *n/a*    | *n/a*    | *n/a*    | *n/a*    |
| [similar](#similar)                           |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [slit](#slit)                                 |       dash | ✔️    | ✔️    | ✔️    | ✔️    |
| [slitt](#slitt)                               |       dash | ✔️    | ✔️    | ✔️    | ✔️    |
| [sortip](#sortip)                             |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [sram](#sram)                                 |        zsh | ✔️    | ✔️    | ⭕    | ⭕    |
| [stfu](#stfu)                                 |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [streamcrap](#streamcrap)                     |  **false** | ✔️    | ✔️    | ⭕    | ⭕    |
| [sum](#sum)                                   |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [sv](#sv)                                     |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [trash](#trash)                               |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [trunc](#trunc)                               |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [unarchive](#unarchive)                       |        zsh | ✔️    | ⭕    | ⭕    | ⭕    |
| [unwrap](#unwrap)                             |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [v_domap](#v_domap)                           |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [v_lower](#v_lower)                           |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [v_upper](#v_upper)                           |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [wat](#wat)                                   |        zsh | ✔️    | ⭕    | ⭕    | ⭕    |
| [wipe](#wipe)                                 |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
| [witch](#witch)                               |       *sh* | ⭕    | ⭕    | ✔️    | ✔️    |
| [xxp](#xxp)                                   |       *sh* | ✔️    | ✔️    | ✔️    | ✔️    |
