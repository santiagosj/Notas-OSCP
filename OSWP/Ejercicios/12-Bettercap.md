# Ejercicios

### A

1. Instale e inicie bettercap. Ejecute los comandos "help" y "clear". Una vez completado, cierre bettercap.

### B

1. Utilice el **módulo wifi.recon** bettercap para detectar puntos de acceso cercanos. 
2. Reconfigure el módulo de reconocimiento para que solo escanee los canales 1, 2 y 3. 
> Si no detecta nada, configure su punto de acceso para que transmita en uno de esos canales y vuelva a escanear.

### C

1. Conecte dos clientes a su punto de acceso y desautentique ambos proporcionando el BSSID. Una vez completado el proceso, intente desautenticar solo un cliente, pero esta vez utilice un ticker para ejecutar la desautenticación cada 10 segundos y así garantizar que se capture el protocolo de enlace.

### D

1. Recrea el script de desautenticación localmente y ejecútalo contra un cliente y un punto de acceso que controles.
2. En el script de desautenticación, cambia la ubicación de la captura de paquetes del protocolo de enlace a una ubicación diferente a tu elección.

3. Crea un caplet para inyectar balizas en el canal 3 con el SSID "WiFu" y sin cifrado. 
>La documentación de bettercap te será útil durante este ejercicio. Dado que bettercap no proporciona un servidor DHCP, los clientes podrían conectarse y desconectarse poco después al no recibir una dirección IP.

### E 
Usa la interfaz web para descubrir los puntos de acceso a tu alrededor. Una vez descubiertos, usa la interfaz web para hacer lo siguiente:

1. Cambie la ruta donde se almacenan los archivos del protocolo de enlace (handshake).
2. Desautenticar un cliente.
3. Capture un handshake WPA.
