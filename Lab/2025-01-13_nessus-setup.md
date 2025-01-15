# {Laboratorio}: {Se Configura Nessus}

## Fecha: 13/01/20225
## Host: {HOST} NA
## IP: {IP} NA

---

## Objetivo
Instalar Nessus

---
## Herramientas
1. echo 
2. systemctl
3. sha256sum
---
## Procedimiento y comandos
1. Paso 1: Descargamos el **.deb** de la pagina oficial de Nessus y copiamos el **checksum** sha256
2. Paso 2: Generamos con echo el archivo sha256-checksum --> echo "checksum Nessus-filename.deb" > sha256-checksum 
3. Paso 3: Instalamos Nessus: sudo apt install ./Nessus-filename.deb
4. Paso 4: Activamos los servicios de Nessus: sudo systemctl start nessusd.service
5. Paso 5: Seguimos las instrucciones, seleccoinamos "Essencials", creamos un Usuario y luego esperamos a que los plugins esten instalados.
---
## Troubleshooting
1. Si la memoria de almacenamiento no es suficiente la compilacion de los plugins complicara el desempeno del sistema.
---

## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

