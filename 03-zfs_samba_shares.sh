#!/bin/bash

#Colores
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
endColour="\033[0m\e[0m"

#CTRL-C
trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}[++] Programa Terminado [++]${endColour}"
        exit 0
}

#Variables
USUARIOS=(usu1 usu2 usu3)
GRUPO=nombre_grupo
COMPARTIDAS=(drivers imagenes backups programas) 
POOL=$(zpool status | grep 'pool:' | awk '{printf $2}')

echo -e "${yellowColour}Instalando el servicio samba ${endColour}"
sudo apt update && sudo apt install -y samba

echo -e "${yellowColour}Credenciales samba $endColour"
for i in "${USUARIOS[@]}"; do echo -e "para $i\n" && sudo smbpasswd -a "$i" ; done

echo -e "${yellowColour}Creacion de Compartidas ${endColour}"
for i in "${COMPARTIDAS[@]}"; do sudo zfs create "$POOL"/"$i" ; done

echo -e "${yellowColour}Cambiar permisos de acceso a las Compartidas ${yellowColour}"
for i in "${COMPARTIDAS[@]}"; do sudo chown -R "$GRUPO":"$GRUPO" /"$POOL"/"$i" ; done

echo -e "${yellowColour}Cambiar permisos de las Compartidas ${yellowColour}"
for i in "${COMPARTIDAS[@]}"; do sudo chmod 775 -R /"$POOL"/"$i" ; done

echo -e "${yellowColour}Activar acceso via SMB a las compartidas ${endColour}"
for i in "${COMPARTIDAS[@]}"; do sudo zfs set sharesmb=on "$POOL"/"$i" ; done

echo -e "${yellowColour}Reiniciar el servicio y mostrar el estado ${endColour}"
sudo systemctl restart smbd.service && sudo systemctl status smbd.service

echo -e "${greenColour}Todos los procesos terminaron correctamente!!!  ${endColour}"

#zfs list
#zfs status
#zfs destroy POOL/DATASET
#zfs set sharesmb=off POOL/DATASET
#zfs create -o quota=5g POOL/DATASET



