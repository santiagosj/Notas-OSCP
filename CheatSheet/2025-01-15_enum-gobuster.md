# Tools: Gobuster cheatsheet

## Fecha: {FECHA}
## Host: {HOST}
## IP: {IP}

---

## Objetivo
{OBJETIVO}

---
## Herramientas
1. tool - 1 
2. tool - 2
---
## Procedimiento y comandos
1. dir Mode: 
	gobuster dir -u https://example.com -w ~/wordlists/shortlist.txt -o result.txt -t 5(amount of trafic default=10) -l (with content length)
2. dns Mode: 
	gobuster dns -d example.com -t 50 -w common-names.txt
	gobuster dns -d example.com-w ~/wordlists/subdomains.txt
	gobuster dns -d example.com -w ~/wordlists/subdomains.txt -i // with show IP
	gobuster dns -d 0.0.1.xip.io -w ~/wordlists/subdomains.txt // Wildcard DNS is also detected properly:
	
3. vhost Mode:
	gobuster vhost -u https://example.com -w common-vhosts.txt
4. s3 Mode:
	gobuster s3 -w bucket-names.txt


---
## Troubleshooting

---

## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

