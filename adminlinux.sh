#!/bin/bash
###Este script está diseñado para un administrador de sistemas Linux a modo de documentación ejecutable.
$menu= echo "Opciones:
    1-Crear usurio
    2-Habilitar usuario
    3-Deshabilitar usuario
    4-Cambiar permisos a un usuario
    5-Copia de seguridad del directorio de trabajo de un usuario determinado
    6-Usuarios conectados actualmente
    7-Espacio libre en disco
    8-Trazar ruta
    9-Salir"

#Función de menú para usuario

read "Bienvenido al menú de SysAdmin Linux. Este script le ayudará hasta que se familiarice con los comandos de consola."
read "Asegúrese de haber lanzado el script con sudo."
read date
sleep 1
read -p "$menu" opcion
 case $opcion in
 ## Nota: Revisar como hacer el return, sin crear función a ser posible.
 #Menú de creación de usuario
  1)
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
        echo "Nuevo usuario $nuevousuario creado para el grupo $nuevogrupo y con la siguiente descripción $descripcion ."
    sleep 1s
	echo "Elige otra opción."
	read -p "$menu" opcion
    ;;
  2)
    read -p "Menú de habilitación de usuario. :" user
    sleep 1s
	echo "Elige otra opción."
	read -p "$menu" opcion
    ;;
  3)
    read -p "Menú de deshabilitación de usuario. :" user
    sleep 1s
	echo "Elige otra opción."
	read -p "$menu" opcion
  4)
    read -p "Menú de copias de seguridad. :" user
    sleep 1s
	echo "Elige otra opción."
	read -p "$menu" opcion
    ;;
  5)
    read -p "Menú de copia de seguridad del directorio de trabajo de usuario. :" user
    sleep 1s
	echo "Elige otra opción."
	read -p "$menu" opcion
    ;;
#Usuarios Online
  6)
    echo "Estos son los usuarios conectados actualmente:" 
    who -H;
    sleep 1s
	echo "Elige otra opción."
	read -p "$menu" opcion
    ;;    
  7)
    read -p "Menú de espacio libre en disco:" user
    sleep 1s
	echo "Elige otra opción."
	read -p "$menu" opcion
  8)
    read -p "Menú de trazado de rutas ip o url :" user
    sleep 1s
	echo "Elige otra opción."
	read -p "$menu" opcion
    ;;
  9)
    echo "Gracias por utilizar SysAdmin Linux. Tenga un buen día."
    exit
    ;;    
  *)
    echo "Opción desconocida. Por favor, elige un número del 1 al 9. Contacta con el administrador Senior si el problema persiste."
    sleep 1s
	echo "Elige otra opción."
	read -p "$menu" opcion
    ;;
 esac
