# Монеты в Pool Config (порт 8562)

Список монет в панели **Pool Config** берётся из файла **coins.json** на сервере Umbrel: `/home/umbrel/.miningcore/coins.json`. Пока его нет или он пустой — ваших монет в списке не будет.

---

## Как добавить монеты

1. Скачайте готовый **coins.json** с нашими монетами (XEC уже с нужными флагами):  
   **https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/templates/coins.json**
2. Скопируйте его на сервер: **/home/umbrel/.miningcore/coins.json** (SCP, SMB или файловый менеджер Umbrel).
3. Откройте **Pool Config**: **http://ВАШ-IP:8562** → **Pool Configuration** → нажмите **Refresh Master Coin List**.

После этого в списке появятся монеты. В панели: Setup Database Schema, Generate Pool Config File, создание Wallet (подстановка адресов вместо "xxx").

Подробнее про XEC: **FIX-XEC-DAEMON.md** в корне репозитория.

---

## Наши монеты (id в coins.json)

По **coins-reference.json**: bitcoin, bitcoin-cash, bitcoin-ii, bitcoin-sv, bitcoin-silver, digibyte-sha256, dogecoin, ecash, neurai, peercoin, ravencoin, vertcoin, litecoin, groestlcoin, fractalbitcoin-sha, monero, ergo, ethereumclassic, ethereumpow, zephyr, spacecoin, xelis, octaspace, zcash, horizen, flux, firo, kaspa, nexa. Шаблоны — в **templates/coins.json**.
