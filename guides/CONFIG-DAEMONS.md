# Конфиг пула: daemons и исправления (без конфликтов нод)

Чтобы пул не выдавал **«Name or service not known»** и **NullReferenceException** по XEC, в config.json и coins.json нужно использовать имена контейнеров **этого магазина** (префикс `sert-umbrel-pool-`).

---

## 1. Host нод в config.json (daemons)

В секции **pools** для каждой монеты в **daemons** указывайте **host** так:

| Монета | host (имя контейнера) | port (RPC) |
|--------|------------------------|------------|
| BTC    | sert-umbrel-pool-btc-node_node_1        | 9004 |
| BCH    | sert-umbrel-pool-bch-node_node_1       | 9002 |
| BC2    | sert-umbrel-pool-bc2-node_node_1        | 9006 |
| BSV    | sert-umbrel-pool-bsv-node_node_1        | 9005 |
| DGB    | sert-umbrel-pool-dgb-node-sha256_digibyted_1 | 9001 |
| DOGE   | sert-umbrel-pool-doge-node_node_1       | 9003 |
| XEC    | sert-umbrel-pool-xec-node_node_1        | 9007 |
| PPC    | sert-umbrel-pool-ppc-node_node_1        | 9012 |
| RVN    | — (ноды в этом магазине пока нет)       | 9010 |
| VTC    | sert-umbrel-pool-vtc-node_node_1        | 9008 |
| XMR    | sert-umbrel-pool-xmr-node_node_1        | 9009 |
| BTCS   | sert-umbrel-pool-btcs-node_node_1       | 9015 |

**Важно:** не используйте старые имена вида `retro-mike-ppc-node_node_1` или просто `xec` — иначе будет «Name or service not known».

Пример для XEC в config.json:

```json
"daemons": [
  {
    "host": "sert-umbrel-pool-xec-node_node_1",
    "port": 9007,
    "user": "pooluser",
    "password": "poolpassword"
  }
]
```

---

## 2. Исправление XEC (coins.json) — убрать NullReferenceException

По документу **«как мы добавили монету XEC в приложение umbrel»**: если в **coins.json** у шаблона XEC включены флаги staking/community/foundation, а нода eCash этих полей не отдаёт — Miningcore падает с **NullReferenceException**, job не создаётся, майнеры отваливаются на subscribe.

**Что сделать:** в файле `/home/umbrel/.miningcore/coins.json` найти шаблон XEC (по symbol/id/name) и выставить **false** для:

- hasCoinbaseStakingReward
- hasCoinbaseStakingRewards
- hasCommunity / hasCommunityAddress
- hasCoinbaseDevReward / hasDeveloper
- hasFoundation
- hasDataMining / hasFortuneReward
- isPoS / isPos / isPOS

Подробно и скрипты — в **FIX-XEC-DAEMON.md** в корне репозитория.

---

## 3. Контейнер Miningcore

После правок перезапуск:

```bash
docker restart sert-umbrel-pool-miningcore_server_1
```

Проверка логов по XEC:

```bash
docker logs --since 2m sert-umbrel-pool-miningcore_server_1 2>&1 | grep -i '\[xec\]'
```

В логах не должно быть `Error during UpdateJob` и `NullReferenceException` для [xec].
