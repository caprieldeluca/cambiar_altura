#!/bin/bash
# Parámetros:
#     -d (Directorio de los archivos a escribir)
#     -m (Metros sobre el nivel del mar al despegue)

while getopts d:m: flag
do
    case "${flag}" in
        d) DIRECTORIO="${OPTARG}";;
        m) METROS=${OPTARG};;
    esac
done

rm -r "${DIRECTORIO}"/modificados
mkdir "${DIRECTORIO}"/modificados

for F in "${DIRECTORIO}"/*.JPG
do
  cp "${F}" "${DIRECTORIO}/modificados"
done

for F in "${DIRECTORIO}"/modificados/*.JPG
do
  RELATIVA=$(exiftool -b -RelativeAltitude "${F}")
  SUMA=$(echo "${METROS}${RELATIVA}" | bc)
  exiftool -GPSAltitudeRef=0 "${F}"
  exiftool -GPSAltitude=${SUMA} "${F}"
  ABSOLUTA=$(exiftool -b -GPSAltitude "${F}")
  rm "${F}"_original
done