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
