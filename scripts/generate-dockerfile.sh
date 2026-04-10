
#!/bin/bash

cat << 'EOF' > Dockerfile
# ===== Build Stage =====

FROM eclipse-temurin:21.0.8_9-jdk-jammy AS builder
WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline
COPY ./src ./src
RUN ./mvnw clean install -DskipITs -Dmaven.failsafe.skip=true

# ===== Runtime Stage =====
FROM eclipse-temurin:21.0.8_9-jre-jammy AS final
WORKDIR /app
EXPOSE 8080
COPY --from=builder /app/target/*.jar app.ja
ENTRYPOINT ["java", "-jar", "app.jar"]
EOF
