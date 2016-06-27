## obligatory personal dotfiles repository

_(plus some little shell scripts)_

there's probably a lot of subtle things gone uncredited,
but oh well.

## commands defined RC files

such as [.bashrc](/home/bashrc) [.zshrc](/home/zshrc) and [-shrc](/home/-shrc)

### TODO

## shell scripts

most (but not all) stuff that's written for bash will work in zsh too.
if it just says `(sh)` then it'll probably work on anything,
but probably depends on GNU awk.

### [arith](/sh/arith)

(zsh) does arithmetic using shell expansion.

```
$ arith 10**(6/20.)
1.9952623149688795
```

### [aur](/sh/aur)

(bash) downloads, edits, makes, and installs packages from the [AUR.](//aur.archlinux.org)

a little broken.

```
$ aur -eyoI cmdpack-uips applyppf
```

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

### [confirm](/sh/confirm)

(bash/zsh) displays a simple yes/no prompt and returns 0 or 1 respectively.

### [days](/sh/days)

(bash) compute days since a date.

```
$ days 'January 1 1970'
16979
```

### [dfu](/sh/dfu)

(sh) pretty df output in GiB.

```
$ dfu
Filesystem              Used     Max    Misc
/                       6.90   13.75    0.75
/dev                    0.00    0.45    0.00
/boot                   0.02    0.10    0.00
/media/2tb           1528.48 1740.49   93.17
```

### [e](/sh/e)

(zsh) wraps around $EDITOR to run as root if necessary. needs some work.

```
$ e /etc/sudoers
[sudo] password for notwa: 
```

### [gitall](/sh/gitall)

(zsh) asks you to update most of the git repos it finds. i don't really use this.

### [hex](/sh/hex)

(zsh) same as `arith` but outputs as `%08X`.

```
$ hex 0x221EA8-0x212020
0000FE88
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

### [logs](/sh/logs)

(bash/zsh) just wraps around journalctl. i don't remember how it works exactly.

### [lol-twitter](/sh/lol-twitter)

(zsh) checks if usernames (from stdin) are available on twitter.

seems to return a 403 code these days, but you could probably fix that.

### [lsarchive](/sh/lsarchive) + [unarchive](/sh/unarchive)

(zsh) guess what these do. written by Sorin Ionescu.
includes autocomplete files.

### [lsz](/sh/lsz)

(zsh) a needlessly fancy alternative to `ls`.
based on lsf or something, which might be [a gist somewhere.](//gist.github.com/notwa)
you can find similar, more mature projects on github.

### [minutemaid](/sh/minutemaid)

(zsh) returns 0 if the current minute is divisible by a number.
note that a minute is relative to the seconds since the epoch,
not the minute of the hour.

```
# crontab usage:
* * * * * minutemaid 9 cd repo && git pull # runs every nine minutes
```

### [mkgist](/sh/mkgist)

(bash) makes a (mostly) empty gist and pulls it so you never have to visit the site.
i think this is broken.

### [monitor](/sh/monitor)

(zsh) literally just `watch` as a shell script. kinda nice though.

### [mw](/sh/mw) + [mw-cyg](/sh/mw-cyg)

(zsh) manages a ton of environment variables for cross-compiling programs.
you'll want to tweak this if you use it yourself.

### [now](/sh/now)

(bash) returns the local date-time in a sortable format.
will take a date or a file as an argument too.

```
$ now
2016-06-27_19551873
$ now ./now
2016-03-12_25288645
$ now '@1234567890'
2009-02-13_55890000
```

### [pacbm](/sh/pacbm)

(zsh) lists installed pacman packages by their filesize, and the sum, ascending.
requires `expac`.

```
$ pacbm | head -n -1 | tail -2
  155.67M clang
  192.34M chromium
```

### [pacman-list-disowned](/sh/pacman-list-disowned)

(zsh?) lists disowned pacman files. this might take a while.
written by Benjamin Boudreau and Sorin Ionescu.

### [pause](/sh/pause)

(bash/zsh) pause; the companion script of confirm.

```
$ pause
Press any key to continue
$ 
```

### [pre](/sh/pre)

(bash/zsh) dumps all the #defines that your current C compiler, $CFLAGS and $LDFLAGS will result in.

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
$ psbm | head -n -1 | tail -2                                                  5336
  155.91M     795 chromium
  171.04M     832 chromium
```

### [randir](/sh/randir)

(sh) outputs a random directory in the working directory.
seems to return `./` sometimes, whoops.

```
$ randir
./sh
```

### [sc](/sh/sc)

(bash) uploads given files to dropbox and returns a direct link for sharing.
you'll want to tweak this if you use it yourself.

has some extra logic for screenshots created by `scropt`.

### [scramble](/sh/sc)

(bash) scrambles text in a predictable way using regex.

(bhas) sacbremls ttex in a pdrceailtbe way unsig reegx.

### [screeny](/sh/screeny) + [unscreen](/sh/unscreen)

(zsh) sets up and detaches a screen for running daemons as other users, etc.

will close any existing screens of the same name using its companion script, unscreen.

e.g. run znc as user znc in a screen called znc: `screeny znc znc znc -f`. znc!

### [scropt](/sh/scropt)

(bash) run scrot through optipng and save to `~/play/$(now).png`.

```
$ ~/sh/sc $(~/sh/scropt -s -d0.5)
```

### [similar](/sh/similar)

(sh) sort stdin and color similarities between adjacent lines. kinda broken.

### [slit](/sh/slit)

(zsh) view specific columns of text.
via [pretzo.](https://github.com/sorin-ionescu/prezto/)

```
$ df | slit 1 5                                                                5353
Filesystem Use%
dev 0%
run 1%
/dev/sda6 30%
tmpfs 3%
tmpfs 0%
tmpfs 1%
tmpfs 1%
```

### [sram](/sh/sram)

(zsh) converts between a couple saveram formats for N64 emulators.

### [sv](/sh/sv)

(zsh) i have no idea?

### [trunc](/sh/trunc)

(bash) truncates text to fit within your terminal using the unicode character `…`.

```
$ echo $COLUMNS
64
$ unwrap /usr/share/licenses/common/GPL3/license.txt | trunc | head
                    GNU GENERAL PUBLIC LICENSE                 …

 Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.…

                            Preamble 

  The GNU General Public License is a free, copyleft license fo…

  The licenses for most software and other practical works are …
```

## submodules

probably horribly outdated

### [meow.sh](//github.com/notwa/meow.sh/)

scrapes and downloads nyaa torrents.

### [z](//github.com/rupa/z)

cd to the most "frecently" used directory matching a regex.
