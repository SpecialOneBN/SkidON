# SkidON - Репозиторий структура

## Корневая структура monorepo

```
SkidON/
├── .github/                          # GitHub Actions workflows
│   ├── workflows/
│   │   ├── ci.yml                   # Основной CI/CD pipeline
│   │   ├── security.yml             # Сканирование безопасности
│   │   ├── performance.yml          # Нагрузочное тестирование
│   │   └── release.yml              # Релизы и деплой
│   ├── ISSUE_TEMPLATE/              # Шаблоны для issues
│   ├── PULL_REQUEST_TEMPLATE.md     # Шаблон для PR
│   └── CODEOWNERS                   # Владельцы кода
│
├── services/                        # Микросервисы
│   ├── api-gateway/
│   │   ├── cmd/
│   │   │   └── main.go
│   │   ├── internal/
│   │   │   ├── delivery/
│   │   │   │   ├── http/            # REST API handlers
│   │   │   │   └── grpc/            # gRPC handlers
│   │   │   ├── service/             # Бизнес-логика
│   │   │   ├── repository/          # Работа с данными
│   │   │   ├── model/
│   │   │   │   ├── entity/          # Domain entities
│   │   │   │   └── dto/             # Data Transfer Objects
│   │   │   ├── config/              # Конфигурация
│   │   │   └── middleware/          # HTTP middleware
│   │   ├── pkg/                     # Публичные пакеты
│   │   ├── tests/
│   │   │   ├── unit/
│   │   │   ├── integration/
│   │   │   └── fixtures/
│   │   ├── migrations/              # SQL миграции
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml       # Локальная разработка
│   │   ├── go.mod
│   │   └── README.md
│   │
│   ├── parser-service/              # Сервис парсинга маркетплейсов
│   │   ├── cmd/
│   │   ├── internal/
│   │   │   ├── delivery/
│   │   │   │   ├── http/
│   │   │   │   ├── grpc/
│   │   │   │   └── consumer/        # Kafka consumers
│   │   │   ├── service/
│   │   │   │   ├── parser/          # Парсеры маркетплейсов
│   │   │   │   │   ├── ozon/
│   │   │   │   │   ├── wildberries/
│   │   │   │   │   └── aliexpress/
│   │   │   │   ├── scheduler/       # Планировщик задач
│   │   │   │   └── processor/       # Обработка данных
│   │   │   ├── repository/
│   │   │   │   ├── postgres/
│   │   │   │   ├── mongodb/
│   │   │   │   └── redis/
│   │   │   ├── model/
│   │   │   └── config/
│   │   ├── configs/                 # Конфигурации парсеров
│   │   │   ├── ozon.yaml
│   │   │   ├── wildberries.yaml
│   │   │   └── aliexpress.yaml
│   │   ├── tests/
│   │   ├── Dockerfile
│   │   ├── go.mod
│   │   └── README.md
│   │
│   ├── product-service/             # Сервис управления товарами
│   │   ├── cmd/
│   │   ├── internal/
│   │   │   ├── delivery/
│   │   │   ├── service/
│   │   │   │   ├── product/         # Управление товарами
│   │   │   │   ├── category/        # Категории
│   │   │   │   ├── discount/        # Скидки и акции
│   │   │   │   └── analytics/       # Аналитика цен
│   │   │   ├── repository/
│   │   │   ├── model/
│   │   │   └── config/
│   │   ├── migrations/
│   │   ├── tests/
│   │   ├── Dockerfile
│   │   ├── go.mod
│   │   └── README.md
│   │
│   ├── user-service/                # Сервис пользователей
│   │   ├── cmd/
│   │   ├── internal/
│   │   │   ├── delivery/
│   │   │   ├── service/
│   │   │   │   ├── auth/            # Аутентификация
│   │   │   │   ├── user/            # Управление пользователями
│   │   │   │   ├── subscription/    # Подписки
│   │   │   │   └── preference/      # Предпочтения
│   │   │   ├── repository/
│   │   │   ├── model/
│   │   │   └── config/
│   │   ├── migrations/
│   │   ├── tests/
│   │   ├── Dockerfile
│   │   ├── go.mod
│   │   └── README.md
│   │
│   ├── notification-service/        # Сервис уведомлений
│   │   ├── cmd/
│   │   ├── internal/
│   │   │   ├── delivery/
│   │   │   │   └── consumer/        # Kafka consumers
│   │   │   ├── service/
│   │   │   │   ├── email/           # Email уведомления
│   │   │   │   ├── push/            # Push уведомления
│   │   │   │   ├── telegram/        # Telegram bot
│   │   │   │   └── scheduler/       # Планировщик уведомлений
│   │   │   ├── repository/
│   │   │   ├── model/
│   │   │   └── config/
│   │   ├── templates/               # Шаблоны уведомлений
│   │   │   ├── email/
│   │   │   └── push/
│   │   ├── tests/
│   │   ├── Dockerfile
│   │   ├── go.mod
│   │   └── README.md
│   │
│   └── analytics-service/           # Сервис аналитики
│       ├── cmd/
│       ├── internal/
│       │   ├── delivery/
│       │   ├── service/
│       │   │   ├── metrics/         # Метрики системы
│       │   │   ├── reports/         # Отчеты
│       │   │   ├── trends/          # Анализ трендов
│       │   │   └── recommendations/ # Рекомендации
│       │   ├── repository/
│       │   │   ├── clickhouse/      # Аналитическая БД
│       │   │   └── elasticsearch/   # Поиск и агрегация
│       │   ├── model/
│       │   └── config/
│       ├── dashboards/              # Grafana dashboards
│       ├── tests/
│       ├── Dockerfile
│       ├── go.mod
│       └── README.md
│
├── shared/                          # Общие библиотеки
│   ├── pkg/
│   │   ├── logger/                  # Логирование
│   │   │   ├── logger.go
│   │   │   ├── zap.go
│   │   │   └── logrus.go
│   │   ├── database/                # Подключения к БД
│   │   │   ├── postgres/
│   │   │   ├── mongodb/
│   │   │   ├── redis/
│   │   │   └── clickhouse/
│   │   ├── messaging/               # Очереди сообщений
│   │   │   ├── kafka/
│   │   │   └── rabbitmq/
│   │   ├── auth/                    # JWT, OAuth
│   │   │   ├── jwt.go
│   │   │   └── oauth.go
│   │   ├── metrics/                 # Prometheus метрики
│   │   │   ├── prometheus.go
│   │   │   └── middleware.go
│   │   ├── tracing/                 # Distributed tracing
│   │   │   ├── jaeger.go
│   │   │   └── opentelemetry.go
│   │   ├── http/                    # HTTP клиенты и утилиты
│   │   │   ├── client.go
│   │   │   ├── middleware.go
│   │   │   └── response.go
│   │   ├── grpc/                    # gRPC утилиты
│   │   │   ├── client.go
│   │   │   ├── server.go
│   │   │   └── interceptor.go
│   │   ├── cache/                   # Кэширование
│   │   │   ├── redis.go
│   │   │   └── memory.go
│   │   ├── config/                  # Общие конфигурации
│   │   │   ├── config.go
│   │   │   └── env.go
│   │   ├── errors/                  # Обработка ошибок
│   │   │   ├── errors.go
│   │   │   └── codes.go
│   │   ├── validation/              # Валидация
│   │   │   ├── validator.go
│   │   │   └── rules.go
│   │   └── utils/                   # Утилиты
│   │       ├── strings.go
│   │       ├── time.go
│   │       └── crypto.go
│   │
│   ├── proto/                       # gRPC схемы
│   │   ├── user/
│   │   │   └── user.proto
│   │   ├── product/
│   │   │   └── product.proto
│   │   ├── parser/
│   │   │   └── parser.proto
│   │   ├── notification/
│   │   │   └── notification.proto
│   │   └── analytics/
│   │       └── analytics.proto
│   │
│   └── go.mod
│
├── web/                             # Frontend приложения
│   ├── admin/                       # Админ панель
│   │   ├── src/
│   │   ├── public/
│   │   ├── package.json
│   │   └── README.md
│   │
│   ├── api/                         # API документация
│   │   ├── swagger/                 # OpenAPI спецификации
│   │   │   ├── api-gateway.yaml
│   │   │   ├── product-service.yaml
│   │   │   └── user-service.yaml
│   │   └── postman/                 # Postman коллекции
│   │       ├── SkidON.postman_collection.json
│   │       └── environments/
│   │
│   └── landing/                     # Landing page
│       ├── src/
│       ├── public/
│       ├── package.json
│       └── README.md
│
├── deploy/                          # Развертывание
│   ├── docker/
│   │   ├── docker-compose.yml       # Полная среда
│   │   ├── docker-compose.dev.yml   # Разработка
│   │   ├── docker-compose.prod.yml  # Продакшн
│   │   └── docker-compose.monitoring.yml # Мониторинг
│   │
│   ├── kubernetes/                  # K8s манифесты
│   │   ├── base/                    # Базовые манифесты
│   │   │   ├── namespace.yaml
│   │   │   ├── configmap.yaml
│   │   │   ├── secret.yaml
│   │   │   ├── services/
│   │   │   └── deployments/
│   │   ├── overlays/                # Kustomize overlays
│   │   │   ├── development/
│   │   │   ├── staging/
│   │   │   └── production/
│   │   └── monitoring/              # Мониторинг в K8s
│   │       ├── prometheus/
│   │       ├── grafana/
│   │       └── jaeger/
│   │
│   ├── helm/                        # Helm charts
│   │   ├── skidon/
│   │   │   ├── Chart.yaml
│   │   │   ├── values.yaml
│   │   │   ├── values-dev.yaml
│   │   │   ├── values-prod.yaml
│   │   │   └── templates/
│   │   └── monitoring/
│   │       ├── Chart.yaml
│   │       ├── values.yaml
│   │       └── templates/
│   │
│   └── terraform/                   # Infrastructure as Code
│       ├── aws/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   ├── outputs.tf
│       │   └── modules/
│       ├── gcp/
│       └── azure/
│
├── scripts/                         # Утилиты и скрипты
│   ├── migrations/                  # Миграции БД
│   │   ├── postgres/
│   │   │   ├── 001_init.up.sql
│   │   │   ├── 001_init.down.sql
│   │   │   ├── 002_users.up.sql
│   │   │   └── 002_users.down.sql
│   │   └── mongodb/
│   │       ├── 001_init.js
│   │       └── 002_indexes.js
│   │
│   ├── seed/                        # Тестовые данные
│   │   ├── users.json
│   │   ├── products.json
│   │   └── categories.json
│   │
│   ├── generators/                  # Генераторы кода
│   │   ├── service-generator.sh
│   │   ├── migration-generator.sh
│   │   └── proto-generator.sh
│   │
│   ├── build/                       # Скрипты сборки
│   │   ├── build-all.sh
│   │   ├── build-docker.sh
│   │   └── release.sh
│   │
│   ├── performance/                 # Нагрузочное тестирование
│   │   ├── k6/
│   │   │   ├── load-test.js
│   │   │   ├── stress-test.js
│   │   │   └── scenarios/
│   │   └── artillery/
│   │       ├── config.yml
│   │       └── scenarios/
│   │
│   └── monitoring/                  # Настройки мониторинга
│       ├── prometheus/
│       │   ├── prometheus.yml
│       │   └── rules/
│       ├── grafana/
│       │   ├── dashboards/
│       │   └── datasources/
│       └── alertmanager/
│           └── alertmanager.yml
│
├── docs/                            # Документация
│   ├── architecture/                # Архитектурная документация
│   │   ├── README.md
│   │   ├── system-design.md
│   │   ├── data-flow.md
│   │   ├── service-communication.md
│   │   └── diagrams/
│   │       ├── system-architecture.puml
│   │       ├── service-interaction.puml
│   │       └── database-schema.puml
│   │
│   ├── api/                         # API документация
│   │   ├── README.md
│   │   ├── authentication.md
│   │   ├── rate-limiting.md
│   │   └── changelog.md
│   │
│   ├── deployment/                  # Руководства по развертыванию
│   │   ├── local-development.md
│   │   ├── docker-setup.md
│   │   ├── kubernetes-setup.md
│   │   └── production-deployment.md
│   │
│   ├── monitoring/                  # Мониторинг и наблюдаемость
│   │   ├── metrics.md
│   │   ├── logging.md
│   │   ├── tracing.md
│   │   └── alerting.md
│   │
│   └── contributing/                # Для разработчиков
│       ├── README.md
│       ├── code-style.md
│       ├── testing.md
│       └── release-process.md
│
├── tools/                           # Инструменты разработки
│   ├── docker/                      # Docker утилиты
│   │   ├── dev.Dockerfile
│   │   └── multi-stage.Dockerfile
│   │
│   ├── proto/                       # Protobuf утилиты
│   │   ├── generate.sh
│   │   └── validate.sh
│   │
│   └── linting/                     # Линтеры и форматеры
│       ├── .golangci.yml
│       ├── .editorconfig
│       └── .prettierrc
│
├── tests/                           # Интеграционные тесты
│   ├── integration/                 # Интеграционное тестирование
│   │   ├── api/
│   │   ├── database/
│   │   └── messaging/
│   │
│   ├── e2e/                         # End-to-end тесты
│   │   ├── scenarios/
│   │   └── fixtures/
│   │
│   └── contract/                    # Contract тестирование
│       ├── pact/
│       └── schemas/
│
├── configs/                         # Конфигурационные файлы
│   ├── development/
│   │   ├── config.yaml
│   │   └── .env
│   ├── staging/
│   │   ├── config.yaml
│   │   └── .env
│   ├── production/
│   │   ├── config.yaml
│   │   └── .env
│   └── local/
│       ├── config.yaml
│       └── .env
│
├── .github/                         # GitHub конфигурация
├── .gitignore                       # Git ignore правила
├── .editorconfig                    # Настройки редактора
├── .golangci.yml                    # Конфигурация линтера
├── Makefile                         # Команды сборки и развертывания
├── docker-compose.yml               # Основной docker-compose
├── go.work                          # Go workspace
├── go.work.sum                      # Go workspace sum
├── LICENSE                          # Лицензия
└── README.md                        # Основная документация
```

## Описание структуры

### `/services/` - Микросервисы
Каждый микросервис имеет собственную структуру с четким разделением слоев:
- **cmd/** - точки входа приложения
- **internal/** - внутренняя логика (не экспортируется)
- **pkg/** - публичные пакеты (могут использоваться другими сервисами)
- **tests/** - тесты специфичные для сервиса

### `/shared/` - Общие библиотеки
Переиспользуемые компоненты между сервисами:
- **pkg/** - общие Go пакеты
- **proto/** - gRPC схемы

### `/deploy/` - Развертывание
Все конфигурации для развертывания:
- **docker/** - Docker Compose файлы
- **kubernetes/** - K8s манифесты с Kustomize
- **helm/** - Helm charts
- **terraform/** - Infrastructure as Code

### `/scripts/` - Утилиты
Скрипты для автоматизации:
- **migrations/** - миграции БД
- **seed/** - тестовые данные
- **performance/** - нагрузочное тестирование

### `/docs/` - Документация
Полная техническая документация проекта

### `/tests/` - Интеграционные тесты
Тесты уровня системы, которые тестируют взаимодействие между сервисами