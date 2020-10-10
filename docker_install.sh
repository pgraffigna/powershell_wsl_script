#!/bin/bash
# para buscar las versiones disponibles de un paquete apt-cache madison PAQUETE

# Colores
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
blueColour="\e[0;34m\033[1m"
purpleColour="\e[0;35m\033[1m"
endColour="\033[0m\e[0m"

trap ctrl_c INT
function ctrl_c(){
        echo -e "\n${redColour}[++] Programa Terminado [++]${endColour}"
        exit 0
}

KEY=https://download.docker.com/linux/ubuntu/gpg
REPO=https://download.docker.com/linux/ubuntu

echo -e "\n${yellowColour}Actualización de la cache de los repositorios${endColour}"
sudo apt-get update

echo -e "\n${yellowColour}[!!] Instalación de los requerimientos${endColour}"
sudo apt-get install -y -qq \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

echo -e "\n${yellowColour}[!!] Descargar y agregar las llaves de docker${endColour}"
curl -fsSL  "$KEY"| sudo apt-key add -

echo -e "\n${yellowColour}[!!] Agregar los repositorios${endColour}"
sudo add-apt-repository \
  "deb [arch=amd64] $REPO \
  $(lsb_release -cs) \
  stable"  

echo -e "\n${yellowColour}[!!] Actualización de la cache de los repositorios${endColour}"
sudo apt-get update

echo -e "\n${yellowColour}[!!] Instalación de docker-ce, docker-ce-cli, containerd.io${endColour}"
sudo apt-get install -y -qq docker-ce docker-ce-cli containerd.io

echo -e "\n${yellowColour}[!!] Agregando a usuario local a grupo docker"
sudo usermod -a -G docker "$USER"

echo -e "\n${yellowColour}[!!] Iniciando el servicio${endColour}"
sudo service docker start

