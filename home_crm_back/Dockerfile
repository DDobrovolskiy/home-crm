# Этап сборки приложения
FROM gradle:8-jdk17 AS build
ADD .. /src
WORKDIR /app
COPY ../gradlew .
COPY gradle/wrapper/gradle-wrapper.jar gradle/wrapper/
COPY gradle/wrapper/gradle-wrapper.properties gradle/wrapper/
COPY ../build.gradle settings.gradle ./
COPY ../src ./src
RUN chmod +x gradlew
RUN ./gradlew build --no-daemon

# Этап запуска приложения
FROM eclipse-temurin:17-jre-focal
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]