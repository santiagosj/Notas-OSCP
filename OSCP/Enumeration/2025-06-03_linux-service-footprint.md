**CheatSheet: Enumeración "Service Footprints" en Linux**

---

### 🔎 **Concepto**:

La técnica de "Service Footprints" se enfoca en identificar y analizar los servicios activos en un sistema, su configuración, 
puertos expuestos, binarios asociados y posibles vectores de explotación. Esto permite priorizar vectores de ataque 
según servicios vulnerables o mal configurados.

---

### ⚖️ **Requisitos**:

* Acceso al sistema con permisos para listar procesos y escanear puertos.
* Conocimientos básicos de servicios comunes (SSH, Apache, MySQL, etc).

---

### 🔄 **Flujo de Trabajo**:

1. **Detectar servicios activos (puertos abiertos):**

```bash
ss -tulnp     # Mostrar sockets activos
netstat -tulnp  # Alternativa si existe
```

2. **Listar procesos y binarios:**

```bash
ps aux | grep -E 'apache|nginx|mysql|sshd'
```
```
watch -n 1 "ps -aux | grep pass"
```

3. **Identificar puertos y servicios con nmap (si está permitido):**

```bash
nmap -sV -p- localhost
```

4. **Ver configuraciones de servicios comunes:**

```bash
cat /etc/ssh/sshd_config
cat /etc/apache2/apache2.conf
```

5. **Buscar servicios que se inician al arrancar:**

```bash
systemctl list-unit-files --type=service | grep enabled
```

6. **Revisar logs de servicios:**

```bash
journalctl -u ssh
journalctl -u apache2
```

7. **Detectar servicios ocultos o inusuales:**

```bash
ls /etc/systemd/system/
chkconfig --list 2>/dev/null
```

8. **Monitorear trafico**

```bash
sudo tcpdump -i lo -A | grep "pass"
```

---

### 🛠️ **Herramientas útiles**:

* `ss`, `netstat`, `ps`
* `systemctl`, `service`, `chkconfig`
* `journalctl`, `logrotate`, `grep`
* `nmap` (para escaneo de red)
* `lsof` (archivos abiertos por procesos)

---

### 📂 **Ejemplos clave**:

* Ver si Apache o Nginx está corriendo:

```bash
ps aux | grep -E 'apache|nginx'
```

* Revisar puertos abiertos por servicios:

```bash
ss -tulnp | grep LISTEN
```

* Ver binario usado por un servicio:

```bash
which apache2
```

* Ver configuraciones de MySQL:

```bash
cat /etc/mysql/my.cnf
```

---

### 🌍 **Notas**:

* Servicios corriendo como root son prioritarios para escalar privilegios.
* Compara configuraciones con la documentación oficial para detectar desviaciones.
* Puede correlacionarse con "User Trail" para detectar qué usuario inició un servicio sospechoso.
