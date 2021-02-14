#!/bin/bash
###Este script está diseñado para un administrador de sistemas Linux a modo de documentación ejecutable.
#Función de menú para usuario
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
    sleep 1s
    echo ""
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
#Menú de habilitación de usuario
#Testado en repl.
[2])
    read -p "Menú de habilitación de usuario. Introduzca el nombre del usuario a habilitar:" user
    sleep 1s
    passwd -u $user
    echo "El usuario <$user> ha sido deshabilitado"
    echo ""
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
#Menú de deshabilitación de usuario
#Testado en repl.
[3])
    read -p "Menú de deshabilitación de usuario. Introduzca el nombre del usuario a deshabilitar :" user
    sleep 1s
    passwd -l $user
    echo "El usuario <$user> ha sido deshabilitado"
    echo ""
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
#Cambiar permisos a un usuario
#Investigar sobre permisos específicos de usuario y los comandos correspondientes.
[4])
    echo "Aquí podrá cambiar los permisos que tiene un usuario sobre un fichero o directorio."
    read -p "Primero Seleccione un usuario para cambiar sus permisos" user
    sleep 1s
    read -p "Seleccione la ruta del archivo o directorio para modificar los permisos de <$user> sobre el mismo." ruta
    echo "Los permisos para el usuario <$user> sobre el archivo o directorio <$ruta> son los siguientes"
    read -p "Introduce los permisos que quieres asignar al usuario sobre este archivo o directorio, en formato numérico"
    echo ""
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
#Menú de copia de seguridad del directorio de trabajo de usuario
#Testear en máquina virtual.
[5])
    read -p "Menú de copias de seguridad. Introduce un usuario para hacer una copia de seguridad de su directorio /home. :" user
    sleep 1s
    echo "Creando copia de seguridad. Esto puede tardar algún tiempo..."
    tar -zcvpf /backup/$user-$(date +%d-%m-%Y).tar.gz /home/$user
    echo "La copia de seguridad ha sido creada en /backup/$user"
    echo ""
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
#Usuarios Online.
#Revisar comando en máquina virtual. Debería valer.
[6])
    echo "Estos son los usuarios conectados actualmente:"
    who -h
    sleep 1s
    echo ""
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
#Menú de espacio libre en disco.
#Investigar si se puede concretar más
[7])
    echo "Aquí podrá ver un resumen del uso del disco. La cantidad libre será mostrado bajo la columna <Available>" 
    df -h
    sleep 1s
    echo ""
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
#Menú de trazado de rutas ip o url
#Traceroute?
[8])
    read -p "Menú de trazado de rutas ip o url :" user
    sleep 1s
    echo ""
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
[9])

    echo "Gracias por utilizar SysAdmin Linux. Tenga un buen día."
    exit
    ;;
*)
    echo "Opción desconocida. Por favor, elige un número del 1 al 9. Contacta con el administrador Senior si el problema persiste."
    sleep 1s
    echo ""
    echo "Elige otra opción."
    read -p "$menu" opcion
    ;;
esac
