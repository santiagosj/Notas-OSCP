# Cheatsheet: Troubleshooting tarjetas Wi‑Fi 

Objetivo: pasos rápidos y comandos para diagnosticar y estabilizar interfaces inalámbricas, crear una interfaz monitor sin renombrar la original y resolver fallos comunes (no captura, inestabilidad, drivers/firmware).

## Conecxion con wpa_supplicant

[fuente-1](https://askubuntu.com/questions/138472/how-do-i-connect-to-a-wpa-wifi-network-using-the-command-line)
[fuente-2](https://codelucky.com/wpa-supplicant-linux/)

```bash
wpa_supplicant -B -i <interface> -c /etc/wpa_supplicant.conf

network={
   ssid="ESSID"
   psk="password"
}
# Explorar alternativa con wpa_cli
> scan
> scan_result
> add_network
> set_network 0 ssid "ESSID"
> set_network 0 psk "password"
> enable_network 0
> reconnect
> status
> quit
dhclient -r
dhclient wlan0
```
## Comprobaciones rápidas
- Revisar bloqueo por hardware/software:
```bash
rfkill list all
sudo rfkill unblock wifi
```
- Ver información del PHY y capacidades (monitor, HT, canales):
```bash
iw phy phy0 info
```
- Ver interfaces y estados:
```bash
ip link show
```

## Crear un modo monitor "estático" sin renombrar la interfaz original
- Añadir una interfaz monitor nueva (mon0) ligada al phy:
```bash
sudo iw phy phy0 interface add mon0 type monitor
sudo ip link set dev wlan0 up
```
- Fijar canal (evita salto de canales):
```bash
sudo iw dev wlan0 set channel 6 HT20
```
- Eliminar la interfaz monitor cuando termines:
```bash
sudo iw dev wlan0 del
```

## Evitar procesos que interfieren con captura
- Parar servicios que ocupen la tarjeta:
```bash
sudo systemctl stop NetworkManager wpa_supplicant
sudo pkill -f wpa_supplicant
```
- Restaurar servicios al terminar:
```bash
sudo systemctl start NetworkManager
```

## Comprobar y recuperar drivers/firmware
- Buscar errores relevantes en el kernel:
```bash
dmesg | grep -iE 'firmware|wifi|iwl|rtl|ath'
journalctl -k -b | tail -n 200
```
- Recargar módulo problemático:
```bash
sudo modprobe -r <driver_name>
sudo modprobe <driver_name>
```
- Listar módulos relacionados:
```bash
lsmod | grep -E 'iwlwifi|ath|rtw|rtl'
```

## Gestión de energía y estabilidad
- Desactivar power management (puede cortar paquetes):
```bash
sudo iw dev <iface> set power_save off
```
- Comprobar configuración de energía del sistema (tlp, powertop).

## Captura y verificación alternativa (si airodump presenta problemas)
- Capturar con tcpdump o tshark:
```bash
sudo tcpdump -i mon0 -w /tmp/capture.pcap
sudo tshark -i mon0 -w /tmp/capture.pcap
```
- Inspeccionar fichero pcap con Wireshark.

## Problemas comunes y soluciones rápidas
- No aparece tráfico en monitor:
    - Asegurar que mon0 está en el canal correcto.
    - Confirmar antenna/alcance físico.
    - Parar NetworkManager/wpa_supplicant.
    - Revisar que el driver soporte modo monitor (consultar "iw phy ... info").
- Intermitencia / desconexiones:
    - Desactivar power_save.
    - Probar otro driver o firmware (actualizar paquetes de firmware).
    - Cambiar canal/anchura (HT20 vs HT40).
- Interfaz que no se puede crear/activar:
    - Revisar logs de dmesg por errores al crear la interfaz.
    - Probar recargar módulo y reiniciar servicios de red.

## Procedimiento de recuperación rápido (pasos secuenciales)
1. Comprobar rfkill y desbloquear.
2. Parar NetworkManager/wpa_supplicant.
3. Crear interfaz monitor (iw phy … interface add).
4. Fijar canal y probar captura con tcpdump/tshark.
5. Si falla, revisar dmesg/journal, recargar módulo.
6. Al terminar, borrar mon0 y reiniciar NetworkManager.

Notas: sustituir phy0, mon0 y <iface>/<driver_name> por los valores reales del equipo. Mantener firmware y kernel actualizados para evitar incompatibilidades.
* Modo monitor estable sin cambiar los nombres de la interfaz
```bash
sudo ip link set wlanX down
sudo iw dev wlanX set type monitor
sudo ip link set wlanX up
```

* Modo managed

```bash
sudo ip link set wlanX down
sudo iw dev wlanX set type managed
sudo ip link set wlanX up
```

* Verificar

```bash
iwconfig wlanX
```
* sinff o ataque

```bash
sudo airodump-ng wlanX
```
* Adicionales info

```bash
iw dev <interface> info
iwconfig <interface>
iw list
# borrar interface
iw <interface> del
ip link
```
```bash
iw list | grep -A 10 "Frequencies:"
# Captura en banda especifica
airodump-ng wlan0 --band abg
# Captura en canal especifico
airodump-ng -c 6 wlan0
```

