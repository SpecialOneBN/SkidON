# Используем официальный образ Go как этап сборки
FROM golang:1.22 AS builder

WORKDIR /app

# Копируем go.mod и go.sum, устанавливаем зависимости
COPY go.mod go.sum ./
RUN go mod download

# Копируем весь исходный код
COPY . .

# Собираем бинарник
RUN go build -o app ./cmd

# Финальный образ — только бинарник и нужные файлы (без Go)
FROM debian:bookworm-slim

WORKDIR /app

# Копируем бинарник из builder-этапа
COPY --from=builder /app/app .

# Открываем нужный порт (если у тебя, например, 8080)
EXPOSE 8080

# Устанавливаем команду запуска
CMD ["./app"]
