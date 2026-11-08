# Build context: service root.
#   docker compose up -d --build
# glibc-based JDK: protoc-gen-grpc-java publishes linux binaries linked against glibc (Alpine/musl cannot run them).
# JDK 25 official images use Ubuntu Noble.
FROM eclipse-temurin:25-jdk-noble AS builder

WORKDIR /app

COPY gradlew .
COPY gradle gradle
COPY settings.gradle .
COPY build.gradle .

RUN chmod +x gradlew

RUN ./gradlew dependencies --no-daemon

COPY src src

RUN ./gradlew bootJar --no-daemon


# Execution stage
FROM eclipse-temurin:25-jre-alpine

WORKDIR /app

RUN addgroup -S spring && adduser -S spring -G spring

COPY --from=builder /app/build/libs/*.jar app.jar
RUN mkdir -p /app/config && chown -R spring:spring /app

RUN echo '#!/bin/sh' > /app/entrypoint.sh && \
    echo 'exec su-exec spring:spring java -Djava.security.egd=file:/dev/./urandom -Dspring.profiles.active=${SPRING_PROFILES_ACTIVE:-prod} -jar /app/app.jar "$@"' >> /app/entrypoint.sh && \
    chmod +x /app/entrypoint.sh

USER root
RUN apk add --no-cache su-exec wget

ENTRYPOINT ["/app/entrypoint.sh"]
