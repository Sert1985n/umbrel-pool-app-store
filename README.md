# Umbrel Pool App Store

Магазин приложений для майнинг-пула на **Umbrel**. Две панели: **8563** — родная MiningCore Web UI (Setup DB / Generate Config); **8561** — ваша WEB UI (Pool Dashboard): статистика, графики, кошелёк. Панель «мои монеты» удалена — всё в 8563.

---

## Полная настройка (один раз, всё работает)

**См. [SETUP-FULL.md](SETUP-FULL.md)** — установка приложений → coins.json → **8563** (MiningCore Web UI): Setup DB, Refresh, Generate Config → перезапуск MiningCore → **8561** (ваша панель) — статистика, графики.

---

## Краткая шпаргалка по типичным проблемам

См. **QUICK-FIX.md** и **ЕСЛИ-НЕ-РАБОТАЕТ.md**. **8563** — родная MiningCore Web UI (Setup DB, Generate Config). **8561** — ваша WEB UI (Pool Dashboard). **guides/COINS-JSON-SETUP.md**. Сеть и порты: **guides/NETWORK-PORTS.md**.

---

## Приложения

| Приложение | Порт | Описание |
|------------|------|----------|
| **sert-umbrel-pool-miningcore** | 8560 | MiningCore — пул (Dozzle в UI; API на 4000 внутри) |
| **sert-umbrel-pool-miningcore-webui** | 8563 | **MiningCore Web UI (родная)** — Setup DB, Refresh Coin List, Generate Config. Иконка: шестерёнка. |
| **sert-umbrel-pool-poolui** | 8561 | **Моя WEB UI — Pool Dashboard** — статистика, графики, кошелёк. Иконка: дашборд. |
| **sert-umbrel-pool-btc-node** | — | Нода Bitcoin |
| **sert-umbrel-pool-bch-node** | — | Нода Bitcoin Cash |
| **sert-umbrel-pool-bsv-node** | — | Нода Bitcoin SV |
| **sert-umbrel-pool-bc2-node** | — | Нода Bitcoin II |
| **sert-umbrel-pool-btcs-node** | — | Нода Bitcoin Silver |
| **sert-umbrel-pool-dgb-node-sha256** | — | Нода Digibyte (SHA256) |
| **sert-umbrel-pool-doge-node** | — | Нода Dogecoin |
| **sert-umbrel-pool-xec-node** | — | Нода eCash (XEC) |
| **sert-umbrel-pool-ppc-node** | — | Нода Peercoin |
| **sert-umbrel-pool-vtc-node** | — | Нода Vertcoin |
| **sert-umbrel-pool-xmr-node** | — | Нода Monero |
| **sert-umbrel-pool-xmr-wallet** | — | Monero Wallet RPC |
| **sert-umbrel-pool-ltc-node** | — | Litecoin (LTC) |
| **sert-umbrel-pool-rvn-node** | — | Ravencoin (RVN) |
| **sert-umbrel-pool-grs-node** | — | Groestlcoin (GRS) |
| **sert-umbrel-pool-xna-node** | — | NeurAI (XNA) |
| **sert-umbrel-pool-zen-node** | — | Horizen (ZEN) |
| **sert-umbrel-pool-firo-node** | — | Firo (FIRO) |
| **sert-umbrel-pool-kas-node** | — | Kaspa (KAS) |
| **sert-umbrel-pool-nexa-node** | — | Nexa (NEXA) |
| **sert-umbrel-pool-erg-node** | — | Ergo (ERG) |
| **sert-umbrel-pool-fb-node** | — | Fractal Bitcoin (FB) |
| **sert-umbrel-pool-postgres** | 5050 | PostgreSQL + pgAdmin |
| **sert-umbrel-pool-dozzle** | — | Просмотр логов контейнеров |

---

## Документация и настройка без конфликтов

| Файл | Описание |
|------|----------|
| **SETUP-FULL.md** | **Полная настройка одним разом** — приложения, coins.json, Pool Config, кошельки, дашборд |
| **guides/WEBUI-STATIC-AND-DATA-FLOW.md** | Статика не «как в обычном сайте» у Pool Config (8562): wwwroot, серверные страницы; coins.json, wallet, fee/rewardRecipients (панель 83); Pool Dashboard без изменений |
| **QUICK-FIX.md** | Кратко: нет панели/иконок, Referral/копирайт (букмарклет), монеты в Pool Configuration, запись в GitHub |
| **guides/POOL-CONFIG-ACTIONS.md** | Setup Database Schema, Refresh Master Coin List, Generate Pool Config File, полный список монет, запись изменений в GitHub |
| **guides/CONFIG-DAEMONS.md** | Таблица host для config.json (daemons), исправление XEC в coins.json |
| **guides/NODES-AND-XEC.md** | Ноды без конфликтов, ссылка на документ «как добавили XEC», что проверить |
| **guides/POOL-CONFIG-PANEL.md** | Панель Pool Config (порт 8562): Setup DB, Refresh Coin List, Generate Config, Wallet |
| **guides/COINS-JSON-SETUP.md** | Как появились ваши монеты в Pool Config: скачать coins.json, исправить XEC, скопировать на сервер |
| **COINS-SETUP-GUIDE.md** | Настройка монет, пути Umbrel |
| **FIX-XEC-DAEMON.md** | Ошибки XEC: host, coinTemplates (hasCoinbaseStakingReward и т.д.) |
| **guides/NATIVE-WEBUI-CUSTOMIZE.md** | Убрать Referral Links, Support Me; заменить копирайт на public-pool-btc.ru (userscript/букмарклет) |
| **templates/README.md** | Инструкция по копированию coins.json для списка монет в Pool Configuration |
| **guides/POOL-CONFIGURATION-COINS.md** | Как добавить монеты в MiningCore Web UI (coins.json, Refresh Master Coin List) |
| **guides/NETWORK-PORTS.md** | Порты и имена контейнеров (miningcore, webui, dashboard, ноды) |
| **guides/POOLUI-ИЗМЕНЕНИЯ.md** | Изменения в poolui; папка Desktop\\www\\poolui; список монет и нод |
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
