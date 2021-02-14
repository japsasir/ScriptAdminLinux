#!/bin/bash
###Este script está diseñado para un administrador de sistemas Linux a modo de documentación ejecutable.


#Función de menú para usuario

read "Bienvenido al menú de SysAdmin Linux. Este script le ayudará hasta que se familiarice con los comandos de consola."
read "Asegúrese de haber lanzado el script con sudo."
read date




sleep 1
read -p "Opciones:
    1-Crear usurio
    2-Habilitar usuario
    3-Deshabilitar usuario
    4-Cambiar permisos a un usuario
    5-Copia de seguridad del directorio de trabajo de un usuario determinado
    6-Usuarios conectados actualmente
    7-Espacio libre en disco
    8-Trazar ruta
    9-Salir
" opcion
 case $opcion in
  1)
    read -p "Menú de creación de usuario. :" user
    ;;
  2)
    read -p "Menú de habilitación de usuario. :" user
    ;;
  3)
    read -p "Menú de deshabilitación de usuario. :" user
  4)
    read -p "Menú de copias de seguridad. :" user
    ;;
  5)
    read -p "Menú de copia de seguridad del directorio de trabajo de usuario. :" usuario
    ;;
  6)
    echo "Estos son los usuarios conectados actualmente" 
    ;;    
  7)
    read -p "Menú de espacio libre en disco:" usuario
    ;;
  8)
    read -p "Menú de trazado de rutas ip o url :" usuario
    ;;
  9)
    echo "Gracias por utilizar SysAdmin Linux. Tenga un buen día."
    ;;    
  *)
    echo "Opción desconocida. Por favor, elige un número del 1 al 9. Contacta con el administrador Senior si el problema persiste."
    ;;
 esac
