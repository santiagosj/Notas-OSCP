# Walk: Mutable Rules 
## Fecha: 21/02/2025
## Objetivo
You extracted the MD5 hash "19adc0e8921336d08502c039dc297ff8" from a target system. Create a rule which makes all letters upper case and duplicates the passwords contained in **rockyou.txt** and crack the hash.
## Herramientas
1. hashcat

## Procedimiento y comandos
#### Paso 1: Crear la regla que convierta a mayuscula y duplique cada pass de rockyou.txt
- `echo "u d" > uppercase.rule`
> Guardamos el hash en un .txt:
- `echo "19adc0e8921336d08502c039dc297ff8" > hashToBeCracked.txt`
#### Paso 2: Ejecutamos hashcat con la regla, el modo y la lista rockyou.txt
- `hashcat -m 0 hashToBeCracked.txt /usr/share/wordlists/rockyou.txt -r uppercase.rule --force`
```
Dictionary cache hit:
* Filename..: /usr/share/wordlists/rockyou.txt
* Passwords.: 14344385
* Bytes.....: 139921507
* Keyspace..: 14344385

19adc0e8921336d08502c039dc297ff8:BUTTERFLY5BUTTERFLY5     
                                                          
Session..........: hashcat
Status...........: Cracked
Hash.Mode........: 0 (MD5)
Hash.Target......: 19adc0e8921336d08502c039dc297ff8
Time.Started.....: Fri Feb 21 16:44:58 2025, (0 secs)
Time.Estimated...: Fri Feb 21 16:44:58 2025, (0 secs)
Kernel.Feature...: Pure Kernel
Guess.Base.......: File (/usr/share/wordlists/rockyou.txt)
Guess.Mod........: Rules (uppercase.rule)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........:  2070.7 kH/s (1.10ms) @ Accel:1024 Loops:1 Thr:1 Vec:16
Recovered........: 1/1 (100.00%) Digests (total), 1/1 (100.00%) Digests (new)
Progress.........: 16384/14344385 (0.11%)
Rejected.........: 0/16384 (0.00%)
Restore.Point....: 8192/14344385 (0.06%)
Restore.Sub.#1...: Salt:0 Amplifier:0-1 Iteration:0-1
Candidate.Engine.: Device Generator
Candidates.#1....: TOTAL90TOTAL90 -> COCOLISOCOCOLISO
Hardware.Mon.#1..: Temp: 56c Util: 23%

Started: Fri Feb 21 16:44:56 2025
Stopped: Fri Feb 21 16:45:00 2025
```
- 19adc0e8921336d08502c039dc297ff8: **BUTTERFLY5BUTTERFLY5**
