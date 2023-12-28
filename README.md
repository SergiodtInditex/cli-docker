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
