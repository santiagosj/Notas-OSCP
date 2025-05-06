# Técnica de Enumeración para Obtener el ID de Cuenta AWS de un Bucket S3 Público

## Requisitos previos:
- Una cuenta AWS propia para realizar la enumeración
- Un bucket S3 de lectura pública en la cuenta objetivo

## Pasos:

1. **Identificar un bucket S3 público objetivo**
   - Localizar un bucket u objeto S3 de lectura pública perteneciente a la cuenta objetivo
   ```bash
   curl -s www.offseclab.io | grep -o -P 'offseclab-assets-public-\w{8}'
   ```
   - Verificar que es accesible públicamente mediante `aws s3 ls [nombre-bucket]`

2. **Crear un usuario IAM en tu cuenta de atacante**
   - Ejecutar `aws --profile attacker iam create-user --user-name enum`
     ```bash
          {
	    "User": {
	        "Path": "/",
	        "UserName": "enum",
	        "UserId": "AIDAZMM7SQGHZ4LACSS4J",
	        "Arn": "arn:aws:iam::645116625295:user/enum",
	        "CreateDate": "2025-05-06T18:08:52+00:00"
	      }
           }

     ```
   - Crear credenciales de acceso con `aws --profile attacker iam create-access-key --user-name enum`
   - Configurar un perfil en AWS CLI para este usuario: `aws configure --profile enum`

3. **Crear una política IAM con condición de ID de cuenta**
   - Crear un archivo JSON (policy-s3-read.json) que:
     - Permita acciones `s3:ListBucket` y `s3:GetObject`
     - Incluya una condición `StringLike` en `s3:ResourceAccount` que limite el acceso
     - Inicialmente usar `"StringLike": {"s3:ResourceAccount": ["0*"]}`
   ```bash
     1  {
     2      "Version": "2012-10-17",
     3      "Statement": [
     4          {
     5              "Sid": "AllowResourceAccount",
     6              "Effect": "Allow",
     7              "Action": [
     8                  "s3:ListBucket",
     9                  "s3:GetObject"
    10              ],
    11              "Resource": "*",
    12              "Condition": {
    13                  "StringLike": {"s3:ResourceAccount": ["1*"]}
    14              }
    15          }
    16      ]
    17  }
	
   ```

4. **Aplicar la política al usuario IAM**
   - Ejecutar `aws --profile attacker iam put-user-policy --user-name enum --policy-name s3-read --policy-document file://policy-s3-read.json`

5. **Probar el acceso al bucket utilizando cada dígito posible**
   - Intentar listar el bucket: `aws --profile enum s3 ls [nombre-bucket]`
   - Si obtienes "Access Denied", modificar la política probando con otro dígito inicial ("1*", "2*", etc.)
   - Volver a aplicar la política y probar nuevamente

6. **Identificar el primer dígito y continuar con los siguientes**
   - Una vez que obtengas acceso exitoso, habrás identificado el primer dígito
   - Repetir el proceso con el segundo dígito (ej: "10*", "11*", "12*", etc.)
   - Continuar con cada posición hasta obtener el ID completo (12 dígitos)

## Observaciones importantes:
- Las políticas pueden tardar 10-15 segundos en activarse después de aplicarse
- Esta técnica aprovecha las condiciones en políticas IAM para filtrar por ID de cuenta
- El proceso puede automatizarse con scripts o herramientas como s3-account-search
- Aunque se usa con S3 por su frecuente exposición pública, el concepto podría aplicarse a otros servicios AWS

