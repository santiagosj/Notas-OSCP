# Ejercicios

### A 4.1.1

1. Conecte su tarjeta inalámbrica y active el modo monitor.
2. Abra Wireshark y comience a capturar tramas. 
3. Habilite la barra de herramientas inalámbrica y alterne entre los canales 1, 6 y 11.
4. Guarde el archivo de captura para usarlo más adelante.

### B 4.2.1

1. Configure su punto de acceso de laboratorio para usar cifrado WPA, ya sea con TKIP o CCMP (a veces se muestra como AES). Asegúrese de que su tarjeta inalámbrica esté en modo monitor en el mismo canal que su punto de acceso.

2. Con una captura en ejecución, cree un filtro de visualización para el BSSID de su punto de acceso de laboratorio. El BSSID suele estar impreso en una etiqueta adhesiva en la parte posterior del punto de acceso, pero también puede encontrarlo en los marcos buscando marcos Beacon con su SSID.

### B 4.2.2
Iniciar una captura de paquetes en Wireshark con un filtro de captura para:

1. Beacons
2. Probes (requests and responses)
3. Association (requests and responses)
4. Data (any)
5. A specific MAC address

1. Beacons  
    - Filtro de captura (BPF): `wlan type mgt subtype beacon`  
    - Uso: pegar en "Capture Filter" antes de iniciar la captura (o `-f "wlan type mgt subtype beacon"` en la línea de comandos).

2. Probes (requests and responses)  
    - Filtro de captura: `(wlan type mgt subtype probe-req) or (wlan type mgt subtype probe-resp)`

3. Association (requests and responses)  
    - Filtro de captura: `(wlan type mgt subtype assoc-req) or (wlan type mgt subtype assoc-resp)`

4. Data (any)  
    - Filtro de captura: `wlan type data`

5. A specific MAC address  
    - Filtro de captura: `wlan host AA:BB:CC:DD:EE:FF`  
    - Reemplaza `AA:BB:CC:DD:EE:FF` por la dirección MAC objetivo. Si estás capturando en modo no monitor (tramas Ethernet), usa `ether host AA:BB:CC:DD:EE:FF`.

Notas rápidas:
- Estos son filtros de captura (BPF). Para búsquedas más flexibles después de capturar usar filtros de visualización de Wireshark (por ejemplo `wlan.fc.type_subtype == 0x08` para beacons).
- Corroborar que la interfaz esté en modo monitor si requerimos ver tramas 802.11 nativas y usar la interfaz correcta al iniciar la captura.
- Podemos combinar filtros con `and`, `or`, y paréntesis según necesitemos (por ejemplo `wlan type mgt and (subtype beacon or subtype probe-resp)`).

### C 4.3.1

Inicie Wireshark desde la línea de comandos con las siguientes opciones:

1. Initiate immediate capture with your wireless interface.
2. Initiate immediate capture and place your wireless interface in monitor mode.
3. Initiate immediate capture with a capture filter.
4. Open a .pcap file.

### D 4.4.1

1. Usando un pipe sin nombre, ejecute `tcpdump` con su dispositivo inalámbrico y diríjalo a Wireshark.
2. Usando un pipe  con nombre, ejecute `tcpdump` con su dispositivo inalámbrico y diríjalo a Wireshark.
3. Inicie un comando `tcpdump` SSH remoto y envíe la captura a Wireshark. Esto puede ejecutarse a través del host local, a otra máquina virtual o a otro sistema con acceso SSH.

### F

1. Abra wpa-Induction.pcap y habilite las reglas de coloración con las reglas disponibles en el sitio web de Wireshark. Localice e identifique las tramas de autenticación (rosa), asociación (azul claro y verde claro) y las cuatro EAPoL (verde oscuro). Todas estas tramas deben estar cerca.
2. Usando filtros de visualización, use "eapol" para localizar las tramas EAPoL y "wlan.fc.type_subtype in {0x0 0x1 0xb}" para localizar las tramas de solicitud/respuesta de asociación y autenticación.
3. Agregue una columna para la velocidad de datos, que se encuentra en la información de radio 802.11, y busque tramas con una velocidad de 54 Mbit.
4. Configure un punto de acceso WPA con una frase de contraseña de su elección que contenga caracteres especiales. Inicie una captura de paquetes y conecte un dispositivo. Navegue por la web un rato y luego detenga la captura.

