# Etap budowania aplikacji (z użyciem Mavena)
FROM maven:3.8.8-eclipse-temurin-17 AS build

# Ustawienie katalogu roboczego
WORKDIR /app

# Kopiowanie pliku pom.xml i katalogu src do kontenera
COPY pom.xml . 
COPY src ./src

# Budowanie aplikacji, pomijając testy
RUN mvn clean package -DskipTests

# Etap uruchamiania aplikacji (z użyciem JDK 17)
FROM openjdk:17-jdk-slim

# Ustawienie katalogu roboczego
WORKDIR /app

# Kopiowanie pliku JAR z kontenera build do kontenera uruchamiającego
COPY --from=build /app/target/rest-service-0.0.1-SNAPSHOT.jar /app/rest-service.jar

# Wystawienie portu 8080
EXPOSE 8080

# Uruchomienie aplikacji przy starcie kontenera
ENTRYPOINT ["java", "-jar", "/app/rest-service.jar"]

