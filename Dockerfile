# ==========================
# Stage 1: Build
# ==========================
FROM ubuntu:24.04 AS builder

# Устанавливаем инструменты сборки
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        ninja-build \
        clang \
        git \
        ca-certificates \
        curl \
        wget \
        unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Копируем проект
COPY . .

# Сборка проекта
RUN mkdir -p build && cd build && cmake .. -G Ninja && ninja

# ==========================
# Stage 2: Runtime
# ==========================
FROM ubuntu:24.04 AS runtime

# Минимальные зависимости для запуска
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Копируем бинарники и тесты
COPY --from=builder /app/build /app/build

# Указываем рабочую директорию сразу в build
WORKDIR /app/build

# Запуск по умолчанию
CMD ["./main"]
