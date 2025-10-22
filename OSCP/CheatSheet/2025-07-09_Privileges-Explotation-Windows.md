## Lista de posibles privilegios explotables en Windows

Estructura:

* Privilegio a explotar
* Herramienta de exploit por defecto o conocida
* Servicio/condiciones necesarias para la explotación
* Troubleshooting práctico

---

### 1) SeImpersonatePrivilege

**Exploit:** LPE por impersonación de token SYSTEM.

**Herramientas:**

* PrintSpoofer.exe
* JuicyPotato / RoguePotato / GhostPotato / HotPotato
* BadPotato (bypass de algunos EDR)

**Servicio necesario:**

* spooler (Print Spooler)
* rpcss u otros servicios con SYSTEM que usen Named Pipes

**Troubleshooting:**

* Si spooler está detenido:

```powershell
Set-Service -Name spooler -StartupType Automatic
Start-Service -Name spooler
```

* Verificar privilegios:

```powershell
whoami /priv
```

---

### 2) SeAssignPrimaryTokenPrivilege

**Exploit:** LPE con Potato Suite modificado / Token Manipulation.

**Herramientas:**

* Tokenvator
* PrintSpoofer modificado

**Servicio necesario:**

* Servicio vulnerable que acepte duplicación de token primario.

**Troubleshooting:**

* Confirmar privilegio con `whoami /priv`.
* Probar forks específicos de PrintSpoofer para este privilegio.

---

### 3) SeBackupPrivilege

**Exploit:** Leer archivos inaccesibles (NTDS.dit, SYSTEM, SAM).

**Herramientas:**

* robocopy
* ntbackup
* DiskShadow\.exe

**Servicio necesario:**

* Ninguno específico, pero habilitar VSS para `DiskShadow`.

**Troubleshooting:**

* Verificar espacio en disco.
* Listar VSS writers:

```powershell
vssadmin list writers
```

---

### 4) SeRestorePrivilege

**Exploit:** Reemplazar archivos protegidos del sistema (DLL hijacking, backdoor en binarios).

**Herramientas:**

* robocopy
* takeown + icacls

**Servicio necesario:**

* Depende del binario objetivo.

**Troubleshooting:**

* Usar robocopy en modo backup/restore:

```powershell
robocopy D:\backdoor C:\windows\system32 backdoor.dll /b
```

---

### 5) SeDebugPrivilege

**Exploit:** Inyección de DLL o acceso a procesos protegidos.

**Herramientas:**

* Mimikatz
* Process Hacker

**Servicio necesario:**

* Acceso a lsass o procesos SYSTEM.

**Troubleshooting:**

* Habilitar privilegios si es necesario mediante `secedit`.

---

### 6) SeLoadDriverPrivilege

**Exploit:** Cargar drivers maliciosos para LPE.

**Herramientas:**

* DSEFix
* Exploits de drivers vulnerables (capcom.sys, gdrv.sys)

**Servicio necesario:**

* Firma del driver en sistemas modernos.

**Troubleshooting:**

* Comprobar HVCI, deshabilitar si el entorno lo permite.

---

### 7) SeTakeOwnershipPrivilege

**Exploit:** Tomar control de archivos o claves de registro restringidos.

**Herramientas:**

* takeown
* icacls

**Servicio necesario:**

* Ninguno.

**Troubleshooting:**

```powershell
takeown /f C:\Windows\System32\cmd.exe
icacls C:\Windows\System32\cmd.exe /grant usuario:F
```

---

### 8) SeRemoteShutdownPrivilege

**Exploit:** Permite realizar DoS (no escalada de privilegios).

---

### 9) SeTcbPrivilege

**Exploit:** Permite ejecución de código como SYSTEM (raro encontrarlo habilitado).

**Herramientas:**

* Explotación personalizada.

**Troubleshooting:**

* Verificar que realmente esté habilitado en `whoami /priv`.

---

## Tabla Resumen

| Privilegio                    | Exploit/Herramienta          | Servicio/Condición  | Troubleshooting               |
| ----------------------------- | ---------------------------- | ------------------- | ----------------------------- |
| SeImpersonatePrivilege        | PrintSpoofer, Potato Suite   | spooler / RPC       | Start spooler, `whoami /priv` |
| SeAssignPrimaryTokenPrivilege | Tokenvator, PrintSpoofer mod | Servicio vulnerable | Confirmar privilegio          |
| SeBackupPrivilege             | DiskShadow, robocopy         | Habilitar VSS       | Verificar espacio, writers    |
| SeRestorePrivilege            | robocopy, takeown            | Depende del binario | Usar robocopy en /b           |
| SeDebugPrivilege              | Mimikatz, Process Hacker     | Acceso a SYSTEM     | Elevar privilegio con secedit |
| SeLoadDriverPrivilege         | DSEFix, exploits driver      | Firma driver        | Comprobar HVCI                |
| SeTakeOwnershipPrivilege      | takeown, icacls              | Ninguno             | takeown + icacls              |
| SeRemoteShutdownPrivilege     | -                            | -                   | Solo DoS                      |
| SeTcbPrivilege                | Exploit personalizado        | Raro activo         | Verificar habilitado          |

---

Si deseas, puedo preparar un **script en PowerShell que detecte automáticamente qué privilegios tienes y recomiende el exploit adecuado según el entorno**, facilitando la priorización de vectores en tus labs OSCP, HTB, PG y entornos reales de pentesting.
