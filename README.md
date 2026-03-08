# Umbrel Pool App Store

Магазин приложений для майнинг-пула на **Umbrel**: Miningcore, ноды монет, Web UI. Все имена контейнеров с префиксом **sert-umbrel-pool-** — конфликтов с другими магазинами нет. Настройка daemons и исправление XEC — по документу «как мы добавили монету XEC в приложение umbrel».

---

## Краткая шпаргалка по типичным проблемам

См. **QUICK-FIX.md** — там по шагам: почему нет панели и иконок, как добавить монеты в список Pool Configuration. **Referral Links и Support Me** в родной Web UI теперь удаляются автоматически, копирайт заменён на public-pool-btc.ru (прокси в приложении MiningCore Web UI). **Все правки записываются в GitHub**; чтобы Umbrel подтянул приложения, нажмите **Update** / **Refresh** у магазина.

---

## Где моя панель? Где иконки?

**Моя панель** — приложения **sert-umbrel-pool-poolui** («Моя панель — Pool Dashboard», порт 8560) и **sert-umbrel-pool-dashboard** («Pool Dashboard (Моя панель)», порт 8561). Оба показывают одну и ту же панель пула.

**Если панель не появилась в магазине:**  
1. В Umbrel откройте **Settings → Community App Stores**.  
2. Добавьте источник: `https://github.com/Sert1985n/umbrel-pool-app-store` (если ещё нет).  
3. Нажмите **Update** / **Refresh** у магазина Umbrel Pool (или удалите источник и добавьте снова).  
4. Установите **«Моя панель — Pool Dashboard»** (порт 8560) или **«Pool Dashboard (Моя панель)»** (порт 8561).

**Иконки** в манифестах указаны с [cryptologos.cc](https://cryptologos.cc/) и, где есть, из папки **icons/** в репозитории. Если иконки не грузятся, обновите магазин (Update/Refresh) и проверьте доступ в интернет с устройства Umbrel.

---

## Приложения (как в [Retro Mike Store](https://github.com/TheRetroMike/retromike-umbrel-app-store))

Каждое приложение — папка с `umbrel-app.yml` и `docker-compose.yml`. Иконки — по возможности те же (cryptologos, bitcoincash.org и т.д.).

| Приложение | Описание |
|------------|----------|
| **sert-umbrel-pool-miningcore** | MiningCore — пул |
| **sert-umbrel-pool-miningcore-webui** | **MiningCore Web UI (родная)** — порт 8559. Referral Links и Support Me удалены, копирайт заменён на public-pool-btc.ru (автоматически через прокси). Setup Database Schema, Refresh Master Coin List, Generate Pool Config File |
| **sert-umbrel-pool-poolui** | **Моя панель — Pool Dashboard** — ваша панель (порт 8560): статистика, графики, кошелёк |
| **sert-umbrel-pool-dashboard** | **Pool Dashboard (Моя панель)** — то же приложение панели на порту 8561 (отдельная запись в магазине) |
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
| **guides/NATIVE-WEBUI-CUSTOMIZE.md** | Резервный вариант: userscript/букмарклет, если прокси не применился (Referral/Support/копирайт) |
| **templates/README.md** | Инструкция по копированию coins.json для списка монет в Pool Configuration |
| **guides/POOL-CONFIGURATION-COINS.md** | Почему в Pool Configuration нет ваших монет; как добавить монеты для Wallet и config (coins.json, Refresh Master Coin List) |
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
