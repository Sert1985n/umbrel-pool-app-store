# Все монеты в Pool Config (порт 8562)

Панель **Pool Configuration** показывает список из файла **coins.json** на сервере: `/home/umbrel/.miningcore/coins.json`. Чтобы в списке были **все 28 монет**, подставьте наш шаблон и обновите список в панели.

---

## Одной командой на Umbrel (SSH)

```bash
curl -sSL -o /home/umbrel/.miningcore/coins.json "https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/templates/coins.json"
```

**Важно:** после загрузки файла нужно **обновить список в панели**:

1. Откройте **http://ВАШ-IP:8562** (если включён gateway — сверху будет кнопка «Перезапустить MiningCore» и iframe с панелью).
2. Перейдите в **Pool Configuration** (или откройте панель в новой вкладке по ссылке сверху).
3. Нажмите **Refresh Master Coin List** — в списке должны появиться все 28 монет.

Если список по-прежнему старый (15 монет):

- Проверьте, что файл записался:  
  `ls -la /home/umbrel/.miningcore/coins.json` и  
  `head -5 /home/umbrel/.miningcore/coins.json` (должен быть JSON с "bitcoin" и т.д.).
- В Umbrel: **Apps** → приложение **Pool Config** → **Restart**. Затем снова откройте панель и нажмите **Refresh Master Coin List**.
- Либо перезапустите MiningCore (кнопка «Перезапустить MiningCore» на странице Pool Config или в Umbrel → MiningCore → Restart), затем снова **Refresh Master Coin List**.

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
