#Programa final

BKT="crp-dev-iac-testing-btk05"

bucket() {
  PROJECTID="crp-dev-iac-testing"
  F_ACCESO="STANDARD"
  REGION="US"
  T_ACCESO="on"
  gsutil mb -p $PROJECTID -c $F_ACCESO -l $REGION -b $T_ACCESO gs://$BKT
}

eliminar_bucket(){
    gsutil rm -r gs://$BKT
}

nueva_carpeta(){
  mkdir grupo-02
  echo "Creando carpeta 'grupo-02'"
  gcloud alpha storage ls --recursive gs://$BKT
}

ingresa_grupo_02(){
    cd grupo-02
    echo "Ingresando a carpeta 'grupo-02'"
}

genera_carpetas(){
    for i in {1..100}; do
        mkdir carpeta-$i
        gsutil cp carpeta-$i gs://$BKT
        #rm -r carpeta-$i
        echo carpeta-$i generada
     done
     echo "100 nuevas carpetas"
     ls
}

 
# funciones
bucket
nueva_carpeta
lista_nueva_carpeta
ingresa_grupo_02
genera_carpetas
#eliminar_bucket

