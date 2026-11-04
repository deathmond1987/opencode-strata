#!/bin/bash
set -e

CONTAINER_NAME="strata"
SHOULD_STOP_STRATA=false

# Функция очистки, которая выполнится при выходе (в т.ч. по Ctrl+C)
cleanup() {
    if [ "$SHOULD_STOP_STRATA" = true ]; then
        echo -e "\n==> Скрипт завершен. Останавливаю Strata..."
        docker compose -f docker-compose-strata.yml stop
        # Или можно использовать: docker stop "$CONTAINER_NAME"
    fi
}

# Привязываем функцию cleanup к сигналам выхода (EXIT, SIGINT / Ctrl+C)
trap cleanup EXIT INT TERM

echo "==> Проверяем состояние контейнера $CONTAINER_NAME..."
STATUS=$(docker inspect --format='{{.State.Status}}' "$CONTAINER_NAME" 2>/dev/null || echo "not_found")

if [ "$STATUS" = "running" ]; then
    echo "==> Strata уже запущен (был включен ранее), выключать при выходе не будем."
else
    if [ "$STATUS" = "exited" ] || [ "$STATUS" = "created" ]; then
        echo "==> Strata остановлен. Запускаем..."
        docker start "$CONTAINER_NAME"
    else
        echo "==> Strata не найден. Создаем и запускаем через docker-compose-strata.yml..."
        docker compose -f docker-compose-strata.yml up -d
    fi
    # Раз мы сами его запустили — запоминаем, что его нужно выключить при выходе
    SHOULD_STOP_STRATA=true
fi

echo "==> Ждем, пока Strata перейдет в состояние healthy..."
while true; do
  HEALTH_STATUS=$(docker inspect --format='{{if .State.Health}}{{.State.Health.Status}}{{else}}no-healthcheck{{end}}' "$CONTAINER_NAME" 2>/dev/null || echo "starting")
  
  if [ "$HEALTH_STATUS" = "healthy" ] || [ "$HEALTH_STATUS" = "no-healthcheck" ]; then
    echo -e "\n==> Strata готов к работе!"
    break
  elif [ "$HEALTH_STATUS" = "unhealthy" ]; then
    echo -e "\nОшибка: Strata перешел в состояние unhealthy!"
    exit 1
  fi
  
  echo -n "."
  sleep 2
done

echo "==> Запускаем Opencode..."
docker compose run --rm opencode-env
