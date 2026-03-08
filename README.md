# Umbrel Pool App Store

Магазин приложений для майнинг-пула на **Umbrel**: Miningcore, ноды монет, Web UI. Все имена контейнеров с префиксом **sert-umbrel-pool-** — конфликтов с другими магазинами нет. Настройка daemons и исправление XEC — по документу «как мы добавили монету XEC в приложение umbrel».

---

## Краткая шпаргалка по типичным проблемам

См. **QUICK-FIX.md**. **Моя панель** — это приложение **«MiningCore Web UI»** (порт 8559): в нём раздаётся ваш poolui из папки `sert-umbrel-pool-miningcore-webui/www`. Отдельного приложения «Моя панель» в списке нет. Referral/Support/копирайт в родном Web UI — только через userscript: **guides/NATIVE-WEBUI-CUSTOMIZE.md**. Подробно: **guides/POOLUI-ИЗМЕНЕНИЯ.md**. **Все правки в GitHub**; обновите магазин (Update/Refresh).

---

## Где моя панель?

**Моя панель** — приложение **«MiningCore Web UI (Моя панель)»** в магазине Umbrel Pool. После установки открывается по порту **8559** — это ваш дашборд (файлы из `C:\Users\WIN-10\Desktop\www\poolui`, скопированы в репозиторий в `sert-umbrel-pool-miningcore-webui/www`). Для Pool Configuration (Setup Database Schema, Refresh Master Coin List) установите приложение **«Pool Configuration»** (порт 8560).

**Иконки** в манифестах указаны с [cryptologos.cc](https://cryptologos.cc/) и, где есть, из папки **icons/** в репозитории. Если иконки не грузятся, обновите магазин (Update/Refresh) и проверьте доступ в интернет с устройства Umbrel.

---

## Приложения (как в [Retro Mike Store](https://github.com/TheRetroMike/retromike-umbrel-app-store))

Каждое приложение — папка с `umbrel-app.yml` и `docker-compose.yml`. Иконки — по возможности те же (cryptologos, bitcoincash.org и т.д.).

| Приложение | Описание |
|------------|----------|
| **sert-umbrel-pool-miningcore** | MiningCore — пул |
| **sert-umbrel-pool-miningcore-webui** | **MiningCore Web UI (Моя панель)** — ваша панель poolui (порт 8559): статистика, графики, кошелёк. Без Referral/Support. |
| **sert-umbrel-pool-pool-config** | **Pool Configuration** — родной Web UI (порт 8560): Setup Database Schema, Refresh Master Coin List, Generate Pool Config File |
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
| **QUICK-FIX.md** | Кратко: нет панели/иконок, Referral/копирайт (букмарклет), монеты в Pool Configuration, запись в GitHub |
| **guides/POOL-CONFIG-ACTIONS.md** | Setup Database Schema, Refresh Master Coin List, Generate Pool Config File, полный список монет, запись изменений в GitHub |
| **guides/CONFIG-DAEMONS.md** | Таблица host для config.json (daemons), исправление XEC в coins.json |
| **COINS-SETUP-GUIDE.md** | Настройка монет, пути Umbrel |
| **FIX-XEC-DAEMON.md** | Ошибки XEC: host, coinTemplates (hasCoinbaseStakingReward и т.д.) |
| **guides/NATIVE-WEBUI-CUSTOMIZE.md** | Убрать Referral Links, Support Me; заменить копирайт на public-pool-btc.ru (userscript/букмарклет) |
| **templates/README.md** | Инструкция по копированию coins.json для списка монет в Pool Configuration |
| **guides/POOL-CONFIGURATION-COINS.md** | Почему в Pool Configuration нет ваших монет; как добавить монеты для Wallet и config (coins.json, Refresh Master Coin List) |
| **guides/POOLUI-ИЗМЕНЕНИЯ.md** | Что сделано с poolui; какие изменения вносить в Desktop\\www\\poolui; Referral/копирайт; список монет и недостающих нод |
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
