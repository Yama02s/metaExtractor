#!/bin/bash

#colores

   greenColour="\e[0;32m\033[1m"
   endColour="\033[0m\e[0m"
   redColour="\e[0;31m\033[1m"
   blueColour="\e[0;34m\033[1m"
   yellowColour="\e[0;33m\033[1m"
   purpleColour="\e[0;35m\033[1m"
   turquoiseColour="\e[0;36m\033[1m"
   grayColour="\e[0;37m\033[1m"

function ctrl_c(){
  echo -e "\n${redColour}[!] Saliendo...${endColour}"
  tput cnorm && exit 1
}
trap ctrl_c INT

#funciones
function helpPanel(){
  echo -e "\n${yellowColour}[+]${endColour} Uso:"
  echo -e "\n${yellowColour}f)${endColour}Extraer metadatos de un archivo"
  echo -e "\n${yellowColour}h)${endColour} Panel de ayuda "
}

#parametros

 declare -i parameter_counter=0

 while getopts "f:h" arg; do
   case $arg in
     f) file="$OPTARG"; let parameter_counter+=1;;
     h) ;;
   esac
 done

 if [ $parameter_counter -eq 1 ]; then
   if [ -f "$file" ]; then
     echo -e "\n${yellowColour}[+]${endColour} Analizando el archivo ${redColour}$file${endColour}"
     info_basica=$(exiftool "$file")
     model=$(echo "$info_basica" | grep "Camera Model Name" | awk -F": " '{print $2}')
     date_time=$(echo "$info_basica" | grep "Create Date" | awk -F": " '{print $2}' | cut -c 1-19)
     software=$(echo "$info_basica" | grep "Software" | awk -F": " '{print $2}')

     if [ -n "$model" ]; then
       echo -e "\n${yellowColour}[+]${endColour} Camara: $model";fi
     if [ -n "$date_time" ]; then
       echo -e "\n${yellowColour}[+]${endColour} Fecha de creacion: $date_time";fi
     if [ -n "$software" ]; then
       echo -e "\n${yellowColour}[+]${endColour} Software o edicion: $software";fi

     gps_info=$(exiftool -c "%.6f" -GPSPosition "$file" 2>/dev/null)

     if [ -n "$gps_info" ]; then
       lat_long=$(echo "$gps_info" | awk -F": " '{print $2}' | tr -d ' ')

       echo -e "\n${yellowColour}[!]${endColour} ${redColour}COORDENADAS DETECTADAS!!!${endColour}"
       echo -e "\n${yellowColour}[+]${endColour} Coordenadas: $lat_long"
       echo -e "\n${yellowColour}[+]${endColour} Google Maps: ${purpleColour}hhtps://www.google.com/maps/place/$lat_long${endColour}"
     else
       echo -e "\n${redColour}[!] No se han encontrado datos de GPS${endColour}"
     fi

   else
     echo -e "\n${redColour}[!] El nombre del archivo que ingreso no existe...${endColour}"
   fi
 else
   helpPanel
 fi
