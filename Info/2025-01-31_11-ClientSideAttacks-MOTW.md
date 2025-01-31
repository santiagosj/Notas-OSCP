
### **MOTW (Mark of the Web) y sus mecanismos de seguridad**

**Mark of the Web (MOTW)** es una característica de seguridad en Windows que ayuda a proteger a los usuarios contra la ejecución de archivos potencialmente peligrosos descargados de Internet o de ubicaciones no confiables. Funciona agregando un metadato al archivo que indica su procedencia, lo que permite a Windows y a ciertas aplicaciones aplicar restricciones de seguridad adicionales.

----------

## **🔹 ¿Cómo funciona MOTW?**

Cuando un archivo es descargado desde Internet o copiado desde una fuente no confiable (como un correo electrónico o una unidad de red), Windows le añade un _Alternate Data Stream (ADS)_ llamado `Zone.Identifier`, que pertenece a **NTFS**. Este ADS contiene información sobre la zona de seguridad de la que proviene el archivo.

📌 **Ejemplo del ADS "Zone.Identifier" en un archivo descargado:**  
Si descargas un archivo `malicious.docx` desde Internet, el sistema añade un ADS con información como esta:

```
[ZoneTransfer] 
ZoneId=3
```
🔹 **Explicación de los valores de ZoneId:**

-   `ZoneId=0` → Zona Local (archivo generado localmente).
-   `ZoneId=1` → Zona de Intranet (dentro de una red confiable).
-   `ZoneId=2` → Zona de sitios de confianza.
-   `ZoneId=3` → **Zona de Internet (descargado desde la web, correo, etc.).**
-   `ZoneId=4` → Zona restringida (contenido de alto riesgo).

Cuando un archivo tiene `ZoneId=3` o `ZoneId=4`, Windows aplica protecciones adicionales, como:  
✔ Bloquear la ejecución de macros en archivos de Office.  
✔ Mostrar advertencias de seguridad al abrir el archivo.  
✔ Aplicar políticas de restricción en Microsoft Defender SmartScreen.

----------

## **🔹 Formatos que pueden contener MOTW**

Para que un archivo sea afectado por MOTW, debe estar en un formato compatible con ADS en NTFS o contener metadatos internos que almacenen la marca de procedencia. Algunos formatos que pueden incluir MOTW son:

✅ **Archivos que soportan ADS (NTFS)**

-   `.exe`, `.dll` (ejecutables y librerías).
-   `.msi` (instaladores de Windows).
-   `.zip`, `.7z`, `.rar` (archivos comprimidos, pero el contenido puede perder la marca si se extrae con herramientas de terceros).
-   `.js`, `.vbs`, `.ps1` (scripts de JavaScript, VBScript y PowerShell).

✅ **Documentos de Microsoft Office (internamente con XML)**

-   `.docx`, `.xlsx`, `.pptx` (Word, Excel, PowerPoint).
    -   Office revisa el origen del archivo y bloquea macros si proviene de Internet.

✅ **Archivos PDF**

-   Algunos lectores PDF pueden reconocer MOTW y activar restricciones de seguridad.

----------

## **🔹 Cómo se puede manipular o evitar MOTW**

🔍 **Eliminar la marca de MOTW manualmente:**

-   Haciendo _clic derecho → Propiedades_ en el archivo y seleccionando _"Desbloquear"_.
-   Copiando el archivo a un sistema de archivos que no soporte ADS (por ejemplo, FAT32).

🛠 **Técnicas utilizadas por atacantes para evadir MOTW:**

1.  **Recomprimir archivos**: Si el usuario extrae un `.zip` usando herramientas de terceros como `7-Zip`, la marca puede perderse.
2.  **Uso de contenedores alternativos**: Como `.iso`, `.vhd`, o `.img` (cuando un archivo está dentro de un disco virtual, al montarlo puede no heredar MOTW).
3.  **Copiar a otro sistema de archivos**: Si el archivo es movido a una unidad con formato FAT32, MOTW se pierde porque FAT32 no soporta ADS.
4.  **Crear un archivo desde código**: Un malware puede generar un archivo ejecutable en el sistema sin que tenga MOTW, ya que no fue descargado.

----------

## **🔹 Protección contra amenazas que abusan de MOTW**

💡 **Recomendaciones para mejorar la seguridad:**  
✔ Configurar políticas de seguridad en Microsoft Defender SmartScreen para bloquear archivos con `ZoneId=3`.  
✔ Usar software de descompresión que mantenga la marca MOTW en archivos extraídos.  
✔ Aplicar reglas de ejecución restringida en PowerShell y Group Policy para bloquear ejecución de scripts con MOTW.  
✔ Educar a los usuarios para no desbloquear archivos sin verificación previa.

----------

### **📌 Conclusión**

MOTW es una capa de seguridad clave en Windows que protege a los usuarios de la ejecución de archivos descargados de fuentes no confiables. Sin embargo, hay varias maneras de evadirlo, lo que lo convierte en un mecanismo útil pero no infalible. La combinación de MOTW con otras medidas como SmartScreen y restricción de macros ayuda a reducir los riesgos de seguridad.
