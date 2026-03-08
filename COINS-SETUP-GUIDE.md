# Добавление и настройка монет — Umbrel

Памятка по настройке монет для Miningcore на **Umbrel** (Retro Mike App Store). Пути и имена контейнеров указаны для Umbrel.

---

## Список монет (28)

| btc | bch | bc2 | bsv | dgb | doge | xec | xna |
|-----|-----|-----|-----|-----|------|-----|-----|
| ppc | rvn | vtc | ltc | grs | fb   | xmr | erg |
| etc | ethw| zeph| space| xel | octa | zec | zen |
| flux| firo| kas | nexa |

---

## 1. Где лежат конфиги (Umbrel)

| Конфиг | Путь на хосте |
|--------|----------------|
| config.json | `/home/umbrel/.miningcore/config.json` |
| coins.json  | `/home/umbrel/.miningcore/coins.json` |

В docker-compose Miningcore они монтируются в контейнер **retro-mike-miningcore_server_1**. Редактировать нужно файлы на хосте в `/home/umbrel/.miningcore/`.

---

## 2. config.json — секция пула и daemons

Для каждой монеты в **pools**:

- **id** — символ (xec, btc, …).
- **coin** — каноническое имя (ecash, bitcoin, …).
- **ports** — stratum (6001–6025 и т.д., см. coins-reference.json).
- **daemons**:
  - **host** — имя контейнера ноды в сети Umbrel, например:
    - `retro-mike-xec-node_node_1`
    - `retro-mike-ppc-node_node_1`
  - Или `127.0.0.1`, если порты ноды проброшены на хост.
  - **port** — RPC-порт ноды (для XEC: 9007 и т.д.).
  - **user** / **password** — RPC (например pooluser / poolpassword).

Если host не резолвится → ошибка *"Name or service not known (host:port)"*. Проверьте: `docker ps` — имя контейнера ноды должно совпадать с тем, что в config.

---

## 3. coins.json — шаблоны монет (coinTemplates)

На Umbrel **coinTemplates** часто лежат в отдельном файле **coins.json**.

Для монет, у которых нода **не отдаёт** в getblocktemplate поля staking/community/foundation, нужно в шаблоне этой монеты выставить **false**:

- hasCoinbaseStakingReward
- hasCoinbaseStakingRewards
- hasCommunity / hasCommunityAddress
- hasCoinbaseDevReward / hasDeveloper
- hasFoundation
- hasDataMining / hasFortuneReward
- isPoS / isPos / isPOS

Иначе Miningcore падает с **NullReferenceException** (CreateCoinbaseStakingRewardOutputs), job не создаётся, майнеры отваливаются на subscribe. Для **XEC** это обязательно — см. **FIX-XEC-DAEMON.md**.

---

## 4. Ноды на Umbrel

- Установить приложение ноды из App Store (например **retro-mike-xec-node**).
- Контейнер ноды и Miningcore в одной Docker-сети Umbrel — обращение по имени контейнера (например `retro-mike-xec-node_node_1`) работает.
- RPC-порты нод см. в **coins-reference.json**.

---

## 5. Кошелёк

В config.json в секции пула заменить плейсхолдер `"xxx"` в **address** на реальный адрес кошелька для выплат.

---

## 6. После изменений

```bash
docker restart retro-mike-miningcore_server_1
```

Проверить логи по монете, например XEC:

```bash
docker logs --since 2m retro-mike-miningcore_server_1 2>&1 | grep -i '\[xec\]'
```

---

## 7. Порты (stratum и API)

В docker-compose Miningcore проброшены 6001–6025, 6201–6225, 6301–6325, 6401–6425, 4000. При необходимости расширить диапазон для всех 28 монет (до 6028) — поправить ports в compose.
