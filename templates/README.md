# Шаблоны для пула

## coins.json — список монет в Pool Configuration

Список монет на странице **Pool Configuration** (Web UI, порт 8559) берётся из файла **coins.json** на сервере Umbrel.

- **Путь:** `/home/umbrel/.miningcore/coins.json`
- Формат — объект с ключами-ид монет (bitcoin, ecash, neurai и т.д.) и шаблонами. Описание формата и примеры — в репозитории [Miningcore](https://github.com/coinfoundry/miningcore).

**Как добавить монеты в список:**

1. Подготовьте или возьмите **coins.json** с нужными coinTemplates (из [Miningcore](https://github.com/coinfoundry/miningcore) или соберите по документации пула).
2. Скопируйте файл на сервер в `/home/umbrel/.miningcore/coins.json`.
3. Перезапустите Miningcore: `docker restart sert-umbrel-pool-miningcore_server_1`
4. Откройте http://ВАШ-IP:8559/PoolConfiguration и нажмите **Refresh Master Coin List**.

Подробнее: **guides/POOL-CONFIGURATION-COINS.md**.
