### Sintaxis básica
[Utils](https://github.com/mivang/cheatsheets/blob/master/crunch)
```bash
crunch <min-len> <max-len> [<charset string>] [opciones]
```
* min-len / max-len: longitud mínima y máxima (obligatorios).
* Si no especificás <charset string>, crunch usa los charsets por defecto.

### Placeholders (para -t pattern)

* `@` = minúsculas (a–z)

* `,` = MAYÚSCULAS (A–Z)

* `%` = números (0–9)

* `^` = símbolos ( !@#... )


Ej: `-t @,%^` → 1ª minúscula, 2ª mayúscula, 3ª número, 4ª símbolo

### Opciones esenciales (resumen)

* `-o` archivo : guardar salida en archivo.

* `-z gzip|bzip2|lzma|7z` : comprimir salida.

* `-f /ruta/charset.lst` nombre_charset : usar charset predefinido.

* `-t pattern`: patrón fijo con placeholders.

* `-s START` : comenzar desde la palabra START (útil para reanudar).

* `-r` : reanudar generación (usa el mismo comando que antes + -r).

* `-b <n><type>` : dividir salida en archivos del tamaño indicado (ej. 20mib).

* `-c <n>` : número de líneas por archivo (cuando se usa -o START).

* `-d <num><symbol>` : limitar repeticiones consecutivas (ej. -d 2@ evita aaa).

* `-p ...`: permutaciones sin repetir (usa nombres/words). Debe ser la última opción.

* `-q filename.txt` : permuta líneas de un archivo.

* `-l mask` : cuando usás -t, -l indica cuáles posiciones son literales (para escapar placeholders).

* `-i` : invertir orden de generación.

* `-e string` : parar temprano cuando encuentra string.

* `-u` : desactiva la barra de porcentaje (printpercentage).

### Charsets rápidos (ejemplos)

Minúsculas: `abcdefghijklmnopqrstuvwxyz`

MAYÚSCULAS: `ABCDEFGHIJKLMNOPQRSTUVWXYZ`

Números: `0123456789`

Símbolos comunes: `!@#$%^&*()_+-=[]{}|;:'",.<>/?\`

charset.lst (incluido en Kali) tiene presets: `mixalpha`, `mixalpha-numeric`, `mixalpha-numeric-all-space`, `numeric`, `ualpha`

### Ejemplos útiles (copiar/pegar)

1. Wordlist básica, a–z, longitudes 1 a 6 (no guardar):

```bash
crunch 1 6
```

2. Guardar a archivo (mix alpha-numérico, 6–8 chars):

```bash
crunch 6 8 -f /usr/share/crunch/charset.lst mixalpha-numeric -o wordlist.txt
```
3. Prefijo fijo + patrón: pass + 2 letras minúsc + 2 números:
```bash
crunch 8 8 abcdefghijklmnopqrstuvwxyz  -t pass@@%% -o pass_guess.txt
# o especificando sets con + para placeholders:
crunch 8 8 abc + 123 -t pass@@%% -o pass_guess.txt
```
4. Patrón con MAYÚS y símbolos: P@ss + 3 símbolos:

```bash
crunch 7 7 -t P@ss^^^ -o p@ss_syms.txt
```

5. Empezar desde un punto intermedio (resume manual):
```bash
crunch 4 6 -f charset.lst mixalpha-numeric -o wordlist.txt -s c3d4
# O para reanudar automáticamente (si ya generaste y usaste -o):
crunch 4 6 -f charset.lst mixalpha-numeric -o wordlist.txt -r
```
6. Limitar repeticiones: permitir máximo 2 letras minúsculas seguidas:
```bash
crunch 5 5 -d 2@ -t @@@@@ -o no_triples.txt
```
7. Generar permutaciones (sin repetir) de palabras:
```bash
crunch 3 6 -p admin user root
# (ignora min/max, debe ser la última opción)
```
8. Partir archivos en chunks por tamaño y comprimir:
```bash
crunch 4 6 -f charset.lst mixalpha-numeric-all-space -o START -b 100m -z gzip
# Genera varios archivos *.txt.gz de ~100 MiB
```
9. Usar archivo con palabras a permutar:
```bash
crunch 1 1 -q lista.txt -o perms.txt
```
### Buenas prácticas / tips

* No generar combinaciones completas con charsets grandes y longitudes largas: usar `-t` (patrones) o `-p` o listas dirigidas (como nombres + años).

* Comprimir con -z gzip al vuelo para ahorrar disco.

* Para cracking moderno, a menudo conviene generar por streaming y pipear a hashcat/john en vez de a un archivo (ej. crunch ... | hashcat -a 0 ...).

* Usá `-s` para reiniciar desde donde quedó en caso de corte.

* Tené en cuenta la codificación/unicode si querés caracteres no-ASCII (-f unicode.lst <name>). 

### Cheatsheet rápido (tabla resumen)

- `crunch min max [charset] -o file` → generar y guardar

- `-t pattern` → patrón con @ , % ^

- `-f charset.lst name` → charset predefinido

- `-z gzip|bzip2|lzma|7z` → comprimir salida

- `-b 100m -o START` → dividir en archivos ~100MiB

- `-d 2@` → no más de 2 letras minúsc seguidas

- `-p` → permutaciones (sin repetición)

- `-r` → resume generación