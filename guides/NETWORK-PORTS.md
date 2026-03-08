# Сеть и порты — Umbrel Pool App Store

Проект переписан по [TheRetroMike/retromike-umbrel-app-store](https://github.com/TheRetroMike/retromike-umbrel-app-store). Имена контейнеров и порты приведены под префикс **sert-umbrel-pool**.

## Порты приложений (доступ через Umbrel)

| Приложение | Порт | Назначение |
|------------|------|------------|
| **sert-umbrel-pool-miningcore** | 8560 | Dozzle (логи). API MiningCore — внутренний 4000 |
| **sert-umbrel-pool-miningcore-webui** | 8563 | **MiningCore Web UI (родная)** — Setup DB, Refresh Coin List, Generate Config |
| **sert-umbrel-pool-poolui** | 8561 | **Моя WEB UI (Pool Dashboard)** — статистика, графики, кошелёк |

## Имена контейнеров (для config.json и прокси)

- **MiningCore API:** `sert-umbrel-pool-miningcore_server_1` (порт 4000)
- **MiningCore Web UI (родная):** `sert-umbrel-pool-miningcore-webui_web_1` (порт 8080)
- **Моя WEB UI (poolui):** `sert-umbrel-pool-poolui_web_1` (порт 80)

Ноды монет (для daemons в config.json):

- BTC: `sert-umbrel-pool-btc-node_node_1`
- BCH: `sert-umbrel-pool-bch-node_node_1`
- DGB: `sert-umbrel-pool-dgb-node-sha256_digibyted_1`
- DOGE: `sert-umbrel-pool-doge-node_node_1`
- XEC: `sert-umbrel-pool-xec-node_node_1`
- VTC: `sert-umbrel-pool-vtc-node_node_1`
- и т.д. — шаблон: `sert-umbrel-pool-<id>-node_node_1` (DGB: `_digibyted_1`)

Полная таблица host для daemons — в **CONFIG-DAEMONS.md**.

## Stratum-порты (внешние)

В `config.json` пула указаны порты 6001–6028 (и диапазоны 6201–6228, 6301–6328, 6401–6428). Они пробрасываются с контейнера **sert-umbrel-pool-miningcore_server_1** на хост. Соответствие монета → stratum порт — в **coins-reference.json**.

## Монеты и config.json / coins.json

- **config.json** — `/home/umbrel/.miningcore/config.json`. В нём перечислены пулы и daemons (host = имя контейнера ноды).
- **coins.json** — `/home/umbrel/.miningcore/coins.json`. Используется родным Web UI для **Refresh Master Coin List** и **Generate Pool Config File**. Список ваших монет — в корне репозитория: **coins-reference.json**. Чтобы ваши монеты попадали в Setup Database Schema / Refresh Master Coin List / Generate Pool Config, добавьте их в coins.json на сервере (см. **templates/README.md**, **POOL-CONFIGURATION-COINS.md**).
