## obligatory personal dotfiles repository

_(plus some little shell scripts)_

quick install for random boxes:

```
cd && curl -L https://github.com/notwa/rc/archive/master.tar.gz | tar zx && mv rc-master rc && rc/install
```

## stuff defined in RC files

such as [.bashrc](/home/bashrc) and [.zshrc](/home/zshrc)
but mostly [-shrc](/home/-shrc) and [.streamcrap](/home/streamcrap)

### reload

exec's the current shell.
if it's `zsh`, it'll also recompile `.zshrc` so everything actually reloads.

### ADDPATH

adds a directory to `$PATH` if it isn't already there.

### ify

pipes a command through another command, so you can pass arguments at the end as usual.

this is mainly useful for aliases. 99% of the time you'll use this with `less`.

```
$ alias ll="ify less ls -ACX --group-directories-first --color=force"
$ ll /etc
```

### has

prints the result of `which` if the program is found, or shuts up and returns 1.

```
export CC="$(has clang || has clang-3.8 || has gcc)"
```

### revend

reverses the 4-byte endianness of a file. this is an in-place operation!

### nocom

strips lines that begin with a `#` character.

### jrep

extracts ascii and japanese unicode characters.

### bomb

adds a Byte Order Mark to a file.

### cleanse

extracts readable ascii characters.

### rot13

rot13 with rotated numbers as well.

### unwrap

unwraps text that was wrapped using double-newlines as spacing,
e.g. this readme file.

### double

prints every line twice.
prints every line twice.

### join2

joins every other line.

```
$ echo "hey\nyou\nout there\nwe bringing it live" | join2
hey you
out there we bringing it live
```

### katagana

converts katakana to hiragana.
useful for translating [debug text from ancient games.](https://tcrf.net/)

### picky + unused

attempts to find any non-standard packages that were installed
with pacman so that you can make note to install them, later,
on a fresh installation.

`unused` will print unused packages instead.

### makepkgf + rakef

make the freakin' package!

### trash

given a number of bytes, outputs binary garbage from `/dev/random`.

### wipe

(zsh) clears the screen and scrollback and prints an ugly horizontal line,
so you know with absolute certainty that you're looking
at the top of your history, and that your terminal's scrollback
didn't cap out and eat text.

```
$ wipe; ./configure && make
[insert a bajillion lines you'd never be able to find the top of unless
 you piped it to a file or less or wiped scrollback beforehand]
```

### yt

watches a youtube video through mpv with a bunch of audio filtering crap.

can be given a full URL or just a video ID.
remaining arguments are passed to mpv.

there exist several other variants for specific use cases.

### twitch

watches twitch streams through mpv with a bunch of audio filtering crap.

give it a username.
remaining arguments are passed to mpv.

## shell scripts

most (but not all) stuff that's written for bash will work in zsh too.
if it just says `(sh)` then it'll probably work on any shell,
but might depend on GNU awk.

[prezto]: https://github.com/sorin-ionescu/prezto

### [arith](/sh/arith) + [hex](/sh/hex)

(zsh) does arithmetic using the shell.

```
$ noglob arith 10**(6/20.)
1.9952623149688795
$ hex 0x221EA8-0x212020
0000FE88
```

### [aur](/sh/aur)

(bash) downloads, edits, makes, and installs packages from the [AUR.](//aur.archlinux.org)

it's a little broken.

```
$ aur -eyoI cmdpack-uips applyppf
```

### [autosync](/sh/autosync)

(zsh) combines inotifywait and rsync.

sometimes nicer than ssh-ing into a server and running vim remotely.

### [cdbusiest](/sh/cdbusiest) + [dbusiest](/sh/dbusiest)

(zsh) cd to the directory with the most files in it (recursive).
dbusiest just outputs file counts without changing the directory.

useful for finding the biggest stinkers when archiving.

```
$ cd
$ cdbusiest
197195 src
$ pwd
/home/notwa/src
```

### [colors](/sh/colors)

(bash) print out all the foreground and background terminal color combinations.
a 76-character script!

### [compandy](/sh/compandy)

(zsh) a dumb thing to generate compand arguments for ffmpeg audio filters.

kinda pointless now that acompressor is wildly supported.

### [compile](/sh/compile)

(zsh) a huge mess for compiling single-file C and C++ programs.

supports gcc and clang on \*nix,
and mingw64 gcc, msvc clang, and regular msvc on Windows.
tested on x86\_64 and on ARMv7 as well.
does not support MacOS, maybe someday…

defaults to gnu11 and gnu++1z as C and C++ standards respectively.
defaults to clang, gcc, and msvc in that order.

`compile` attempts to guess the most sane switches for any program,
so that compilation may reduce to:

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

also contains a helper function that dumps the commands required to
install a recent version of clang on an ubuntu machine.

### [confirm](/sh/confirm)

(bash/zsh) displays a simple yes/no prompt and returns 0 or 1 respectively.

```
$ confirm && echo yay || echo nay
Continue? [y/N] y
yay
$ confirm && echo yay || echo nay
Continue? [y/N] n
nay
```

### [days](/sh/days)

(bash) compute days since a date.

```
$ days 'January 1 1970'
17229
```

### [dfu](/sh/dfu)

(sh) pretty-print `df` in GiB.

```
$ dfu
Filesystem              Used     Max    Left    Misc
/dev                    0.00    0.45    0.45    0.00
/                      12.13   13.75    1.62    0.75
/boot                   0.02    0.10    0.07    0.00
/media/chibi         1275.73 1304.45   28.72   69.88
```

### [disf](/sh/disf)

disassembles a single function from an unstripped executable.
not robust.

### [e](/sh/e)

(zsh) wraps around $EDITOR to run as root if necessary.
this still needs some work to detect root-owned directories.

```
$ e /etc/sudoers
[sudo] password for notwa: 
```

### [is\_empty](/sh/is_empty)

(bash) returns 0 if the directory given by $1 is empty.

### [isup](/sh/isup)

(zsh) returns 0 if a website returns a 2xx HTTP code.

```
$ isup google.com && echo yay || echo nay
yay
$ isup fdhafdslkjgfjs.com && echo yay || echo nay
nay
```

### [lsarchive](/sh/lsarchive) + [unarchive](/sh/unarchive)

(zsh) guess what these do. [via prezto.][prezto]
includes autocomplete files.

### [minutemaid](/sh/minutemaid)

(zsh) returns 0 if the current minute is divisible by a number.

note that a minute is relative to the seconds since the epoch,
not the minute of the hour.

```
# crontab usage:
* * * * * minutemaid 9 cd repo && git pull # runs every nine minutes
```

### [monitor](/sh/monitor)

(zsh) basically just `watch` reimplemented as a shell script. kinda nice though.

### [now](/sh/now)

(bash) prints a date-time (UTC) in a sortable format.
it takes a date or file as an argument,
else defaults to the current time.

```
$ now
2019-05-27_35083906
$ now ~/sh/monitor
2017-03-14_82387259
$ now '@1234567890'
2009-02-13_84690000
```

### [pacbm](/sh/pacbm)

(zsh) lists installed pacman packages by their filesize, and the sum, ascending.
requires `expac`.

```
$ pacbm | head -n -1 | tail -2
  204.78M clang
  235.44M linux-firmware
```

### [pacman-list-disowned](/sh/pacman-list-disowned)

(zsh?) lists disowned pacman files. this might take a while.
[via prezto.][prezto]

### [pause](/sh/pause)

(bash/zsh) pause; the companion script of `confirm`.

```
$ pause
Press any key to continue
$ 
```

### [pre](/sh/pre)

(bash/zsh) dumps all the #defines that `$CC $CPPFLAGS $CFLAGS $LDFLAGS` would result in.

```
$ pre | shuf | head -10
#define __NO_MATH_INLINES 1
#define __FLT_MIN_10_EXP__ (-37)
#define __INT_LEAST32_TYPE__ int
#define __FLT_MIN_EXP__ (-125)
#define __LDBL_MIN_EXP__ (-16381)
#define __UINT8_C_SUFFIX__ 
#define __WINT_UNSIGNED__ 1
#define __INT_LEAST16_FMTd__ "hd"
#define __UINT_FAST32_MAX__ 4294967295U
#define __SSE__ 1
```

### [psbm](/sh/psbm)

(sh) lists processes by their memory usage, and the sum, ascending.

```
$ psbm | head -n -1 | tail -2
  185.08M    1163 chromium
  199.95M    1060 chromium
```

### [randir](/sh/randir)

(sh) outputs a random directory in the working directory.

```
$ randir
./sh
```

### [rs](/sh/rs)

(zsh) record screen. does not record audio.

currently only works on Windows (gdigrab).
i'm sure there's something equivalent for Linux.

### [sc](/sh/sc)

(bash) uploads given files to a webserver and returns a direct link for sharing.
you'll want to tweak this if you use it yourself.

has some extra logic for screenshots created by `scropt`.

### [scramble](/sh/sc)

(bash) scrambles text in a predictable way using regex.

(bhas) sacbremls ttex in a pdrceailtbe way unsig reegx.

### [screeny](/sh/screeny) + [unscreen](/sh/unscreen)

(zsh) sets up and detaches a screen for running daemons as other users, etc.

this will close any existing screens of the same name using its companion script, unscreen.

e.g. run znc as user znc in a screen called znc: `screeny znc znc znc -f`. znc!

<!--(you should really just use tmux though)-->

### [scropt](/sh/scropt)

(bash) runs `scrot` through `optipng` and saves to `~/play/$(now).png`.

```
$ ~/sh/sc $(~/sh/scropt -s -d0.5)
```

### [similar](/sh/similar)

(sh) highlights similarities between adjacent lines.

### [slit](/sh/slit) + [slitt](/sh/slitt)

(zsh) views specific columns of text.
[via pretzo.][prezto]

```
$ df | slit 1 5
Filesystem Use%
dev 0%
run 1%
/dev/sda6 30%
tmpfs 3%
tmpfs 0%
tmpfs 1%
tmpfs 1%
```

`slitt` is exactly the same, but it works with tabs instead of spaces.

### [sram](/sh/sram)

(zsh) converts between a couple saveram formats for N64 emulators.

### [sv](/sh/sv)

(bash) collects the lastmost value of every key.
takes the field separator as an argument.

```
echo "this=that\nthem=those\nthis=cat" | sv =
this=cat
them=those
```

### [tpad](/sh/tpad)

(bash) adds a 1px transparent border around an image
so that twitter doesn't mangle it into a jpg.
sadly, this trick doesn't work anymore.

### [trunc](/sh/trunc)

(bash) truncates text to fit within your terminal using the unicode character `…`.
