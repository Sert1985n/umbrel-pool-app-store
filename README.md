# Umbrel Pool App Store

Магазин приложений для майнинг-пула на **Umbrel**: Miningcore, ноды монет, Web UI. Все имена контейнеров с префиксом **sert-umbrel-pool-** — конфликтов с другими магазинами нет. Настройка daemons и исправление XEC — по документу «как мы добавили монету XEC в приложение umbrel».

---

## Где моя панель? Где иконки?

**Моя панель** — это приложение **sert-umbrel-pool-poolui** («Моя панель — Pool Dashboard»). Оно есть в списке приложений магазина **Umbrel Pool**: установите его, откройте по выданному порту (8560) — это и есть ваша панель с 4 блоками статистики, Your Wallet и графиками.

**Иконки** приложений берутся из полей `icon` и `gallery` в каждом `umbrel-app.yml`. Если иконки не отображаются в Umbrel, проверьте доступ в интернет с устройства; для вашей панели и пула добавлены иконки из репозитория в папке **icons/** — в манифестах используются ссылки на `raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/icons/...`, чтобы они грузились с вашего GitHub.

---

## Приложения (как в [Retro Mike Store](https://github.com/TheRetroMike/retromike-umbrel-app-store))

Каждое приложение — папка с `umbrel-app.yml` и `docker-compose.yml`. Иконки — по возможности те же (cryptologos, bitcoincash.org и т.д.).

| Приложение | Описание |
|------------|----------|
| **sert-umbrel-pool-miningcore** | MiningCore — пул |
| **sert-umbrel-pool-miningcore-webui** | **MiningCore Web UI (родная)** — Setup Database Schema, Refresh Master Coin List, Generate Pool Config File, управление монетами (новые и старые), запись изменений в GitHub |
| **sert-umbrel-pool-poolui** | **Моя панель — Pool Dashboard** — ваша панель: статистика, графики, кошелёк (порт 8560). Иконка в **icons/pool-dashboard.svg** |
| **sert-umbrel-pool-btc-node** | Нода Bitcoin |
| **sert-umbrel-pool-bch-node** | Нода Bitcoin Cash |
| **sert-umbrel-pool-bsv-node** | Нода Bitcoin SV |
| **sert-umbrel-pool-bc2-node** | Нода Bitcoin II |
| **sert-umbrel-pool-btcs-node** | Нода Bitcoin Silver |
| **sert-umbrel-pool-dgb-node-sha256** | Нода Digibyte (SHA256) |
| **sert-umbrel-pool-doge-node** | Нода Dogecoin |
| **sert-umbrel-pool-xec-node** | Нода eCash (XEC) |
| **sert-umbrel-pool-ppc-node** | Нода Peercoin |
| **sert-umbrel-pool-vtc-node** | Нода Vertcoin |
| **sert-umbrel-pool-xmr-node** | Нода Monero |
| **sert-umbrel-pool-xmr-wallet** | Monero Wallet RPC (подключение к ноде этого магазина) |
| **sert-umbrel-pool-ltc-node** | Litecoin (LTC) |
| **sert-umbrel-pool-rvn-node** | Ravencoin (RVN) |
| **sert-umbrel-pool-grs-node** | Groestlcoin (GRS) |
| **sert-umbrel-pool-xna-node** | NeurAI (XNA) |
| **sert-umbrel-pool-zen-node** | Horizen (ZEN) |
| **sert-umbrel-pool-firo-node** | Firo (FIRO) |
| **sert-umbrel-pool-kas-node** | Kaspa (KAS) |
| **sert-umbrel-pool-nexa-node** | Nexa (NEXA) |
| **sert-umbrel-pool-erg-node** | Ergo (ERG) |
| **sert-umbrel-pool-fb-node** | Fractal Bitcoin (FB) |
| **sert-umbrel-pool-postgres** | PostgreSQL + pgAdmin |
| **sert-umbrel-pool-dozzle** | Просмотр логов контейнеров |

---

## Документация и настройка без конфликтов

| Файл | Описание |
|------|----------|
| **guides/POOL-CONFIG-ACTIONS.md** | Setup Database Schema, Refresh Master Coin List, Generate Pool Config File, полный список монет, запись изменений в GitHub |
| **guides/CONFIG-DAEMONS.md** | Таблица host для config.json (daemons), исправление XEC в coins.json |
| **COINS-SETUP-GUIDE.md** | Настройка монет, пути Umbrel |
| **FIX-XEC-DAEMON.md** | Ошибки XEC: host, coinTemplates (hasCoinbaseStakingReward и т.д.) |
| **guides/NATIVE-WEBUI-CUSTOMIZE.md** | Убрать Referral Links, Support Me; заменить копирайт на public-pool-btc.ru (userscript) |
| **coins-reference.json** | Master Coin List: id, coin, stratum, rpcPort (для панели и скриптов) |

---

## Конфиги на Umbrel

- **config.json** — `/home/umbrel/.miningcore/config.json`
- **coins.json** — `/home/umbrel/.miningcore/coins.json`
- Контейнер пула: **sert-umbrel-pool-miningcore_server_1**
- Ноды: **sert-umbrel-pool-&lt;монета&gt;-node_node_1** (DGB: **sert-umbrel-pool-dgb-node-sha256_digibyted_1**). Полная таблица — в **guides/CONFIG-DAEMONS.md**.

---

## Список монет (28)

btc, bch, bc2, bsv, dgb, doge, xec, xna, ppc, rvn, vtc, ltc, grs, fb, xmr, erg, etc, ethw, zeph, space, xel, octa, zec, zen, flux, firo, kas, nexa.

Подробности по портам и настройке — в **COINS-SETUP-GUIDE.md**.

---

## GitHub

Репозиторий: **https://github.com/Sert1985n/umbrel-pool-app-store**

- Обновления кода и документации: `git add .` → `git commit -m "..."` → `git push`. Подробнее — в [GITHUB.md](GITHUB.md).
- Запись изменений **config.json** и **coins.json** (бэкап с сервера) — в [guides/POOL-CONFIG-ACTIONS.md](guides/POOL-CONFIG-ACTIONS.md) (раздел «Записать изменения в GitHub»).
