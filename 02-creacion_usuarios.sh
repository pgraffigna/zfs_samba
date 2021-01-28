#!/bin/bash

#Colores
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
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

for i in "${USUARIOS[@]}"; do sudo adduser --no-create-home "$i" && sudo adduser "$i" "$GRUPO"; done

echo -e "${greenColour}Todos los usuarios han sido creados ${endColour}"
