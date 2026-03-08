# Шаблоны для пула

## coins.json — список монет в Pool Configuration

Чтобы в **Pool Configuration** (родная Web UI) отображались все ваши монеты и можно было создавать Wallet и генерировать config:

1. **Скопируйте полный файл coins.json** на сервер Umbrel по пути:  
   **`/home/umbrel/.miningcore/coins.json`**

2. **Откуда взять файл:**  
   - Из вашего проекта CasaOS: папка `Apps/postgres/templates/coins.json` (если вы скачивали CasaOS app store с Miningcore).  
   - Либо из репозитория [Miningcore](https://github.com/coinfoundry/miningcore) (шаблоны монет).

3. **После копирования:**  
   - Перезапустите Miningcore:  
     `docker restart sert-umbrel-pool-miningcore_server_1`  
   - Откройте http://ВАШ-IP:8559/PoolConfiguration и нажмите **Refresh Master Coin List**.

В полном coins.json уже есть шаблоны для: bitcoin, bitcoin-cash, bitcoin-ii, bitcoin-sv, dogecoin, ecash, neurai, ravencoin, monero, ergo, ethereumclassic, ethereum-pow (ETHW), zephyr, xelis, octaspace, zcash, flux, firo, kaspa, nexa и др. После обновления списка ваши монеты будут доступны для настройки и создания Wallet.

Подробнее: **guides/POOL-CONFIGURATION-COINS.md**.
