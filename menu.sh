#!/bin/bash

##
# Menu script:
####     1-Crear usuario                                    
####     2-Habilitar usuario                                
####     3-Deshabilitar usuario                             
####     4-Cambiar permisos a un usuario                   
####     5-Copia de seguridad del directorio de trabajo    
####     de un usuario determinado                        
####     6-Usuarios conectados actualmente                
####     7-Espacio libre en disco                          
####     8-Trazar ruta                                      
####     9-Salir  
##

clear
echo "##########################################################"
echo "###   Administracion de sistemas informaticos en Red   ###"
echo "###                  Script ASO.                       ###"
echo "###            Jacobo Azmani Gonzalez                  ###"
echo "###                                                    ###"
echo "###                                                    ###"
echo "##########################################################"
#Creacion de usuario
function crea_usuario() {
    echo
    echo "Introduce el nuevo usuario:"
    read nuevousuario
    echo "Introduce nombre de grupo para el nuevo usuario $nuevousuario:"
    read nuevogrupo
    echo "Describe el nuevo usuario $nuevousuario del grupo $nuevogrupo:"
    read descripcion
    groupadd $nuevogrupo
    useradd -g $nuevogrupo -c "$descripcion" $nuevousuario
    echo "Nuevo usuario <$nuevousuario> creado para el grupo: <$nuevogrupo> con descripción:  <$descripcion>."
    sleep 1s
    echo ""
}
#Habilitar un usuario
function habilita_usuario() {
    read -p "Introduzca el nombre del usuario a habilitar: " usuario
if [ $usuario -lt 1 ]
then
passwd -u $usuario
fi
if [ $exist -eq 0 ]
then
echo El usuario existe : 
cat /etc/passwd | grep "$usuario" | cut -d ':' -f 6
else
echo El usuario "$usuario" no existe
fi
exit 0
    sleep 1s
    passwd -u $usuario
    echo "El usuario <$usuario> ha sido habilitado"
    echo ""
}
#Deshabilitar un usuario
function deshabilita_usuario() {
    read -p "Menú de deshabilitación de usuario. Introduzca el nombre del usuario a deshabilitar :" user
    sleep 1s
    passwd -l $user
    echo "El usuario <$user> ha sido deshabilitado"
    echo ""
}
#Cambiar permisos de usuario
function permisos_usuario() {
    echo "Aquí podrá cambiar los permisos que tiene un usuario sobre un fichero o directorio."
    read -p "Primero Seleccione un usuario para cambiar sus permisos" user
    sleep 1s
    read -p "Seleccione la ruta del archivo o directorio para modificar los permisos de <$user> sobre el mismo." ruta
    echo "Los permisos para el usuario <$user> sobre el archivo o directorio <$ruta> son los siguientes"
    read -p "Introduce los permisos que quieres asignar al usuario sobre este archivo o directorio, en formato numérico"
    echo ""
}
#Copia de seguridad
function copia_usuario() {
    read -p "Menú de copias de seguridad. Introduce un usuario para hacer una copia de seguridad de su directorio /home. :" user
    sleep 1s
    echo "Creando copia de seguridad. Esto puede tardar algún tiempo..."
    tar -zcvpf /backup/$user-$(date +%d-%m-%Y).tar.gz /home/$user
    echo "La copia de seguridad ha sido creada en /backup/$user"
    echo ""
}
#Usuario logueados
function conectado_usuario() {
    echo "Estos son los usuarios conectados actualmente:"
    who -h
    sleep 1s
    echo ""
}
#Espacio libre en disco.
function espacio_disco() {
    echo "Aquí podrá ver un resumen del uso del disco. La cantidad libre será mostrado bajo la columna <Available>" 
    df -h
    sleep 1s
    echo ""
}
#Trazado de rutas ip o url
function trazar_ruta() {
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
}

##
# Colores  Variables
##
green='\e[32m'
blue='\e[34m'
clear='\e[0m'

##
# Colores de menu
##

ColorGreen(){
	echo -ne $green$1$clear
}
ColorBlue(){
	echo -ne $blue$1$clear
}

menu(){
echo -ne "
#############################################
##                                         ##
##         Menu administrador              ##
##                                         ##
## $(ColorGreen '1)') Crear nuevo usuario                  ##
## $(ColorGreen '2)') Habilitar usuario                    ##
## $(ColorGreen '3)') Deshabilitar usuario                 ##
## $(ColorGreen '4)') Permisos de usuario                  ##
## $(ColorGreen '5)') Copia usuario                        ##
## $(ColorGreen '6)') Conectar usuario                     ##
## $(ColorGreen '7)') Espacio de disco                     ##
## $(ColorGreen '8)') Trazar ruta                          ##
## $(ColorGreen '0)') Salir                                ##
#############################################
$(ColorBlue 'Elija una opcion:') "

        read a
        case $a in
	        1) crea_usuario ; menu ;;
	        2) habilita_usuario ; menu ;;
	        3) deshabilita_usuario ; menu ;;
	        4) permisos_usuario ; menu ;;
	        5) copia_usuario ; menu ;;
            6) conectado_usuario ; menu ;;
            7) espacio_disco ; menu ;;
            8) trazar_ruta ; menu ;;
            9) salir ; menu ;;
            
		0) exit 0 ;;
		*) echo -e $red"Opcion incorrecta."$clear;
        esac
}

# Llamada a menu
menu
