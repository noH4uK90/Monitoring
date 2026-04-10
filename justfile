set shell := ["powershell.exe", "-c"]

# Информация о всех командах
help:
    just --list

# Запустить контейнеры
up:
    docker compose up -d

# Остановить контейнеры
stop:
    docker stop

# Остановить и удалить контейнеры
down:
    docker compose down -v

# Обновить конфиги Prometheus
reload-prometheus:
    docker kill -s HUP monitoring_prometheus

# Создать сеть для мониторинга
create-network:
    docker network create monitoring_network