# Монеты в Pool Configuration (http://192.168.0.244:8559/PoolConfiguration)

Страница **Pool Configuration** показывает список монет из **Miningcore** (файл **coins.json** на сервере). Чтобы в списке были **все ваши монеты** и можно было создавать Wallet и генерировать config:

---

## Шаг 1: Положить на сервер полный coins.json

Список чекбоксов (Bitcoin, eCash, NeurAI и т.д.) берётся из **coinTemplates** в файле **coins.json**, который читает Miningcore.

- **Путь на Umbrel:** `/home/umbrel/.miningcore/coins.json`
- Файл должен быть **объектом** с ключами-ид монет (например `"bitcoin"`, `"ecash"`, `"neurai"`) и описанием шаблона (name, symbol, family, hashers, explorer links и т.д.).

**Откуда взять готовый coins.json с вашими монетами:**

1. **Рекомендуется:** из вашего проекта CasaOS (ZimaOS/CasaOS app store с Miningcore): файл **`Apps/postgres/templates/coins.json`** — скопируйте его целиком на сервер в `/home/umbrel/.miningcore/coins.json`. В нём уже есть шаблоны для Bitcoin, eCash, NeurAI, Ergo, Kaspa, Nexa, Flux, Zcash, Ethereum Classic, EthereumPoW (ethereum-pow), Zephyr, Xelis, OctaSpace и др.
2. Либо из репозитория [Miningcore](https://github.com/coinfoundry/miningcore) (папка с шаблонами монет).

На Windows скопировать можно так (если есть доступ по SSH к Umbrel):

```bash
scp /path/to/coins.json umbrel@192.168.0.244:/home/umbrel/.miningcore/coins.json
```

Или через SMB/файловый менеджер Umbrel, если есть доступ к папке `.miningcore`.

---

## Шаг 2: Перезапустить Miningcore

Чтобы пул подхватил новый coins.json:

```bash
docker restart sert-umbrel-pool-miningcore_server_1
```

(Выполнить на сервере Umbrel по SSH или через Docker.)

---

## Шаг 3: Обновить список в интерфейсе

1. Откройте в браузере: **http://192.168.0.244:8559/PoolConfiguration**
2. Нажмите кнопку **«Refresh Master Coin List»**.
3. В списке должны появиться все монеты из coins.json; отметьте нужные и используйте **Generate Pool Config File** / создание Wallet.

---

## Ваши монеты (id для coins.json)

По **coins-reference.json** ваши монеты: btc, bch, bc2, bsv, btcs, dgb, doge, xec, xna, ppc, rvn, vtc, ltc, grs, fb, xmr, erg, etc, ethw, zeph, space, xel, octa, zec, zen, flux, firo, kas, nexa. Убедитесь, что в coins.json есть шаблоны с такими id (или canonical name), иначе они не появятся в списке.
