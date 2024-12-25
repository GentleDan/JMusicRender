#!/bin/bash

echo "Запуск trusted-session-generator для получения переменных..."
output=$(docker run --rm quay.io/invidious/youtube-trusted-session-generator)

visitor_data=$(echo "$output" | grep -oP 'visitor_data: \K.*')
po_token=$(echo "$output" | grep -oP 'po_token: \K.*')

if [ -z "$visitor_data" ] || [ -z "$po_token" ]; then
  echo "Ошибка: Не удалось извлечь переменные visitor_data или po_token"
  exit 1
fi

export VISITOR_DATA=$visitor_data
export PO_TOKEN=$po_token

echo "Переменные успешно извлечены:"
echo "VISITOR_DATA=$VISITOR_DATA"
echo "PO_TOKEN=$PO_TOKEN"

echo "Запуск JMusicBot..."
exec java -Dnogui=true -jar JMusicBot-0.4.3.2.jar
