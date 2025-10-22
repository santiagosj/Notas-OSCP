# Wireshark

## Filter Types

- **Display Filters:** View specific packets in a capture file (applied after capture).
- **Capture Filters:** Limit packets captured (set before capture).  
    *This sheet covers Display Filters.*

---

## Display Filter Syntax

- **Format:** `protocol.field operator value`
- **Operators:**
    - `==` (equal)
    - `!=` (not equal)
    - `>` (greater than)
    - `<` (less than)
    - `contains` (substring match)
- **Logical Operators:** `and`, `or`, `not` (case-insensitive)
- **Tip:** Use parentheses for complex expressions.

## Common Display Filter Examples

### IP Address Filters

- Any packet to/from an IP:  
    `ip.addr == 192.168.1.5`
- Source IP only:  
    `ip.src == 10.0.0.1`
- Destination IP only:  
    `ip.dst == 8.8.8.8`
- Either source or destination:  
    `ip.addr == 192.168.1.1`

### Port Filters

- TCP/UDP to/from a port:  
    `tcp.port == 80`  
    `udp.port == 53`
- Source port:  
    `tcp.srcport == 443`
- Destination port:  
    `udp.dstport == 123`

### Protocol Filters

- TCP only: `tcp`
- UDP only: `udp`
- ICMP only: `icmp`
- HTTP only: `http`

### Combining Filters

- TCP traffic on port 80:  
    `tcp and tcp.port == 80`
- From IP A to IP B:  
    `ip.src == 192.168.0.100 and ip.dst == 192.168.0.200`
- Exclude HTTP:  
    `not http`

### String & Payload Filters

- Contains string (case-sensitive):  
    `frame contains "password"`
- Payload contains "login":  
    `data contains "login"`

### Packet Length Filters

- Larger than 1000 bytes:  
    `frame.len > 1000`
- Smaller than 200 bytes:  
    `frame.len < 200`

### TCP Flags Filters

- SYN flag set:  
    `tcp.flags.syn == 1`
- ACK flag set:  
    `tcp.flags.ack == 1`
- SYN and ACK:  
    `tcp.flags.syn == 1 and tcp.flags.ack == 1`
- RST flag:  
    `tcp.flags.reset == 1`

### DNS Filters

- DNS queries:  
    `dns.flags.response == 0`
- DNS responses:  
    `dns.flags.response == 1`
- DNS A record queries:  
    `dns.qry.type == 1`

### Wi-Fi / BSSID Filters

- Filter by BSSID (MAC of the AP):  
    `wlan.bssid == aa:bb:cc:dd:ee:ff`
- Any packet to/from a MAC address:  
    `wlan.addr == 00:11:22:33:44:55`
- Source / Destination MAC (station addresses):  
    `wlan.sa == 00:11:22:33:44:55`  
    `wlan.da == 66:77:88:99:aa:bb`
- Exclude a BSSID:  
    `wlan.bssid != aa:bb:cc:dd:ee:ff`
- Filter beacons from a given BSSID (useful for SSID discovery):  
    `wlan.bssid == aa:bb:cc:dd:ee:ff and wlan.fc.type_subtype == 8`
- Match SSID strings (shows AP name; requires beacon/probe frames):  
    `wlan.ssid == "MyNetwork"`

> These fields apply to 802.11 (monitor-mode) captures — BSSID may not appear in captured traffic if not in monitor mode or if frames are hidden by capture settings.
---

## Tips

- **Search:** Press `Ctrl + F` to search packets.
- **Auto-complete:** Use tab for field suggestions.
- **Case Sensitivity:** Field names are case-sensitive; operators are not.
- **Parentheses:** Use for grouping filters.

---

**Reference:**  
[Wireshark Display Filters Documentation](https://wiki.wireshark.org/DisplayFilters)
---

## Ejemplo práctico (entorno de prueba/autorizado)

Supongamos que accedemos a testphp.vulnweb y quieremos capturar credenciales enviadas por HTTP (texto plano). Pasos y ejemplos:

1) Captura (BPF para reducir volumen)
```bash
# usando tcpdump / dumpcap / wireshark -f
sudo tcpdump -i eth0 -w captura.pcap 'host testphp.vulnweb and tcp port 80'
# o con wireshark directamente
sudo wireshark -k -f 'host testphp.vulnweb and tcp port 80'
```

2) Filtrado en Wireshark (Display Filters) — localizar solicitudes POST y URIs
- Mostrar sólo solicitudes HTTP POST:
```bash
http.request.method == "POST"
```
- Mostrar solicitudes cuyo URI contenga "login" o "test":
```bash
http.request.full_uri contains "login"
```
- Buscar parámetros comunes en el payload (username/password):
```bash
frame contains "username" or frame contains "user" or frame contains "password" or frame contains "pass"
```

3) Inspección de la solicitud y credenciales
- Selecciona un paquete HTTP POST → botón derecho → "Follow" → "TCP Stream" para ver cuerpo POST (a menudo contiene los parámetros: user=...&pass=...).
- En los detalles del paquete, revisar campos:
    - http.request.full_uri (URL solicitada)
    - http.host (host)
    - http.content_type / http.content_length
    - http (cuerpo POST aparece en la vista de seguimiento de stream)

4) Extracción rápida con tshark (archivo pcap)
```bash
tshark -r captura.pcap -Y 'http.request.method == "POST"' -T fields -e ip.src -e http.request.full_uri -e http.file_data
```
- Nota: según la captura, el cuerpo POST puede aparecer en http.file_data o sólo en la vista completa (-V). Si no aparece, usa:
```bash
tshark -r captura.pcap -Y 'http.request.method == "POST"' -V | sed -n '/^ /,/^$/p'
```
para inspeccionar manualmente el payload.

5) Consejos rápidos
- Busca nombres de parámetros comunes: user, username, login, uid, pass, password, pwd.
- Si la web usa HTTPS, el contenido está cifrado: necesitarás un entorno autorizado (mitmproxy/depuración con certificados o claves privadas) — no es posible extraer credenciales desde un pcap normal sin descifrado.

## Filtros de captura (BPF)

- Aplicados antes de iniciar la captura (reduce volumen). Sintaxis basada en Berkeley Packet Filter (BPF).
- Palabras clave comunes: host, src, dst, port, portrange, net, tcp, udp, icmp, arp, ether, vlan, and, or, not. Use comillas si hay espacios.

Ejemplos útiles (cadenas BPF):

- Capturar todo hacia/desde una IP:
```bash
host 192.168.1.5
```
- Sólo desde / sólo hacia:
```bash
src host 10.0.0.1
dst host 8.8.8.8
```
- Puerto único / origen / destino:
```bash
port 80
src port 443
dst port 53
```
- Rango de puertos:
```bash
portrange 1000-2000
```
- Por protocolo:
```bash
tcp
udp
icmp
arp
```
- Combinaciones (AND / OR / NOT):
```bash
tcp and host 192.168.1.10 and port 22
udp and (port 53 or port 123)
not port 22
```
- Redes / subredes:
```bash
net 192.168.0.0/24
```
- Filtrar por MAC (Ethernet):
```bash
ether host 00:11:22:33:44:55
ether src 00:11:22:33:44:55
```
- VLAN:
```bash
vlan 100
vlan and host 192.168.1.5
```
- Tráfico DNS/HTTP/TLS típico:
```bash
udp port 53           # DNS
tcp port 80           # HTTP
tcp port 443          # HTTPS/TLS (solo puerto)
```
- Wireless (monitor mode): excluir beacons (útil para reducir ruido):
```bash
not subtype beacon
```

Ejemplos de uso con herramientas:

- tcpdump (guardar en archivo):
```bash
sudo tcpdump -i eth0 -w captura.pcap 'host testphp.vulnweb and tcp port 80'
```
- wireshark (arrancar con filtro de captura):
```bash
sudo wireshark -i wlan0 -k -f "tcp and port 80 and not port 22"
```

Consejos rápidos:
- Probar filtros con tcpdump primero para validar.
- Encerrar el filtro en comillas en la línea de comandos si contiene espacios o paréntesis.
- Los filtros de captura son más limitados que los Display Filters (no pueden inspeccionar campos HTTP internos).
- Para capturas grandes, combine filtros de captura con rotación de archivos (-W/-C) o snaplen (-s).

```bash
wireshark -D
```
- `-D`: shows interfaces

```bash
sudo wireshark -i wlan0mon -k
```
- `-i`: interface
- `-k`: Start capture immediately

```bash
sudo wireshark -i wlan0 -I -k
```
- `-I`: Start monitor mode in the selected interface 

```bash
sudo wireshark -i 4 -I -k
```
- `-i`: indicates the index of the interface to use

```bash
sudo wireshark -i wlan0mon -k -f "not subtype beacon"
```

- `-f`: capture filter

```bash
sudo wireshark -i wlan0mon -k -s 60
```
- `-s`: first 60 bytes of the frame instead the entire frame

```bash
wireshark wifi.pcap
```
- Open a file

### 1. Start Immediate Capture (Wireless Interface)

```sh
wireshark -i wlan0 -k
```
- `-i wlan0`: Use interface `wlan0`
- `-k`: Start capture immediately

### 2. Start Capture with Monitor Mode (Wireless)

```sh
wireshark -i wlan0 -I -k
```
- Set interface to monitor mode and start capture

### 3. Start Capture with a Capture Filter

```sh
wireshark -i wlan0 -k -f "tcp port 80"
```
- `-f`: Apply capture filter (e.g., only TCP port 80 traffic)

### 4. Open a `.pcap` File

```sh
wireshark file.pcap
```
- Opens `file.pcap` for analysis
---
**Tip:**  
For headless environments, use `tshark` (Wireshark CLI):

- Start capture: `tshark -i wlan0`
- With filter: `tshark -i wlan0 -f "port 53"`
- Read file: `tshark -r file.pcap`
- Save output: `tshark -i wlan0 -w output.pcap`

## Remote Capture

### Basics: Capturing Remotely

#### Using `tcpdump` (on remote host)

```bash
sudo tcpdump -i wlan0 -w /tmp/capture.pcap
```
- Captures traffic on `wlan0` and writes to `/tmp/capture.pcap`.

```bash
sudo tcpdump -i wlan0mon -w - -U
```

#### Using `tshark`

```bash
sudo tshark -w - -i wlan0mon
```

#### Transfer the Capture

```bash
scp user@remote:/tmp/capture.pcap .
```
- Securely copy the capture file to your local machine.

---

### Live Remote Capture with SSH

#### Pipe `tcpdump` Output to Local Wireshark

```bash
ssh root@10.11.0.196 "sudo -S tcpdump -U -w - -i wlan0mon" | sudo wireshark -k -i -
```

```bash
ssh user@remote "sudo tcpdump -i wlan0mon -U -w -" | wireshark -k -i -
```
- Captures live traffic from remote host and displays in local Wireshark.

#### Pipe to Local `tshark`

```bash
ssh user@remote "sudo tcpdump -i wlan0mon -U -w -" | tshark -i -
```
- Analyzes remote traffic locally with `tshark`.

---

### Advanced: Using `tshark` Remotely

#### Save and Download

```bash
ssh user@remote "sudo tshark -i wlan0mon -w /tmp/remote.pcap"
scp user@remote:/tmp/remote.pcap .
```

#### Live Stream to Local

```bash
ssh user@remote "sudo tshark -i wlan0mon -w -" | wireshark -k -i -
```
---

### Using `dumpcap` for Remote Capture

#### On Remote Host
```bash
sudo dumpcap -w - -P -i wlan0mon
```
```bash
sudo dumpcap -i wlan0mon -w /tmp/dumpcap.pcap
```
- Efficient packet capture (minimal processing).

#### Stream to Local

```bash
ssh user@remote "sudo dumpcap -i wlan0mon -w -" | wireshark -k -i -
```
---

### Tips

- Use `-f "<filter>"` with `tcpdump`, `tshark`, or `dumpcap` for capture filters.
- Use `-s <snaplen>` to limit packet size.
- For high-volume captures, consider rotating files:  
    `tcpdump -W <count> -C <sizeMB> -w capture-%i.pcap`
- Always run capture tools with appropriate privileges (`sudo` if needed).

---

**Reference:**  
- [Wireshark Remote Capture](https://wiki.wireshark.org/CaptureSetup/Remote)
- [tcpdump Manual](https://www.tcpdump.org/manpages/tcpdump.1.html)
- [tshark Manual](https://www.wireshark.org/docs/man-pages/tshark.html)
