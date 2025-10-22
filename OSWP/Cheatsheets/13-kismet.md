# Kismet — Cheatsheet (completo, conciso)

Resumen rápido
- Kismet es un detector/sniffer de redes inalámbricas (Wi‑Fi, Bluetooth y otros) que registra redes, paquetes y metadatos, soporta sensores remotos (drones) y ofrece UI web y cliente ncurses.
- Ejecutarlo normalmente requiere privilegios root y una interfaz en modo monitor (o un adaptador compatible).

Instalación (Debian/Ubuntu)
- Instalar paquete oficial:
```bash
sudo apt update
sudo apt install kismet
```
- En algunas distros usar repositorio oficial de Kismet si se necesita la versión más reciente.

Preparación de la interfaz (modo monitor)
- Con airmon-ng (aircrack-ng suite):
```bash
sudo airmon-ng check kill
sudo airmon-ng start wlan0
# result: wlan0mon
```
- Con ip/iw (sin airmon-ng):
```bash
sudo ip link set wlan0 down
sudo iw dev wlan0 set type monitor
sudo ip link set wlan0 up
```
- Ver interfaces:
```bash
iw dev
ip link show
```

Arrancar Kismet
- Lanzar modo servidor + cliente (interactivo):
```bash
sudo kismet
```
- Especificar fuente (si ya está en modo monitor):
```bash
sudo kismet -c wlan0mon
```
- Ejecutar sólo servidor (daemon) y definir puerto/host:
```bash
sudo kismet_server --no-ncurses --log-prefix /ruta/logs
```
- Conectar cliente remoto:
```bash
kismet_client <host>:<puerto>
```

Fuentes / sensores
- Sintaxis simple al pasar fuente:
```bash
-c <source>
# ejemplo: -c wlan0mon
```
- Fuentes remotas (drone): instalar kismet_drone en sensor remoto y conectar al servidor.
- Drones permiten distribuir captura/conteo de canales sin enviar pcap bruto (según configuración y banda).

Logs y formatos
- Carpetas comunes de logs: ~/.kismet o /var/log/kismet (depende de la instalación).
- Formatos generados típicos:
    - .kismet.csv (resumen)
    - .kismet.netxml (detalles de red)
    - .kismet.pcap / .pcapng (trazas de paquetes)
    - kismet.db (base de datos SQLite)
- Abrir PCAP con Wireshark:
```bash
wireshark /ruta/archivo.pcap
```

Exportar y convertir
- Usar la interfaz web de Kismet para exportar pcap/netxml/csv.
- Herramientas incluidas (según instalación) permiten convertir logs a otros formatos; consultar kismet package tools.

GPS / geolocalización
- Integración con gpsd (recomendada):
```bash
sudo apt install gpsd gpsd-clients
sudo systemctl start gpsd
# configurar kismet para usar gpsd (en kismet.conf o vía web UI)
```
- Kismet añadirá coordenadas a redes/paquetes si el GPS está disponible.

Filtros y captura selectiva
- Para evitar capturar todo, poner la interfaz en un canal fijo antes de arrancar:
```bash
sudo iw dev wlan0mon set channel 6
```
- En Kismet se pueden configurar filtros y alertas desde kismet.conf o la UI (cadena pcap, listas de SSID a ignorar, etc.). Revisar la documentación local para la sintaxis exacta.

Interfaz web y ncurses
- Acceder a la UI web en http://<host>:2501/ (puerto por defecto, confirmar en logs).
- Cliente ncurses (kismet_client) ofrece navegación y vistas rápidas de redes, clientes y paquetes.

Configuración básica (kismet.conf)
- Archivos típicos: /etc/kismet/kismet.conf o ~/.kismet/kismet.conf
- Elementos útiles:
    - set source para declarar antenas/fuentes
    - set gps=true / gpsd_host
    - set logprefix=/ruta/logs
- Ejemplo mínimo (conceptual):
```bash
# kismet.conf (ejemplo)
logprefix=/home/usuario/kismet-logs
source=wlan0mon
gps=true
```

Uso con drones (sensores remotos)
- En sensor remoto:
```bash
sudo kismet_drone
# o usar systemd unit según packaging
```
- En servidor: añadir drone por hostname/puerto en la UI o config, el servidor consumirá los datos del drone.

Alertas y detección
- Kismet soporta reglas/alertas para:
    - nuevos APs, SSID ocultos, clientes sospechosos, cambios de canal, WPS, etc.
- Configurables desde kismet.conf o la UI.

Comandos útiles
- Ver versión:
```bash
kismet --version
```
- Ver ayuda:
```bash
kismet --help
kismet_server --help
kismet_client --help
```
- Listar interfaces y capacidades:
```bash
iw dev
iw phy
```
- Reiniciar servicio/systemd:
```bash
sudo systemctl restart kismet
sudo systemctl status kismet
```

Análisis post-captura
- Abrir pcap con Wireshark/tshark.
- Filtrar por MAC/SSID en la CSV/NETXML para análisis offline.
- Usar kismet.db (SQLite) para consultas con sqlite3 si necesita extraer datos programáticamente.

Permisos y seguridad
- Ejecutar como root o con capacidades suficientes para modo monitor.
- Cuidado con mantener interfaces en modo monitor en máquinas de producción.
- Logs pueden contener información sensible (SSIDs, ubicaciones, clientes).

Problemas comunes / soluciones rápidas
- No se detectan redes: comprobar modo monitor, país/región, y que la tarjeta soporta la banda.
- Web UI inaccesible: confirmar puerto en logs y firewall/iptables.
- Interfaz cae al cambiar canal: probar driver/firmware y actualizar kernel o usar otro adaptador.

Recursos y buena práctica
- Mantener Kismet actualizado.
- Usar sensores distribuidos (drones) para cobertura.
- Respetar la legalidad y la privacidad: capturar redes y tráfico sin autorización puede ser ilegal.

Atajos: checklist rápido antes de capturar
1. Poner adaptador en modo monitor.
2. Arrancar gpsd si usar GPS.
3. Arrancar kismet_server / kismet.
4. Verificar que la UI muestra interfaces/drones.
5. Iniciar logging y comprobar archivos de salida.
6. Exportar PCAP para análisis en Wireshark si es necesario.

Fin del cheatsheet — referirse a la documentación oficial para detalles avanzados y opciones específicas de versión.