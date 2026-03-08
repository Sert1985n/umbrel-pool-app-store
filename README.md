# Umbrel — проект пула Miningcore (Retro Mike)

Отдельный проект для настройки майнинг-пула на **Umbrel** с Miningcore и нодами монет из App Store Retro Mike.

---

## Структура проекта

| Файл | Описание |
|------|----------|
| **README.md** | Этот файл — обзор проекта |
| **COINS-SETUP-GUIDE.md** | Что настраивать при добавлении/включении монет (пути Umbrel, имена контейнеров) |
| **FIX-XEC-DAEMON.md** | Исправление ошибок XEC (host, coinTemplates) на Umbrel |
| **coins-reference.json** | Справочник монет: id, coin, stratum, rpcPort для конфигов |

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

Репозиторий готов к публикации на GitHub. Пошаговая инструкция — в **[GITHUB.md](GITHUB.md)**.
