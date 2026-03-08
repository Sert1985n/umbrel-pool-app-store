# Отдельная панель: Setup Database Schema, Refresh Master Coin List, Generate Pool Config File

Как в [Retro Mike MiningCore Web UI](https://github.com/TheRetroMike/retromike-umbrel-app-store/tree/master/retro-mike-miningcore-webui). У нас **одно** приложение с этой панелью:

- **«Pool Config»** (порт **8562**) — панель конфигурации. Дубликата «MiningCore Web UI» больше нет, чтобы не перенаправляло на старую панель.

---

## Что делает эта панель

- **Setup Database Schema** — создание таблиц БД для пула.
- **Refresh Master Coin List** — обновление списка монет из **coins.json** на сервере.
- **Generate Pool Config File** — генерация фрагментов **config.json** по выбранным монетам.
- **Создание Wallet** — в интерфейсе можно задать/подставить адреса кошельков; плейсхолдер `"xxx"` в config заменяется на реальный адрес при настройке выплат.

Всё это делается в браузере: **http://ВАШ-IP:8562** (Pool Config) → страница Pool Configuration.

---

## Откуда берётся список монет

- В панели отображаются монеты из файла **/home/umbrel/.miningcore/coins.json** на Umbrel.
- У Retro Mike в образе уже есть часть шаблонов; полный список можно собрать из [Miningcore](https://github.com/coinfoundry/miningcore) или взять за основу его магазин.
- Наши монеты (см. **coins-reference.json**) нужно добавить в **coins.json** на сервере, затем нажать **Refresh Master Coin List** в панели — тогда они появятся в списке и будут доступны для Generate Pool Config File и создания Wallet.

Подробнее: **POOL-CONFIGURATION-COINS.md**.

---

## Приложение в магазине

| Приложение              | Порт | Назначение |
|-------------------------|------|------------|
| **Pool Config**         | 8562 | Панель конфигурации: Setup DB, Refresh Coin List, Generate Config, Wallet. Монеты из coins.json — см. **COINS-JSON-SETUP.md**. |
| **Pool Dashboard**      | 8561 | Ваша панель: статистика, Current Price, Reward, графики. |

Оба приложения независимы; для работы панели конфигурации нужен установленный **MiningCore** (пул), чтобы API был доступен.
