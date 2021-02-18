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

server_name=$(hostname)

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
    ;;
}

function cpu_check() {
    echo ""
	echo "CPU load on ${server_name} is: "
    echo ""
	uptime
    echo ""
}

function tcp_check() {
    echo ""
	echo "TCP connections on ${server_name}: "
    echo ""
	cat  /proc/net/tcp | wc -l
    echo ""
}

function kernel_check() {
    echo ""
	echo "Kernel version on ${server_name} is: "
	echo ""
	uname -r
    echo ""
}

function all_checks() {
	memory_check
	cpu_check
	tcp_check
	kernel_check
}

##
# Color  Variables
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
Menu administrador
$(ColorGreen '1)') Crear nuevo usuario
$(ColorGreen '2)') CPU load
$(ColorGreen '3)') Number of TCP connections 
$(ColorGreen '4)') Kernel version
$(ColorGreen '5)') Check All
$(ColorGreen '0)') Exit
$(ColorBlue 'Choose an option:') "
        read a
        case $a in
	        1) crea_usuario ; menu ;;
	        2) cpu_check ; menu ;;
	        3) tcp_check ; menu ;;
	        4) kernel_check ; menu ;;
	        5) all_checks ; menu ;;
		0) exit 0 ;;
		*) echo -e $red"Wrong option."$clear; WrongCommand;;
        esac
}

# Call the menu function
menu
