✅** Delegation Abuse**

🎯 Requerimientos:

1. Máquinas/usuarios configurados con Delegación (Unconstrained o Constrained).

2. Permisos para ver atributos: trustedForDelegation, msDS-AllowedToDelegateTo.

🔍 Cómo reconocer:

* Unconstrained:

    netdom query /domain:<domain> trust

o:

    Get-ADComputer -Filter {TrustedForDelegation -eq $true}

* Constrained:

    Get-ADUser -Filter {msDS-AllowedToDelegateTo -ne $null}

⚡ Exploitar:

* Constrained: s4u2proxy → Impersonar usuarios.

* Unconstrained: Capturar TGTs almacenados en hosts delegados (Rubeus tgtdeleg).
