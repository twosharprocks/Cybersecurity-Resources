OSCP [Exam Guide](https://help.offsec.com/hc/en-us/articles/360040165632-OSCP-Exam-Guide-Newly-Updated)

OSCP Cheat Sheets
- https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Methodology%20and%20Resources

- https://github.com/RajChowdhury240/OSCP-CheatSheet/tree/main
- https://infosecsanyam261.gitbook.io/tryharder
- https://strange-1.gitbook.io/notes
- https://github.com/sagishahar/lpeworkshop
- https://github.com/0xsyr0/OSCP
- https://mqt.gitbook.io/oscp-notes
- https://github.com/Twigonometry/Cybersecurity-Notes/tree/main/Exam%20Resources/OSCP
- https://dmcxblue.gitbook.io/red-team-notes-2-0
- https://3os.org/penetration-testing/cheatsheets/nmap-cheatsheet/
- https://github.com/A-poc/RedTeam-Tools
- https://github.com/infosecn1nja/Red-Teaming-Toolkit
- https://sushant747.gitbooks.io/total-oscp-guide/content/
- https://gitlab.com/lagarian.smith/oscp-cheat-sheet/-/blob/master/OSCP_Notes.md
- https://infosecsanyam261.gitbook.io/tryharder
- https://happycamper84.medium.com/windows-reverse-shells-cheatsheet-5eeb09b28c8e
- Data Exfil - https://medium.com/@0xUN7H1NK4BLE/data-exfiltration-tips-tricks-3bd5c58af859

- If it's running SSH, find/replace the id_rsa
- `!/bin/bash`
- SMB - `crackmapexec` show available shares: `crackmapexec smb 192.168.50.242 -u john -p "dqsTwTpZPn#nL" --shares`
- Scanning UDP Ports for SNMP - https://infosecwriteups.com/why-you-should-always-scan-udp-ports-part-1-2-d8ee7eb26727
# Misc
- xfreerdp can pass the hash to login
- `runas /user:domain\username cmd.exe` (or rdp and open CMD as admin)
- Use the Kali directory: **/usr/share/webshells** for all your payloads.
- MSFVenom Shell code for Buffer Overflow https://www.offsec.com/metasploit-unleashed/alphanumeric-shellcode/ 


![](https://johnjhacking.com/uploads/autonmap.png)  
-   If you use metasploit, IMMEDIATELY run windows or linux exploit suggestor. It’s basically an autopwn.

easy wins

-   Linux: Capabilities, SUIDs/GUIDs, cronjobs, modifiable binaries running as root, out-of-date binaries, known-binary exploits, history files.
-   Windows: Weak service permissions, Unquoted service paths, outdated binaries, scheduled tasks, custom 

Take breaks, and set timers - if you're not getting anywhere for more than half an hour, take a break. Get some fresh air, and you'll almost definitely think of a new idea. 
	- Similarly, celebrate when you make progress! If you finish a machine its a good time for a rest
- Regularly review the information you have for a machine - key services, known version numbers, and any known credentials. 
- Document as you go - take screenshots of key moments in the machine, and of course when you read a proof file.
- Metasploit - pick the machine that you think you have the least chance of exploiting manually

## Things I Wish I'd Done

- Downloaded the various resources from the dedicated lab clients; 
- Document for your report as you go during the exam
- Do a practice exam! 
