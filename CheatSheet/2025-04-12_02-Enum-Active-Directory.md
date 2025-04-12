## 💡 Cheatsheet: Enumeración de Active Directory con Clases .NET en PowerShell

### 📍 Información de Dominio y Controlador de Dominio

```powershell
# Obtener el nombre del controlador de dominio principal (PDC)
[System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().PdcRoleOwner.Name
```

```powershell
# Obtener el DistinguishedName del dominio actual
([ADSI]'').distinguishedName
```

```powershell
# Construir ruta LDAP al dominio
$PDC = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().PdcRoleOwner.Name
$DN = ([ADSI]'').distinguishedName
$LDAP = "LDAP://$PDC/$DN"
```

### 🔍 Realizar Búsqueda Básica en el Directorio

```powershell
$direntry = New-Object System.DirectoryServices.DirectoryEntry($LDAP)
$dirsearcher = New-Object System.DirectoryServices.DirectorySearcher($direntry)
$results = $dirsearcher.FindAll()
```

```powershell
# Mostrar todos los resultados
foreach ($result in $results) {
    $result.Properties
}
```

### 🌟 Filtros Específicos para Objetos Comunes

```powershell
# Buscar todos los usuarios
$dirsearcher.Filter = "(&(objectCategory=person)(objectClass=user))"
```

```powershell
# Buscar todos los grupos
$dirsearcher.Filter = "(objectClass=group)"
```

```powershell
# Buscar todos los equipos
$dirsearcher.Filter = "(objectClass=computer)"
```

```powershell
# Buscar usuarios con privilegios (miembros de Domain Admins)
$dirsearcher.Filter = "(&(objectClass=user)(memberOf=CN=Domain Admins,CN=Users,$DN))"
```

### 📋 Leer Atributos Comunes

```powershell
foreach ($result in $dirsearcher.FindAll()) {
    $props = $result.Properties
    Write-Host "Usuario: $($props['samaccountname']) - Nombre: $($props['name']) - Correo: $($props['mail'])"
}
```

### 🛠 Otros Ejemplos Útiles

#### 🧑‍💼 Obtener todos los grupos a los que pertenece un usuario

```powershell
$user = [ADSI]"LDAP://CN=jeff,CN=Users,$DN"
$user.memberOf
```

#### 🖥 Obtener computadoras del dominio

```powershell
$dirsearcher.Filter = "(objectClass=computer)"
$dirsearcher.PropertiesToLoad.Add("name") | Out-Null
$dirsearcher.FindAll() | ForEach-Object {
    $_.Properties["name"]
}
```

#### 📂 Listar todas las unidades organizativas (OUs)

```powershell
$dirsearcher.Filter = "(objectClass=organizationalUnit)"
$dirsearcher.FindAll() | ForEach-Object {
    $_.Properties["ou"]
}
```

### ⚠️ Tips para Escaneos Grandes

```powershell
# Activar paginación para evitar límites en dominios grandes
$dirsearcher.PageSize = 1000
```

```powershell
# Especificar propiedades a cargar
$dirsearcher.PropertiesToLoad.Add("samaccountname")
$dirsearcher.PropertiesToLoad.Add("mail")
```


