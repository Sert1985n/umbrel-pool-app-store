# Отдельная панель: Setup Database Schema, Refresh Master Coin List, Generate Pool Config File

Как в [Retro Mike MiningCore Web UI](https://github.com/TheRetroMike/retromike-umbrel-app-store/tree/master/retro-mike-miningcore-webui). У нас **одно** приложение с этой панелью:

- **«Pool Config»** (порт **8562**) — панель конфигурации. Дубликата «MiningCore Web UI» больше нет, чтобы не перенаправляло на старую панель.

---

## Что делает эта панель

- **При первом запуске** приложения сервис `coins-init` подставляет **coins.json** с нашими монетами в `/home/umbrel/.miningcore/` (если файла ещё нет). Вручную копировать не нужно.
- По адресу **http://ВАШ-IP:8562** открывается страница с iframe панели и кнопкой **«Перезапустить MiningCore»** (сверху).
- В панели (как у Retro Mike): **Setup Database Schema**, **Refresh Master Coin List**, **Generate Pool Config File**, **Создание Wallet** — подстановка ваших адресов вместо "xxx". Включение/выключение монет — выбором в списке при генерации config.
- Всё делается из браузера, без ручных правок на сервере.

---

## Откуда берётся список монет

- При первом запуске **coins-init** копирует наш **templates/coins.json** в **/home/umbrel/.miningcore/coins.json** (если файла нет). В панели нажмите **Refresh Master Coin List** — появятся наши монеты.
- Если список пуст — см. **COINS-JSON-SETUP.md** (ручная подстановка и ссылка на готовый coins.json).

---

## Приложение в магазине

| Приложение              | Порт | Назначение |
|-------------------------|------|------------|
| **Pool Config**         | 8562 | Панель конфигурации: Setup DB, Refresh Coin List, Generate Config, Wallet. Монеты из coins.json — см. **COINS-JSON-SETUP.md**. |
| **Pool Dashboard**      | 8561 | Ваша панель: статистика, Current Price, Reward, графики. |

Оба приложения независимы; для работы панели конфигурации нужен установленный **MiningCore** (пул), чтобы API был доступен.
