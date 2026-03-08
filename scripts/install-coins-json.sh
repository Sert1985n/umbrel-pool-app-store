#!/bin/sh
# Подставляет coins.json (28 монет) и перезапускает MiningCore + Pool Config.
# После: открыть http://IP:8562 → Pool Configuration → Refresh Master Coin List.

COINS_URL="https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/templates/coins.json"
TARGET="/home/umbrel/.miningcore/coins.json"

mkdir -p "$(dirname "$TARGET")"
if [ -f "$TARGET" ]; then
  cp -a "$TARGET" "${TARGET}.bak.$(date +%Y%m%d%H%M%S)"
fi
curl -sSL -o "$TARGET" "$COINS_URL"
echo "Coins.json updated. Restarting MiningCore and Pool Config..."
docker restart sert-umbrel-pool-miningcore_server_1 2>/dev/null || true
sleep 15
docker restart sert-umbrel-pool-pool-config_web_1 2>/dev/null || true
echo "Done. Open http://YOUR-IP:8562 → Pool Configuration → Refresh Master Coin List."
