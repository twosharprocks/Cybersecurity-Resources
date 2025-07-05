---
Date: 2024-10-05
Course: "[[OSCP]]"
Platform: PG-Practice
Category: Linux
Difficulty: Easy
Status: Complete
IP: 192.168.228.24
Writeup: https://medium.com/@sandrofrallicciardi/my-road-to-oscp-proving-grounds-practice-warm-up-levram-7324d5590c6b
---
# Levram


# Resolution summary
- Nmap to identify services on port 22 and 8000
- Password guessed admin credentials to Gerapy platform
- Used exploit for CVE-2021-243857 to achieve shell
- Upgraded shell by running bash script on target
- Identified vulnerable python setuid configuration
- Used GTFObins to find python command providing privilege escalation to root
## Improved skills
- Linux Privilege Escalation
- Establishing Full TTYs
## Used tools
- nmap
- python
- linpeas.sh
- gerapy
- GTFObins

---

# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN levram.nmap 192.168.228.24 -v
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE  REASON         VERSION
22/tcp   open  ssh      syn-ack ttl 61 OpenSSH 8.9p1 Ubuntu 3 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 b9:bc:8f:01:3f:85:5d:f9:5c:d9:fb:b6:15:a0:1e:74 (ECDSA)
| ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBBYESg2KmNLhFh1KJaN2UFCVAEv6MWr58pqp2fIpCSBEK2wDJ5ap2XVBVGLk9Po4eKBbqTo96yttfVUvXWXoN3M=
|   256 53:d9:7f:3d:22:8a:fd:57:98:fe:6b:1a:4c:ac:79:67 (ED25519)
|_ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBdIs4PWZ8yY2OQ6Jlk84Ihd5+15Nb3l0qvpf1ls3wfa
8000/tcp open  http-alt syn-ack ttl 61 WSGIServer/0.2 CPython/3.10.6
|_http-server-header: WSGIServer/0.2 CPython/3.10.6
| http-methods: 
|_  Supported Methods: GET OPTIONS
|_http-cors: GET POST PUT DELETE OPTIONS PATCH
| fingerprint-strings: 
|   FourOhFourRequest: 
|     HTTP/1.1 404 Not Found
|     Date: Sat, 05 Oct 2024 01:35:09 GMT
|     Server: WSGIServer/0.2 CPython/3.10.6
|     Content-Type: text/html
|     Content-Length: 9979
|     Vary: Origin
|     <!DOCTYPE html>
|     <html lang="en">
|     <head>
|     <meta http-equiv="content-type" content="text/html; charset=utf-8">
|     <title>Page not found at /nice ports,/Trinity.txt.bak</title>
|     <meta name="robots" content="NONE,NOARCHIVE">
|     <style type="text/css">
|     html * { padding:0; margin:0; }
|     body * { padding:10px 20px; }
|     body * * { padding:0; }
|     body { font:small sans-serif; background:#eee; color:#000; }
|     body>div { border-bottom:1px solid #ddd; }
|     font-weight:normal; margin-bottom:.4em; }
|     span { font-size:60%; color:#666; font-weight:normal; }
|     table { border:none; border-collapse: collapse; width:100%; }
|     vertical-align:top; padding:2px 3px; }
|     width:12em; text-align:right; color:#6
|   GetRequest: 
|     HTTP/1.1 200 OK
|     Date: Sat, 05 Oct 2024 01:35:04 GMT
|     Server: WSGIServer/0.2 CPython/3.10.6
|     Content-Type: text/html; charset=utf-8
|     Vary: Accept, Origin
|     Allow: GET, OPTIONS
|     Content-Length: 2530
|_    <!DOCTYPE html><html lang=en><head><meta charset=utf-8><meta http-equiv=X-UA-Compatible content="IE=edge"><meta name=viewport content="width=device-width,initial-scale=1"><link rel=icon href=/favicon.ico><title>Gerapy</title><link href=/static/css/chunk-10b2edc2.79f68610.css rel=prefetch><link href=/static/css/chunk-12e7e66d.8f856d8c.css rel=prefetch><link href=/static/css/chunk-39423506.2eb0fec8.css rel=prefetch><link href=/static/css/chunk-3a6102b3.0fe5e5eb.css rel=prefetch><link href=/static/css/chunk-4a7237a2.19df386b.css rel=prefetch><link href=/static/css/chunk-531d1845.b0b0d9e4.css rel=prefetch><link href=/static/css/chunk-582dc9b0.d60b5161.css rel=prefetch><link href=/static/css/chun
|_http-title: Gerapy
1 service unrecognized despite returning data.
```

---
# Enumeration
## Port 22 - SSH 
No enumeration conducted
## Port 8000 - HTTP (Apache)
- Navigated to `192.168.228.24:8000` with Firefox
- Found login page, password guessed credentials `admin:admin`
![[Cybersecurity-Resources/images/Pasted image 20241005111026.png]]
- Successfully logged in with `admin:admin` and identified Gerapy is version 0.9.7
![[Cybersecurity-Resources/images/Pasted image 20241005112043.png]]
---
# Exploitation
## # CVE-2021-243857 (Authenticated RCE)
- Attempted to run exploit `50640.py` against taregt with `admin:admin` credentials - exploit unsuccessful.
![[Cybersecurity-Resources/images/Pasted image 20241005111905.png]]
- Identified [exploit requires atleast one "project" on platform](https://github.com/LongWayHomie/CVE-2021-43857) to work, so created & deployed `test project`;
![[Cybersecurity-Resources/images/Pasted image 20241005112332.png]]
- Re-ran exploit `50640.py` successfully
![[Cybersecurity-Resources/images/Pasted image 20241005113245.png]]
- Created bash reverse shell script on target to establish Full TTY
![[Cybersecurity-Resources/images/Pasted image 20241005114213.png]]
- Caught shell with netcat listener of port `4545`
![[Cybersecurity-Resources/images/Pasted image 20241005114255.png]]
---
# Lateral Movement to user
## Local Enumeration
- Searched for users, sudo privileges & cronjobs
![[Cybersecurity-Resources/images/Pasted image 20241005114632.png]]
- Checked `app` user's home directory, found `local.txt` flag
![[Cybersecurity-Resources/images/Pasted image 20241005120125.png]]
- Downloaded `linpeas.sh` to target and executed
![[Cybersecurity-Resources/images/Pasted image 20241005120531.png]]
- Identified Sudo version 1.9.9
- Identified potentially vulnerable:
	- CVE-2022-0847 (DirtyPipe)
	- CVE-2017-5618 (Setuid screen)
	- Python3.10 cap_setuid=ep
	  ![[Cybersecurity-Resources/images/Pasted image 20241005122400.png]]
---
# Privilege Escalation
## Privilege Escalation vector
- Searched for file capabilities: `getcap -r / 2>/dev/null` & found `python3.10`
![[Cybersecurity-Resources/images/Pasted image 20241005122541.png]]
- Searched [GTFObins for python capabilities](https://gtfobins.github.io/gtfobins/python/) & found privesc through cap_setuid
- Ran python command; `/usr/bin/python3.10 -c 'import os; os.setuid(0); os.system("/bin/sh")'` for root access
![[Cybersecurity-Resources/images/Pasted image 20241005122906.png]]
- Navigated to `/root` directory, found and printed `proof.txt`
![[Cybersecurity-Resources/images/Pasted image 20241005123001.png]]
---
# Trophy & Loot
`local.txt` = `7359701ae43bc362a09bcf9b8c14e17e`
`proof.txt` = `86b558836159caffebe9679b4d429194`