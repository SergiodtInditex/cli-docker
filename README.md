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
