# Ноды: без конфликтов и настройка XEC

Чтобы между нодами и пулом не было конфликтов, используйте имена контейнеров и порты **этого магазина** (префикс `sert-umbrel-pool-`). Настройка XEC — по документу «как мы добавили монету XEC в приложение umbrel».

---

## 1. Документ по добавлению XEC

Основной источник: **«как мы добавили монету XEC в приложение umbrel что нужно настраивать»** (файл на рабочем столе или в ваших заметках). В нём описано:

- Ошибка **NullReferenceException** по XEC: из-за флагов staking/community/foundation в coins.json при том, что нода eCash этих полей не отдаёт.
- **Исправление:** в `/home/umbrel/.miningcore/coins.json` у шаблона XEC выставить **false** для: hasCoinbaseStakingReward, hasCoinbaseStakingRewards, hasCommunity, hasCoinbaseDevReward, hasFoundation, hasDataMining, isPoS и т.п.
- **Host в config.json:** не `xec` и не `retro-mike-xec-node_node_1`, а **sert-umbrel-pool-xec-node_node_1** (чтобы не было «Name or service not known»).

В этом репозитории то же самое кратко: **FIX-XEC-DAEMON.md** (корень), **CONFIG-DAEMONS.md** (таблица host и раздел про XEC).

---

## 2. Конфликты между нодами (устранены)

- **Stratum-порты:** у каждой монеты свой порт. Конфликт ERG/BTCS (оба 6015) исправлен: ERG — **6029**, BTCS — **6015**. Список — **coins-reference.json**.
- **RPC-порты нод:** у каждой ноды свой порт (9001, 9002, … 9021, 9050, 18081 и т.д.). Имена контейнеров уникальны: `sert-umbrel-pool-<монета>-node_node_1` (DGB: `_digibyted_1`).
- **Host в config.json:** только имена контейнеров этого магазина (`sert-umbrel-pool-...`). Старые имена (`retro-mike-...`) не использовать.

Таблица host и RPC-портов — **CONFIG-DAEMONS.md**.

---

## 3. Что проверить после настройки

1. **config.json** — у всех пулов в daemons указаны host из таблицы (CONFIG-DAEMONS.md).
2. **coins.json** — у XEC отключены флаги staking/community/foundation (см. FIX-XEC-DAEMON.md).
3. Перезапуск Miningcore: `docker restart sert-umbrel-pool-miningcore_server_1`.
4. В логах нет `NullReferenceException` и `Name or service not known` по XEC и другим монетам.
