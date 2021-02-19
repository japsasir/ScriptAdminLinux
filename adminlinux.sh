#!/bin/bash
###Este script está diseñado para un administrador de sistemas Linux a modo de documentación ejecutable.

##FUNCIONES GENERALES##

#Función1 crear_usuario
function crear_usuario() {
    clear
    echo ""
    echo "Introduce el nombre del nuevo usuario:"
    read nuevousuario    

if id -u "$nuevousuario" >/dev/null 2>&1;
then
echo "El usuario ya existe."
else
    echo "Introduce el nombre de un grupo para el nuevo usuario $nuevousuario:"
    read nuevogrupo
    echo "Describe el nuevo usuario $nuevousuario del grupo $nuevogrupo. Por ejemplo, nombre completo y puesto:"
    read descripcion
    groupadd $nuevogrupo
    useradd -g $nuevogrupo -c "$descripcion" $nuevousuario
    echo "Nuevo usuario <$nuevousuario> creado para el grupo: <$nuevogrupo> y con la siguiente descripción:  <$descripcion>."
    echo "Para finalizar, introduce una contraseña para $nuevousuario"
    passwd $nuevousuario
fi
    sleep 10s
    clear
}
#Función2 habilita_usuario
function habilita_usuario() {
    clear
    echo ""
    echo "Menú de habilitación de usuario. Introduzca el nombre del usuario a habilitar:"
    read user
if  id -u "$user" >/dev/null 2>&1;
then
    passwd -u $user
    echo "El usuario <$user> ha sido habilitado"
else
    echo "El usuario <$user> no existe."
fi
    sleep 10s
    clear
}
#Función3 deshabilitar_usuario
function deshabilita_usuario() {
    clear
    echo "Menú de deshabilitación de usuario. Introduzca el nombre del usuario a deshabilitar :"
    echo ""
    read user

if  id -u "$user" >/dev/null 2>&1;
then
    passwd -l $user
    echo "El usuario <$user> ha sido deshabilitado"
else
    echo "El usuario <$user> no existe."
fi
    sleep 10s
    clear
}
#Función4 permisos_usuario
function permisos_usuario() {
    echo "Introduce la ruta absoluta del archivo al que quieras modificarle los permisos" 
    read archivo
  if test -e $archivo || test -d $archivo; then
    echo ""
    echo "Los permisos de $archivo actuales son:"
    ls -ld $archivo
    echo ""
    read -p "¿Quieres cambiar algún permiso de este archivo? (y/n): " yesno
        if [ $yesno = "y" ] ;
        then
            echo "¿Que permiso quieres cambiar? (r/w/x) [Lectura, escritura, ejecución]: " 
            read permiso
            echo "¿Añadir o retirar el permiso? (+/-): " ponquita
            for APLICAR in "u" "g" "o" ; do
                case $APLICAR in
                    "u") read -p "Quieres aplicar este permiso para el usurario? (y/n) " yesno
                        if [ $yesno = "y" ] ; then
                            chmod $APLICAR$ponquita$permiso $archivo
                        fi ;;
                    "g") read -p "Quieres aplicar este permiso para el grupo? (y/n) " VAR
                        if [ $yesno = "y" ] ; then
                            chmod $APLICAR$ponquita$permiso $archivo
                        fi ;;
                    "o") read -p "Quieres aplicar este permiso para otros? (y/n) " VAR
                        if [ $yesno = "y" ] ; then
                            chmod $APLICAR$ponquita$permiso $archivo
                        fi ;;
                esac
            done
            echo
            echo
            echo "Los permisos de $archivo tras haber hecho los cambios son: "
            ls -ld $archivo
            echo
            echo
             read -n 1 -p "Pulse una tecla para volver al menú principal..." TECLA
        else
            read -n 1 -p "Puesto que no quiere realizar ningún cambio, pulse una tecla para volver al menú principal..." TECLA
        fi
  else
      echo "$archivo no encontrado. Comprueba la ruta del archivo."
      echo ""
  fi 
    sleep 10s
    clear
}
#Función5 copia_usuario
function copia_usuario() {
    clear
    read -p "Menú de copias de seguridad. Introduce un usuario para hacer una copia de seguridad de su directorio /home. :" user
    sleep 1s
    echo "Creando copia de seguridad. Esto puede tardar algún tiempo..."
    mkdir /backup
    tar -zcvpf /backup/$user-$(date +%d-%m-%Y).tar.gz /home/$user
    echo "La copia de seguridad ha sido creada en /backup/$user"
    sleep 10s
    clear
}
#Función6 conectado_usuario
function conectado_usuario() {
    clear
    echo "Si la herramienta no funciona, ejecutar <sudo apt install finger en la terminal>"
    echo ""
    echo "Estos son los usuarios conectados actualmente:"
    finger -l
    sleep 10s
    clear
}
#Función7 espacio_disco
function espacio_disco() {
    clear
    echo "Aquí podrá ver un resumen del uso del disco durante 10 segundos."
    free -h
    sleep 10s
    clear
}
#Función8 trazar_ruta
function trazar_ruta() {
    clear
    echo "Bienvenido al trazador de rutas."
    echo "Introduce <rutarchivo> para buscar en el sistema de archivos o <rutaip> para trazar la ruta a una url"
    echo ""
    read destino
    clear
    case $destino in
    rutarchivo)
        echo "Introduce el archivo o directorio a buscar"
        echo ""
        read destino
        locate -e $destino
        ;;

    rutaip)
        echo "Introduce la página web o ip para trazar la ruta" 
        echo ""
        read destino
        traceroute $destino
        ;;
    *)
        echo "Las opciones son rutarchivo, rutaip o"
        ;;
    esac

    sleep 10s
    clear
}
##FUNCIÓN MENU Y AMIGOS##

##
# Variables color
##
green='\e[32m'
blue='\e[34m'
clear='\e[0m'

##
# Funciones color
##

ColorGreen() {
    echo -ne $green$1$clear
}
ColorBlue() {
    echo -ne $blue$1$clear
}

#Función menú
menu() {
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
    read opcion
    case $opcion in
    1)
        crear_usuario;
        menu
        ;;
    2)
        habilita_usuario;
        menu
        ;;
    3)
        deshabilita_usuario;
        menu
        ;;
    4)
        permisos_usuario;
        menu
        ;;
    5)
        copia_usuario;
        menu
        ;;
    6)
        conectado_usuario;
        menu
        ;;
    7)
        espacio_disco;
        menu
        ;;
    8)
        trazar_ruta;
        menu
        ;;
    0) exit 0 ;;
    *)
        echo -e $red"Opción incorrecta."$clear
        WrongCommand
        ;;
    esac
}

echo "Bienvenido al menú de SysAdmin Linux."
echo ""
echo "Este script le ayudará hasta que se familiarice
con los comandos de consola."
echo ""
sleep 3s

# Menú
clear
menu
