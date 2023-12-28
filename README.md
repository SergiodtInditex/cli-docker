# Guía de Implementación y Uso del Contenedor Docker para la Aplicación CLI

## Configuración del Entorno de Desarrollo

Antes de sumergirte en Docker, es crucial preparar tu entorno local con el código fuente y configuraciones. Esto garantiza que tu contenedor tenga acceso a todo lo que necesita para ejecutar la aplicación.

### Clonación de Repositorios Relevantes

#### DataStreaming
Este repositorio contiene el código fuente de la aplicación. Usa el siguiente comando para clonarlo en tu máquina local, lo que te permitirá trabajar con los archivos de la aplicación directamente desde tu entorno de desarrollo:

```shell
git clone https://InditexData@dev.azure.com/InditexData/DataStreaming/_git/DataStreaming
cd DataStreaming
```

#### iac-datastreamstatejson:
Este repositorio incluye archivos de configuración clave para la aplicación. Clonarlo te permitirá modificar y aplicar configuraciones de forma local:

```bash
git clone https://github.com/inditex/iac-datastreamstatejson.git
cd iac-datastreamstatejson
```
### Establecimiento de Variables de Entorno

Las variables de entorno `KAFKA_DATA_REPO` y `KAFKA_DATA_CONFIG` funcionan como enlaces entre tu sistema y el contenedor, facilitando el acceso a los archivos locales que son necesarios:

```bash
export KAFKA_DATA_REPO=$(pwd) # Debes ejecutarlo dentro del directorio DataStreaming
export KAFKA_DATA_CONFIG=$(pwd) # Debes ejecutarlo dentro del directorio iac-datastreamstatejson
```
## Integración con Docker

### Obtención del Dockerfile y Scripts Relacionados

#### Repositorio Docker:
Este repositorio contiene el Dockerfile y el script `entrypoint.sh`, que son fundamentales para la configuración del contenedor. Clónalos en un directorio específico para mantener organizados tus archivos relacionados con Docker:

```bash
git clone https://github.com/SergioInditex/cli-docker.git /directorio/para/docker
```
### Preparación del Script de Entrada (Entrypoint)

El archivo `entrypoint.sh` es crucial ya que define las acciones que se ejecutan cuando se inicia tu contenedor. Debes mover este archivo al directorio raíz de `DataStreaming` para asegurar que se encuentre en el lugar adecuado cuando el contenedor se ejecute:

```bash
cp /directorio/para/docker/entrypoint.sh /ruta/al/directorio/DataStreaming/ o ruta $KAFKA_DATA_REPO
```
## Instalación de Docker

Dirígete a la [página oficial de Docker](https://docs.docker.com/get-docker/) y sigue las instrucciones para instalar Docker Desktop o Docker Engine. Una vez instalado, asegúrate de que Docker está funcionando correctamente ejecutando:

```bash
docker --version
```

## Construcción del Contenedor

### Creación de la Imagen

En el directorio que contiene el Dockerfile, construye la imagen de Docker que servirá como la base para tu contenedor:

```bash
docker build -t cli-image .
```
Este paso compila los recursos necesarios y prepara un entorno que imita un sistema operativo con todo lo necesario para ejecutar tu aplicación.

## Manejo del Contenedor

### Iniciar el Contenedor

Al ejecutar el siguiente comando, le indicas a Docker que monte los directorios especificados como volúmenes dentro del contenedor. Esto permite que la aplicación acceda a ellos como si fueran parte de su sistema de archivos interno:

```bash
docker run -v ${KAFKA_DATA_REPO}:/app/DataStreaming \
           -v ${KAFKA_DATA_CONFIG}:/app/iac-datastreamstatejson \
           --name contenedor-cli \
           -it cli-image /bin/bash
```
Al abrir una sesión de bash dentro del contenedor (-it cli-image /bin/bash), proporcionas un entorno interactivo para trabajar con la aplicación.

### Interacción Posterior con el Contenedor Activo

Si necesitas volver a interactuar con un contenedor activo, el siguiente comando te brinda acceso a su terminal sin reiniciar el proceso que se ejecuta desde el `entrypoint.sh`:

```bash
docker exec -it contenedor-cli /bin/bash
```
### Detención y Eliminación

Cuando ya no necesites el contenedor, puedes utilizar los siguientes comandos para detener su ejecución y eliminarlo de tu sistema. Esto te ayudará a liberar recursos o a preparar el entorno para configurar un nuevo contenedor desde cero:

```bash
docker stop contenedor-cli
docker rm contenedor-cli
```



