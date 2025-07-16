# Этап 1: Сборка Flutter Web приложения
FROM ubuntu:latest AS builder

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa

# Клонирование Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"

# Проверка состояния Flutter
RUN flutter doctor

# Переключение на стабильный канал и обновление Flutter
RUN flutter channel stable
RUN flutter upgrade

# Аргумент сборки API
ARG MY_MEGA_API_URL
ENV MY_MEGA_API_URL=${MY_MEGA_API_URL}

# Рабочая директория
WORKDIR /app

# Копирование исходников приложения
COPY . .

# Получение зависимостей
RUN flutter pub get

# Чистка предыдущих сборок и создание новой
RUN flutter clean
RUN flutter build web --release --verbose --dart-define=MY_MEGA_API_URL=${MY_MEGA_API_URL}

# Этап 2: Создание финального образа с Nginx
FROM nginx:alpine

# Копирование собранного веб-приложения
COPY --from=builder /app/build/web /usr/share/nginx/html

# Конфигурация Nginx
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    root /usr/share/nginx/html; \
    index index.html; \
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot|json)$ { \
      expires 1y; \
      add_header Cache-Control "public, immutable"; \
      try_files $uri =404; \
    } \
    location / { \
      try_files $uri $uri/ @fallback; \
    } \
    location @fallback { \
      rewrite ^.*$ /index.html last; \
    } \
    # Безопасность заголовков \
    add_header X-Frame-Options "SAMEORIGIN" always; \
    add_header X-Content-Type-Options "nosniff" always; \
    add_header X-XSS-Protection "1; mode=block" always; \
}' > /etc/nginx/conf.d/default.conf

# Экспозиция порта
EXPOSE 80

# Запуск Nginx
CMD ["nginx", "-g", "daemon off;"]