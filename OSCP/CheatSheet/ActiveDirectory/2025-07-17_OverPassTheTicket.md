✅ 3️⃣ Over-Pass-the-Ticket (Pass-the-Key)

🎯 Requerimientos:

1. Hash NTLM de una cuenta de dominio.

2. Acceso a una máquina donde se puedan inyectar tickets (mimikatz, Rubeus).

3. Herramientas: sekurlsa::pth (Mimikatz).

🔍 Cómo reconocer:

    1. Credenciales obtenidas sin ticket (ejemplo: dump de NTLM).

    2. Sin TGT pero con NTLM, se puede generar TGT válido con Over-Pass.

⚡ Exploitar:

    sekurlsa::pth /user:USERNAME /domain:DOMAIN /ntlm:HASH /run:cmd.exe

> Esto inyecta un TGT generado con el hash NTLM.
