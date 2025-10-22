### CheatSheet: LDAP Tool Lightweight Directory Access Protocl

Notas rápidas sobre flags útiles
```bash
 -x → autenticación simple (sin SASL).

-H ldap://host o -H ldaps://host:636 → servidor (usar ldaps:// o -ZZ StartTLS si quieres cifrado).

-D "CN=Usuario,CN=Users,DC=dom,DC=local" → DN para bind.

-w "password" → contraseña (o -W para pedirla interactiva).

-b "dc=dom,dc=local" → Base DN (punto de inicio).

-s sub|one|base → scope: sub (por defecto), one (un nivel), base.

-LLL → salida limpia (sin comentarios ni encabezados).

-o ldif-wrap=no → (si está disponible) evita el wrapping en LDIF.

-Y GSSAPI → bind Kerberos/GSSAPI (sin -D/-w).

-z <n> → límite de resultados (si tu ldapsearch lo soporta).
```
#### Basicos:

* Buscar todos los usuarios:
```bash
ldapsearch -x -H ldap://DC.DOM.LOCAL -b "dc=dom,dc=local" "(objectClass=user)" sAMAccountName cn displayName -LLL
```
* Listar todos los grupos:
```bash
ldapsearch -x -H ldap://DC.DOM.LOCAL -b "dc=dom,dc=local" "(objectClass=group)" cn member -LLL
```
* Buscar miembros de un grupo:
```bash
ldapsearch -x -H ldap://DC.DOM.LOCAL -b "dc=dom,dc=local" "(&(objectClass=user)(memberOf:1.2.840.113556.1.4.1941:=CN=Domain Admins,CN=Users,DC=dom,DC=local))" sAMAccountName memberOf -LLL
```
* Obtener miembros recursivos:
```bash
ldapsearch -x -H ldap://DC.DOM.LOCAL -b "dc=dom,dc=local" "(&(objectClass=user)(memberOf:1.2.840.113556.1.4.1941:=CN=Domain Admins,CN=Users,DC=dom,DC=local))" sAMAccountName memberOf -LLL
```

#### Confirmar acceso con credenciales

* Probar credenciales validas:
```bash
ldapsearch -x -H ldap://DC.DOM.LOCAL -D "dom\\usuario" -w "MiPass" -b "dc=dom,dc=local" "(objectClass=*)" -s base -LLL
```
> Si devuelve entry(es) o no da error de bind => credenciales validas

* Para GSSAPI/Kerberos (si tenemos TGT)
```bash
ldapsearch -Y GSSAPI -H ldap://DC.DOM.LOCAL -b "dc=dom,dc=local" "(objectClass=*)" -LLL
```
#### Extaccion de info sensible

* Emails y nombres:
```bash
ldapsearch -x -H ldap://DC.DOM.LOCAL -b "dc=dom,dc=local" "(objectClass=user)" mail displayName sAMAccountName -LLL
```
* Cuentas privilegiadas / adminCount:
```bash
ldapsearch -x -H ldap://DC.DOM.LOCAL -b "dc=dom,dc=local" "(&(objectClass=user)(adminCount=1))" sAMAccountName memberOf -LLL
```
* Ultimo cambio de contraseña:
```bash
ldapsearch -x -H ldap://DC.DOM.LOCAL -b "dc=dom,dc=local" "(sAMAccountName=jdoe)" pwdLastSet lastLogonTimestamp -LLL
```
* Computadoras / equipos (util para movimiento lateral) 
```bash
ldapsearch -x -H ldap://DC.DOM.LOCAL -b "dc=dom,dc=local" "(objectClass=computer)" dNSHostName servicePrincipalName -LLL
```
Atributos importantes (filtrar solo lo necesario):
```bash
sAMAccountName,
userPrincipalName, 
cn, 
mail, 
memberOf, 
member, 
servicePrincipalName, 
pwdLastSet, 
lastLogonTimestamp, 
userAccountControl, 
adminCount
```
#### Preparación para propagación de credenciales y kerberos (SPNs / Kerberosting) 

* Buscar cuentas con SPNs (Potenciales targets para Kerberoast)
```bash
ldapsearch -x -H ldap://DC.DOM.LOCAL -b "dc=dom,dc=local" "(&(objectClass=user)(servicePrincipalName=*))" sAMAccountName servicePrincipalName userAccountControl -LLL
```
* Filtrar para excluir máquinas (excluir equipos con SPNs)
```bash
ldapsearch -x -H ldap://DC.DOM.LOCAL -b "dc=dom,dc=local" "(&(!(userAccountControl:1.2.840.113556.1.4.803:=8192))(servicePrincipalName=*))" sAMAccountName servicePrincipalName -LLL
```
> OID 1.2.840.113556.1.4.803 es LDAP_MATCHING_RULE_BIT_AND — usado para bit checks en userAccountControl. (Ej: 8192 is WORKSTATION_TRUST_ACCOUNT — ajustar según necesidad.)

* Encontrar cuentas Humanas:
```bash
ldapsearch -x -H ldap://DC.DOM.LOCAL -b "dc=dom,dc=local" "(&(objectClass=user)(mail=*)(!(userAccountControl:1.2.840.113556.1.4.803:=2)))" sAMAccountName mail -LLL
```
#### Filtros LDAP Comunes
```bash
(objectClass=user) — usuarios.

(objectClass=group) — grupos.

(sAMAccountName=jdoe) — buscar por username.

(mail=*@dom.com) — correos.

(servicePrincipalName=*) — SPNs.

(adminCount=1) — típicamente cuentas protegidas (mayor probabilidad de ser privilegiadas).

(!(userAccountControl:1.2.840.113556.1.4.803:=2)) — exclude disabled accounts.
```
