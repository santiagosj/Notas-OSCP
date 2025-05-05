# Técnica de Enumeración para Obtener el ID de Cuenta AWS de un Bucket S3 Público

## Requisitos previos:
- Una cuenta AWS propia para realizar la enumeración
- Un bucket S3 de lectura pública en la cuenta objetivo

## Pasos:

1. **Identificar un bucket S3 público objetivo**
   - Localizar un bucket u objeto S3 de lectura pública perteneciente a la cuenta objetivo
   - Verificar que es accesible públicamente mediante `aws s3 ls [nombre-bucket]`

2. **Crear un usuario IAM en tu cuenta de atacante**
   - Ejecutar `aws iam create-user --user-name enum`
   - Crear credenciales de acceso con `aws iam create-access-key --user-name enum`
   - Configurar un perfil en AWS CLI para este usuario: `aws configure --profile enum`

3. **Crear una política IAM con condición de ID de cuenta**
   - Crear un archivo JSON (policy-s3-read.json) que:
     - Permita acciones `s3:ListBucket` y `s3:GetObject`
     - Incluya una condición `StringLike` en `s3:ResourceAccount` que limite el acceso
     - Inicialmente usar `"StringLike": {"s3:ResourceAccount": ["0*"]}`

4. **Aplicar la política al usuario IAM**
   - Ejecutar `aws iam put-user-policy --user-name enum --policy-name s3-read --policy-document file://policy-s3-read.json`

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

Esta técnica demuestra cómo las APIs pueden ser explotadas para obtener información más allá de su propósito original, lo que resulta valioso en pruebas de penetración éticas.
