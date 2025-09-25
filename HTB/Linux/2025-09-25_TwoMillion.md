# HTB: TwoMillion

## Host: Linux
## IP: 10.10.11.221

## Procedimiento y comandos

#### Paso 1: Enumeracion

* Nmap

```bash
nmap -A -Pn -oX twom.scan 10.10.11.221 --webxml
Starting Nmap 7.95 ( https://nmap.org ) at 2025-09-25 11:41 -03
Nmap scan report for 10.10.11.221
Host is up (0.26s latency).
Not shown: 998 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.9p1 Ubuntu 3ubuntu0.1 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 3e:ea:45:4b:c5:d1:6d:6f:e2:d4:d1:3b:0a:3d:a9:4f (ECDSA)
|_  256 64:cc:75:de:4a:e6:a5:b4:73:eb:3f:1b:cf:b4:e3:94 (ED25519)
80/tcp open  http    nginx
|_http-title: Did not follow redirect to http://2million.htb/
Device type: general purpose
Running: Linux 5.X
OS CPE: cpe:/o:linux:linux_kernel:5
OS details: Linux 5.0 - 5.14
Network Distance: 2 hops
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using port 5900/tcp)
HOP RTT       ADDRESS
1   338.82 ms 10.10.14.1
2   339.03 ms 10.10.11.221

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 22.48 seconds
```

* Directory:

- dirsearch:

```bash
dirsearch -u http://2million.htb

/usr/lib/python3/dist-packages/dirsearch/dirsearch.py:23: DeprecationWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html
  from pkg_resources import DistributionNotFound, VersionConflict

  _|. _ _  _  _  _ _|_    v0.4.3
 (_||| _) (/_(_|| (_| )

Extensions: php, aspx, jsp, html, js | HTTP method: GET | Threads: 25 | Wordlist size: 11460

Output File: /home/kali/HTB/TwoMillion/reports/http_2million.htb/_25-09-25_12-32-54.txt

Target: http://2million.htb/

[12:32:54] Starting: 
[12:32:59] 301 -  162B  - /js  ->  http://2million.htb/js/                  
[12:33:20] 200 -    2KB - /404                                              
[12:33:46] 401 -    0B  - /api                                              
[12:33:46] 401 -    0B  - /api/v1                                           
[12:33:49] 301 -  162B  - /assets  ->  http://2million.htb/assets/          
[12:33:49] 403 -  548B  - /assets/                                          
[12:34:03] 403 -  548B  - /controllers/                                     
[12:34:05] 301 -  162B  - /css  ->  http://2million.htb/css/                
[12:34:18] 301 -  162B  - /fonts  ->  http://2million.htb/fonts/            
[12:34:24] 302 -    0B  - /home  ->  /                                      
[12:34:27] 403 -  548B  - /images/                                          
[12:34:27] 301 -  162B  - /images  ->  http://2million.htb/images/          
[12:34:33] 403 -  548B  - /js/                                              
[12:34:37] 200 -    4KB - /login                                            
[12:34:39] 302 -    0B  - /logout  ->  /                                    
[12:35:19] 200 -    4KB - /register                                         
[12:36:23] 301 -  162B  - /views  ->  http://2million.htb/views/            
[12:36:40] 500 -  572B  - /wordpress.tar                                    
[12:36:40] 500 -  572B  - /workspace/uploads/                               
                                                                             
Task Completed 
```

* Subdomain

```bash
ffuf -u http://2million.htb -H "Host: FUZZ.2million.htb" -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt -ac -mc all

        /'___\  /'___\           /'___\       
       /\ \__/ /\ \__/  __  __  /\ \__/       
       \ \ ,__\\ \ ,__\/\ \/\ \ \ \ ,__\      
        \ \ \_/ \ \ \_/\ \ \_\ \ \ \ \_/      
         \ \_\   \ \_\  \ \____/  \ \_\       
          \/_/    \/_/   \/___/    \/_/       

       v2.1.0-dev
________________________________________________

 :: Method           : GET
 :: URL              : http://2million.htb
 :: Wordlist         : FUZZ: /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt
 :: Header           : Host: FUZZ.2million.htb
 :: Follow redirects : false
 :: Calibration      : true
 :: Timeout          : 10
 :: Threads          : 40
 :: Matcher          : Response status: all
________________________________________________

#www                    [Status: 400, Size: 150, Words: 5, Lines: 8, Duration: 237ms]
#mail                   [Status: 400, Size: 150, Words: 5, Lines: 8, Duration: 233ms]
:: Progress: [19966/19966] :: Job [1/1] :: 136 req/sec :: Duration: [0:03:48] :: Errors: 0 ::
```







#### Paso 2: 
## Troubleshooting
## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

