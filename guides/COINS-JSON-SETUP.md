# Все монеты в Pool Config (порт 8562)

Панель **Pool Configuration** показывает список из файла **coins.json** на сервере: `/home/umbrel/.miningcore/coins.json`. Чтобы в списке были **все 28 монет**, подставьте наш шаблон и обновите список в панели.

---

## Одной командой на Umbrel (SSH)

```bash
curl -sSL -o /home/umbrel/.miningcore/coins.json "https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/templates/coins.json"
```

**Обязательно после загрузки файла:** список монет в панели берётся из MiningCore (пул), который читает `coins.json` при старте. Поэтому нужно **сначала перезапустить MiningCore**, затем обновить список в панели.

**Шаг 1 — перезапуск MiningCore (по SSH):**
```bash
docker restart sert-umbrel-pool-miningcore_server_1
```
Подождите 10–20 секунд, пока контейнер поднимется.

**Шаг 2 — обновление списка в панели:**
1. Откройте **http://ВАШ-IP:8562** → **Pool Configuration** (или панель в новой вкладке).
2. Нажмите **Refresh Master Coin List** — должны появиться все 28 монет.

Если список всё ещё старый:
- Убедитесь, что шаг 1 выполнен (MiningCore перезапущен).
- Перезапустите приложение **Pool Config** в Umbrel (Apps → Pool Config → Restart), затем снова откройте панель и нажмите **Refresh Master Coin List**.

---

## Вручную

1. Скачайте **coins.json**:  
   https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/templates/coins.json  
2. Скопируйте в **/home/umbrel/.miningcore/coins.json** на сервере.
3. В панели нажмите **Refresh Master Coin List**.

---

## Список монет (28)

bitcoin, bitcoin-cash, bitcoin-ii, bitcoin-sv, bitcoin-silver, digibyte-sha256, dogecoin, ecash, neurai, peercoin, ravencoin, vertcoin, litecoin, groestlcoin, fractalbitcoin-sha, monero, ergo, ethereumclassic, ethereumpow, zephyr, spacecoin, xelis, octaspace, zcash, horizen, flux, firo, kaspa, nexa.  
Про XEC: **FIX-XEC-DAEMON.md** в корне репозитория.
