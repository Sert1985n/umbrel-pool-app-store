# Отдельная панель: Setup Database Schema, Refresh Master Coin List, Generate Pool Config File

Как в [Retro Mike MiningCore Web UI](https://github.com/TheRetroMike/retromike-umbrel-app-store/tree/master/retro-mike-miningcore-webui). У нас **одно** приложение с этой панелью:

- **«Pool Config»** (порт **8562**) — панель конфигурации. Дубликата «MiningCore Web UI» больше нет, чтобы не перенаправляло на старую панель.

---

## Что делает эта панель

- **Setup Database Schema** — создание таблиц БД для пула.
- **Refresh Master Coin List** — обновление списка монет из **coins.json** на сервере (/home/umbrel/.miningcore/).
- **Generate Pool Config File** — генерация фрагментов **config.json** по выбранным монетам.
- **Создание Wallet** — в интерфейсе можно задать/подставить адреса кошельков; плейсхолдер "xxx" в config заменяется на реальный адрес.

Откройте **http://ВАШ-IP:8562** → страница Pool Configuration и остальные разделы панели (как у Retro Mike).

---

## Откуда берётся список монет

- В панели отображаются монеты из файла **/home/umbrel/.miningcore/coins.json** на Umbrel.
- Чтобы появились наши монеты — скопируйте **templates/coins.json** на сервер (или скачайте по ссылке из репозитория) и нажмите в панели **Refresh Master Coin List**. Подробно: **COINS-JSON-SETUP.md**.

---

## Приложение в магазине

| Приложение              | Порт | Назначение |
|-------------------------|------|------------|
| **Pool Config**         | 8562 | Панель конфигурации: Setup DB, Refresh Coin List, Generate Config, Wallet. Монеты из coins.json — см. **COINS-JSON-SETUP.md**. |
| **Pool Dashboard**      | 8561 | Ваша панель: статистика, Current Price, Reward, графики. |

Оба приложения независимы; для работы панели конфигурации нужен установленный **MiningCore** (пул), чтобы API был доступен.
