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

