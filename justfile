set shell := ["powershell.exe", "-c"]

# Информация о всех командах
help:
    just --list

# Запустить контейнеры
up:
    docker compose up -d
    # prometheus.yml и alloy-config.alloy примонтированы как bind mount —
    # `docker compose up -d` не видит изменений содержимого файла и не
    # пересоздаёт контейнер, поэтому конфиг без явного reload молча не
    # подхватывается
    just reload-prometheus
    just reload-alloy

# Остановить контейнеры
stop:
    docker stop

# Остановить и удалить контейнеры
down:
    docker compose down -v

# Обновить конфиги Prometheus
reload-prometheus:
    docker kill -s HUP monitoring_prometheus

# Перечитать конфиг Alloy без потери positions (SIGHUP = reload, как у Prometheus)
reload-alloy:
    docker kill -s HUP alloy

# Полный перезапуск Alloy (когда он залипает на удалённом контейнере
# после пересоздания сервиса и перестаёт видеть его логи в Loki)
restart-alloy:
    docker restart alloy

# Создать сеть для мониторинга
create-network:
    docker network create monitoring_network