# DS deliverable 2 Readme

# Energy Utility Platform - Microservices

A distributed system for managing energy consumption devices, users, and real-time monitoring using a microservices architecture.

## Contents

## Project structure

```
./
├── DeviceDataSimulator
│   ├── config.properties
│   ├── pom.xml
│   ├── src
│   │   ├── main
│   │   │   ├── java
│   │   │   │   └── Simulator.java
│   │   │   └── resources
│   │   └── test
│   │       └── java
│   └── target
│       ├── classes
│       │   └── Simulator.class
│       └── generated-sources
│           └── annotations
├── device-service
│   ├── Dockerfile
│   ├── mvnw
│   ├── mvnw.cmd
│   ├── pom.xml
│   ├── postman_collection.json
│   ├── src
│   │   ├── main
│   │   │   ├── java
│   │   │   │   └── com
│   │   │   │       └── example
│   │   │   │           └── demo
│   │   │   │               ├── config
│   │   │   │               │   ├── RabbitConfig.java
│   │   │   │               │   ├── SecurityConfig.java
│   │   │   │               │   └── WebClientConfig.java
│   │   │   │               ├── controllers
│   │   │   │               │   └── DeviceController.java
│   │   │   │               ├── DemoApplication.java
│   │   │   │               ├── dtos
│   │   │   │               │   ├── builders
│   │   │   │               │   ├── DeviceDTO.java
│   │   │   │               │   └── validators
│   │   │   │               │       └── annotation
│   │   │   │               ├── entities
│   │   │   │               │   └── Device.java
│   │   │   │               ├── handlers
│   │   │   │               │   ├── exceptions
│   │   │   │               │   │   └── model
│   │   │   │               │   │       ├── CustomException.java
│   │   │   │               │   │       ├── ExceptionHandlerResponseDTO.java
│   │   │   │               │   │       └── ResourceNotFoundException.java
│   │   │   │               │   └── RestExceptionHandler.java
│   │   │   │               ├── messaging
│   │   │   │               │   └── DeviceSyncListener.java
│   │   │   │               ├── repositories
│   │   │   │               │   └── DeviceRepository.java
│   │   │   │               └── services
│   │   │   │                   └── DeviceService.java
│   │   │   └── resources
│   │   │       └── application.properties
│   │   └── test
│   │       └── java
│   │           └── com
│   │               └── example
│   │                   └── demo
│   │                       └── DemoApplicationTests.java
│   └── target
│       ├── classes
│       │   ├── application.properties
│       │   └── com
│       │       └── example
│       │           └── demo
│       │               ├── controllers
│       │               │   ├── DeviceController.class
│       │               │   └── PersonController.class
│       │               ├── DemoApplication.class
│       │               ├── dtos
│       │               │   ├── builders
│       │               │   │   └── PersonBuilder.class
│       │               │   ├── DeviceDetailsDTO.class
│       │               │   ├── DeviceDTO.class
│       │               │   ├── PersonDetailsDTO.class
│       │               │   ├── PersonDTO.class
│       │               │   └── validators
│       │               │       ├── AgeValidator.class
│       │               │       └── annotation
│       │               │           └── AgeLimit.class
│       │               ├── entities
│       │               │   ├── Device.class
│       │               │   └── Person.class
│       │               ├── handlers
│       │               │   ├── exceptions
│       │               │   │   └── model
│       │               │   │       ├── CustomException.class
│       │               │   │       ├── ExceptionHandlerResponseDTO.class
│       │               │   │       └── ResourceNotFoundException.class
│       │               │   └── RestExceptionHandler.class
│       │               ├── repositories
│       │               │   ├── DeviceRepository.class
│       │               │   └── PersonRepository.class
│       │               └── services
│       │                   ├── DeviceService.class
│       │                   └── PersonService.class
│       └── generated-sources
│           └── annotations
├── docker-compose.yml
├── frontend
│   ├── Dockerfile
│   ├── node_modules
│   ├── package.json
│   ├── package-lock.json
│   ├── public
│   │   ├── favicon.ico
│   │   ├── index.html
│   │   ├── logo192.png
│   │   ├── logo512.png
│   │   ├── manifest.json
│   │   └── robots.txt
│   ├── README.md
│   └── src
│       ├── App.css
│       ├── App.js
│       ├── App.test.js
│       ├── components
│       │   ├── Devices.js
│       │   ├── EnergyMonitoring.js
│       │   └── Persons.js
│       ├── index.css
│       ├── index.js
│       ├── logo.svg
│       ├── reportWebVitals.js
│       └── setupTests.js
├── monitoring-service
│   ├── Dockerfile
│   ├── HELP.md
│   ├── mvnw
│   ├── mvnw.cmd
│   ├── pom.xml
│   ├── src
│   │   ├── main
│   │   │   ├── java
│   │   │   │   └── com
│   │   │   │       ├── config
│   │   │   │       │   ├── RabbitConfig.java
│   │   │   │       │   └── RabbitConverterConfig.java
│   │   │   │       ├── controllers
│   │   │   │       │   └── MonitoringController.java
│   │   │   │       ├── dtos
│   │   │   │       │   └── SensorRecordDTO.java
│   │   │   │       ├── entities
│   │   │   │       │   ├── HourlyConsumption.java
│   │   │   │       │   └── MonitoredDevice.java
│   │   │   │       ├── messaging
│   │   │   │       │   ├── DeviceSyncConsumer.java
│   │   │   │       │   └── SensorDataConsumer.java
│   │   │   │       ├── MonitoringServiceApplication.java
│   │   │   │       ├── repositories
│   │   │   │       │   ├── HourlyConsumptionRepository.java
│   │   │   │       │   └── MonitoredDeviceRepository.java
│   │   │   │       └── services
│   │   │   │           └── MonitoringService.java
│   │   │   └── resources
│   │   │       └── application.properties
│   │   └── test
│   │       └── java
│   │           ├── com
│   │           │   └── MonitoringServiceApplicationTests.java
│   │           └── org
│   │               └── example
│   └── target
│       └── classes
│           └── application.properties
├── person-service
│   ├── Dockerfile
│   ├── mvnw
│   ├── mvnw.cmd
│   ├── pom.xml
│   ├── postman_collection.json
│   ├── src
│   │   ├── main
│   │   │   ├── java
│   │   │   │   └── com
│   │   │   │       └── example
│   │   │   │           └── demo
│   │   │   │               ├── config
│   │   │   │               │   ├── RabbitConfig.java
│   │   │   │               │   ├── SecurityConfig.java
│   │   │   │               │   └── WebClientConfig.java
│   │   │   │               ├── controllers
│   │   │   │               │   └── PersonController.java
│   │   │   │               ├── DemoApplication.java
│   │   │   │               ├── dtos
│   │   │   │               │   ├── builders
│   │   │   │               │   │   └── PersonBuilder.java
│   │   │   │               │   ├── DeviceDTO.java
│   │   │   │               │   ├── PersonDetailsDTO.java
│   │   │   │               │   ├── PersonDTO.java
│   │   │   │               │   └── validators
│   │   │   │               │       ├── AgeValidator.java
│   │   │   │               │       └── annotation
│   │   │   │               │           └── AgeLimit.java
│   │   │   │               ├── entities
│   │   │   │               │   └── Person.java
│   │   │   │               ├── handlers
│   │   │   │               │   ├── exceptions
│   │   │   │               │   │   └── model
│   │   │   │               │   │       ├── CustomException.java
│   │   │   │               │   │       ├── ExceptionHandlerResponseDTO.java
│   │   │   │               │   │       └── ResourceNotFoundException.java
│   │   │   │               │   └── RestExceptionHandler.java
│   │   │   │               ├── repositories
│   │   │   │               │   └── PersonRepository.java
│   │   │   │               └── services
│   │   │   │                   └── PersonService.java
│   │   │   └── resources
│   │   │       └── application.properties
│   │   └── test
│   │       └── java
│   │           └── com
│   │               └── example
│   │                   └── demo
│   │                       └── DemoApplicationTests.java
│   └── target
│       ├── classes
│       │   ├── application.properties
│       │   └── com
│       │       └── example
│       │           └── demo
│       │               ├── config
│       │               │   ├── RabbitConfig.class
│       │               │   ├── SecurityConfig.class
│       │               │   └── WebClientConfig.class
│       │               ├── controllers
│       │               │   ├── DeviceController.class
│       │               │   └── PersonController.class
│       │               ├── DemoApplication.class
│       │               ├── dtos
│       │               │   ├── builders
│       │               │   │   └── PersonBuilder.class
│       │               │   ├── DeviceDetailsDTO.class
│       │               │   ├── DeviceDTO.class
│       │               │   ├── PersonDetailsDTO.class
│       │               │   ├── PersonDTO.class
│       │               │   └── validators
│       │               │       ├── AgeValidator.class
│       │               │       └── annotation
│       │               │           └── AgeLimit.class
│       │               ├── entities
│       │               │   ├── Device.class
│       │               │   └── Person.class
│       │               ├── handlers
│       │               │   ├── exceptions
│       │               │   │   └── model
│       │               │   │       ├── CustomException.class
│       │               │   │       ├── ExceptionHandlerResponseDTO.class
│       │               │   │       └── ResourceNotFoundException.class
│       │               │   └── RestExceptionHandler.class
│       │               ├── repositories
│       │               │   ├── DeviceRepository.class
│       │               │   └── PersonRepository.class
│       │               └── services
│       │                   ├── DeviceService.class
│       │                   └── PersonService.class
│       └── generated-sources
│           └── annotations
├── README.md
└── traefik
    └── traefik.yml

```

- `src/main/...` — SpringBoot source
- `src/main/resources/application.properties` — app configuration
- `postman_collection.json` — Postman collection to import
- `pom.xml` — Maven project wht Spring Boot 4.0.0-SNAPSHOT and Java 25

## System Architecture

The platform is composed of three main services and a gateway:

- **User/Device Service:** Handles CRUD for persons and devices.
- **Monitoring Service:** Consumes sensor data and tracks hourly energy consumption.
- **Simulator:** A standalone component that streams energy readings via RabbitMQ.
- **Traefik Gateway:** Acts as a Reverse Proxy, routing frontend requests to the correct backend service.

## Communication Patterns

### **Event-Driven Synchronization (RabbitMQ)**

When a device is created or updated in the **Device Service**, it publishes a message to the **device-sync-queue**. The **Monitoring Service** listens to this queue to keep its local database in sync.

- **Goal:** Maintain data consistency across services without tight coupling.

### **Telemetry Data Streaming**

The **Simulator** publishes sensor readings to the `sensor.queue`. The Monitoring Service aggregates these readings into hourly buckets.

- **Normalization:** Timestamps are rounded to the nearest hour using:
    
    $$
    ⁍
    $$
    

## Technology Stack

| **Component** | **Technology** |
| --- | --- |
| **Frontend** | React, Chart.js, React Router |
| **Backends** | Spring Boot, Spring Data JPA |
| **Database** | PostgreSQL (separate instances per service) |
| **Messaging** | RabbitMQ |
| **Proxy/Gateway** | Traefik |
| **Containerization** | Docker, Docker Compose |

## Setup and Installation

### **Prerequisites**

- Docker & Docker Compose installed.

### **Running the System**

1. Navigate to the project root directory.
2. Build and start all containers:Bash

```bash
docker-compose up -d --build
```

1. The frontend will be available at **http://localhost:80**.

## API Endpoints

### **Device Service**

- `GET /devices` - Retrieve all devices.
- `POST /devices` - Create a new device (triggers RabbitMQ sync).

### **Monitoring Service**

- `GET /monitoring/history?deviceId={id}&date={yyyy-MM-dd}` - Returns 24-hour consumption data for the chart.