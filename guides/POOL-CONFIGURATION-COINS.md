# Монеты в Pool Configuration (http://IP:8559/PoolConfiguration)

Страница **Pool Configuration** в родной MiningCore Web UI (порт 8559) показывает список монет для **Setup Database Schema**, **Refresh Master Coin List**, **Generate Pool Config File** и для создания **Wallet** и записи в **config.json**. Список монет берётся из **Miningcore** (файл **coins.json** и встроенные шаблоны).

---

## Почему моих монет нет в списке?

Родная панель (образ [theretromike/miningcorewebui](https://hub.docker.com/r/theretromike/miningcorewebui)) получает список монет через API Miningcore или из примонтированного **coins.json**. Если ваших монет нет:

1. **Убедитесь, что Miningcore видит coins.json.**  
   В приложении **sert-umbrel-pool-miningcore-webui** в docker-compose смонтирован каталог:
   - `/home/umbrel/.miningcore` → `/app/miningcore`  
   В нём должны лежать актуальные **config.json** и **coins.json**.

2. **Добавьте шаблоны монет в coins.json на сервере.**  
   Путь на Umbrel: **`/home/umbrel/.miningcore/coins.json`**.  
   Формат — массив объектов (coinTemplates). Примеры шаблонов можно взять из [Retro Mike store](https://github.com/TheRetroMike/retromike-umbrel-app-store) (в образе Miningcore или в репозитории), из вашего **coins-reference.json** и из гайда **guides/POOL-CONFIG-ACTIONS.md** (таблица Master Coin List).

3. **Нажмите «Refresh Master Coin List»** на странице Pool Configuration.  
   Панель запросит у Miningcore обновление списка; после этого ваши монеты из coins.json должны появиться в интерфейсе для выбора Wallet и генерации config.

4. **Проверьте, что запущен именно ваш Miningcore.**  
   Контейнер пула: **sert-umbrel-pool-miningcore_server_1**. Web UI должен быть настроен на его API (переменная `API_BASE_URL` в образе miningcorewebui указывает на этот контейнер).

---

## Как добавить монеты «как в Retro Mike»

В [retromike-umbrel-app-store](https://github.com/TheRetroMike/retromike-umbrel-app-store) приложения Miningcore и Web UI используют общие **config.json** и **coins.json** с хоста. У вас то же самое: один каталог `/home/umbrel/.miningcore/` для пула и для панели.

- Скопируйте или соберите **coins.json** с нужными coinTemplates (id, symbol, name, algorithm и т.д.) и положите в `/home/umbrel/.miningcore/coins.json`.
- Перезапустите Miningcore (чтобы он подхватил новый coins.json):  
  `docker restart sert-umbrel-pool-miningcore_server_1`
- Откройте http://192.168.0.244:8559/PoolConfiguration и нажмите **Refresh Master Coin List**. Дальше выбирайте монеты для создания Wallet и **Generate Pool Config File**.

Полный перечень ваших монет (id, coin, stratum, rpcPort) — в **coins-reference.json** и в таблице Master Coin List в **guides/POOL-CONFIG-ACTIONS.md**.
