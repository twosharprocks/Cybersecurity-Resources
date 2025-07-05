Tags: [[Cyber]]

---
# Bash
[explainshell.com](https://explainshell.com/) - Lists out meaning of a line of script
[Linux Command Resources](https://linuxcommand.org/lc3_resources.php) \[HUGE Resource with links to more\]
[Linux man-pages project](https://www.kernel.org/doc/man-pages/)
[Linux MAN Pages](https://man7.org/linux/man-pages/index.html)
[Full “Intro to BASH” Reference](https://programminghistorian.org/en/lessons/intro-to-bash)
[BASH Beginners Guide \[HUGE reference\]](https://tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html)
[BASH Cheat Sheet \[Top 25\]](https://www.educative.io/blog/bash-shell-command-cheat-sheet)
## Core
`↑ ↓` - Scrolls through previous commands, `→` Completes partial path with available file/dir
`CtrlC` - Cancels/stops your current line/command (displays as _^C_)
`clear` Clear console, `reset` Reset console, `exit` Close console
`start` Start argument (eg. `start folder_name` will open folder_name)
`man` Manual & options for whatever command follows it
`whatis` Provides a shorter version of `man`
`--help` Help for whatever command you put in front (eg. `ls --help` shows help for “ls”)
`ls` List directory contents 
* `-la` Show size & permissions (& hidden files), `-s` file sizes, `-S` show the largest file first
* `ln` link a file
* `pwd` Print Working Directory
* `cd` Change Directory (eg. cd /tmp/var)
* `mkdir` Make Directory 
   `mkdir -p parent/{F1,F2,F3}/{temp1,temp2}` creates folder “Parent” with sub-directories F1, F2 & F3 each, with temp1 & temp2 directores inside each sub-directory.
`rm` or `rmdir` Remove Directory, mv or mvdir (eg. mvdir folder /new/dir)
* Options: `-r` or `-R` "Recursive", applies command throughout 
* eg. `rm -r foldername` removes folder & it's contents
`..` Parent Directory (One level above), `//` Root directory
`touch` Create new file (eg. `touch dir/sample.txt`)
`cp` Copy (eg. `cp test.txt dir/test2.txt` copies test.txt to directory dir and renames it test2.txt)
`rm` to remove file
`shred` to permanently delete file
`*` Wildcard
 * eg. `rm test/*-geoff` removes all files in directory test that end in “-geoff”
 * eg. `rm *` will remove all files in the current directory

`&&` Execute another command in the same line ONLY if the previous command worked

`|` Pipe, Redirects command into another (from left to right)

`||` Double Pipe, operates as command 1 OR command 2

`;` Semicolon, starts an entirely new command regardless of what was before
## Writing/Finding Data
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
* [Options](https://man7.org/linux/man-pages/man1/find.1.html): `iname` ignores case, `-type` file (`f`) or directory (`d`),
* eg. `find -type f -iname *.txt’` finds all .txt files
* eg. `find -type d -iname rogers/*` finds directories starting with “rogers” ignoring case
* eg. `find /directory/folder -type f -iname /log.txt` searches different directory
`whereis` all locations of a file
`grep` Searches inside files for a string \[[Using Grep](https://www.linode.com/docs/guides/how-to-grep-for-text-in-files/)\]
* [Options:](https://man7.org/linux/man-pages/man1/grep.1.html) `-c` count, `-r` recursive, `-i` case insensitive, `-l` list filename
* eg. `grep bob log1.txt` finds ‘bob’ in log1.txt
* eg. `grep -i bob log1.txt` find ‘bob’ regardless of casing
* eg. `grep -il bob \*.txt` finds ‘bob’ in all text files, but only returns filenames
`xxd` Provides a [Hex dump](https://linuxhint.com/xxd-hex-dumper-guide/) for a file
## Networking
`wget` Download a file from a URL
* Options: `‐‐output-document=filename.html example.com` (Rename file being downloaded), 
* Download to specific folder: `‐‐directory-prefix=folder/subfolder example.com`
* Resume interrupted download: `‐‐continue example.com/big.file.iso` 
* Download IF server has a newer version:`‐‐continue ‐‐timestamping wordpress.org/latest.zip` 
* Download from multiple URLs listed in txt file: `‐‐input list-of-file-urls.txt`
* Download sequentially numbered files: `http://example/{1..20}.jpg`
* Download an entire webpage `wget ‐‐page-requisites ‐‐span-hosts ‐‐convert-links ‐‐adjust-extension http://example.com/dir/file`
`curl` Call a URL
* [Options:](https://gist.github.com/eneko/dc2d8edd9a4b25c5b0725dd123f98b10)  `--abstract-unix-socket <path>` Connect via abstract Unix domain socket
* `-a, --append`  Append to target file when uploading
* `-E, --cert &lt;certificate[:password]>` Client certificate file and password
* `-K, --config <file>` Read config from a file
* `-b, --cookie <data|filename>` Send cookies from string/file
* `-c, --cookie-jar <filename>` Write cookies to filename after operation 
* `-d, --data <data>` HTTP POST data
* `-G, --get` Put the post data in the URL and use GET
* `-x, --proxy [protocol://]host[:port]` Use this proxy
* `-U, --proxy-user <user:password>` Proxy user and password
* `--pubkey <key>` SSH Public key file name
* `-u, --user <user:password>` Server user and password 
`ping` Sends Ping
* Options: `ping -c 5` Sends 5 pings
`netstat` Shows open ports
`uname` OS & system hardware info
* Options: `a (--all)` All system info, 
* `-n (-- nodename)` System network name 
* `-r (--kernal-release)` Kernel release 
* `-v (--kernal-version)` Kernel version
* `-s (--kernal-name)` Kernel name 
* `-m (--machine)` Hardware name 
* `-p (--processor)` Processor architecture 
* `-i (--hardware-platform)` Hardware platform
* `-o (--operating-system)` Operating system
`nslookup` Lookup DNS Records
* Options: `-type=(any, soa, ns, a, mx, txt)` Displays DNS record type
## Archive & Compress
Tar: `tar [option(s)] [archive_name.tar] [objects_to_archive]`
* Full tar options list [tar {A|c|d|r|t|u|x}[GnSkUWOmpsMBiajJzZhPlRvwo]](https://linuxcommand.org/lc3_man_pages/tar1.html)
* Options
	* `c` create archive (also `--create`)
	    * `-z` Creates compressed gzip archive (title ends in “.tar.gz” or “.tgz”)
	    * `-j` Creates compressed bzip archive (title ends in “.tar.bz2” or “.tbz”
	    * `--exclude` Excludes files and folders in archived directory
	* `f` file, **must be last option** & followed by archive title. (also `--file`)
	* `x` extract archive (also `--extract`, `--get`) [must use `-z` or `-j` if archive is compressed]
	    * `-C` Extracts archive to different directory (directory path must follow)
	    * `-k` keeps existing files when extracting. (also --keep-old-files)
	    * `--wildcards` "*.jpg": Extracts files ending in .jpg (works for any)
	    * `--keep-newer-files` Don’t replace existing files newer than archive
	    * `--keep-directory-symlink` Don’t replace symlinks
	    * `--no-overwrite-dir` Preserve metadata
	    * `--overwrite` Overwrite existing files
	    * `--overwrite-dir` Overwrite metadata
	    * `--recursive-unlink` Remove all files in directory before extraction
	    * `--remove-files` Remove files from disk after adding to archive
	    * `--skip-old-files` Don’t replace existing files when extracting, skip over
	    * `-U` Remove each file prior to extracting over (also `--unlink-first`)
	    * `-W` Verify archive (also `--verify`)
	* `-v` verbose, displays archive results
	* `-vv` very verbose, displays detailed results including file paths & permissions
	* `-r` append (also `--append`)
	    * `tar rf archive.tar archive/ folder/ file.txt` adds folder & file.txt to archive.tar
	* `-u` update, just archiving files  (also --update)
	* `-t` list archive contents (also `--list`)
	    * `tar tvf archive.tar` List contents of “archive.tar” with verbose output
	* `-d` difference, comparing archive & file system. (also `-diff`, `--compare`)
	* `--delete` delete from archive, does not operate on compressed archives.
	* `-A` Apprend archive to another, must be same format. (also `catenate`, `--concatenate`)
	* `--test-label` Test archive volume label, codes as `0` if match found, codes `1` if not.

Zip/Unzip
- Leaves behind original and creates new zip files
- zip command format is: `zip [option(s)] [archive_name.zip] [objects_to_archive]`
* `tar -jxvf archive.tar.bz2` extracts the .bz2 “archive.tar” with verbose output
* Options:
	* `-[0-9]`: Level of compression, `-0` is none & `-9` is maximum
	* `-e` Adds password protection (use this and **<span style="text-decoration:underline;">not</span>** `-P`)
- unzip command format is: `unzip [option(s)] [archive_name.zip]`
	* `-v` verbose
	* `-l` list files
	* `-t` test files to be unzipped
gzip/gunzip
- `gzip` creates new gzip file and removes original (default)
- Format: `gzip [option(s)] [archive_name.zip]`
* Options
	* `-c`: Leaves original file [output needs to be redirected] (also `--stdout`, `--to-stdout`)
	    * `>` to output to filename.type.gz
	* `-r` Recursive compression down sub-directories
	* -`[0-9]` Level of compression, `-0` is none & `-9` is maximum
- gunzip short options (also “gzip -d” to “decompress”)
	- `-t` test files to be gunzipped (silent if no issue)
    * `tar -tzf my_tar.tar.gz >/dev/null` tests & throws away output *without* unzipping
bzip2/bunzip2
- Very similar to gzip (greater compression), uses most of the same commands but with b_2
## Scripting

[Bash Scripting Cheatsheet](https://devhints.io/bash)
[Full BASH Scripting Reference](https://tldp.org/LDP/abs/html/index.html)
* [BASH Options list](https://tldp.org/LDP/abs/html/options.html)
[Bash Shell Scripting [Full Book]](https://en.m.wikibooks.org/wiki/Bash_Shell_Scripting)
[Common Newbie Bash Mistakes](https://wiki.bash-hackers.org/scripting/newbie_traps)
* `./script.sh` will run script.sh
    * `chmod +x script.sh` will compile the changes made after editing script.sh
* `nano` Command line text editor (vim is also available)
    * `nano index.html` will open the index.html file for editing 
    * If the file does not already exist, nano/vim will create it
    * `CtrlS` saves the file, and CrtlX exits the editor
----------

# User, Group & System Management

[Linux Handbook [Huge Free Resource]](https://linuxhandbook.com/)
[Important Linux Directories and their structure](https://www.tecmint.com/linux-directory-structure-and-important-files-paths-explained/) {#important-linux-directories-and-their-structure}
## Important folders in /etc

* `/etc/passwd` - used to keep track of every registered user that has access to a system
    * [List all usernames](https://linuxize.com/post/how-to-list-users-in-linux/) - `less /etc/passwd` or `awk -F: '{ print $1}' /etc/passwd`
* `/etc/group` - used to keep track of every registered group that has access to a system
    * `/etc/groups` - **does not exist**
* `/etc/shadow` - system file storing encrypted user passwords (accessible only to root)

**<span style="text-decoration:underline;">sudo</span>**
* `sudo su` Switch to root user
* `sudo -l List` sudo permissions of current user
* `sudo -lU :user` List sudo permissions of &lt;user>
* `sudo visudo` Allows safe editing of the 'sudoers' file

**<span style="text-decoration:underline;">User & Group management</span>** 

[chmod, chgrp, groupadd, usermod -g](https://www.howtogeek.com/50787/add-a-user-to-a-group-or-second-group-on-linux/), 

[Chgrp](https://linuxize.com/post/chgrp-command-in-linux/) and [Sharing Linux Directories](https://www.tutorialspoint.com/how-to-create-a-shared-directory-for-all-users-in-linux#)



* `groups <user>` List groups user is in 
    * `id <user>` Same as above but with GIDs
* `sudo adduser <user>` Add user to system
* `sudo deluser <user>` Delete user from system
* `sudo addgroup <group>` Add group to system
* `sudo delgroup <group>` Delete group from system
* `sudo usermod -aG <user><group>` - adds user to group
* `sudo usermod -G <user><group>` - add user to group <span style="text-decoration:underline;">exclusively</span> (no other groups)
* `sudo usermod -L <user>` Lock user from accessing system

**<span style="text-decoration:underline;">chown</span>** 

Command Format is: `sudo chown &lt;owner>:&lt;group> &lt;item>`


* `sudo chown root test.txt` change owner of test.txt to user root
* `sudo chown :root test` change owner of test to group root
* `sudo chown -R mike:sally test` change owner test to user mike and group sally

**<span style="text-decoration:underline;">chmod</span>**

Command Format is: `sudo chmod <command> file`

* `sudo chmod 755 foo.txt` adds read, write, execute to foo.txt for owner; read and execute for groups and others
* `sudo chmod +x foo.txt` adds execute access to foo.txt for all users 
* `sudo chmod -x foo.txt` removes execute access to foo.txt for all users
* `sudo chmod u-w foo.txt` removes write access to foo.txt for all users 
* `sudo chmod g=rx,o= foo.txt` give group read & execute access to foo.txt; no access for others
* `sudo chmod u=rw,g=rw,o=w foo.txt` read/write for owner & group, write only for others
* `sudo chmod u=rwx,g-r,u+r foo.txt` read/write/execute for user to foo.txt, remove read for group, add read for others

**<span style="text-decoration:underline;">System Management</span>**

* `apt-get` Package Management
    * `apt-get update` Update package information, list possible upgrades
    * `apt-get upgrade` Upgrades package where available
    * `apt-get install <package>` Installs package
    * Options `-y` Execute without further prompts
* `top` System information ([Using the Linux top command](https://www.howtogeek.com/668986/how-to-use-the-linux-top-command-and-understand-its-output/))
    * `htop` Prettier system info
    * `uname -a` List system info (Option `-r` for just kernel number)
* `ps` for processes
    * [ps Man ](https://man7.org/linux/man-pages/man1/ps.1.html) [[Linux ps Command Tutorial](https://www.baeldung.com/linux/ps-command)]
    * `ps aux` Provides auxiliary info on system processes [[Using ps aux](https://www.linode.com/docs/guides/use-the-ps-aux-command-in-linux/)]
    * `ps -ef` Prints all system processes (-e) with additional info (-f)
    * `kill` Kills process by PID [[Killing processes](https://linuxhint.com/kill-all-user-processes-linux/)]
        * pkill Kills process by name
* `systemctl` System manager [(How to use) ](https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units)
    * `sudo systemctl start servicename` to start the service
    * Options: `stop`, `restart`, `reload`, `enable`, `disable`, `status, is-active`, `is-enabled`, `is-failed`, `list-units` (`--all`, `--state=inactive`, `type=service`), `list-all-files`, `cat`, `list-dependencies`, `show`, `-p` (Conflicts), `mask`, `unmask`, `edit`
* `free` (system memory)
    * Options: `-h` (human readable) `-s` (runs for defined length) `-c n` (runs the command n# of times)
* `RANDOM` (generates random number between 0 & 32767)
* `export` Allows a system-defined variable to be called by a script
* `history` Shows all commands used
    * `history | grep “string” ` to find uses of a specific command

* `crontab -e` for displaying and modifying cron jobs
    * [Crontab Generator](https://crontab-generator.org/)
    * [Crontab guru](https://crontab.guru/)
* `journalctl` Log manager ([How to manage Log Files with Logrotate](https://www.digitalocean.com/community/tutorials/how-to-manage-log-files-with-logrotate-on-ubuntu-12-10))
    * `logrotate` Rotation of logs for archiving, compress, ect ([logrotate MAN](https://man7.org/linux/man-pages/man8/logrotate.8.html))
    * `sudo nano /etc/logrotate.conf`  To edit log config
* `timedatectl` Time/date manager
    * Options: `status`, `list-timezones` (List available timezones), `set-timezone` (Change timezone to string eg. Australia/Adelaide)
* `auditctl` Manage the audit system 
    * `sudo auditctl -w /etc/shadow` will add a rule to monitor the shadow directory
    * `sudo aureport -m` List an audit of account modifications

[SELinux on GitHub](https://github.com/SELinuxProject)

* [Wikipedia Entry](https://en.wikipedia.org/wiki/Security-Enhanced_Linux)
* NSA Developed, has no “root” or superuser
* Built into Android, Fedora/RedHat, CentOS.
