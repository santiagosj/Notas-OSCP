### 🛠️ Técnicas de Port Forwarding con Chisel y Ligolo-ng
#### 📌 1. Chisel

Chisel es una herramienta para tunelizar tráfico TCP a través de HTTP/HTTPS. Ideal para entornos donde solo se permite tráfico web saliente.
🔁 Reverse Port Forwarding (RPF)

> Acceder desde Kali a un puerto interno de una red remota (pivoting clásico).

1. Servidor (Kali):
```bash
chisel server -p 8000 --reverse
```
2. Cliente (host comprometido):
```bash
chisel client <KALI_IP>:8000 R:4444:10.10.10.1:445
```
Esto hace que en Kali puedas acceder a 10.10.10.1:445 mediante localhost:4444.
🔀 Forward Port Forwarding (FPF)

> Exponer un puerto local al equipo remoto.

1. Servidor (host remoto):

```bash
chisel server -p 8000
```

2. Cliente (Kali):

```bash
chisel client <REMOTE_IP>:8000 L:8080:127.0.0.1:80
```

Permite al host remoto acceder al localhost:80 de Kali mediante su localhost:8080.
📥 SOCKS Proxy

    Crear un proxy SOCKS5 para exploración dinámica (uso con proxychains o herramientas que soporten SOCKS).

Servidor:

chisel server -p 8000 --socks5

Cliente:

chisel client <KALI_IP>:8000 socks

[https://exploit-notes.hdks.org/exploit/network/port-forwarding/chisel/](HDKS - Chisel Port Forwarding Guide)

#### 📝 SSH Port Forwarding Cheatsheet
1. Local Port Forwarding (L → R)

*  Redirige un puerto local hacia un destino accesible desde el servidor remoto.
👉 Se usa cuando querés acceder desde tu máquina a un servicio interno de la red remota.

```bash
ssh -L [puerto_local]:[host_destino]:[puerto_destino] usuario@servidor
```

Ejemplos:

Acceder a MySQL en una red remota:

```bash
ssh -L 3306:127.0.0.1:3306 user@remote_host
```

👉 Ahora podés conectarte a localhost:3306 como si fuera el MySQL del servidor remoto.

Redirigir un sitio web interno de la red remota:

```bash
ssh -L 8080:intranet.local:80 user@remote_host
```

👉 Abrís en tu navegador http://localhost:8080.

2. Remote Port Forwarding (R → L)

Expone un puerto del servidor remoto hacia tu máquina local (o a un host accesible desde ella).
👉 Útil para acceder a tu servicio local desde fuera.

```bash
ssh -R [puerto_remoto]:[host_local]:[puerto_local] usuario@servidor
```

Ejemplos:

Exponer tu servidor web local (puerto 8000) en un VPS remoto:

```bash
ssh -R 8080:127.0.0.1:8000 user@remote_host
```

👉 Desde el servidor remoto, accedés a localhost:8080 y ves tu web local.

Dar acceso externo (requiere GatewayPorts yes en sshd_config):

```bash
ssh -R 0.0.0.0:8080:127.0.0.1:8000 user@remote_host
```

👉 Otros pueden acceder a http://remote_host:8080.

3. Dynamic Port Forwarding (SOCKS Proxy)

Crea un proxy SOCKS5 en tu máquina local, que redirige tráfico hacia cualquier host a través del servidor SSH.
👉 Útil para túneles tipo VPN.

```bash
ssh -D [puerto_local] usuario@servidor
```

Ejemplo:

```bash
ssh -D 1080 user@remote_host
```

👉 Configurás en tu navegador un SOCKS5 proxy en localhost:1080.
Opcional: usar proxychains para tunelizar cualquier programa:

```bash
proxychains nmap -sT 10.10.10.10
```

4. Reverse SOCKS Proxy (más avanzado)

Si queremos crear un SOCKS proxy en el servidor remoto para salir por tu máquina:

```bash
ssh -R 1080 user@remote_host -N -D 1080
```

5. Opciones útiles

```bash
-N: No abrir shell, solo el túnel.

-f: Ejecutar en background.

-v: Verbose, útil para debug.

-C: Habilitar compresión.

-g: Permitir que otros accedan al túnel.
```

Ejemplo:

```bash
ssh -f -N -L 8080:intranet.local:80 user@remote_host
```

6. Resumen Visual

| Tipo    | Opción | Dirección      | Ejemplo                                     |
| ------- | ------ | -------------- | ------------------------------------------- |
| Local   | `-L`   | Local → Remoto | `ssh -L 8080:intranet.local:80 user@remote` |
| Remote  | `-R`   | Remoto → Local | `ssh -R 8080:127.0.0.1:8000 user@remote`    |
| Dynamic | `-D`   | Proxy (SOCKS)  | `ssh -D 1080 user@remote`                   |


