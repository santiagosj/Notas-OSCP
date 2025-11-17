#!/bin/bash
set -e

echo "[*] Parando procesos de experimentación..."
sudo pkill -f hostapd-mana || true
sudo pkill -f hostapd || true
sudo pkill -f dnsmasq || true
sudo pkill -f airodump-ng || true
sudo pkill -f aireplay-ng || true
sudo pkill -f aircrack-ng || true

sleep 1

echo "[*] Eliminando reglas nft/iptables relacionadas (si existen)..."
# nft: eliminar tabla 'nat' si existe
if sudo nft list tables | grep -q '^table ip nat'; then
  sudo nft delete table ip nat || true
  echo "  - nft nat table deleted"
else
  echo "  - no nft nat table found"
fi

# iptables nat flush (por si acaso)
sudo iptables -t nat -F || true
sudo iptables -t nat -X || true
sudo iptables -F || true

echo "[*] Parando dnsmasq y hostapd por systemd (si existen)..."
sudo systemctl stop dnsmasq || true
sudo systemctl disable --now dnsmasq || true
sudo systemctl stop hostapd || true
sudo systemctl disable --now hostapd || true

sleep 1

echo "[*] Parando interfaces monitor creadas por airmon-ng (wlan0mon etc)..."
# Intenta parar interfaces monitor conocidas
for ifc in wlan0mon wlan2mon mon0 mon1; do
  if ip link show "$ifc" >/dev/null 2>&1; then
    sudo airmon-ng stop "$ifc" || {
      sudo ip link set "$ifc" down || true
      sudo iw dev "$ifc" set type managed || true
    }
    echo "  - stopped $ifc"
  fi
done

echo "[*] Asegurando wlan0 y wlan2 en modo managed y abajo/arriba..."
for IF in wlan0 wlan2; do
  if ip link show "$IF" >/dev/null 2>&1; then
    sudo ip link set "$IF" down || true
    # intentar set type managed (algunas tarjetas requieren ip link name reset)
    sudo iw dev "$IF" set type managed 2>/dev/null || true
    sudo ip link set "$IF" name "$IF" 2>/dev/null || true
    sudo ip link set "$IF" up || true
    echo "  - $IF set to managed/up"
  else
    echo "  - $IF not present"
  fi
done

echo "[*] Deshabilitando IP forwarding (si lo activaste) ..."
sudo sysctl -w net.ipv4.ip_forward=0 >/dev/null || true
sudo sysctl -w net.ipv6.conf.all.forwarding=0 >/dev/null || true

echo "[*] Reiniciando NetworkManager para restaurar control del sistema (puede cortar SSH)..."
sudo systemctl restart NetworkManager || true

sleep 2

echo "[*] Limpieza de leases temporales / archivos"
sudo rm -f /tmp/wl_* 2>/dev/null || true
sudo rm -f /var/lib/misc/dnsmasq.leases 2>/dev/null || true

echo "[*] Estado final: interfaces, procesos y reglas"
iw dev || true
ip -br addr show || true
sudo ss -lntu | sed -n '1,200p' || true
ps aux | egrep 'hostapd|dnsmasq|airodump|aireplay|aircrack' || true

echo "[+] Cleanup completo."
