Es una herramienta automatizada escrita en Bash diseñada para extraer y filtrar metadatos de archivos de imagen.

La herramienta utiliza "ExifTool" para el análisis profundo, pero limpia la salida para mostrar solo la informacion critica y, si detecta coordenadas GPS va a generar automáticamente un enlace a Google Maps con la ubicación exacta.

[+]Requisitos

Necesitas tener instalado "exiftool" en tu sistema (Kali Linux, Parrot OS, Ubuntu):

sudo apt update
sudo apt install libimage-exiftool-perl

[+]Uso:
Una vez que clones el repositorio tendras que darle perimsos de ejecucion con el "chmod +u metaExtractor.sh".
Luego ejecutas la herramienta:
./metaExtractor.sh -f imagen.jpg
