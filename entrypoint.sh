#!/bin/bash

# Este script se ejecutará al iniciar el contenedor.

# Establecer las variables de entorno dentro del contenedor
export KAFKA_DATA_REPO="/app/DataStreaming"
export KAFKA_DATA_CONFIG="/app/iac-datastreamstatejson"


# Ruta al almacén de claves donde import_certificates.sh importaría los certificados
KEYSTORE_PATH="/app/DataStreaming/temp/api.cert"

# Ruta al archivo que set_env.sh podría generar
#ENV_CONFIG_FILE="/path/to/env/config/file"

# Comprueba si el almacén de claves ya existe para determinar si se deben importar los certificados
if [ ! -f "$KEYSTORE_PATH" ]; then
    echo "--------------------------------------------"
    echo "Importando certificados..."
    echo "--------------------------------------------"
    /app/DataStreaming/scripts/import_certificates.sh
    echo "--------------------------------------------"
    echo "--------- CERTIFICADOS IMPORTADOS ---------"
    echo "--------------------------------------------"
else
    echo "--------------------------------------------"
    echo "Los certificados ya han sido importados y se encuentran configurados en tu maquina"
    echo "--------------------------------------------"
fi

# Comprueba si el archivo de configuración de entorno existe para determinar si se debe ejecutar set_env.sh
#if [ ! -f "$ENV_CONFIG_FILE" ]; then
   # echo "Configurando variables de entorno..."
    #source /app/DataStreaming/scripts/set_env.sh
#else
   # echo "Las variables de entorno ya han sido configuradas."
#fi


# Verificar si ya se ha compilado el proyecto con Maven
if [ ! -f "$KAFKA_DATA_REPO/cli/ktm-cli/target/ktm-cli.jar" ]; then
    echo "--------------------------------------------"
    echo "Compilando la aplicación CLI con Maven..."
    echo "--------------------------------------------"
    cd "$KAFKA_DATA_REPO/cli" && mvn clean install
    echo "--------------------------------------------"
    echo "CLI compilado y listo para su uso"
    echo "--------------------------------------------"

else
    echo "--------------------------------------------"
    echo "CLI compilado y listo para su uso"
    echo "--------------------------------------------"
fi

# Bucle que pide al usuario un parámetro y ejecuta ktm-cli.sh con ese parámetro
# Sale del bucle cuando el usuario introduce "exit cli"
while true; do
    echo "*********************************************"
    echo "Introduce el parámetro de ejecución para ktm-cli (o escribe 'exit cli' para salir y abrir una cosola):"
    read ktm_param

    # Comprobar si el usuario quiere salir del bucle
    if [ "$ktm_param" == "exit cli" ]; then
        echo "Saliendo y abriendo una consola..."
        break
    fi

    # Ejecutar ktm-cli.sh con el parámetro proporcionado por el usuario
    "$KAFKA_DATA_REPO/scripts/ktm-cli.sh" $ktm_param

    # Mostrar un mensaje de que el comando ha terminado
    echo "ktm-cli.sh ha terminado de ejecutarse con el parámetro: $ktm_param"
done

# Mantener el contenedor en ejecución y abrir una shell interactiva
cd /app/DataStreaming/scripts
echo "Iniciando consola ..."
exec /bin/bash
