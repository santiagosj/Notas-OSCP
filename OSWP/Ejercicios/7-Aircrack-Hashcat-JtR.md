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

