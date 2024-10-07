---
Date: 2024-10-06
Platform: PG-Practice
Category: Linux
Difficulty: Intermediate
Status: Complete
IP: 192.168.228.98
Writeup: https://medium.com/@vivek-kumar/offensive-security-proving-grounds-walk-through-pelican-614538719710
---
# Pelican
Pretty happy with this one considering I figured most of it out without really looking at a walkthrough. Identifying Exhibition vs Zookeeper was a little confusing, but as soon as I identified that Exhibition v1.0 was vulenerable to command injection then finding & using an exploit (which was really just adding a reverse shell to a java script field) became fairly straightforward. 

Privilege escalation with `gcore` was a little tricky, as it's been awhile since I needed to remember how `strings` worked. But once it became clear I could search for plaintext passwords then it made sense and switching to root was easy.

# Resolution summary
- Used Nmap to id a series of open port, notably 8080 & 8081 (HTTP)
- Identified vulnerable service (Exhibition v1.0)
- Added reverse shell to javascript field in admin console and gained initial access
- Searched for sudo privileges, identified `charles` user could run `gcore`
- Ran `gcore` as sudo against `password-store` binary and saved output
- Searched output file for strings, identified credentials for root
- Switched user to root
## Improved skills
- Linux enumeration
- Linux privilege escalation
## Used tools
- Nmap
- Searchsploit

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN pelican.nmap 192.168.228.98 -v
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE     VERSION
22/tcp   open  ssh         OpenSSH 7.9p1 Debian 10+deb10u2 (protocol 2.0)
| ssh-hostkey: 
|   2048 a8:e1:60:68:be:f5:8e:70:70:54:b4:27:ee:9a:7e:7f (RSA)
|   256 bb:99:9a:45:3f:35:0b:b3:49:e6:cf:11:49:87:8d:94 (ECDSA)
|_  256 f2:eb:fc:45:d7:e9:80:77:66:a3:93:53:de:00:57:9c (ED25519)
139/tcp  open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp  open  netbios-ssn Samba smbd 4.9.5-Debian (workgroup: WORKGROUP)
631/tcp  open  ipp         CUPS 2.2
|_http-title: Forbidden - CUPS v2.2.10
| http-methods: 
|   Supported Methods: GET HEAD OPTIONS POST PUT
|_  Potentially risky methods: PUT
|_http-server-header: CUPS/2.2 IPP/2.1
2222/tcp open  ssh         OpenSSH 7.9p1 Debian 10+deb10u2 (protocol 2.0)
| ssh-hostkey: 
|   2048 a8:e1:60:68:be:f5:8e:70:70:54:b4:27:ee:9a:7e:7f (RSA)
|   256 bb:99:9a:45:3f:35:0b:b3:49:e6:cf:11:49:87:8d:94 (ECDSA)
|_  256 f2:eb:fc:45:d7:e9:80:77:66:a3:93:53:de:00:57:9c (ED25519)
8080/tcp open  http        Jetty 1.0
|_http-server-header: Jetty(1.0)
|_http-title: Error 404 Not Found
8081/tcp open  http        nginx 1.14.2
|_http-server-header: nginx/1.14.2
|_http-title: Did not follow redirect to http://192.168.228.98:8080/exhibitor/v1/ui/index.html
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
Service Info: Host: PELICAN; OS: Linux; CPE: cpe:/o:linux:linux_kernel

Host script results:
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled but not required
|_clock-skew: mean: 1h19m58s, deviation: 2h18m34s, median: -2s
| smb2-time: 
|   date: 2024-10-06T06:11:31
|_  start_date: N/A
| smb-os-discovery: 
|   OS: Windows 6.1 (Samba 4.9.5-Debian)
|   Computer name: pelican
|   NetBIOS computer name: PELICAN\x00
|   Domain name: \x00
|   FQDN: pelican
|_  System time: 2024-10-06T02:11:29-04:00
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
```

---
# Enumeration
## Port 22/2222 - SSH (OpenSSH 7.9p1)
No enumeration conducted
## Port 139/445 - Netbios-SSN (Samba 4.9.5-Debian)
No enumeration conducted
## Port 631 - IPP (CUPS 2.2)
No enumeration conducted
## Port 8080/8081 - HTTP (Jetty 1.0/Nginx 1.14.2)
- Attempted to access `http://192.168.228.98:8080` (Jetty 1.0)
![[Pasted image 20241006165927.png]]
- Attempted to access `http://192.168.228.98:8081` (nginx 1.14.2)
  - Redirected to `http://192.168.228.98:8080/exhibitor/v1/ui/index.html`
![[Pasted image 20241006170029.png]]
  - Identified `Exhibitor v1.0` - vulnerable to command injection (CVE-2019-5029)
---
# Exploitation
## Command Injection
- Found potential exploit for Exhibitor v1.0 with Searchsploit (`EDB-ID 48654`)
- Accessed Exhibitor config tab and added reverse shell to `java.env script`
![[Pasted image 20241006172119.png]]
- Started Netcat listener on port `4444` and caught reverse shell
![[Pasted image 20241006172211.png]]
---
# Lateral Movement to user
## Local Enumeration
- Upgraded to full TTY: `python3 -c 'import pty; pty.spawn("/bin/bash")'`
- Navigated to `charles` home directory and printed `local.txt`
![[Pasted image 20241006172608.png]]
- Checked for other users: `cat /etc/passwd`
![[Pasted image 20241006172753.png]]
- Checked sudo privilege: `sudo -l`
![[Pasted image 20241006172859.png]]
---
# Privilege Escalation
## Local Enumeration
- Run `ps aux` to identify running processes
![[Pasted image 20241006173841.png]]
- Identify process `513 -- /usr/bin/passwo` as likely `password-store` 
- Run gcore as sudo against process 513 (core dump saved to `output` file)
![[Pasted image 20241006174145.png]]
- Ran `strings core.513` on output file, and identified credentials 
  `root:ClogKingpinInning731`
![[Pasted image 20241006174442.png]]
## Privilege Escalation vector
- Switched user to root with found credentials
![[Pasted image 20241006174612.png]]
- Moved to `/root` directory and printed `proof.txt`
![[Pasted image 20241006174804.png]]
---
# Trophy & Loot
`local.txt` = `534c7b18e8c396fd0bee2fa3fdeef220`
`root.txt` = `af08887caa16e75251abbe18d4fa9269`