# Монеты и панель Pool Config (порт 8562)

Всё делается **из панели**: список монет, Setup Database Schema, Refresh Master Coin List, Generate Pool Config File, создание Wallet (подстановка ваших адресов вместо "xxx"), включение/выключение монет, перезапуск MiningCore.

---

## Что делает панель

- **При первом запуске** приложения Pool Config сервис `coins-init` подставляет файл **coins.json** с нашими монетами в `/home/umbrel/.miningcore/coins.json` (если файла ещё нет). Ручная загрузка не нужна.
- В интерфейсе открывается **MiningCore Web UI** (как у Retro Mike): Setup Database Schema, **Refresh Master Coin List**, Generate Pool Config File, создание Wallet — подстановка реальных адресов вместо "xxx".
- **Включить/выключить монету** — в панели выбираете, какие монеты нужны при генерации config и в списке; ненужные просто не отмечаете.
- Кнопка **«Перезапустить MiningCore»** на странице Pool Config отправляет запрос на перезапуск контейнера пула (нужен доступ к docker.sock на хосте).

Откройте **http://ВАШ-IP:8562** → панель загружается в iframe; сверху есть ссылка «Открыть панель в новой вкладке» и кнопка «Перезапустить MiningCore».

---

## Если монет в списке нет (ручная подстановка coins.json)

Если по какой-то причине `coins-init` не сработал или список пуст:

1. Скачайте готовый **coins.json** с нашими монетами (XEC уже с нужными флагами):  
   **https://raw.githubusercontent.com/Sert1985n/umbrel-pool-app-store/main/templates/coins.json**
2. Скопируйте его на сервер: **/home/umbrel/.miningcore/coins.json**
3. В панели нажмите **Refresh Master Coin List**.
4. При необходимости перезапустите MiningCore кнопкой на странице или:  
   `docker restart sert-umbrel-pool-miningcore_server_1`

Подробнее про XEC: **FIX-XEC-DAEMON.md** в корне репозитория.

---

## Наши монеты (id в coins.json)

По **coins-reference.json**: bitcoin, bitcoin-cash, bitcoin-ii, bitcoin-sv, bitcoin-silver, digibyte-sha256, dogecoin, ecash, neurai, peercoin, ravencoin, vertcoin, litecoin, groestlcoin, fractalbitcoin-sha, monero, ergo, ethereumclassic, ethereumpow, zephyr, spacecoin, xelis, octaspace, zcash, horizen, flux, firo, kaspa, nexa. Шаблоны для них лежат в **templates/coins.json**.
