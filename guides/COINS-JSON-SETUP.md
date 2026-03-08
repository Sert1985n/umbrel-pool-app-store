# Как появились ваши монеты в Pool Config (порт 8562)

Список монет в панели **Pool Config** (Setup Database Schema, Refresh Master Coin List, Generate Pool Config File) берётся **только** из файла **coins.json** на сервере Umbrel. Пока его нет или он пустой — ваших монет в списке не будет.

---

## 1. Скачать готовый coins.json

Скачайте файл с шаблонами монет (в нём уже есть bitcoin, bitcoin-cash, ecash, dogecoin, vertcoin и многие другие):

**https://raw.githubusercontent.com/oliverw/miningcore/master/src/Miningcore/coins.json**

Сохраните как `coins.json`.

---

## 2. Исправить XEC (обязательно для eCash)

Чтобы пул не падал с NullReferenceException по XEC, в скачанном coins.json найдите блок **"ecash"** и добавьте (или замените при наличии) эти поля в **false**:

```json
"hasCoinbaseStakingReward": false,
"hasCoinbaseStakingRewards": false,
"hasCommunity": false,
"hasCoinbaseDevReward": false,
"hasFoundation": false,
"hasDataMining": false,
"isPoS": false
```

Подробнее: **FIX-XEC-DAEMON.md** в корне репозитория.

---

## 3. Скопировать на Umbrel

- Скопируйте готовый **coins.json** на сервер по пути:  
  **/home/umbrel/.miningcore/coins.json**  
  (через SCP, SMB или файловый менеджер Umbrel).
- Перезапустите Miningcore:  
  `docker restart sert-umbrel-pool-miningcore_server_1`
- Откройте **Pool Config** в браузере: **http://ВАШ-IP:8562** → страница **Pool Configuration** → нажмите **Refresh Master Coin List**.

После этого в списке появятся монеты из coins.json. Для генерации config и создания Wallet используйте кнопки в этой же панели.

---

## 4. Наши монеты (id в coins.json)

По **coins-reference.json** нужны шаблоны с такими id (или близкими по смыслу):  
bitcoin, bitcoin-cash, bitcoin-ii, bitcoin-sv, bitcoin-silver, digibyte-sha256, dogecoin, ecash, neurai, peercoin, ravencoin, vertcoin, litecoin, groestlcoin, fractalbitcoin-sha, monero, ergo, ethereumclassic, ethereumpow, zephyr, spacecoin, xelis, octaspace, zcash, horizen, flux, firo, kaspa, nexa.

Часть из них уже есть в скачанном coins.json; недостающие можно добавить по образцу существующих (скопировать блок другой монеты того же family и поменять name, symbol, id). Полный список — в **coins-reference.json**.
