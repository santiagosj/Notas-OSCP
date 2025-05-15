# Enumeración para Port Forwarding en Windows

## Información del sistema y usuario

```cmd
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type"
whoami
whoami /priv
whoami /groups
hostname
```

## Configuración de red

```cmd
ipconfig /all
route print
netstat -ano
arp -a
```

## Conexiones activas y puertos

```cmd
netstat -ano | findstr "LISTENING ESTABLISHED"
netstat -anob
```

## Reglas de firewall

```cmd
netsh advfirewall show currentprofile
netsh advfirewall firewall show rule name=all | findstr "Name Description" | findstr /v "Display"
```

## Pruebas de conectividad externa

```cmd
# Probar conectividad a servidor remoto (sustituir con IP/puerto relevante)
Test-NetConnection -ComputerName 10.10.10.10 -Port 22
Test-NetConnection -ComputerName 10.10.10.10 -Port 80
Test-NetConnection -ComputerName 10.10.10.10 -Port 443
Test-NetConnection -ComputerName 10.10.10.10 -Port 3389

# Alternativa sin PowerShell
ping 10.10.10.10
telnet 10.10.10.10 22
```

## Software instalado

```cmd
wmic product get name,version
dir "C:\Program Files" /b
dir "C:\Program Files (x86)" /b
```

## Verificar restricciones de ejecución

```cmd
# Verificar políticas de restricción de software
gpresult /h restricciones.html
```

## Verificar procesos y servicios

```cmd
tasklist /v
wmic process list full
sc query
```

## Carpetas compartidas y sesiones de red

```cmd
net share
net session
net use
```

## Verificar hosts alcanzables en la red interna

```cmd
# Escanear subredes internas (ejemplo para 192.168.1.0/24)
for /L %i in (1,1,254) do @ping -n 1 -w 100 192.168.1.%i | findstr "TTL"

# Alternativa con PowerShell
1..254 | ForEach-Object { Test-Connection -ComputerName "192.168.1.$_" -Count 1 -Quiet }
```

## Verificar presencia de herramientas

```cmd
where plink.exe
where ssh.exe
where putty.exe
where nc.exe
where ncat.exe
```

## Comprobar si hay proxies configurados

```cmd
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" | findstr "ProxyServer ProxyEnable"
netsh winhttp show proxy
```

## Políticas de grupo aplicadas

```cmd
gpresult /r
```
