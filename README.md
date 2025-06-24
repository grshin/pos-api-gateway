# pos-api-gateway

## 개요

`pos-api-gateway`는 Spring Cloud Gateway를 기반으로 하는 API Gateway 서비스입니다.  
`order-service`와 `inventory-service`를 프록시하여 클라이언트 요청을 각 서비스로 라우팅합니다.

## 주요 기능

- `/api/orders/**` 요청을 `order-service` (`http://localhost:8081`)로 전달
- `/api/inventory/**` 요청을 `inventory-service` (`http://localhost:8082`)로 전달
- 간단한 고정 URL 라우팅 구성
- 향후 Eureka 등 서비스 디스커버리 연동 가능

## 환경 설정

- Java 17 이상
- Spring Boot 3.1.x
- Spring Cloud 2022.0.x

## 실행 방법

1. `order-service` 와 `inventory-service`가 각각 포트 8081, 8082에서 실행 중이어야 합니다.
2. `pos-api-gateway` 프로젝트 루트에서 빌드 및 실행:

```bash
./gradlew clean build
./gradlew bootRun
```

3. Gateway는 기본적으로 포트 8080에서 실행됩니다.

## 테스트

아래 명령어로 Gateway 경유 서비스 접근을 테스트할 수 있습니다.

```bash
curl http://localhost:8080/api/orders/test
curl http://localhost:8080/api/inventory/test
```

정상적으로 서비스 응답이 돌아오면 Gateway 설정이 올바른 것입니다.

## `application.yml` 예시

```yaml
server:
  port: 8080

spring:
  application:
    name: pos-api-gateway

  cloud:
    gateway:
      routes:
        - id: pos-order-service
          uri: http://localhost:8081
          predicates:
            - Path=/api/orders/**
        - id: pos-inventory-service
          uri: http://localhost:8082
          predicates:
            - Path=/api/inventory/**
```

## 향후 개선 방향

- Eureka 기반 서비스 디스커버리 및 로드 밸런싱 적용
- 인증 및 인가 필터 추가
- 요청/응답 로깅 및 모니터링 강화
- Docker 및 Kubernetes 배포 구성

---

## 👤 Author

- **grshin**
- [GitHub](https://github.com/grshin/pos-api-gateway)
