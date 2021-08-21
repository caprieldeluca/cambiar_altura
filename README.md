# cambiar_altura
Simple script en bash para ajustar la etiqueta EXIF *GPSAltitude* de todas las imágenes en un directorio.  

---
## Parámetros:  
     -d (Directorio de los archivos a escribir)  
     -m (Metros sobre el nivel del mar al despegue)  
---  

Al recibir imágenes de vuelos fotogramétricos hechos con algunos drones en especial, se observa un valor erróneo de altitud absoluta de la georreferenciación en los metadatos de cada toma.  
Estos valores sorprenden por tener un error del orden de los 100 metros en forma negativa (el resultado por lo general es una referencia bajo el nivel del mar).  
Sin embargo estos dispositivos graban también un valor de altitud relativa al punto de despegue, medida por barómetro, con mucha mejor precisión.  

El objetivo del script es sobreescribir la altura absoluta de cada imagen, como la suma de la altura absoluta al despegue más el valor de la altitud relativa para cada toma.  
La altitud absoluta al despegue puede estimarse de muchas formas: cualquier dispositivo receptor GNSS por código o cualquier modelo digital de elevaciones provisto por un organismo oficial devolverá un valor mucho más aproximado para esa posición que el registrado en los metadatos de las imágenes.

El script crea un subdirectorio `modificados` y copia allí cada archivo con extensión *JPG* encontrado en el directorio de trabajo o el especificado en el parámetro `-d`.  
Para cada archivo en el nuevo subdirectorio, lee la etiqueta EXIF *RelativeAltitude*, la suma al valor especificado en el parámetro `-m` y escribe la etiqueta *GPSAltitude* con el resultado de la operación.
Además establece el valor de la etiqueta EXIF GPSAltitudeRef con el valor 0 ("Above Sea Level").

---  
Requiere `exiftool`:  

    conda create -n exiftool  
    conda activate exiftool  
    conda install -c conda-forge exiftool  


---
Ejemplo de uso:  

Para cambiar la altitud absoluta de las imágenes en el directorio */home/gabriel/vuelo*, definiendo el valor de *15.5* metros sobre el nivel del mar como altitud al despegue:  

``
sh cambiar_altura.sh -d /home/gabriel/vuelo -m 15.5
``  

---  
Copyright (c) 2021 Gabriel De Luca  
[MIT License](https://github.com/gabriel-de-luca/cambiar_altura/blob/main/LICENSE)

