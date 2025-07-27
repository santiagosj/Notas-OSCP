### 🧭 1. Mapeo RÁPIDO inicial (15 minutos máx)
| Objetivo                        | ¿Qué buscar?                                                   | Resultado esperado                                | ¿Cuándo avanzar?                                       |
| ------------------------------- | -------------------------------------------------------------- | ------------------------------------------------- | ------------------------------------------------------ |
| Identificar todos los puertos   | Puertos TCP abiertos                                           | Lista completa de puertos                         | Cuando tengas un listado confiable (ej. top 1000 + p-) |
| Detectar servicios y versiones  | Servicios comunes: HTTP, SMB, FTP, SSH, WinRM, DNS, RDP        | Identificación de posibles vectores               | Cuando tengas versiones o banners reveladores          |
| Clasificar servicios relevantes | HTTP con título o CMS, SMB accesible, WinRM, FTP anónimo, etc. | Una lista de servicios potencialmente explotables | Cuando puedas priorizar 2-3 para revisar primero       |
| Marcar vectores repetidos       | ¿Ya lo viste antes? (ej. CMS Pico, phpMyAdmin, IIS, Netlogon)  | Reconocimiento por experiencia                    | Si es familiar, priorizarlo (explotabilidad conocida)  |


### 🎯 2. Exploración dirigida por vector

| Tipo de vector | Objetivo específico                   | Criterio para profundizar                           | Criterio para descartar rápidamente                   |
| -------------- | ------------------------------------- | --------------------------------------------------- | ----------------------------------------------------- |
| HTTP/Web       | Identificar LFI, RCE, login, uploads  | Hay formularios, includes, CMS, versiones           | Página estática sin funcionalidad ni login            |
| CMS detectado  | Detectar vulnerabilidad conocida      | Versión específica, archivo `README`, admin visible | No hay panel, no hay leak de versión                  |
| SMB            | Acceso sin auth, shares listables     | Listado de shares, acceso a archivos                | “Access denied” en todo sin usuarios conocidos        |
| FTP            | Upload sin auth, leaks                | Permite upload o archivos sensibles listados        | No hay write ni archivos útiles                       |
| WinRM          | Intentar login con usuarios conocidos | Usuario válido y WinRM activo                       | Sin usuarios y puerto cerrado                         |
| RDP            | Validar acceso visual                 | Captura de pantalla posible, login interactivo      | Solo error de conexión o bloqueo                      |
| DNS            | Zone transfer, leakage                | Zona transferible, nombres internos filtrados       | No se puede transferir y no responde consultas útiles |
| SSH            | Login, enumeración banner             | Banner con versión vieja o filtración de nombre     | Cerrado o no responde a diccionario                   |


