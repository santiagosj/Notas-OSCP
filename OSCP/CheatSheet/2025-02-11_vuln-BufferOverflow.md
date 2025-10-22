# Buffer Overflow Cheat Sheet

## 🔢 Conceptos Clave

**Buffer Overflow** ocurre cuando un programa escribe más datos en un buffer de los que este puede contener, sobrescribiendo memoria adyacente y potencialmente alterando el flujo de ejecución.

### Terminología Esencial

-   **EIP (Extended Instruction Pointer)**: Registro que indica la siguiente instrucción a ejecutar. Al sobrescribirlo, podemos redirigir el flujo del programa.
-   **ESP (Extended Stack Pointer)**: Registro que apunta al tope del stack, donde suelen ubicarse los datos inyectados.
-   **JMP ESP**: Instrucción (ff e4 en hexadecimal) que salta a la dirección contenida en ESP, comúnmente usada para ejecutar shellcode en la pila.
-   **NOP Sled**: Serie de instrucciones `NOP` ( en hexadecimal) que no hacen nada y facilitan la ejecución del shellcode al aumentar la superficie de aterrizaje.
-   **Shellcode**: Código malicioso en ensamblador que proporciona acceso al sistema, como una reverse shell.
-   **SEH (Structured Exception Handler)**: Mecanismo de manejo de excepciones en Windows, explotado en ciertos tipos de buffer overflow.


## 🔎 Técnicas de Enumeración y Detección

1.  **Fuzzing**:
    
    -   Enviar datos aleatorios o patrones controlados para identificar crasheos.
    -   Herramientas: `Boofuzz`, `Peach Fuzzer`, `Spike`.
2.  **Identificación de Offsets**:
    
    -   Usar patrones únicos (“pattern_create” de Metasploit) para localizar la posición exacta que sobrescribe EIP.
3.  **Revisar Protecciones**:
    
    -   **DEP (Data Execution Prevention)**: Previene la ejecución de código en ciertas secciones de memoria.
    -   **ASLR (Address Space Layout Randomization)**: Aleatoriza las direcciones de memoria para dificultar la explotación.
    -   Herramientas: `checksec`, `!mona modules` en Immunity Debugger.
4.  **Debugging**:
    
    -   Herramientas: `Immunity Debugger`, `GDB`, `WinDbg`.
    -   Uso de breakpoints y seguimiento de registros.


## 🤖 Técnicas de Explotación

1.  **Explotación Básica**:
    
    -   Identificar el offset que sobrescribe EIP.
    -   Insertar una dirección que apunte a un `JMP ESP` o `CALL ESP`.
    -   Agregar un NOP sled y el shellcode.
2.  **Return-to-libc**:
    
    -   Redirigir el flujo a funciones ya existentes en la memoria, como `system()`.
    -   Útil cuando DEP está habilitado.
3.  **ROP (Return Oriented Programming)**:
    
    -   Uso de "gadgets" (órdenes cortas) que ya existen en la memoria para construir una cadena que evite DEP.
4.  **Explotación SEH**:
    
    -   Sobrescribir la estructura de manejo de excepciones para redirigir el flujo.
    -   Común en entornos Windows.
5.  **Bypass de Protecciones**:
    
    -   **DEP**: Uso de ROP o shellcode que llama a `VirtualProtect()` para marcar memoria como ejecutable.
    -   **ASLR**: Encontrar módulos sin ASLR o usar bruteforce.


## 🔧 Herramientas

-   **Metasploit Framework**: `pattern_create`, `pattern_offset`, `msfvenom`.
-   **Immunity Debugger + Mona.py**: Automatización del análisis de buffer overflows.
-   **GDB + PEDA**: Debugging en entornos Linux.
-   **Wireshark**: Análisis de tráfico para entender la comunicación del exploit.


## 📖 Ejemplo de Exploit Básico en C

```c
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char shellcode[] =
"\x90\x90\x90..." // NOP sled seguido del shellcode
"\xcc\xcc\xcc";   // INT3 para debugging

unsigned char retn[] = "\xcb\x75\x52\x73"; // JMP ESP en msvbvm60.dll

int main() {
    char buffer[512];
    memset(buffer, '\x90', 512); // Relleno con NOPs
    memcpy(buffer + 260, retn, 4); // Sobrescribe EIP
    memcpy(buffer + 264, shellcode, sizeof(shellcode));
    
    FILE *exploit = fopen("exploit.txt", "w");
    fwrite(buffer, sizeof(buffer), 1, exploit);
    fclose(exploit);
    
    printf("Exploit generado!\n");
    return 0;
}

```

## 🔹 Recomendaciones Finales

-   Practica en entornos controlados como **Vulnerable by Design (VBD)** o **Exploit Development VMs**.
-   Revisa constantemente protecciones modernas (DEP, ASLR, Stack Canaries).
-   Documenta cada paso para entender bien el proceso de explotación y ajustes necesarios.

----------

Este resumen proporciona una guía rápida para entender y explotar vulnerabilidades de **Buffer Overflow**. 🚀🧑‍🔧
