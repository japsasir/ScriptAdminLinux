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

nombre_equipo=$(hostname)

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
Menu administrador
$(ColorGreen '1)') Crear nuevo usuario
$(ColorGreen '2)') Habilitar usuario
$(ColorGreen '3)') Deshabilitar usuario
$(ColorGreen '4)') Permisos de usuario
$(ColorGreen '5)') Copia usuario
$(ColorGreen '6)') Conectar usuario
$(ColorGreen '7)') Espacio de disco
$(ColorGreen '8)') Trazar ruta
$(ColorGreen '0)') Salir
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
		*) echo -e $red"Opcion incorrecta."$clear; WrongCommand;;
        esac
}

# Llamada a menu
menu
