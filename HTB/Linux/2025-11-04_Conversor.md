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
#### Paso 2: ...
## Troubleshooting
## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

