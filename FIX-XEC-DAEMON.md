# Исправление XEC на Umbrel

Типичные ошибки при работе пула XEC на Umbrel и как их устранить.

---

## 1. "Name or service not known (xec:9007)"

**Причина:** в config.json в daemons для пула XEC указан host `xec` (или другой hostname), который не резолвится в сети Docker.

**Решение:** заменить **host** на реальное имя контейнера ноды, например:

- `sert-umbrel-pool-xec-node_node_1` (если установлен из этого магазина)

или на `127.0.0.1`, если RPC ноды проброшен на хост.

Проверить имя контейнера:

```bash
docker ps --format '{{.Names}}' | grep -i xec
```

В config.json в секции пула xec:

```json
"daemons": [
  { "host": "retro-mike-xec-node_node_1", "port": 9007, "user": "pooluser", "password": "poolpassword" }
]
```

После правки: `docker restart sert-umbrel-pool-miningcore_server_1`.

---

## 2. NullReferenceException в CreateCoinbaseStakingRewardOutputs, майнеры отваливаются на subscribe

**Причина:** в **coins.json** (или coinTemplates в config) у XEC включены флаги hasCoinbaseStakingReward / hasCommunity / hasFoundation и т.п., а нода eCash не отдаёт эти поля в getblocktemplate → Miningcore падает.

**Решение:** в шаблоне XEC в **coins.json** выключить флаги (ставить `false`):

- hasCoinbaseStakingReward
- hasCoinbaseStakingRewards
- hasCommunity / hasCommunityAddress
- hasCoinbaseDevReward / hasDeveloper
- hasFoundation
- hasDataMining / hasFortuneReward
- isPoS / isPos / isPOS

Файл на хосте: `/home/umbrel/.miningcore/coins.json`. После правки перезапустить Miningcore.

---

## 3. Как понять, что всё ок

- В логах нет `Error during UpdateJob` и `NullReferenceException` для [xec].
- Майнер на stratum-порту XEC (6007) не отваливается сразу после subscribe.
- В логах есть сообщения вида `[xec] Broadcasting job ...`.
