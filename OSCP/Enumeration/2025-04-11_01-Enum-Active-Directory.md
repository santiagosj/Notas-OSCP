## 🧠 Resumen de Comandos `net.exe` para Enumeración en Active Directory

| Comando | Descripción | Contexto | Ejemplo |
|--------|-------------|----------|---------|
| `net user` | Muestra los usuarios **locales** del equipo | Local | `net user` |
| `net user [usuario]` | Muestra detalles de un usuario **local** | Local | `net user stephanie` |
| `net user /domain` | Enumera los usuarios del **dominio** actual | Dominio | `net user /domain` |
| `net user [usuario] /domain` | Muestra detalles de un usuario del **dominio** | Dominio | `net user jeff /domain` |
| `net localgroup` | Muestra los grupos **locales** en el sistema | Local | `net localgroup` |
| `net localgroup [grupo]` | Muestra miembros de un grupo local | Local | `net localgroup Administradores` |
| `net group /domain` | Muestra los grupos **del dominio** | Dominio | `net group /domain` |
| `net group [grupo] /domain` | Muestra los miembros de un grupo de dominio | Dominio | `net group "Domain Admins" /domain` |
| `net accounts` | Muestra políticas de cuenta (caducidad, longitud mínima, etc.) | Local/Dominio | `net accounts` |
| `net view` | Muestra equipos visibles en la red | Local | `net view` |
| `net view /domain:[nombre]` | Muestra equipos en un dominio específico | Dominio | `net view /domain:corp.com` |
| `net view \\[host]` | Enumera recursos compartidos en una máquina remota | Local/Dominio | `net view \\DC1` |
| `net config workstation` | Información de la estación de trabajo (dominio, nombre PC) | Local | `net config workstation` |
| `net config server` | Información del equipo actuando como servidor | Local | `net config server` |
| `net time /domain` | Hora actual del controlador de dominio | Dominio | `net time /domain` |
| `net use` | Muestra conexiones activas a recursos compartidos | Local | `net use` |
| `net use [letra]: \\host\share` | Conecta a recurso compartido | Local/Dominio | `net use Z: \\DC1\share` |
| `net session` | Muestra sesiones activas conectadas al sistema | Local (admin) | `net session` |
| `net file` | Muestra archivos abiertos remotamente (permiso admin) | Local | `net file` |


