# Монеты в Pool Configuration (http://ВАШ-IP:8559/PoolConfiguration)

Страница **Pool Configuration** в MiningCore Web UI показывает список монет из файла **coins.json** на сервере Umbrel. От этого списка зависят Setup Database Schema, Refresh Master Coin List, создание Wallet и Generate Pool Config File.

---

## Откуда берётся список монет

- **Путь на Umbrel:** `/home/umbrel/.miningcore/coins.json`
- Miningcore читает этот файл при старте. В нём — объект с ключами-ид монет (например `"bitcoin"`, `"ecash"`, `"neurai"`) и шаблонами (name, symbol, family, hashers, explorer links и т.д.).
- Формат и примеры шаблонов — в репозитории [Miningcore (coinfoundry/miningcore)](https://github.com/coinfoundry/miningcore).

---

## Как добавить монеты в список

1. Подготовьте **coins.json** с нужными coinTemplates (из Miningcore или по документации).
2. Скопируйте файл на сервер в `/home/umbrel/.miningcore/coins.json` (через SCP, SMB или файловый доступ Umbrel).
3. Перезапустите Miningcore:  
   `docker restart sert-umbrel-pool-miningcore_server_1`
4. Откройте в браузере **http://ВАШ-IP:8559/PoolConfiguration** и нажмите **Refresh Master Coin List**.

После этого в списке появятся монеты из coins.json; их можно отмечать и использовать для создания Wallet и генерации config.

---

## Ваши монеты (id для coins.json)

По **coins-reference.json**: btc, bch, bc2, bsv, btcs, dgb, doge, xec, xna, ppc, rvn, vtc, ltc, grs, fb, xmr, erg, etc, ethw, zeph, space, xel, octa, zec, zen, flux, firo, kas, nexa. В coins.json должны быть шаблоны с соответствующими id (или canonical name).
