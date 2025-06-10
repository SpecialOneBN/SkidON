# 🛍️ SkidON - Intelligent Discount Aggregator

[![CI/CD](https://github.com/yourusername/SkidON/workflows/CI%2FCD%20Pipeline/badge.svg)](https://github.com/yourusername/SkidON/actions)
[![Go Report Card](https://goreportcard.com/badge/github.com/yourusername/SkidON)](https://goreportcard.com/report/github.com/yourusername/SkidON)
[![Coverage Status](https://codecov.io/gh/yourusername/SkidON/branch/main/graph/badge.svg)](https://codecov.io/gh/yourusername/SkidON)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Go Version](https://img.shields.io/github/go-mod/go-version/yourusername/SkidON)](https://golang.org/)

> **SkidON** - это высокопроизводительная система агрегации скидок, которая парсит популярные маркетплейсы и предоставляет пользователям актуальную информацию о лучших предложениях в режиме реального времени.

## 🎯 Основные возможности

- **🔍 Интеллектуальный парсинг** - Автоматический сбор данных с популярных маркетплейсов (Ozon, Wildberries, AliExpress, М.Видео)
- **⚡ Real-time обновления** - Мгновенные уведомления о новых скидках через Kafka
- **🎯 Персонализация** - Подписки на категории товаров и персональные рекомендации
- **📊 Аналитика** - Анализ трендов цен и эффективности скидок
- **🚀 High Performance** - Микросервисная архитектура с горизонтальным масштабированием
- **🔐 Enterprise Security** - JWT аутентификация, rate limiting, мониторинг безопасности

## 🏗️ Архитектура

### Микросервисы

| Сервис                     | Описание                                    | Технологии                    |
|----------------------------|---------------------------------------------|-------------------------------|
| **API Gateway**            | Единая точка входа, роутинг, аутентификация | Go, Gin, JWT                  |
| **Parser Service**         | Парсинг маркетплейсов, обработка данных     | Go, Colly, Chromedp           |
| **Product Service**        | Управление товарами, категориями, скидками  | Go, PostgreSQL, MongoDB       |
| **User Service**           | Управление пользователями, подписками       | Go, PostgreSQL, Redis         |
| **Notification Service**   | Email, Push, Telegram уведомления           | Go, Kafka, SMTP               |
| **Analytics Service**      | Метрики, отчеты, рекомендации               | Go, ClickHouse, Elasticsearch |

### Технологический стек

**Backend:**
- **Go 1.21+** - Основной язык программирования
- **PostgreSQL** - Реляционные данные (пользователи, подписки)
- **MongoDB** - Документы (товары, история цен)
- **Redis** - Кэширование, сессии, очереди
- **Apache Kafka** - Асинхронный обмен сообщениями
- **ClickHouse** - Аналитическая база данных

**Infrastructure:**
- **Docker & Docker Compose** - Контейнеризация
- **Kubernetes** - Оркестрация контейнеров
- **Helm** - Управление Kubernetes приложениями
- **Terraform** - Infrastructure as Code

**Observability:**
- **Prometheus** - Сбор метрик
- **Grafana** - Визуализация и dashboards
- **Jaeger** - Distributed tracing
- **ELK Stack** - Централизованное логирование

## 🚀 Quick Start

### Предварительные требования

- Go 1.21+
- Docker & Docker Compose
- Make
- Git

### Локальная разработка

```bash
# Клонирование репозитория
git clone https://github.com/SpecialOneBN/SkidON.git
cd SkidON

# Запуск всех сервисов
make dev

# Или пошагово:
make deps        # Установка зависимостей
make proto-gen   # Генерация gRPC кода
make build       # Сборка всех сервисов
make docker-up   # Запуск инфраструктуры
```

### Доступ к сервисам

| Сервис      | URL                    | Описание                 |
|-------------|------------------------|--------------------------|
| API Gateway | http://localhost:8080  | REST API                 |
| Grafana     | http://localhost:3000  | Мониторинг (admin/admin) |
| Prometheus  | http://localhost:9090  | Метрики                  |
| Jaeger      | http://localhost:16686 | Трейсинг                 |
| Kafka UI    | http://localhost:8081  | Управление Kafka         |

### API Примеры

```bash
# Получить топ скидки
curl http://localhost:8080/api/v1/deals/top

# Регистрация пользователя
curl -X POST http://localhost:8080/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"password123"}'

# Подписка на категорию
curl -X POST http://localhost:8080/api/v1/subscriptions \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"category":"electronics","notification_types":["email","push"]}'
```

## 📁 Структура проекта

```
SkidON/
├── services/           # Микросервисы
│   ├── api-gateway/
│   ├── parser-service/
│   ├── product-service/
│   ├── user-service/
│   ├── notification-service/
│   └── analytics-service/
├── shared/             # Общие библиотеки
├── deploy/             # Развертывание (Docker, K8s, Helm)
├── docs/               # Документация
├── scripts/            # Утилиты и миграции
└── tests/              # Интеграционные тесты
```

Подробное описание структуры: [Repository Structure](./docs/architecture/repository-structure.md)

## 🔧 Разработка

### Основные команды

```bash
# Сборка
make build                    # Собрать все сервисы
make build-service SERVICE=api-gateway  # Собрать конкретный сервис

# Тестирование
make test                     # Unit тесты
make test-integration         # Интеграционные тесты
make benchmark               # Бенчмарки

# Качество кода
make lint                     # Линтинг
make format                   # Форматирование
make security                 # Проверка безопасности

# Docker
make docker-build             # Сборка образов
make docker-up               # Запуск сервисов
make docker-down             # Остановка сервисов

# Базы данных
make migrate-up              # Применить миграции
make migrate-down            # Откатить миграции
```

### Создание нового сервиса

```bash
# Генерация структуры нового сервиса
./scripts/generators/service-generator.sh my-new-service

# Генерация миграции
./scripts/generators/migration-generator.sh create_users_table
```

### Архитектурные принципы

- **Clean Architecture** - Четкое разделение слоев
- **Domain-Driven Design** - Доменно-ориентированный подход
- **SOLID принципы** - Качественный код
- **12-Factor App** - Современные практики разработки
- **Event-Driven Architecture** - Асинхронная обработка

## 📊 Мониторинг и наблюдаемость

### Метрики

- **System Metrics**: CPU, Memory, Disk, Network
- **Application Metrics**: Response time, Throughput, Error rate
- **Business Metrics**: Parsed products/hour, Active users, Notification delivery rate
- **Parser Metrics**: Success rate per marketplace, Parsing speed, Error frequency

### Dashboards

- **System Overview** - Общее состояние системы
- **Parser Performance** - Производительность парсеров
- **User Activity** - Активность пользователей
- **Business KPIs** - Ключевые показатели бизнеса

### Алерты

- High error rate (>5%)
- High response time (>1s)
- Parser failures
- Database connection issues
- Queue overflow

## 🚀 Развертывание

### Development

```bash
make dev  # Локальная разработка
```

### Staging