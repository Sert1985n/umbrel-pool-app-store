# Umbrel Pool App Store

Магазин приложений для майнинг-пула на **Umbrel**. Проект переписан по [TheRetroMike/retromike-umbrel-app-store](https://github.com/TheRetroMike/retromike-umbrel-app-store): Miningcore и родной MiningCore Web UI сохранены, порты и имена контейнеров — под **sert-umbrel-pool**. Добавлена ваша панель **Pool Dashboard** (poolui). **Приложения независимы** — MiningCore Web UI и Pool Dashboard можно ставить без обязательной установки MiningCore (как у Retro Mike). Настройка daemons и XEC — по документу «как мы добавили монету XEC в приложение umbrel».

---

## Краткая шпаргалка по типичным проблемам

См. **QUICK-FIX.md**. Если магазин пустой или приложения не появляются — **ЕСЛИ-НЕ-РАБОТАЕТ.md**. **Родной Web UI** (Setup Database Schema, Refresh Master Coin List, Generate Pool Config) — приложение **«MiningCore Web UI»** (порт **8559**). **Ваша панель** (статистика, графики, кошелёк) — приложение **«Pool Dashboard»** (порт **8561**). Referral/Support/копирайт в родном Web UI — через userscript: **guides/NATIVE-WEBUI-CUSTOMIZE.md**. Сеть и порты: **guides/NETWORK-PORTS.md**. **Все правки в GitHub**; обновите магазин (Update/Refresh).

---

## Приложения

| Приложение | Порт | Описание |
|------------|------|----------|
| **sert-umbrel-pool-miningcore** | 8560 | MiningCore — пул (Dozzle в UI; API на 4000 внутри) |
| **sert-umbrel-pool-miningcore-webui** | 8559 | **MiningCore Web UI** — родная панель: Pool Configuration, Setup Database Schema, Refresh Master Coin List, Generate Pool Config File |
| **sert-umbrel-pool-dashboard** | 8561 | **Pool Dashboard** — ваша панель (poolui): статистика, графики, кошелёк. Без Referral/Support. |
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
| **QUICK-FIX.md** | Кратко: нет панели/иконок, Referral/копирайт (букмарклет), монеты в Pool Configuration, запись в GitHub |
| **guides/POOL-CONFIG-ACTIONS.md** | Setup Database Schema, Refresh Master Coin List, Generate Pool Config File, полный список монет, запись изменений в GitHub |
| **guides/CONFIG-DAEMONS.md** | Таблица host для config.json (daemons), исправление XEC в coins.json |
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
