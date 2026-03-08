# Все монеты в Pool Config (порт 8562)

Панель **Pool Configuration** (http://ВАШ-IP:8562/PoolConfiguration) показывает список из файла **coins.json** на сервере: `/home/umbrel/.miningcore/coins.json`. Чтобы в списке были **все 28 монет** из [репозитория](https://github.com/Sert1985n/umbrel-pool-app-store), подставьте наш шаблон.

---

## Одной командой на Umbrel (SSH)

Подключитесь к Umbrel по SSH и выполните:

```bash
curl -sSL -o /home/umbrel/.miningcore/coins.json "https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/templates/coins.json"
```

Затем откройте **Pool Config** → **Pool Configuration** и нажмите **Refresh Master Coin List**. В списке появятся все 28 монет.

(Скрипт с бэкапом: **scripts/install-coins-json.sh** — скопировать на сервер и запустить `sh install-coins-json.sh`.)

---

## Вручную

1. Скачайте **coins.json** (все 28 монет, XEC с нужными флагами):  
   **https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/templates/coins.json**
2. Скопируйте файл на сервер в **/home/umbrel/.miningcore/coins.json** (SCP, SMB или файловый менеджер Umbrel).
3. В панели: **http://ВАШ-IP:8562** → **Pool Configuration** → **Refresh Master Coin List**.

---

## Список монет (28)

По **coins-reference.json** в шаблоне:  
bitcoin, bitcoin-cash, bitcoin-ii, bitcoin-sv, bitcoin-silver, digibyte-sha256, dogecoin, ecash, neurai, peercoin, ravencoin, vertcoin, litecoin, groestlcoin, fractalbitcoin-sha, monero, ergo, ethereumclassic, ethereumpow, zephyr, spacecoin, xelis, octaspace, zcash, horizen, flux, firo, kaspa, nexa.

Панель остаётся той же (MiningCore Web UI 1 в 1); меняется только содержимое списка монет за счёт замены coins.json. Про XEC: **FIX-XEC-DAEMON.md** в корне репозитория.
