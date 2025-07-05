---
Date: 2024-10-21
Course: "[[OSCP]]"
Platform: PG-Practice
Category: Windows
Difficulty: Easy
Status: Complete
IP: 192.168.191.65
Writeup: https://medium.com/@ardian.danny/oscp-practice-series-27-proving-grounds-algernon-aef735582b6e
---
# Algernon
This was my first shift across from Linux into Windows, and I'll freely admit to being a little overwhelmed at all the open ports and not knowing quite where to start. Realising the FTP had an anonymous login was straight forward, and identifiying the `admin` user from the logs was nice, but it turned out to be a deadend and the real solution was 10x easier than what I'd experienced with the last few Linux boxes - I really needed to reset my expectations.

Sure, the Windows boxes have a mountain of open ports and the options are overwhelming for enumeration, but if anything that makes things easier. In this case, it was as easy as checking the website on port `9998`, identifying a vulnerable service, and running an appropriate exploit against it to get RCE. The exploit gave me access as Administrator too, so there wasn't even PrivEsc to tackle here.

All around this was a ***very*** easy box compared to what I've just been doing, but it was an excellent reminder on enumerating Windows services and the process you need to follow when you're attacking a Windows machine. There aren't many notes to add to your cheat sheet for this one... although it's probably worth keeping `type C:\Users\Administrator\Desktop\proof.txt` on a quick reference when you get access and don't know where to find the proof file!

# Resolution summary
- Ran Nmap to identify ports `21`, `80`, `135`, `139`, `445` & `9998`
- Identified port `9998` as running `SmarterMail`
- Found exploit for `SmarterMail` that allowed unauthenticated remote code execution
- Ran exploit and gained initial access as `System` - navigated to Administrator desktop and printed `proof.txt`
## Improved skills
- Exploit identification
## Used tools
- nmap
- ftp
- gobuster
- python

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN Algernon.nmap 192.168.191.65 -v
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE       VERSION
21/tcp   open  ftp           Microsoft ftpd
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
| 04-29-20  10:31PM       <DIR>          ImapRetrieval
| 08-02-24  01:34PM       <DIR>          Logs
| 04-29-20  10:31PM       <DIR>          PopRetrieval
|_04-29-20  10:32PM       <DIR>          Spool
| ftp-syst: 
|_  SYST: Windows_NT
80/tcp   open  http          Microsoft IIS httpd 10.0
|_http-server-header: Microsoft-IIS/10.0
| http-methods: 
|   Supported Methods: OPTIONS TRACE GET HEAD POST
|_  Potentially risky methods: TRACE
|_http-title: IIS Windows
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
445/tcp  open  microsoft-ds?
9998/tcp open  http          Microsoft IIS httpd 10.0
|_http-server-header: Microsoft-IIS/10.0
| http-title: Site doesn't have a title (text/html; charset=utf-8).
|_Requested resource was /interface/root
| uptime-agent-info: HTTP/1.1 400 Bad Request\x0D
| Content-Type: text/html; charset=us-ascii\x0D
| Server: Microsoft-HTTPAPI/2.0\x0D
| Date: Mon, 21 Oct 2024 09:51:00 GMT\x0D
| Connection: close\x0D
| Content-Length: 326\x0D
| \x0D
| <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN""http://www.w3.org/TR/html4/strict.dtd">\x0D
| <HTML><HEAD><TITLE>Bad Request</TITLE>\x0D
| <META HTTP-EQUIV="Content-Type" Content="text/html; charset=us-ascii"></HEAD>\x0D
| <BODY><h2>Bad Request - Invalid Verb</h2>\x0D
| <hr><p>HTTP Error 400. The request verb is invalid.</p>\x0D
|_</BODY></HTML>\x0D
|_http-favicon: Unknown favicon MD5: 9D7294CAAB5C2DF4CD916F53653714D5
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled but not required
| smb2-time: 
|   date: 2024-10-21T09:51:01
|_  start_date: N/A
```
---
# Enumeration
## Port 21 - FTP (Microsoft FTPD)
- Ran `ftp 192.168.191.65` and accessed `FTP` service with `anonymous` login (no password)
![[Cybersecurity-Resources/images/Pasted image 20241021203342.png]]
- Enumerated available directories and downloaded `/Logs/2020.05.12-administrative.log`
![[Cybersecurity-Resources/images/Pasted image 20241021204417.png]]
- Ran `cat 2020.05.12-administrative.log` and identified username `admin` logging into `192.168.118.6`
![[Cybersecurity-Resources/images/Pasted image 20241021204511.png]]
## Port 80 - HTTP (Microsoft IIS)
- Navigated to `http://192.168.191.65:80` and identified default page for `Microsoft IIS`
![[Cybersecurity-Resources/images/Pasted image 20241021203154.png]]

## Port 135 - MSRPC (Microsoft Windows RPC)
No enumeration conducted

## Port 139 & 445 - SMB (Microsoft Windows Netbios-SSN)
No enumeration conducted

## Port 9998 - HTTP (Microsoft IIS)
- Navigated to `http://192.168.191.65:9998` and identified `SmarterMail`
![[Cybersecurity-Resources/images/Pasted image 20241021202817.png]]
- Ran `gobuster dir -u http://192.168.191.65:9998 -w //usr/share/dirb/wordlists/big.txt` to identify any available web directories
![[Cybersecurity-Resources/images/Pasted image 20241021203628.png]]
---
# Exploitation
Ran `searchsploit SmarterMail` and identified exploit `49216.py` as potential initial access vector
![[Cybersecurity-Resources/images/Pasted image 20241021205733.png]]
- Modified exploit `49216.py` to use target & local IP, and ran `nc -nvlp 80` to start netcat listener on port `80`
![[Cybersecurity-Resources/images/Pasted image 20241021205915.png]]
- Ran `python3 49216.py` and caught reverse shell as `system` with netcat
![[Cybersecurity-Resources/images/Pasted image 20241021210318.png]]
- Navigated to `C:\Users\Administrator\Desktop`, identified `proof.txt` and ran `type C:\Users\Administrator\Desktop\proof.txt` to print `1ab9224ec3c047b987a983a5d1e3c713`
![[Cybersecurity-Resources/images/Pasted image 20241021210611.png]]

---
# Trophy & Loot
`proof.txt` = `1ab9224ec3c047b987a983a5d1e3c713`