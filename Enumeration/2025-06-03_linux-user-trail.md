**CheatSheet: Enumeración "User Trail" en Linux**

---

### 🔎 **Concepto**:

La técnica de "User Trail" busca rastrear la actividad de usuarios dentro del sistema: inicio de sesión, comandos ejecutados, conexiones realizadas, archivos accedidos. Es clave para detectar cuentas activas, compromisos, o usuarios con posibles privilegios elevados.

---

### ⚖️ **Requisitos**:

* Acceso a la terminal con privilegios suficientes para leer archivos de logs (/var/log/, /home/\*/).
* Herramientas comunes instaladas (last, who, grep, find, journalctl, etc).

---

### 🔄 **Flujo de Trabajo**:

1. **Detectar usuarios existentes:**

```bash
cut -d: -f1 /etc/passwd
```

2. **Revisar actividad de inicio de sesión:**

```bash
last -a          # Historial de inicios de sesión
who -uH          # Quién está conectado
lastlog          # Último login por usuario
```

3. **Analizar comandos usados:**

```bash
cat /home/*/.bash_history 2>/dev/null
```

4. **Buscar archivos recientes y modificados por usuarios:**

```bash
find /home -type f -printf '%u %TY-%Tm-%Td %TT %p\n' 2>/dev/null | sort | tail
```

5. **Ver conexiones realizadas por usuarios:**

```bash
grep -a 'Accepted' /var/log/auth.log | awk '{print $1,$2,$3,$9,$11}'
```

6. **Listar procesos por usuario:**

```bash
ps aux --sort=user
```

---

### 🛠️ **Herramientas útiles**:

* `last`, `lastlog`, `who`
* `grep`, `find`, `awk`
* `journalctl` (sistemas con systemd)
* `auditd` (si está habilitado)
* `ps`, `lsof`, `ss`, `netstat`

---

### 📂 **Ejemplos clave**:

* Ver qué comandos ejecutó un usuario:

```bash
cat /home/usuario/.bash_history
```

* Detectar si un usuario se ha conectado recientemente:

```bash
last -a | grep usuario
```

* Buscar archivos creados por un usuario en las últimas 24h:

```bash
find /home/usuario -type f -mtime -1
```

---

### 🌍 **Notas**:

* Algunos logs rotan: revisar /var/log/wtmp.1, /var/log/auth.log.1, etc.
* Usuarios que no tienen login ("/usr/sbin/nologin") pueden ser servicios.
* Puede combinarse con "Service Footprints" para más contexto sobre actividad sospechosa.
