#
#Build
#
FROM maven:3.9.9-eclipse-temurin-17 AS build
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
COPY . $HOME
RUN mvn -f $HOME/pom.xml clean package

#
#RUN
#
FROM openjdk:17-slim
RUN mkdir -p /usr/webapp
COPY --from=build /usr/app/target/*.jar /usr/webapp/app.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","/usr/webapp/app.jar"]
