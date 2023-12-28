# Usa una imagen base oficial de Ubuntu con Java ya instalado
FROM openjdk:11-jdk

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app/DataStreaming

# Instalar Maven y Git (y cualquier otra herramienta necesaria)
RUN apt-get update && \
    apt-get install -y maven git && \
    rm -rf /var/lib/apt/lists/*

# Configurar las variables de entorno para Java y Maven
ENV JAVA_HOME /usr/local/openjdk-11
ENV MAVEN_HOME /usr/share/maven
ENV PATH $JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH

# Configuramos los volúmenes
VOLUME ["/app/DataStreaming", "/app/iac-datastreamstatejson"]

# Copia el archivo entrypoint.sh desde tu directorio local al contenedor
COPY entrypoint.sh /app/DataStreaming/entrypoint.sh

# Dale permisos de ejecución al script
RUN chmod +x /app/DataStreaming/entrypoint.sh

# Establecer variables de entorno específicas de la aplicación
ENV KAFKA_DATA_REPO /app/DataStreaming
ENV KAFKA_DATA_CONFIG /app/iac-datastreamstatejson

# Establecer el puerto por defecto si la aplicación lo necesita (modificar según sea necesario)
EXPOSE 8080

# Establecer el script de entrypoint
ENTRYPOINT ["/app/DataStreaming/entrypoint.sh"]

