# Umbrel — проект пула Miningcore (Retro Mike)

Отдельный проект для настройки майнинг-пула на **Umbrel** с Miningcore и нодами монет из App Store Retro Mike.

---

## Структура проекта

Как в [TheRetroMike/retromike-umbrel-app-store](https://github.com/TheRetroMike/retromike-umbrel-app-store): каждое приложение — папка с `umbrel-app.yml` и `docker-compose.yml`.

| Приложение | Описание |
|------------|----------|
| **sert-umbrel-pool-miningcore** | MiningCore — пул для соло-майнинга |
| **sert-umbrel-pool-miningcore-webui** | Web UI для пула |
| **sert-umbrel-pool-xec-node** | Нода eCash (XEC) |
| **sert-umbrel-pool-btc-node** | Нода Bitcoin (BTC) |
| **sert-umbrel-pool-postgres** | PostgreSQL + pgAdmin (опционально) |

| Документация | Описание |
|--------------|----------|
| **COINS-SETUP-GUIDE.md** | Настройка монет, пути Umbrel, имена контейнеров |
| **FIX-XEC-DAEMON.md** | Исправление ошибок XEC (host, coinTemplates) |
| **coins-reference.json** | Справочник монет: id, coin, stratum, rpcPort |

---

## Конфиги на Umbrel

- **config.json** — `/home/umbrel/.miningcore/config.json` (монтируется в контейнер Miningcore)
- **coins.json** — `/home/umbrel/.miningcore/coins.json` (шаблоны монет, coinTemplates)
- Контейнер Miningcore: **retro-mike-miningcore_server_1** (образ theretromike/miningcore)
- Ноды: контейнеры вида **retro-mike-&lt;coin&gt;-node_node_1** (например retro-mike-xec-node_node_1)

---

## Список монет (28)

btc, bch, bc2, bsv, dgb, doge, xec, xna, ppc, rvn, vtc, ltc, grs, fb, xmr, erg, etc, ethw, zeph, space, xel, octa, zec, zen, flux, firo, kas, nexa.

Подробности по портам и настройке — в **COINS-SETUP-GUIDE.md**.

---

## GitHub

Репозиторий: **https://github.com/Sert1985n/umbrel-pool-app-store**

Дальнейшие обновления: `git add .` → `git commit -m "..."` → `git push`. Подробнее — в [GITHUB.md](GITHUB.md).
