#!/bin/bash
###Este script está diseñado para un administrador de sistemas Linux a modo de documentación ejecutable.
#Función de menú para usuario


#Función menú
menu(){
echo -ne "
------------------
Opciones:
$(ColorGreen '1)') Crear usuario
$(ColorGreen '2)') Habilitar usuario
$(ColorGreen '3)') Deshabilitar usuario
$(ColorGreen '4)') Cambiar permisos a un usuario
$(ColorGreen '5)') Copia de seguridad del directorio de trabajo de un usuario determinado
$(ColorGreen '6)') Usuarios conectados actualmente
$(ColorGreen '7)') Espacio libre en disco
$(ColorGreen '8)') Trazar ruta

$(ColorGreen '0)') Salir
------------------
$(ColorBlue 'Seleccione una opción:') "
        read a
        case $a in
	        1) crear_usuario ; menu ;;
	        2) habilita_usuario ; menu ;;
	        3) deshabilita_usuario ; menu ;;
	        4) permisos_usuario ; menu ;;
	        5) copia_usuario ; menu ;;
            6) conectado_usuario ; menu ;;
            7) espacio_disco ; menu ;;
            8) trazar_ruta ; menu ;;
			0) exit 0 ;;
			*) echo -e $red"Opción incorrecta."$clear; WrongCommand;;
        esac
}











menu="
------------------
Opciones:
    1-Crear usuario
    2-Habilitar usuario
    3-Deshabilitar usuario
    4-Cambiar permisos a un usuario
    5-Copia de seguridad del directorio de trabajo
    de un usuario determinado
    6-Usuarios conectados actualmente
    7-Espacio libre en disco
    8-Trazar ruta
    9-Salir    
------------------
Seleccione una opción:
"

echo "Bienvenido al menú de SysAdmin Linux."
echo ""
echo "Este script le ayudará hasta que se familiarice
con los comandos de consola."
echo ""
echo "Asegúrese de haber lanzado el script con sudo."
echo ""
date
sleep 1
read -p "$menu" opcion
case $opcion in
#Menú de creación de usuario
##FALLO DE MENU
#Testado en repl.
[1])
    clear
    echo
    echo "Introduce el nombre del nuevo usuario:"
    read nuevousuario
    echo "Introduce el nombre de un grupo para el nuevo usuario $nuevousuario:"
    read nuevogrupo
    echo "Describe el nuevo usuario $nuevousuario del grupo $nuevogrupo. Por ejemplo, nombre completo y puesto:"
    read descripcion
    groupadd $nuevogrupo
    useradd -g $nuevogrupo -c "$descripcion" $nuevousuario
    echo "Nuevo usuario <$nuevousuario> creado para el grupo: <$nuevogrupo> y con la siguiente descripción:  <$descripcion>."
    sleep 3s
    clear
    echo ""
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
#Menú de habilitación de usuario
#Testado en repl.
[2])
    clear
    read -p "Menú de habilitación de usuario. Introduzca el nombre del usuario a habilitar:" user
    sleep 1s
    passwd -u $user
    echo "El usuario <$user> ha sido deshabilitado"
    echo ""
    sleep 3s
    clear
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
#Menú de deshabilitación de usuario
#Testado en repl.
[3])
    clear
    read -p "Menú de deshabilitación de usuario. Introduzca el nombre del usuario a deshabilitar :" user
    passwd -l $user
    echo "El usuario <$user> ha sido deshabilitado"
    echo ""
    sleep 3s
    clear
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
#Cambiar permisos a un usuario
#Investigar sobre permisos específicos de usuario y los comandos correspondientes.
[4])
    clear
    echo "Aquí podrá cambiar los permisos que tiene un usuario sobre un fichero o directorio."
    read -p "Primero Seleccione un usuario para cambiar sus permisos" user
    sleep 1s
    read -p "Seleccione la ruta del archivo o directorio para modificar los permisos de <$user> sobre el mismo." ruta
    echo "Los permisos para el usuario <$user> sobre el archivo o directorio <$ruta> son los siguientes" #Los permisos
    read -p "Introduce los permisos que quieres asignar al usuario sobre este archivo o directorio, en formato numérico"
    #Falta comando
    #Falta mensaje de confirmación
    sleep 3s
    clear
    echo ""
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
#Menú de copia de seguridad del directorio de trabajo de usuario
#Testear en máquina virtual.
[5])
    clear
    read -p "Menú de copias de seguridad. Introduce un usuario para hacer una copia de seguridad de su directorio /home. :" user
    sleep 1s
    echo "Creando copia de seguridad. Esto puede tardar algún tiempo..."
    tar -zcvpf /backup/$user-$(date +%d-%m-%Y).tar.gz /home/$user
    echo "La copia de seguridad ha sido creada en /backup/$user"
    sleep 3s
    clear
    echo ""
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
#Usuarios Online.
#Revisar comando en máquina virtual. Debería valer.
[6])
    clear
    echo "Si la herramienta no funciona, ejecutar <sudo apt install finger en la terminal>"
    echo ""
    echo "Estos son los usuarios conectados actualmente:"
    #Se puede usar 'who' con un parámetro, pero es menos informativo.
    finger -l
    sleep 3s
    clear
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
#Menú de espacio libre en disco.
#Investigar si se puede concretar más
[7])
    clear
    echo "Aquí podrá ver un resumen del uso del disco. La cantidad libre será mostrado bajo la columna <Available>" 
    df -h
    echo ""
    sleep 3s
    clear
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
#Menú de trazado de rutas ip o url
#Realpath ruta sistema de archivos.
#
[8])
    clear
    echo "Bienvenido al trazador de rutas."
    echo "Introduce <rutarchivo> para buscar en el sistema de archivos" 
    echo "Introduce <rutaip> para buscar la ruta a una web o url" 
    echo "Introduce <menu> para volver al menú principal"
    read destino
    clear
    # >updatedb && locate $destino> es lo que sale en los apuntes
case $destino in 
    rutarchivo)
    read -p "Introduce el archivo o directorio a buscar" destino
    whereis $destino
    ;;

    rutaip)
    read -p "Introduce la página web o ip para trazar la ruta" destino
    traceroute $destino
    ;;

    menu)
    echo ""
    ;;

    *)
    echo "Las opciones son rutarchivo, rutaip o menu"
    ;;
    esac

    clear
    echo "Has vuelto al menu principal.Elige otra opción."
    read -p "$menu" opcion;
    ;;
#Dejar de usar SysAdmin Linux
[9])
    clear
    echo "Gracias por utilizar SysAdmin Linux. Tenga un buen día."
    sleep 3s
    clear
    exit
    ;;
#Opción no recogida en 'case'
*)
    clear
    echo "Opción desconocida. Por favor, elige un número del 1 al 9. Contacta con el administrador Senior si el problema persiste."
    sleep 1s
    echo ""
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
esac
