# Walk: Mutable Rules 
## Fecha: 21/02/2025
## Objetivo
You extracted the MD5 hash "056df33e47082c77148dba529212d50a" from a target system. Create a rule to add "1@3$5" to each password of the **rockyou.txt** wordlist and crack the hash.
## Herramientas
1. hashcat

## Procedimiento y comandos
#### Paso 1: Crear la regla que adiera _"1@3$5"_ a cada pass de rockyou.txt
- `echo '$1 $@ $3 $$ $5' > add_suffix.rule`
> Guardamos el hash en un .txt:
- `echo "056df33e47082c77148dba529212d50a" > hashToBeCracked.txt`
#### Paso 2: Ejecutamos hashcat con la regla, el modo y la lista rockyou.txt
- `hashcat -m 0 hashToBeCracked.txt /usr/share/wordlists/rockyou.txt -r add_suffix.rule --force`
```
Host memory required for this attack: 2 MB

Dictionary cache hit:
* Filename..: /usr/share/wordlists/rockyou.txt
* Passwords.: 14344385
* Bytes.....: 139921507
* Keyspace..: 14344385

056df33e47082c77148dba529212d50a:courtney1@3$5            
                                                         
Session..........: hashcat
Status...........: Cracked
Hash.Mode........: 0 (MD5)
Hash.Target......: 056df33e47082c77148dba529212d50a
Time.Started.....: Fri Feb 21 16:27:17 2025, (0 secs)
Time.Estimated...: Fri Feb 21 16:27:17 2025, (0 secs)
Kernel.Feature...: Pure Kernel
Guess.Base.......: File (/usr/share/wordlists/rockyou.txt)
Guess.Mod........: Rules (add_suffix.rule)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........:  2523.2 kH/s (1.07ms) @ Accel:1024 Loops:1 Thr:1 Vec:16
Recovered........: 1/1 (100.00%) Digests (total), 1/1 (100.00%) Digests (new)
Progress.........: 8192/14344385 (0.06%)
Rejected.........: 0/8192 (0.00%)
Restore.Point....: 0/14344385 (0.00%)
Restore.Sub.#1...: Salt:0 Amplifier:0-1 Iteration:0-1
Candidate.Engine.: Device Generator
Candidates.#1....: 1234561@3$5 -> whitetiger1@3$5
Hardware.Mon.#1..: Temp: 61c Util: 16%

Started: Fri Feb 21 16:27:15 2025
Stopped: Fri Feb 21 16:27:19 2025
```
- 056df33e47082c77148dba529212d50a: **courtney1@3$5**

