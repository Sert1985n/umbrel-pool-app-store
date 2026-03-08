# Моя панель (poolui) — что сделано и какие изменения вносить

## Что сделано

1. **Приложение «MiningCore Web UI» в магазине Umbrel Pool теперь отдаёт вашу панель (poolui).**  
   При установке «MiningCore Web UI» открывается не родной интерфейс Retro Mike, а ваш дашборд из папки **C:\Users\WIN-10\Desktop\www\poolui** (скопирован в репозиторий в `sert-umbrel-pool-miningcore-webui/www`). Порт **8559**. Отдельного приложения «Моя панель» в списке нет — панель это и есть «MiningCore Web UI».

2. **Добавлено приложение «Pool Configuration»** (порт 8560) — родной Web UI (theretromike/miningcorewebui) для Setup Database Schema, Refresh Master Coin List, Generate Pool Config File и создания Wallet.

3. **Referral Links / Support Me / копирайт**  
   В вашем poolui их нет. Они есть только в родном Web UI (приложение «Pool Configuration», порт 8560). Там их убирают только в браузере: **guides/NATIVE-WEBUI-CUSTOMIZE.md** (userscript или букмарклет).

---

## Какие изменения вносить в poolui

**Папка на вашем ПК:** `C:\Users\WIN-10\Desktop\www\poolui`

- **index.html** — шапка, навигация (Home, язык, тема). При необходимости меняйте заголовок, логотип, пункты меню.
- **app.js** — логика: запросы к `/api`, отображение пулов, страница монеты, блоки POOL STATISTICS, BLOCK STATISTICS, CURRENT PRICE, NETWORK STATISTICS, Your Wallet, графики. Меняйте под свои нужды.
- **site.css** — стили. Меняйте цвета, сетку, отступы под дизайн.

После правок в `C:\Users\WIN-10\Desktop\www\poolui` нужно обновить файлы в репозитории, чтобы на Umbrel отображалась новая версия:

1. Скопировать изменённые файлы из `Desktop\www\poolui` в папку проекта:
   `Umbrel-Pool-Project\sert-umbrel-pool-miningcore-webui\www\`
2. Сделать commit и push в GitHub.
3. В Umbrel: обновить магазин (Update/Refresh) и при необходимости переустановить приложение «MiningCore Web UI».

---

## Монеты (28): что есть, чего не хватает

В **coins-reference.json** перечислены все 28 монет. Ноды в магазине есть для: btc, bch, bc2, bsv, btcs, dgb, doge, xec, xna, ppc, rvn, vtc, ltc, grs, fb, xmr, erg, zen, firo, kas, nexa.

**Пока нет приложений-нод в репозитории для:** ETC, ETHW, ZEPH, SPACE, XEL, OCTA, ZEC, FLUX. Их нужно добавить по образцу существующих нод (например `sert-umbrel-pool-ltc-node`), взяв образы/entrypoint из [retromike-umbrel-app-store](https://github.com/TheRetroMike/retromike-umbrel-app-store) или из официальной документации каждой монеты. В **coins-reference.json** все 28 монет уже перечислены (id, stratum, rpcPort).

Список монет в **Pool Configuration** (родной Web UI) берётся с сервера из файла **coins.json** (`/home/umbrel/.miningcore/coins.json`). Чтобы там были все монеты — нужен полный coins.json на сервере и кнопка **Refresh Master Coin List**. См. **guides/POOL-CONFIGURATION-COINS.md**.

---

## Документ «как мы добавили монету XEC»

В нём описан подход: заменить контейнер Web UI на nginx и раздавать свои файлы из `data/www` (ваш poolui). Мы сделали так же: приложение «MiningCore Web UI» в репозитории использует nginx и папку `www` с вашим poolui. Referral/Support/копирайт в том документе не убираются отдельно — при замене UI на свой они просто не показываются (их нет в poolui). Для родного Web UI (Pool Configuration) — только userscript, см. **guides/NATIVE-WEBUI-CUSTOMIZE.md**.
