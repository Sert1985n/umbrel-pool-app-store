#!/bin/bash
# Исправление XEC: Name or service not known (xec:9007)
# Запуск: sudo bash fix-xec-on-server.sh
# Или копируйте команды по одной в терминал на сервере.

set -e

echo "=== 1. Поиск конфига с пулом xec ==="
CONFIG=$(sudo grep -rl '"xec"' /opt /etc 2>/dev/null | grep -i config | head -1)
if [ -z "$CONFIG" ]; then
  CONFIG="/opt/miningcore/config.json"
  echo "Конфиг по умолчанию: $CONFIG"
fi
echo "Найден: $CONFIG"

echo ""
echo "=== 2. Добавляем xec в /etc/hosts (если нода на этом сервере) ==="
if ! grep -q '^127\.0\.0\.1[[:space:]]*xec' /etc/hosts 2>/dev/null; then
  echo "127.0.0.1 xec" | sudo tee -a /etc/hosts
  echo "Добавлена запись 127.0.0.1 xec"
else
  echo "Запись xec в /etc/hosts уже есть"
fi

echo ""
echo "=== 3. Замена host xec на 127.0.0.1 в конфиге (если есть) ==="
if [ -f "$CONFIG" ]; then
  if sudo grep -q '"host"[[:space:]]*:[[:space:]]*"xec"' "$CONFIG" 2>/dev/null; then
    sudo sed -i.bak 's/"host"[[:space:]]*:[[:space:]]*"xec"/"host": "127.0.0.1"/g' "$CONFIG"
    echo "Заменено в $CONFIG (резервная копия: ${CONFIG}.bak)"
  else
    echo "Поле \"host\": \"xec\" не найдено — отредактируйте вручную: sudo nano $CONFIG"
  fi
else
  echo "Файл $CONFIG не найден. Укажите путь к config.json и отредактируйте daemons для пула xec вручную."
fi

echo ""
echo "=== 4. Перезапуск пула ==="
SVC=""
for s in miningcore pool miningcore-pool pool-api; do
  if systemctl list-units --type=service --all 2>/dev/null | grep -q "$s"; then
    SVC="$s"
    break
  fi
done
if [ -n "$SVC" ]; then
  sudo systemctl restart "$SVC"
  echo "Перезапущен сервис: $SVC"
else
  echo "Сервис не найден. Перезапустите вручную: sudo systemctl restart <имя_сервиса>"
fi

echo ""
echo "=== 5. Логи (Ctrl+C для выхода) ==="
sleep 2
sudo journalctl -u "${SVC:-miningcore}" -f -n 30 --no-pager 2>/dev/null || echo "Запустите: sudo journalctl -u <сервис> -f -n 30"
