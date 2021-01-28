#!/bin/bash

#Colores
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
endColour="\033[0m\e[0m"

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}[++] Programa Terminado [++]${endColour}"
        exit 0
}

echo -e "${yellowColour}Iniciando la instalación del ZFS en Ubuntu Server 20.04 ${endColour}"
echo -e "\n${yellowColour}Actualizando los paquetes ${endColour}"
sudo apt update

echo -e "\n${yellowColour}Instalando los requisitos para usar ZFS ${endColour}"
sudo apt install -y zfsutils-linux

echo -e "\n${yellowColour}Listando los discos disponibles para crear el RAID ${endColour}"
lsblk -f

echo -e "\n${yellowColour}Creación del RAIDZ${endColour}"
read -p "Ingresa el nombre del POOL: " POOL

read -p "Ingresa el nombre de los discos separados por espacio ej:
 >> " -ra DISCOS
sudo zpool create -f "$POOL" "/dev/${DISCOS[0]}" #"/dev/${discos[1]}"

echo -e "\n${yellowColour}Chequeando el estado del POOL ${endColour}"
zpool status

echo -e "\n${greenColour}Todos los procesos terminaron correctamente!!! ${endColour}"
