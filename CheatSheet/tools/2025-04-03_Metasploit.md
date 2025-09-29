# Cheatsheet : Metasploit - Básico general

## 🛠️ Setup Inicial

1. Iniciar la base de datos:
```bash
sudo msfdb init
```

2. Habilitar PostgreSQL:
```bash
sudo systemctl enable postgresql
```

3. Verificar estado de la base de datos desde `msfconsole`:
```bash
db_status
```

```bash
# Resolucion de problemas

sudo msfdb delete

sudo msfdb init

# o
sudo msfdb reinit
```



## 🗂️ Workspaces

- Mostrar workspaces:
```bash
workspace
```

- Crear nuevo workspace:
```bash
workspace -a <workspace-name>
```

- Cambiar de workspace:
```bash
workspace <workspace-name>
```

- Eliminar un workspace:
```bash
workspace -d <workspace-name>
```

---

## 🧰 Herramientas Integradas

### 🔍 Escaneo con Nmap

- Escanear e importar resultados en la base de datos:
```bash
db_nmap -A <target>
```

- Ver hosts detectados:
```bash
hosts
```

- Filtrar por puerto:
```bash
services -p <port>
```

- Ver vulnerabilidades:
```bash
vulns
```

- Obtener RHOSTS automáticamente desde servicios:
```bash
services -p 445 --rhosts
```

---

## 📦 Uso de Módulos

### ▶️ General

- Buscar módulos:
```bash
search <palabra_clave>
```

- Filtrar por tipo:
```bash
search type:auxiliary <palabra_clave>
```

- Seleccionar módulo:
```bash
use <module_path>
```

- Mostrar información del módulo:
```bash
info
```

- Mostrar opciones requeridas:
```bash
show options
```

- Mostrar opciones avanzadas:
```bash
show advanced
```

- Mostrar payloads compatibles:
```bash
show payloads
```

- Mostrar targets compatibles:
```bash
show targets
```

- Establecer valores:
```bash
set <opción> <valor>
```

- Establecer valores globales:
```bash
setg <opción> <valor>
```

- Borrar valores:
```bash
unset <opción>
unsetg <opción>
```

- Ejecutar el módulo:
```bash
run
```

- Volver al prompt global:
```bash
back
```

---

### 📚 Tipos de Módulos

- Ver todos los módulos de un tipo:
```bash
show auxiliary
show exploits
show post
show encoders
show nops
```

---

## 💃 Comandos Globales

| Comando       | Descripción |
|---------------|-------------|
| `help`        | Muestra ayuda general |
| `version`     | Muestra la versión de Metasploit |
| `banner`      | Muestra un banner nuevo |
| `save`        | Guarda la configuración actual |
| `load`        | Carga una extensión |
| `unload`      | Descarga una extensión |
| `resource`    | Ejecuta comandos desde un archivo `.rc` |
| `irb`         | Abre una consola interactiva Ruby |
| `sleep <n>`   | Espera n segundos |
| `connect`     | Cliente TCP/IP integrado (como netcat) |

---

## 📁 Base de Datos (DB)

- Mostrar estado:
```bash
db_status
```

- Escanear con Nmap (e importar):
```bash
db_nmap -A <host>
```

- Ver hosts:
```bash
hosts
```

- Ver servicios:
```bash
services
```

- Ver vulnerabilidades:
```bash
vulns
```

- Ver credenciales:
```bash
creds
```

- Ver archivos loot:
```bash
loot
```

- Ver notas:
```bash
notes
```

- Agregar nota:
```bash
notes -a -t host -n "nombre" -d "detalle" -r <IP>
```

---

## 💻 Sesiones

- Ver sesiones activas:
```bash
sessions
```

- Interactuar con una sesión:
```bash
sessions -i <ID>
```

- Enviar sesión al background:
```bash
background
```

- Matar sesión:
```bash
sessions -k <ID>
```

- Matar todas las sesiones:
```bash
sessions -K
```

---

## 📁 Limpieza del Workspace

- Eliminar todos los hosts:
```bash
hosts -d -R
```

- Eliminar todas las notas:
```bash
notes -d -R
```

- Eliminar todas las credenciales:
```bash
creds -d -R
```

- Eliminar todos los loot:
```bash
loot -d -R
```

- Eliminar todas las sesiones:
```bash
sessions -K
```

---

## 🪠 Meterpreter Básico

- Ayuda:
```bash
help
```

- Navegar el sistema de archivos:
```bash
ls
cd <ruta>
pwd
```

- Subir / descargar archivos:
```bash
upload <archivo>
download <archivo>
```

- Ejecutar comandos:
```bash
shell
```

- Ejecutar scripts:
```bash
run <script>
```

- Capturar pantalla:
```bash
screenshot
```

- Capturar teclado:
```bash
keyscan_start
keyscan_dump
```

- Obtener hashdump:
```bash
hashdump
```

---

## 🧬 Tips Extra

- Ejecutar comandos en segundo plano:
```bash
jobs
```

- Matar un job:
```bash
kill <job_id>
```

- Recargar módulo:
```bash
reload
```

- Ejecutar el último módulo de nuevo:
```bash
rerun
```

---

> ✅ Recomendación: usar `setg` para configurar `LHOST` y `LPORT` globalmente y no tener que setearlo en cada módulo.

---

