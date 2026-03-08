# Порты и контейнеры — без конфликтов (Umbrel)

Имена контейнеров и порты приведены к одному справочнику. Используйте для config.json (daemons) и проверки сборки.

## Приложения (APP_HOST для Umbrel)

| Приложение (папка) | Контейнер (APP_HOST) | Порт |
|--------------------|----------------------|------|
| sert-umbrel-pool-miningcore | sert-umbrel-pool-miningcore_web_1 | 8080 (Dozzle) |
| sert-umbrel-pool-miningcore | sert-umbrel-pool-miningcore_server_1 | 4000 (API) |
| sert-umbrel-pool-miningcore-webui | sert-umbrel-pool-miningcore-webui_web_1 | 8080 |
| sert-umbrel-pool-poolui | sert-umbrel-pool-poolui_server_1 | 80 |
| sert-umbrel-pool-postgres | ${APP_ID}_web_1 | — |
| sert-umbrel-pool-dozzle | sert-umbrel-pool-dozzle_web_1 | 8080 |
| sert-umbrel-pool-btc-node | sert-umbrel-pool-btc-node_web_1 | 8080 (Dozzle) |
| sert-umbrel-pool-btc-node | sert-umbrel-pool-btc-node_node_1 | 9004 RPC |
| sert-umbrel-pool-dgb-node-sha256 | sert-umbrel-pool-dgb-node-sha256_web_1 | 8080 |
| sert-umbrel-pool-dgb-node-sha256 | sert-umbrel-pool-dgb-node-sha256_digibyted_1 | 9001 RPC |
| остальные ноды *-node | sert-umbrel-pool-&lt;id&gt;-node_web_1 | 8080 |
| остальные ноды *-node | sert-umbrel-pool-&lt;id&gt;-node_node_1 | rpcPort из coins-reference |

Формат имени контейнера в Docker: **{папка-приложения}_{имя-сервиса}_1**.

## Ноды: host для config.json (daemons)

В config.json для каждого пула в daemons указывается host — имя контейнера ноды:

- **DGB:** `sert-umbrel-pool-dgb-node-sha256_digibyted_1` (сервис `digibyted`)
- **Все остальные:** `sert-umbrel-pool-<id>-node_node_1`, где `<id>` — id из coins-reference.json (например btc, bch, xec).

Пример: для пула XEC host = `sert-umbrel-pool-xec-node_node_1`, port = 9007.

## Порты монет (coins-reference.json)

Каждая монета имеет **уникальные** stratum и rpcPort. Конфликтов нет.

| Диапазон | Назначение |
|----------|------------|
| 6001–6080 | Stratum (основной) |
| 6201–6280 | Stratum (доп.) |
| 6301–6380 | Stratum (доп.) |
| 6401–6480 | Stratum (доп.) |
| 9001–9095, 8080, 8232, … | RPC нод (у каждой монеты свой) |

Полный список: **coins-reference.json** в корне проекта. При добавлении новой монеты задайте stratum и rpcPort из свободного диапазона (например следующий по порядку).

## MiningCore: проброс портов

В docker-compose MiningCore указано:

```yaml
ports:
  - 6001-6080:6001-6080
  - 6201-6280:6201-6280
  - 6301-6380:6301-6380
  - 6401-6480:6401-6480
  - 4000:4000
```

Этого достаточно для всех монет из coins-reference.json (stratum до 6074).

## Проверка перед сборкой

Запустите проверку портов и сборки из корня проекта:

- **Полная проверка (порты + docker-compose + сборка образа):**  
  `.\build.ps1` (PowerShell)
- **Только порты:**  
  `.\scripts\validate-ports.ps1` или `node scripts/validate-ports.js`

Скрипты проверяют, что в coins-reference.json нет дубликатов stratum и rpcPort. При установленном Docker build.ps1 дополнительно проверяет docker-compose и собирает образ Pool Dashboard.
