FROM ubuntu:latest AS build


# Atualize o repositório e instale o OpenJDK 23 e Maven
RUN apt-get update && \
    apt-get install -y openjdk-23-jdk maven
COPY . .

RUN apt-get install maven -y
RUN mvn clean install 

FROM openjdk:23-jdk

EXPOSE 8080

COPY --from=build /target/deploy_render-1.0.0.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]