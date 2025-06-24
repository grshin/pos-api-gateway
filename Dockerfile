# Build stage
FROM gradle:8.4-jdk17 AS build
WORKDIR /app

# 루트 프로젝트의 settings.gradle, build.gradle 및 gradle wrapper 복사
COPY settings.gradle build.gradle gradle.properties ./
COPY gradle ./gradle

# 서브모듈 소스 복사 (전체 복사 권장)
COPY pos-api-gateway ./pos-api-gateway
COPY pos-common ./pos-common
COPY pos-order-service ./pos-order-service
COPY pos-inventory-service ./pos-inventory-service

# API Gateway 모듈 빌드
RUN gradle :pos-api-gateway:bootJar --no-daemon

# Runtime stage
FROM eclipse-temurin:17-jre
WORKDIR /app

# 빌드 산출물 복사
COPY --from=build /app/pos-api-gateway/build/libs/pos-api-gateway-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
