## obligatory personal dotfiles repository

_(plus some little shell scripts)_

quick install for random boxes:

```
cd && curl -L https://github.com/notwa/rc/archive/master.tar.gz | tar zx && mv rc-master rc && rc/install
```

**NOTE:** everything below this line is overwritten and automatically [regenerated.](/regenerate)

<!-- DOCUMENT -->

## shell functions

### [arith](/sh/arith#L9)

perform arithmetic using the shell and display the result.

### [aur](/sh/aur#L7)

download, edit, make, and install packages from the
[AUR.](https://aur.archlinux.org/)
it's a little broken.

### [autosync](/sh/autosync#L8)

combine `inotifywait` and `rsync`.
this is sometimes nicer than `ssh`-ing into a server and running `vim` remotely.

### [cdbusiest](/sh/cdbusiest#L4)

cd to the directory with the most files in it, counted recursively.

### [colors](/sh/colors#L6)

print out all the foreground and background terminal color combinations.
excluding boilerplate, this script is a mere a 76-characters long!

### [compandy](/sh/compandy#L5)

generate compand arguments for ffmpeg audio filters.
this is kinda pointless now that acompressor is wildly supported.

### [__setup_clang_ubuntu (sh/compile)](/sh/compile#L7)


### [compile](/sh/compile#L29)

compile single-file C and C++ programs, messily.

supports gcc and clang on \*nix, and mingw64 gcc, msvc clang,
and regular msvc on Windows. tested on x86\_64 and on ARMv7 as well.
does not support MacOS, maybe someday…

defaults to gnu11 and gnu++1z as C and C++ standards respectively.
defaults to clang, gcc, and msvc in that order.

`compile` attempts to guess the most sane switches for any program, so that compilation may reduce to:

**TODO:** restore examples.

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

### [days](/sh/days#L6)

compute days since a given date.

```
$ days 'January 1 1970'
18838
```

### [dbusiest](/sh/dbusiest#L6)

display the directory with the most files in it, counted recursively.

### [dfu](/sh/dfu#L6)

pretty-print `df` in GiB.

**TODO:** restore examples.

### [disf](/sh/disf#L9)

disassemble a single function from an unstripped executable, unreliably.

### [e](/sh/e#L6)

wrap around `$EDITOR` to run it as root if necessary.
this still needs some work to detect root-owned directories.

```
$ e /etc/sudoers
[sudo] password for notwa: 
```

### [has](/sh/has#L6)

print the result of `which` if the program is found, else simply return 1.

`export CC="$(has clang || has clang-3.8 || has gcc)"`

### [hex](/sh/hex#L9)

perform arithmetic using the shell and display the result as an unsigned 32-bit integer in hexadecimal.

### [ify](/sh/ify#L6)

pipe one command through another, so you can still pass arguments to the former.

this is mainly useful for aliases. 99% of the time you'll use this with `less`.

```
$ alias ll="ify less ls -ACX --group-directories-first --color=force"
$ ll /etc
```

### [is_empty](/sh/is_empty#L6)

return 0 if the directory given by argument is empty.

### [isup](/sh/isup#L8)

return 0 if a given website returns a 2xx HTTP code.

### [minutemaid](/sh/minutemaid#L6)

return 0 if the current minute is divisible by a number.
note that a minute is relative to the seconds since the epoch, not the minute of the hour.

```
# crontab usage:
* * * * * minutemaid 9 ~/work/do_my_bidding # runs every nine minutes
```

### [monitor](/sh/monitor#L4)

this is `watch` loosely reimplemented as a shell script.

### [noccom](/sh/noccom#L10)

strip C-like comments; both multi-line and single-line.

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

list installed pacman packages by their filesize, and the sum, ascending. requires `expac`.

```
$ pacbm | head -n -1 | tail -2
204.78M clang
235.44M linux-firmware
```

### [pause](/sh/pause#L6)

pause — the companion script of `confirm`.

```
$ pause
Press any key to continue
$ 
```

### [pre](/sh/pre#L6)

dump all the `#define`s that `$CC $CPPFLAGS $CFLAGS $LDFLAGS` would result in.

**TODO:** restore examples.

### [randir](/sh/randir#L6)

display a random directory in the current working directory.

```
$ randir
./sh
```

### [rs](/sh/rs#L4)

record screen. does not record audio.
currently only works on Windows (gdigrab).
i'm sure there's something equivalent for Linux.

### [sc](/sh/sc#L40)

upload given files to a webserver and return a direct link for sharing them.
you'll want to tweak this if you use it yourself.
this contains some extra logic for screenshots created by `scropt`.

### [scramble](/sh/scramble#L6)

scrambles text in a predictable way using regex.

sacbremls ttex in a pdrceailtbe way unsig reegx.

### [screeny](/sh/screeny#L4)

i don't use this anymore~

### [scropt](/sh/scropt#L8)

run `scrot` through `optipng` and save the result to `~/play/$(now).png`.

`$ ~/sh/sc $(~/sh/scropt -s -d0.5)`

### [slit](/sh/slit#L6)

view specific columns of text.

### [slitt](/sh/slitt#L6)

view specific columns of text.
this version of `slit` uses tabs for its field separators.

### [sram](/sh/sram#L4)

convert between a couple saveram formats for N64 emulators.

### [mpv_watch (sh/streamcrap)](/sh/streamcrap#L57)

watch something in mpv with a bunch of extra audio filtering crap.

### [mpv_stream (sh/streamcrap)](/sh/streamcrap#L69)

watch a stream in mpv with a bunch of extra audio filtering crap.

### [twitch (sh/streamcrap)](/sh/streamcrap#L82)

watch a twitch stream in mpv with a bunch of extra audio filtering crap.

### [yt (sh/streamcrap)](/sh/streamcrap#L88)

watch a youtube video in mpv with a bunch of extra audio filtering crap.
this can be given a full URL or just a video ID.
remaining arguments are passed to mpv.

there exist several variants for more specific use cases.

### [ytg (sh/streamcrap)](/sh/streamcrap#L101)

watch a youtube video. like `yt`, but with a preference for different formats.

### [ytll (sh/streamcrap)](/sh/streamcrap#L107)

watch a stream on youtube in mpv, etcetera etcetera.
this is the low latency version that does not support seeking.

### [ytgll (sh/streamcrap)](/sh/streamcrap#L113)

watch a stream on youtube in mpv. like `ytll`, but with a preference for different formats.

### [sv](/sh/sv#L6)

collect the lastmost value of every key.
the field separator can be given as its sole argument.

```
echo "this=that\nthem=those\nthis=cat" | sv =
this=cat
them=those
```

**TODO:** add multi-file grep example.

### [tpad](/sh/tpad#L6)

add a 1px transparent border around an image to prevent twitter from mangling it into a jpg.
sadly, this trick doesn't work anymore.

### [trunc](/sh/trunc#L6)

truncate text to fit within your terminal using the unicode character `…`.

### [unscreen](/sh/unscreen#L6)

i don't use this anymore~

### [wipe](/sh/wipe#L6)

clear the screen and its scrollback, then print a high-contrast horizontal line.
using this, you'll know with absolute certainty that you're looking at the top of your history,
and that your terminal's scrollback didn't cap out and eat text.

**TODO:** rename because wipe(1) already exists.

## miscellaneous

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

### [reload (bashrc)](/home/bashrc#L49)

**TODO:** respect initctl like in `.zshrc`.

### [has (-shrc)](/home/-shrc#L8)

hardcoded here for convenience.

### [ADDPATH (-shrc)](/home/-shrc#L24)

append a directory to `$PATH` if it isn't already present.

### [fils (-shrc)](/home/-shrc#L113)

(GNU du) display human-friendly filesizes for the files in a directory.

### [lsa (-shrc)](/home/-shrc#L114)

(GNU ls) list files with directories and dotfiles ordered first.

### [perlu (-shrc)](/home/-shrc#L115)

invoke perl expecting files with UTF-8 encoding.

### [rgn (-shrc)](/home/-shrc#L116)

invoke ripgrep without respecting `.gitignore` files.

### [cms (-shrc)](/home/-shrc#L117)

invoke cryptominisat5 with less noise.

### [curls (-shrc)](/home/-shrc#L118)

invoke curl with less noise.

### [get (-shrc)](/home/-shrc#L122)

retrieve the most recent files from the default branch of a git repository, and not much else.

### [gs (-shrc)](/home/-shrc#L123)

invoke git's status subcommand.

### [gd (-shrc)](/home/-shrc#L124)

invoke git's diff subcommand with fewer lines of context.

### [gds (-shrc)](/home/-shrc#L125)

display difference stats from git.

### [gl (-shrc)](/home/-shrc#L126)

invoke git's log subcommand with a single line per commit.

### [glo (-shrc)](/home/-shrc#L127)

navigate git's commit tree succinctly.

### [g1 (-shrc)](/home/-shrc#L128)

display the most recent git commit.

### [gr (-shrc)](/home/-shrc#L129)

display remote git repositories verbosely.

### [gb (-shrc)](/home/-shrc#L130)

display the current git branch.

### [revend (-shrc)](/home/-shrc#L136)

reverse the 4-byte endianness of a single file. *this is an in-place operation!*

### [clone (-shrc)](/home/-shrc#L138)

invoke rsync suitably for creating virtually indistinguishable copies of files.

### [aligntabs (-shrc)](/home/-shrc#L139)

align tab-delimited fields in stdin.

### [crawla (-shrc)](/home/-shrc#L140)

play Dungeon Crawl: Stone Soup through ssh on the akrasiac server.

### [crawlz (-shrc)](/home/-shrc#L141)

play Dungeon Crawl: Stone Soup through ssh on the develz server.

### [ll (-shrc)](/home/-shrc#L144)

list files verbosely, fancily, ordered, but not recursively.

### [diff (-shrc)](/home/-shrc#L152)

use git's diff subcommand for general diffing.

### [gc (-shrc)](/home/-shrc#L153)

columnize text by using git's column subcommand.

### [counts (-shrc)](/home/-shrc#L154)

count files in the current directory, including files found recursively.

### [exts (-shrc)](/home/-shrc#L155)

count and sort file extensions in the current directory, including files found recursively.

### [nocom (-shrc)](/home/-shrc#L156)

strip single-line C-like and shell-like comments.

### [sortip (-shrc)](/home/-shrc#L157)

sort numerically by IPv4 segments.

### [jrep (-shrc)](/home/-shrc#L158)

extract strings comprised of basic ASCII or Japanese codepoints.

### [bomb (-shrc)](/home/-shrc#L159)

add a Byte-Order Mark to a file.

### [cleanse (-shrc)](/home/-shrc#L160)

strip unprintable and non-ASCII characters.

### [rot13 (-shrc)](/home/-shrc#L161)

rot13 with numbers rotated as well.

### [unwrap (-shrc)](/home/-shrc#L162)

join paragraphs into one line each.

### [double (-shrc)](/home/-shrc#L163)

print every line twice. <br/> print every line twice.

### [join2 (-shrc)](/home/-shrc#L164)

join every other line.

### [katagana (-shrc)](/home/-shrc#L165)

convert katakana codepoints to their equivalent hiragana.
useful for translating [debug text from ancient games.](https://tcrf.net/)

### [picky (-shrc)](/home/-shrc#L167)

TODO

### [unused (-shrc)](/home/-shrc#L168)

TODO

### [makepkgf (-shrc)](/home/-shrc#L169)

make the freakin' package!

### [rakef (-shrc)](/home/-shrc#L170)

make the freakin' gem!

### [eashare (-shrc)](/home/-shrc#L172)

upload a file and copy its URL to the clipboard.

**NOTE:** this only works on MSYS2 for now.

**NOTE:** i lied, this doesn't work at all.
