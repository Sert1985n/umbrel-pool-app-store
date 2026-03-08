# Setup Database Schema, Refresh Master Coin List, Generate Pool Config File

Три действия для настройки пула Miningcore и управления монетами. **Все ваши монеты** — в **coins-reference.json**; их можно включать в **config.json** и в **coins.json** на сервере. Управление: приложение **«MiningCore Web UI»** (порт 8559) — Setup Database Schema, Refresh Master Coin List, Generate Pool Config File. Изменения можно записывать в GitHub (раздел 4).

---

## 1. Setup Database Schema

**Что это:** создание таблиц в PostgreSQL для пула (блоки, шары, выплаты, майнеры и т.д.).

**Когда делать:** один раз при первом запуске Miningcore с включённым PostgreSQL.

**Как делается на Umbrel:**

- В **config.json** должен быть блок **persistence.postgres** (хост БД, пользователь, пароль, база `miningcore`).
- При **первом старте** контейнера Miningcore сам выполняет миграции и создаёт схему БД. Отдельной кнопки в Umbrel нет — достаточно один раз запустить пул с правильным `config.json`.

**Путь config.json на Umbrel:** `/home/umbrel/.miningcore/config.json`

Пример блока в config.json:

```json
"persistence": {
  "postgres": {
    "host": "sert-umbrel-pool-postgres_postgres_1",
    "port": 5432,
    "user": "miningcore",
    "password": "miningcore",
    "database": "miningcore"
  }
}
```

После первого успешного запуска схема БД уже создана; повторно «Setup Database Schema» не требуется.

---

## 2. Refresh Master Coin List

**Что это:** обновление списка монет (шаблонов), которые пул знает. Источник — **coins.json** и/или встроенные шаблоны Miningcore.

**Когда делать:** после обновления образа Miningcore или после добавления новой монеты в репозиторий (например, в **coins-reference.json**).

**Как делается:**

- **coins.json** на Umbrel: `/home/umbrel/.miningcore/coins.json`
- Полный список монет для управления пулом — **Master Coin List** ниже. Используйте его при настройке панели или при ручном формировании **coins.json** / **coins-map.json**.

### Master Coin List (все монеты для управления)

| id   | coin                 | stratum | rpcPort | zmqPort | Примечание |
|------|----------------------|--------|---------|---------|------------|
| btc  | bitcoin              | 6004   | 9004    | 7004    | |
| bch  | bitcoin-cash         | 6002   | 9002    | 7002    | |
| bc2  | bitcoin-ii           | 6006   | 9006    | 7006    | |
| bsv  | bitcoin-sv           | 6005   | 9005    | 7005    | |
| btcs | bitcoin-silver       | 6015   | 9015    | 7015    | Bitcoin Silver |
| dgb  | digibyte-sha256      | 6001   | 9001    | 7001    | |
| doge | dogecoin             | 6003   | 9003    | 7003    | |
| xec  | ecash                | 6007   | 9007    | 7007    | см. FIX-XEC-DAEMON.md |
| xna  | neurai               | 6011   | 9011    | 7011    | |
| ppc  | peercoin             | 6012   | 9012    | 7012    | |
| rvn  | ravencoin            | 6010   | 9010    | 7010    | |
| vtc  | vertcoin             | 6008   | 9008    | 7008    | |
| ltc  | litecoin             | 6020   | 9020    | 7020    | |
| grs  | groestlcoin          | 6013   | 9013    | 7013    | |
| fb   | fractalbitcoin-sha   | 6014   | 9021    | 7021    | Fractal Bitcoin |
| xmr  | monero               | 6009   | 9009    | —       | + wallet RPC |
| erg  | ergo                 | 6015   | 9050    | —       | |
| etc  | ethereumclassic      | 6016   | 8545    | —       | |
| ethw | ethereumpow          | 6017   | 8546    | —       | |
| zeph | zephyr               | 6018   | 38081   | —       | |
| space| spacecoin           | 6019   | 9133    | —       | |
| xel  | xelis                | 6021   | 8080    | —       | |
| octa | octaspace            | 6022   | 8547    | —       | |
| zec  | zcash                | 6023   | 8232    | —       | |
| zen  | horizen              | 6024   | 8231    | —       | |
| flux | flux                | 6025   | 16124   | —       | |
| firo | firo                | 6026   | 8888    | —       | |
| kas  | kaspa                | 6027   | 16110   | —       | |
| nexa | nexa                 | 6028   | 7227    | —       | |

Файл **coins-reference.json** в корне репозитория — тот же список в JSON для скриптов и панелей.

---

## 3. Generate Pool Config File

**Что это:** формирование или обновление **config.json** (пулы, порты stratum, daemons, кошельки, комиссия, минимальная выплата).

**Когда делать:** при добавлении/удалении монеты, смене кошелька, смене host/port ноды или комиссии пула.

**Как делается:**

- Редактирование **config.json** вручную или через панель (если используется Mining Pool Configuration на порту 4050).
- Для каждой монеты в **pools** задаются: **id** (как в Master Coin List), **coin**, **ports** (stratum), **daemons** (host и port из таблицы в **CONFIG-DAEMONS.md**), **address**, **paymentProcessing.minimumPayment**, **rewardRecipients** (комиссия пула, например 1.5%).

**Host нод на Umbrel:** в **CONFIG-DAEMONS.md** — полная таблица имён контейнеров (например `sert-umbrel-pool-xec-node_node_1`, порт 9007). Подставляйте эти host/port в **daemons** для каждой монеты.

Пример одного пула в config.json:

```json
{
  "id": "xec",
  "enabled": true,
  "coin": "ecash",
  "address": "ВАШ_WALLET_АДРЕС",
  "ports": { "6007": { "listenAddress": "0.0.0.0", "difficulty": 1000000, "name": "TCP" } },
  "daemons": [
    {
      "host": "sert-umbrel-pool-xec-node_node_1",
      "port": 9007,
      "user": "pooluser",
      "password": "poolpassword"
    }
  ],
  "paymentProcessing": {
    "enabled": true,
    "payoutScheme": "SOLO",
    "minimumPayment": 0.001
  },
  "rewardRecipients": [
    { "address": "КОШЕЛЁК_КОМИССИИ_ПУЛА", "percentage": 1.5 }
  ]
}
```

После изменения config.json перезапустите пул:

```bash
docker restart sert-umbrel-pool-miningcore_server_1
```

---

## 4. Записать изменения в GitHub

Чтобы изменения **config.json** и **coins.json** хранились в репозитории и были видны в GitHub:

### Вариант A: отдельный репозиторий для конфигов (рекомендуется)

1. Создайте репозиторий, например `umbrel-pool-config` (приватный или публичный).
2. На сервере Umbrel в каталоге с конфигами или в отдельной папке:

```bash
cd /home/umbrel
mkdir -p pool-config-backup
cp .miningcore/config.json pool-config-backup/
cp .miningcore/coins.json pool-config-backup/
cd pool-config-backup
git init
git remote add origin https://github.com/Sert1985n/umbrel-pool-config.git
git add config.json coins.json
git commit -m "Backup config and coins"
git branch -M main
git push -u origin main
```

3. После каждого изменения (Setup/Refresh/Generate или ручная правка):

```bash
cd /home/umbrel/pool-config-backup
cp /home/umbrel/.miningcore/config.json .
cp /home/umbrel/.miningcore/coins.json .
git add config.json coins.json
git commit -m "Update config and coins"
git push
```

### Вариант B: только документация в этом репозитории

- Изменения в **документации** (этот гайд, **CONFIG-DAEMONS.md**, **coins-reference.json**) коммитить и пушить в **umbrel-pool-app-store**:

```bash
cd /path/to/Umbrel-Pool-Project
git add .
git commit -m "Update pool config docs and master coin list"
git push
```

Сам **config.json** и **coins.json** с сервера в этот репозиторий обычно не кладут (в них могут быть кошельки и пароли). Для их версионирования используйте Вариант A.

---

## Кратко

| Действие | Что делать |
|----------|------------|
| **Setup Database Schema** | Один раз: запустить Miningcore с `persistence.postgres` в config.json — схема создаётся автоматически. |
| **Refresh Master Coin List** | Использовать список монет выше и **coins-reference.json**; при необходимости обновить **coins.json** на сервере. |
| **Generate Pool Config File** | Редактировать **config.json** (пулы, daemons из **CONFIG-DAEMONS.md**, кошельки, комиссия, minimumPayment); перезапуск пула. |
| **Записать в GitHub** | Копировать config.json и coins.json в отдельный репо и делать commit/push; либо пушить только изменения документации в **umbrel-pool-app-store**. |
