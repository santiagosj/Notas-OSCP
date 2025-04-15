## 🕹️ Enumerar Sesiones Activas con Herramientas Externas - PSLoggedOn y similares

Esta referencia cubre herramientas externas a PowerView que pueden usarse para detectar usuarios logueados en sistemas Windows, útil durante el post-explotación y movimiento lateral.

---

### ⚡ Herramienta: **PsLoggedOn.exe** (Sysinternals)

#### 🔧 Descripción
Permite ver:
- Usuarios locales actualmente logueados
- Usuarios remotos con sesiones activas (por ejemplo, mediante SMB)

#### 🔺 Sintaxis Básica
```bash
PsLoggedOn.exe \\fileserver01
```

#### ⚡ Requisitos:
- Debes tener permisos de administrador en el host remoto.
- RPC debe estar accesible (puerto 445/tcp).
- No bloqueado por firewall o GPO.
- Necesitas estar en el mismo dominio o tener credenciales válidas.

#### 🔍 Ejemplo de uso en post-explotación:
```bash
PsLoggedOn.exe \\websrv03
```

Salida posible:
```
Users logged on locally:
  [websrv03]\Administrator

Users logged on remotely:
  [CORP]\juanperez from 10.10.20.8
```

---

### 📂 Alternativas Similares

#### **quser.exe**
Ver sesiones activas locales en terminal server:
```cmd
quser /server:websrv03
```

#### **query user** (alias de `quser` en cmd)
```cmd
query user /server:fileserver01
```

#### **Net Sessions** (nativo Windows)
```cmd
net session
```
> 💡 Solo muestra conexiones remotas SMB al equipo actual.

---

### 🔹 Consejos de uso
- Combina `PsLoggedOn` con scripts de enumeración para automatizar la detección de sesiones privilegiadas.
- Usa `PsExec` si necesitas ejecutar herramientas remotamente:
```bash
PsExec.exe \\target cmd.exe /c PsLoggedOn.exe
```

---

### 🌐 Descarga de PsLoggedOn
- Sitio oficial: https://learn.microsoft.com/en-us/sysinternals/downloads/psloggedon

---

🕵️‍♂️ Ideal para entornos donde PowerView o scripts avanzados están bloqueados. No requiere PowerShell.

