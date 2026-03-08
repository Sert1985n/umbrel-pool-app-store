#!/bin/sh
# Подставляет coins.json со всеми 28 монетами из репозитория в /home/umbrel/.miningcore/
# Запускать на Umbrel по SSH. После запуска: открыть Pool Config (порт 8562) → Refresh Master Coin List.

COINS_URL="https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/templates/coins.json"
TARGET="/home/umbrel/.miningcore/coins.json"

mkdir -p "$(dirname "$TARGET")"
if [ -f "$TARGET" ]; then
  cp -a "$TARGET" "${TARGET}.bak.$(date +%Y%m%d%H%M%S)"
fi
curl -sSL -o "$TARGET" "$COINS_URL"
echo "Done. Restart MiningCore or open Pool Config (http://IP:8562) and click Refresh Master Coin List."
