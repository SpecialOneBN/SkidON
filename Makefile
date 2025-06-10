# Makefile
.PHONY: help build test lint clean docker-build docker-up docker-down proto-gen migrate-up migrate-down

# Переменные
SERVICES := api-gateway parser-service product-service user-service notification-service
DOCKER_COMPOSE := docker-compose -f docker-compose.yml
BIN_DIR := ./bin
PROTO_DIR := ./proto
MIGRATION_DIR := ./scripts/migrations

# Цвета для вывода
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

## help: Показать это сообщение
help:
	@echo "$(BLUE)SkidON - Система агрегации скидок$(NC)"
	@echo ""
	@echo "$(YELLOW)Доступные команды:$(NC)"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

## build: Собрать все сервисы
build:
	@echo "$(BLUE)Сборка всех сервисов...$(NC)"
	@mkdir -p $(BIN_DIR)
	@for service in $(SERVICES); do \
		echo "$(GREEN)Сборка $$service...$(NC)"; \
		cd $$service && go build -ldflags="-s -w" -o ../$(BIN_DIR)/$$service ./cmd && cd ..; \
	done
	@echo "$(GREEN)Сборка завершена!$(NC)"

## build-service: Собрать конкретный сервис (make build-service SERVICE=api-gateway)
build-service:
	@if [ -z "$(SERVICE)" ]; then \
		echo "$(RED)Ошибка: укажите SERVICE (например: make build-service SERVICE=api-gateway)$(NC)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Сборка $(SERVICE)...$(NC)"
	@mkdir -p $(BIN_DIR)
	@cd $(SERVICE) && go build -ldflags="-s -w" -o ../$(BIN_DIR)/$(SERVICE) ./cmd
	@echo "$(GREEN)$(SERVICE) собран!$(NC)"

## test: Запустить тесты
test:
	@echo "$(BLUE)Запуск тестов...$(NC)"
	@go test -v -race -coverprofile=coverage.out ./...
	@go tool cover -html=coverage.out -o coverage.html
	@echo "$(GREEN)Тесты завершены! Отчет: coverage.html$(NC)"

## test-integration: Запустить интеграционные тесты
test-integration:
	@echo "$(BLUE)Запуск интеграционных тестов...$(NC)"
	@$(DOCKER_COMPOSE) up -d postgres redis
	@sleep 5
	@go test -v -tags=integration ./...
	@$(DOCKER_COMPOSE) down
	@echo "$(GREEN)Интеграционные тесты завершены!$(NC)"

## lint: Запустить линтер
lint:
	@echo "$(BLUE)Запуск линтера...$(NC)"
	@golangci-lint run --timeout=5m ./...
	@echo "$(GREEN)Линтинг завершен!$(NC)"

## format: Форматировать код
format:
	@echo "$(BLUE)Форматирование кода...$(NC)"
	@gofmt -s -w .
	@goimports -w .
	@echo "$(GREEN)Код отформатирован!$(NC)"

## clean: Очистить собранные файлы
clean:
	@echo "$(BLUE)Очистка...$(NC)"
	@rm -rf $(BIN_DIR)
	@rm -f coverage.out coverage.html
	@docker system prune -f
	@echo "$(GREEN)Очистка завершена!$(NC)"

## docker-build: Собрать Docker образы
docker-build:
	@echo "$(BLUE)Сборка Docker образов...$(NC)"
	@for service in $(SERVICES); do \
		echo "$(GREEN)Сборка образа $$service...$(NC)"; \
		docker build -t skidon/$$service:latest ./$$service; \
	done
	@echo "$(GREEN)Docker образы собраны!$(NC)"

## docker-up: Запустить все сервисы в Docker
docker-up:
	@echo "$(BLUE)Запуск сервисов в Docker...$(NC)"
	@$(DOCKER_COMPOSE) up -d
	@echo "$(GREEN)Сервисы запущены!$(NC)"
	@echo "$(YELLOW)API Gateway: http://localhost:8080$(NC)"
	@echo "$(YELLOW)Grafana: http://localhost:3000$(NC)"
	@echo "$(YELLOW)Prometheus: http://localhost:9090$(NC)"

## docker-down: Остановить все сервисы
docker-down:
	@echo "$(BLUE)Остановка сервисов...$(NC)"
	@$(DOCKER_COMPOSE) down -v
	@echo "$(GREEN)Сервисы остановлены!$(NC)"

## docker-logs: Показать логи сервисов
docker-logs:
	@$(DOCKER_COMPOSE) logs -f

## proto-gen: Генерация gRPC кода
proto-gen:
	@echo "$(BLUE)Генерация gRPC кода...$(NC)"
	@mkdir -p shared/proto
	@protoc --go_out=. --go_opt=paths=source_relative \
		--go-grpc_out=. --go-grpc_opt=paths=source_relative \
		$(PROTO_DIR)/*.proto
	@echo "$(GREEN)gRPC код сгенерирован!$(NC)"

## migrate-up: Применить миграции БД
migrate-up:
	@echo "$(BLUE)Применение миграций...$(NC)"
	@migrate -path $(MIGRATION_DIR) -database "postgres://user:password@localhost:5432/skidon?sslmode=disable" up
	@echo "$(GREEN)Миграции применены!$(NC)"

## migrate-down: Откатить миграции БД
migrate-down:
	@echo "$(BLUE)Откат миграций...$(NC)"
	@migrate -path $(MIGRATION_DIR) -database "postgres://user:password@localhost:5432/skidon?sslmode=disable" down
	@echo "$(GREEN)Миграции откачены!$(NC)"

## dev: Запустить в режиме разработки
dev: docker-up
	@echo "$(BLUE)Режим разработки запущен!$(NC)"
	@echo "$(YELLOW)Для остановки используйте: make docker-down$(NC)"

## benchmark: Запустить бенчмарки
benchmark:
	@echo "$(BLUE)Запуск бенчмарков...$(NC)"
	@go test -bench=. -benchmem -count=3 ./... | tee benchmark.txt
	@echo "$(GREEN)Бенчмарки завершены! Результаты: benchmark.txt$(NC)"

## security: Проверка безопасности
security:
	@echo "$(BLUE)Проверка безопасности...$(NC)"
	@gosec ./...
	@echo "$(GREEN)Проверка безопасности завершена!$(NC)"

## deps: Установить зависимости
deps:
	@echo "$(BLUE)Установка зависимостей...$(NC)"
	@go mod download
	@go mod tidy
	@echo "$(GREEN)Зависимости установлены!$(NC)"

## tools: Установить инструменты разработки
tools:
	@echo "$(BLUE)Установка инструментов...$(NC)"
	@go install