**Cheat Sheet: Ataques a Contraseñas en Pentesting**

---

### 1. **Tipos Comunes de Hashes y su Identificación**

| Tipo de Hash | Ejemplo | Identificación | Notas |
|--------------|---------|------------------|-------|
| NTLM         | 32c6ee... | Longitud 32 caracteres hex | Windows |
| MD5          | 5f4dcc... | Longitud 32 caracteres hex | Muy común, pero vulnerable |
| SHA1         | aaf4c6... | Longitud 40 caracteres hex | Mejor que MD5, pero roto |
| bcrypt       | $2y$10$... | Comienza con `$2a$`, `$2b$` o `$2y$` | Más seguro, incluye salt |

Herramienta para identificar hashes:
```bash
hash-identifier
```

---

### 2. **Crackeo de Hashes con Hashcat**

```bash
hashcat -m <modo> -a 0 <archivo_hashes> <diccionario>
```

Ejemplo para NTLM:
```bash
hashcat -m 1000 -a 0 hashes.txt rockyou.txt
```

Modos comunes:
- `0`: MD5
- `100`: SHA1
- `500`: md5crypt
- `1000`: NTLM
- `1800`: sha512crypt
- `3200`: bcrypt

---

### 3. **Crackeo de Hashes con John the Ripper**

Preparar archivo:
```bash
john --format=raw-md5 hashes.txt --wordlist=rockyou.txt
```

Soporta NTLM:
```bash
john --format=NT hashes.txt --wordlist=rockyou.txt
```

Ver resultados:
```bash
john --show hashes.txt
```

---

### 4. **Ataques por Fuerza Bruta y Diccionario con Hydra**

```bash
hydra -l <usuario> -P <diccionario> <protocolo>://<objetivo>
```

Ejemplos:
- FTP:
```bash
hydra -l admin -P rockyou.txt ftp://192.168.1.100
```
- SSH:
```bash
hydra -l root -P rockyou.txt ssh://192.168.1.100
```
- HTTP (básico):
```bash
hydra -l admin -P rockyou.txt 192.168.1.100 http-get /login
```

---

### 5. **Ataques con Medusa (alternativa a Hydra)**

```bash
medusa -h <host> -u <usuario> -P <diccionario> -M <servicio>
```

Ejemplo:
```bash
medusa -h 192.168.1.100 -u root -P rockyou.txt -M ssh
```

---

### 6. **Ataques a Formularios Web con Hydra**

```bash
hydra -l admin -P rockyou.txt <IP> http-post-form "/login.php:user=^USER^&pass=^PASS^:F=Login failed"
```

- `F=` indica el mensaje de error al fallar el login

---

### 7. **Obtención de Hashes en Sistemas Windows**

- Desde acceso con privilegios:
```powershell
reg save HKLM\SAM sam
reg save HKLM\SYSTEM system
```

- Luego usar `secretsdump.py`:
```bash
secretsdump.py -system system -sam sam LOCAL
```

---

### 8. **Fuerza Bruta a archivos Zip/RAR/7z**

Con `fcrackzip`:
```bash
fcrackzip -u -D -p rockyou.txt archivo.zip
```

Con `john` para ZIP:
```bash
zip2john archivo.zip > archivo.hash
john archivo.hash --wordlist=rockyou.txt
```

---

### 9. **Diccionarios y Herramientas úteis**

- Diccionario común:
  - `/usr/share/wordlists/rockyou.txt`
  - `SecLists` (repositorio)

- Herramientas:
  - `Crunch`: Generador de diccionarios
  - `CeWL`: Crawler para crear diccionarios específicos
  - `hashid`, `hash-identifier`: Identificadores de hashes

---

### 10. **Tips y Buenas Prácticas**

- Usa GPU con Hashcat siempre que sea posible
- Filtra hash duplicados antes de crackear
- Prioriza ataques por diccionario sobre fuerza bruta pura
- Utiliza diccionarios personalizados si tienes información sobre la víctima (OSINT)



