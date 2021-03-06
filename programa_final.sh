#!/bin/bash
PROJECT="crp-dev-iac-testing"
BKT="crp-dev-iac-testing-bkt05"
LIST_BK=$(gsutil ls | grep $BKT | wc -l)

eliminar_bucket(){
    gsutil rm -r gs://$BKT
}

bucket() {
  PROJECTID="crp-dev-iac-testing"
  F_ACCESO="STANDARD"
  REGION="US"
  T_ACCESO="on"
  gsutil mb -p $PROJECTID -c $F_ACCESO -l $REGION -b $T_ACCESO gs://$BKT
  gsutil label ch -l grupo:grupo-02 gs://$BKT
  gsutil label ch -l proyecto:golondrinas gs://$BKT
  echo "Bucket generado con exito y etiquetas asignadas"
}

llenado_datos(){
  echo $LIST_BK
  if [ $LIST_BK != 0 ]; then
          echo "Existe bucket:" $BKT
  else
        bucket
  fi
}

creacion_txt(){
  echo "Creación de archivos sinceramente.txt ..."
touch ./sinceramente.txt
    for i in {1..100};do
            gsutil cp sinceramente.txt gs://$BKT/grupo-02/carpeta-$i/
    done
}

encuentra_files_no_vacios(){
     echo "Archivos no vacios: "
        for i in {1..100};do
                SIZE=$(gsutil du gs://$BKT/grupo-02/carpeta-$i/sinceramente.txt | awk '{print $1}')
                if [ $SIZE != 0 ];then
                 echo "Carpeta con datos: gs://$BKT/grupo-02/carpeta-$i"
                 echo "Contenido: " $(gsutil cat gs://$BKT/grupo-02/carpeta-$i/sinceramente.txt)
                 echo ""
                 sleep 15
                fi
        done
}

 
llenado_datos
creacion_txt
encuentra_files_no_vacios
#eliminar_bucket

