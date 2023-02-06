Linux - Bash Commands
=====

[Linux Command Resources](https://linuxcommand.org/lc3_resources.php) \[HUGE Resource with links to more\]

[Linux man-pages project](https://www.kernel.org/doc/man-pages/)

[Linux MAN Pages](https://man7.org/linux/man-pages/index.html)


[Full “Intro to BASH” Reference](https://programminghistorian.org/en/lessons/intro-to-bash)

[BASH Beginners Guide \[HUGE reference\]](https://tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html)

[BASH Cheat Sheet \[Top 25\]](https://www.educative.io/blog/bash-shell-command-cheat-sheet)

#Basic Bash
----------

`↑ ↓` - Scrolls through previous commands, → Completes partial path with available file/dir

`CtrlC` - Cancels/stops your current line/command (displays as _^C_)

`clear` Clear console, reset Reset console, exit Close console

`start` Start argument (eg. _start foldername_ will open foldername)

`man` Manual & options for whatever command follows it

`--help` Help for whatever command you put in front (eg. _ls --help_ shows help for “ls”)

`whatis` shorter version of “man”

`which`

`whereis` all locations of a thing

# **Directories**

`ls` List directory contents 
* `-la` Show size & permissions (& hidden files), `-s` file sizes, `-S` largest first ln link a file

`pwd` Print Working Directory

`cd` Change Directory (eg. cd /tmp/var),

`mkdir` Make Directory 
*   `mkdir -p parent/{F1,F2,F3}/{temp1,temp2}` creates folder “Parent” with sub-directories F1, F2 & F3 each, with temp1 & temp2 directores inside each sub-directory.

`rm` or `rmdir` Remove Directory, mv or mvdir (eg. mvdir folder /new/dir)
* `-r` or `-R` "Recursive", applies command throughout (eg. `rm -r foldername` removes folder & it's contents)

`..` Parent Directory (One level above), // Root directory

# **Files**

`touch` Create new file (eg. `touch dir/sample.txt)`

`cp` Copy (eg. `cp test.txt dir/test2.txt` copies test.txt to directory dir and renames it test2.txt)

`rm` to remove file

`shred` to permanently delete file

`>` Create/write to file (eg. `echo “Hello world” > Hi.txt` creates Hi.txt with “Hello world” inside)

`>>` Append to file (Creates file if it doesn’t exist, adds to existing file if it does)

`cat` Concatenate (combine & display)
* Options: `-s` suppress repeated empty output lines, `-n` display line numbers, `-e` $ at end of line, `-b` # of non-empty lines
* eg. `cat 1.txt 2.txt` combines files & displays on console
* eg. `cat 1.txt 2.txt **\>** 1\_2.txt` combines & writes data to 1\_2.txt (overwrites if 1\_2.txt already exists)
* eg. `cat 1.txt 2.txt **\>>** 1\_2.txt` combines & writes data to 1\_2.txt (appends if 1\_2.txt already exists)

`more` Display file one page at a time, spacebar for next page.

`less` Greater flexibility. Scroll horizontally/forward/backward one line at a time

`q` to exit file line display

`head` Display top 10 lines (eg. `head -n 4 logfile1.txt` displays first 4 lines with line #’s)

`tail` Display bottom 10 lines (eg. `tail -26 test.rtf` shows last 26 lines of test.rtf)

`cmp` Compare files

`diff` Show differences between files

`sed` Edits a stream sed s/(old value)/(replacement value)/ \[CAUTION: `sed` overwrites\]

* eg. “The Dog chased a Ball”, `sed s/Ball/Cat/` changes it to “The Dog chased a Cat”

`awk` Data processing and extracting/reporting from streams \[[Using awk](https://opensource.com/article/20/9/awk-ebook)\]

* eg. `awk -F, '{print $(field#)}'` then awk isolates column (field#) with ‘,’ separating data

* eg. `awk -F ‘{print $4, $7}’` reads a new column for each space, prints columns 4 & 7

`find` Searches for file/directory names \[[Using find function](https://www.diskinternals.com/linux-reader/bash-find-command/)]
* [Options](https://man7.org/linux/man-pages/man1/find.1.html): iname ignore case, -type file (f) or directory (d),

eg. `find -type f -iname \`\*.txt’` finds all .txt files

eg. `find -type d -iname rogers\*` finds directories starting with “rogers” ignoring case

eg. `find /directory/folder -type f -iname \`log.txt\`` searches different directory

`grep` Sarching inside files for data \[[Using Grep](https://www.linode.com/docs/guides/how-to-grep-for-text-in-files/)\]

* [Options:](https://man7.org/linux/man-pages/man1/grep.1.html) -c count, -r recursive, -i case insensitive, -l list filename

eg. `grep bob log1.txt` finds ‘bob’ in log1.txt

eg. `grep -i bob log1.txt` find ‘bob’ regardless of casing

eg. `grep -il bob \*.txt` finds ‘bob’ in all text files, but only returns filenames

`xxd` [Hex dump](https://linuxhint.com/xxd-hex-dumper-guide/) a file

`xxd` \[options\] \[file\]

# **Networking**

`wget` Get

`curl` Call a URL

`ifconfig` (Needs install?)

`ip address` (IP info)

`resolvectl` status Provides DNS server

`ping` Sends Ping

* eg. `ping -c 5` Sends 5 pings

`netstat` Shows open ports

`ss` Shows socket statistics

`-tulpn` Shows tcp & udp sockets that are listening, processes using the sockets, without resolving service names

`iptables`

`ufw`

* eg. `ufw allow 80` Allows port 80

`uname`

* Options: -a

`nslookup`

`host`

`dig`

`neofetch` (Needs install)

`cal` Calender

# **Special**

`*` Wildcard

* eg. `rm test/*-geoff` removes all files in directory test that end in “-geoff”

* eg. `rm *` will remove all files in the current directory

`&&` Execute another command in the same line ONLY if the previous command worked

`|` Pipe, Redirects command into another (from left to right)

`||` Double Pipe, operates as command 1 OR command 2

`;` Semicolon, starts an entirely new command regardless of what was before
