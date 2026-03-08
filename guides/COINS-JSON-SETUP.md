# Все монеты в Pool Config (порт 8562)

Панель **Pool Configuration** показывает список из файла **coins.json** на сервере: `/home/umbrel/.miningcore/coins.json`. Чтобы в списке были **все 28 монет**, подставьте наш шаблон и обновите список в панели.

---

## Одной командой на Umbrel (SSH)

```bash
curl -sSL -o /home/umbrel/.miningcore/coins.json "https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/templates/coins.json"
```

**Обязательно после загрузки файла:** перезапустите **оба** контейнера (MiningCore и панель Pool Config), затем в панели нажмите **Refresh Master Coin List**.

**Шаг 1 — перезапуск контейнеров (по SSH):**

Узнайте имена контейнеров (на Umbrel может быть префикс):  
`docker ps --format "{{.Names}}" | grep -E "miningcore|pool-config"`

Перезапустите MiningCore и панель (подставьте свои имена, если в выводе выше они другие):
```bash
docker restart sert-umbrel-pool-miningcore_server_1
sleep 15
docker restart sert-umbrel-pool-pool-config_web_1
```
Подождите ещё 10–15 секунд.

**Шаг 2 — обновление списка в панели:**
1. Откройте **http://ВАШ-IP:8562** → **Pool Configuration** (или «Открыть панель в новой вкладке»).
2. Нажмите **Refresh Master Coin List** — должны появиться все 28 монет.

Если список всё ещё старый — перезапустите оба приложения через Umbrel: **Apps** → **Pool Config** → **Restart**, затем **MiningCore** → **Restart**. Подождите ~30 сек, откройте панель и снова **Refresh Master Coin List**.

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
